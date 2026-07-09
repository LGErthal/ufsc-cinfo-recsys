import pdfplumber
import re
from datetime import datetime, timedelta
from dataclasses import dataclass, field
from typing import List, Optional


# CONFIG
PDF_PATH = "./data/CADASTRO_TURMAS_20262_cinfo.pdf"
OUTPUT_SQL = "./data/output/grade_cinfo_20262.sql"

SEMESTRE = "20262"

BLOCO_MINUTOS = 50


# INTERVALOS
INTERVALOS = [
    ("10:00", "10:10"),
    ("20:10", "20:20"),
]

# DATACLASSES
@dataclass
class Agenda:
    dia: int
    hora_inicio: str
    hora_fim: str


@dataclass
class Turma:
    semestre: str

    codigo_disciplina: str
    turma: str
    nome_disciplina: str

    agendas: List[Agenda] = field(default_factory=list)

# HELPERS
def escape_sql(value: str) -> str:

    if value is None:
        return ""

    return value.replace("'", "''")


def calcular_fim_com_intervalo(
    inicio: datetime,
    duracao_blocos: int
) -> datetime:

    minutos_total = duracao_blocos * BLOCO_MINUTOS

    fim = inicio + timedelta(minutes=minutos_total)

    for inicio_int, fim_int in INTERVALOS:

        ini_int = inicio.replace(
            hour=int(inicio_int.split(":")[0]),
            minute=int(inicio_int.split(":")[1])
        )

        fim_intervalo = inicio.replace(
            hour=int(fim_int.split(":")[0]),
            minute=int(fim_int.split(":")[1])
        )

        if inicio < ini_int and fim > ini_int:
            fim += (fim_intervalo - ini_int)

    return fim


def parse_horario(horario_str: str) -> Optional[Agenda]:

    match = re.match(r"(\d)\.(\d{4})-(\d)", horario_str)

    if not match:
        return None

    dia = int(match.group(1))
    hora = match.group(2)
    duracao = int(match.group(3))

    inicio = datetime.strptime(hora, "%H%M")

    fim = calcular_fim_com_intervalo(inicio, duracao)

    return Agenda(
        dia=dia,
        hora_inicio=inicio.strftime("%H:%M:%S"),
        hora_fim=fim.strftime("%H:%M:%S")
    )


def extrair_horarios(texto: str) -> List[Agenda]:

    horarios = re.findall(r"\d\.\d{4}-\d", texto)

    resultado = []

    for horario in horarios:

        parsed = parse_horario(horario)

        if parsed:
            resultado.append(parsed)

    return resultado



# PDF PARSER
def extrair_disciplinas_do_pdf(pdf_path: str) -> List[Turma]:

    turmas = []

    with pdfplumber.open(pdf_path) as pdf:

        texto_completo = ""

        for page in pdf.pages:

            texto = page.extract_text()

            if texto:
                texto_completo += texto + "\n"

    linhas = texto_completo.split("\n")

    linhas_processadas = []

    # JUNTA LINHAS QUEBRADAS
    i = 0

    while i < len(linhas):

        linha = linhas[i].strip()

        if not linha:
            i += 1
            continue

        # Detecta início disciplina
        if re.match(r"^[A-Z]{3}\d{4}", linha):

            linha_completa = line = linha

            j = i + 1

            while j < len(linhas):

                prox = linhas[j].strip()

                # Nova disciplina
                if re.match(r"^[A-Z]{3}\d{4}", prox):
                    break

                # Cabeçalhos
                if prox.startswith("CADASTRO"):
                    break

                if prox.startswith("SeTIC"):
                    break

                linha_completa += " " + prox

                j += 1

            linhas_processadas.append(linha_completa)

            i = j

        else:
            i += 1

    # PARSE DISCIPLINAS
    for linha in linhas_processadas:

        try:

            partes = linha.split()

            codigo_disciplina = partes[0]
            turma = partes[1]

            # ENCONTRA CARGA HORÁRIA (Adicionado 0 na lista)
            workload_index = None

            for idx, parte in enumerate(partes):

                if parte.isdigit():

                    possible = int(parte)

                    if possible in [0, 18, 36, 72, 74, 108, 126, 432]:
                        workload_index = idx
                        break

            if workload_index is None:
                print(f"ERRO workload: {linha}")
                continue

            # NOME DISCIPLINA
            nome_disciplina = " ".join(
                partes[2:workload_index]
            )

            # HORÁRIOS
            agendas = extrair_horarios(linha)

            turma_obj = Turma(
                semestre=SEMESTRE,

                codigo_disciplina=codigo_disciplina,
                turma=turma,
                nome_disciplina=nome_disciplina,

                agendas=agendas
            )

            turmas.append(turma_obj)

        except Exception as e:

            print("\nERRO AO PROCESSAR:")
            print(linha)
            print(e)

    return turmas


def gerar_sql(
    turmas: List[Turma],
    output_sql: str
):

    sql = []

    # TABELAS
    sql.append("""
CREATE TABLE IF NOT EXISTS semestres (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    semestre VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS turmas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    created_at TIMESTAMP DEFAULT NOW(),

    semestre_id INTEGER NOT NULL
        REFERENCES semestres(id),

    curriculo_disciplina INTEGER NOT NULL
        REFERENCES curriculo(id),

    turma VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS turmas_agenda (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    turma_id INTEGER NOT NULL
        REFERENCES turmas(id),

    dia INTEGER NOT NULL,

    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS unique_turma
ON turmas (
    semestre_id,
    curriculo_disciplina,
    turma
);

CREATE INDEX IF NOT EXISTS idx_curriculo_codigo
ON curriculo(codigo_disciplina);

CREATE INDEX IF NOT EXISTS idx_turmas_semestre
ON turmas(semestre_id);

CREATE INDEX IF NOT EXISTS idx_turmas_agenda_turma
ON turmas_agenda(turma_id);

CREATE INDEX IF NOT EXISTS idx_turmas_agenda_dia
ON turmas_agenda(dia);

ALTER TABLE semestres DISABLE ROW LEVEL SECURITY;
ALTER TABLE turmas DISABLE ROW LEVEL SECURITY;
ALTER TABLE turmas_agenda DISABLE ROW LEVEL SECURITY;
""")


    # SEMESTRE
    sql.append(f"""
INSERT INTO semestres (semestre)
VALUES ('{SEMESTRE}')
ON CONFLICT (semestre) DO NOTHING;
""")

    # INSERTS
    sql.append(f"""
DO $$
DECLARE
    v_semestre_id INTEGER;
    v_turma_id INTEGER;
    r_curr RECORD;
BEGIN

SELECT id
INTO v_semestre_id
FROM semestres
WHERE semestre = '{SEMESTRE}';
""")

    for turma in turmas:

        codigo_disciplina = escape_sql(
            turma.codigo_disciplina
        )

        nome_turma = escape_sql(turma.turma)

        nome_disciplina = escape_sql(
            turma.nome_disciplina
        )

        # Alterado para criar a disciplina padrão (2026) caso não exista nenhuma referência no banco
        sql.append(f"""
    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = '{codigo_disciplina}') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, '{nome_disciplina}', 0, '{codigo_disciplina}', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = '{codigo_disciplina}') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '{nome_turma}';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '{nome_turma}')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)
""")

        for agenda in turma.agendas:
            sql.append(f"""
        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = {agenda.dia} AND hora_inicio = '{agenda.hora_inicio}'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, {agenda.dia}, '{agenda.hora_inicio}', '{agenda.hora_fim}');
        END IF;
""")

        sql.append("""
    END LOOP;
""")

    sql.append("""
END $$;
""")

    with open(output_sql, "w", encoding="utf-8") as f:
        f.write("\n".join(sql))

    print(f"\nSQL gerado com sucesso: {output_sql}")


if __name__ == "__main__":

    turmas = extrair_disciplinas_do_pdf(PDF_PATH)

    print(f"\nTotal de seções encontradas: {len(turmas)}\n")

    for s in turmas[:90]:

        print("=" * 60)
        print(f"DISCIPLINA: {s.codigo_disciplina}")
        print(f"TURMA: {s.turma}")
        print(f"NOME: {s.nome_disciplina}")

        for agenda in s.agendas:

            print(
                f"  DIA {agenda.dia} | "
                f"{agenda.hora_inicio} -> "
                f"{agenda.hora_fim}"
            )

    gerar_sql(turmas, OUTPUT_SQL)