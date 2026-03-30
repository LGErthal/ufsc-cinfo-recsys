import pdfplumber
import re
from datetime import datetime, timedelta
import os
from typing import List, Dict, Optional

# Variáveis
PDF_PATH = "./files/cadastro_turmas_cinfo.pdf"
OUTPUT_SQL = "grade_cinfo.sql"
BLOCO_MINUTOS = 50


def calcular_fim_com_intervalo(inicio: datetime, duracao_blocos: int) -> datetime:
    """
    Função para calcular o horário de término de uma disciplina com base no intervalo entre as aulas.
    
    A função considera a duração dos blocos de aula (em minutos) e ajusta o horário final 
    caso a aula atravesse um intervalo fixo.

    Parâmetros:
    inicio (datetime): O horário de início da aula.
    duracao_blocos (int): A quantidade de blocos de aula, cada um com duração de 50 minutos.

    Retorna:
    datetime: O horário de término da aula considerando os intervalos fixos.
    """
    minutos_total = duracao_blocos * BLOCO_MINUTOS
    fim = inicio + timedelta(minutes=minutos_total)

    intervalos = [
        ("10:00", "10:10"),
        ("20:10", "20:20"),
    ]

    for inicio_int, fim_int in intervalos:
        ini_int = inicio.replace(
            hour=int(inicio_int.split(":")[0]),
            minute=int(inicio_int.split(":")[1])
        )
        fim_int = inicio.replace(
            hour=int(fim_int.split(":")[0]),
            minute=int(fim_int.split(":")[1])
        )

        # Se a aula atravessa o início do intervalo, adiciona o intervalo ao horário final
        if inicio < ini_int and fim > ini_int:
            fim += timedelta(minutes=10)

    return fim


def parse_horario(horario: str) -> Optional[Dict[str, int]]:
    """
    Função para parsear os horários no formato especificado.

    Parâmetros:
    horario (str): O horário no formato 'd.HHMM-dd' onde 'd' é o dia da semana, 'HHMM' é a hora de início 
                   e 'dd' é a duração da aula em blocos.

    Retorna:
    dict: Dicionário contendo o dia da semana, hora de início e hora de término (se o formato for válido).
    """
    match = re.match(r"(\d)\.(\d{4})-(\d)", horario)
    if not match:
        return None

    dia_semana = int(match.group(1))
    hora = match.group(2)
    duracao = int(match.group(3))

    inicio = datetime.strptime(hora, "%H%M")
    fim = calcular_fim_com_intervalo(inicio, duracao)

    return {
        "dia_semana": dia_semana,
        "hora_inicio": inicio.strftime("%H:%M:%S"),
        "hora_fim": fim.strftime("%H:%M:%S"),
    }


def extrair_horarios(texto: str) -> List[Dict[str, int]]:
    """
    Função para extrair todos os horários de uma string.

    Parâmetros:
    texto (str): O texto contendo os horários no formato esperado.

    Retorna:
    List[dict]: Lista de dicionários contendo o dia da semana, hora de início e hora de término.
    """
    horarios = re.findall(r"\d\.\d{4}-\d", texto)
    return [parse_horario(h) for h in horarios if parse_horario(h)]


def extrair_disciplinas_do_pdf(pdf_path: str) -> List[Dict[str, str]]:
    """
    Função principal para extrair as disciplinas do PDF.

    Parâmetros:
    pdf_path (str): O caminho para o arquivo PDF a ser processado.

    Retorna:
    List[dict]: Lista de dicionários contendo informações sobre as disciplinas (código, turma, nome e horários).
    """
    disciplinas = []
    
    with pdfplumber.open(pdf_path) as pdf:
        texto = ""
        for page in pdf.pages:
            texto += page.extract_text() + "\n"

    linhas = texto.split("\n")

    i = 0
    while i < len(linhas):
        linha = linhas[i]

        # Detecta o início de uma linha de disciplina
        if re.match(r"^[A-Z]{3}\d{4}", linha):
            linha_completa = linha

            # Junta as linhas seguintes caso a turma tenha dois horários
            j = i + 1
            while j < len(linhas) and not re.match(r"^[A-Z]{3}\d{4}", linhas[j]):
                linha_completa += " " + linhas[j]
                j += 1

            try:
                partes = linha_completa.split()

                codigo = partes[0]
                turma = partes[1]

                # Extrai o nome da disciplina
                nome = []
                k = 2
                while k < len(partes) and not partes[k].isdigit():
                    nome.append(partes[k])
                    k += 1

                nome = " ".join(nome)

                # Extrai os horários da disciplina
                horarios = extrair_horarios(linha_completa)

                disciplinas.append({
                    "codigo": codigo,
                    "turma": turma,
                    "nome": nome,
                    "horarios": horarios
                })

            except Exception as e:
                print(f"Erro ao processar linha: {linha_completa}")

            i = j
        else:
            i += 1

    return disciplinas


def gerar_sql(disciplinas: List[Dict[str, str]], output_sql: str) -> None:
    """
    Função para gerar o SQL de criação e inserção das disciplinas e horários.

    Parâmetros:
    disciplinas (List[dict]): Lista de dicionários contendo as informações das disciplinas.
    output_sql (str): O caminho para o arquivo onde o SQL gerado será salvo.

    Retorna:
    None: A função salva o SQL gerado no arquivo especificado.
    """
    sql = []

    # Criação das tabelas no banco de dados
    sql.append("""
        CREATE TABLE disciplinas (
            id SERIAL PRIMARY KEY,
            codigo VARCHAR(10),
            nome TEXT
        );
        
        CREATE TABLE turmas (
            id SERIAL PRIMARY KEY,
            course_id INTEGER REFERENCES disciplinas(id),
            turma VARCHAR(10)
        );
        
        CREATE TABLE grade (
            id SERIAL PRIMARY KEY,
            section_id INTEGER REFERENCES turmas(id),
            dia_semana INTEGER,
            hora_inicio TIME,
            hora_fim TIME
        );
    """)

    mapa_disciplinas = {}
    disciplina_id = 1
    turma_id = 1

    for d in disciplinas:
        # Inserir a disciplina se ela não estiver no mapa
        if d["codigo"] not in mapa_disciplinas:
            sql.append(
                f"INSERT INTO disciplinas (id, codigo, nome) VALUES ({disciplina_id}, '{d['codigo']}', '{d['nome']}');"
            )
            mapa_disciplinas[d["codigo"]] = disciplina_id
            disciplina_id += 1

        did = mapa_disciplinas[d["codigo"]]

        # Inserir a turma
        sql.append(
            f"INSERT INTO turmas (id, course_id, turma) VALUES ({turma_id}, {did}, '{d['turma']}');"
        )

        # Inserir os horários
        for h in d["horarios"]:
            sql.append(
                f"""INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES ({turma_id}, {h['dia_semana']}, '{h['hora_inicio']}', '{h['hora_fim']}');"""
            )

        turma_id += 1

    with open(output_sql, "w") as f:
        f.write("\n".join(sql))

    print("SQL gerado com sucesso!")


if __name__ == "__main__":
    disciplinas = extrair_disciplinas_do_pdf(PDF_PATH)
    gerar_sql(disciplinas, OUTPUT_SQL)