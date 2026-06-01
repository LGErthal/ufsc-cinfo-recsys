from datetime import datetime

DIA_MAP = {
    2: "Segunda",
    3: "Terça",
    4: "Quarta",
    5: "Quinta",
    6: "Sexta",
}

TURNOS = {
    "Todas as manhãs": (7 * 60 + 30, 12 * 60),
    "Todas as tardes": (13 * 60 + 30, 17 * 60 + 30),
    "Todas as noites": (18 * 60 + 30, 22 * 60),
}

AREA_PREFERENCIA = {
    "Tecnologia da Informação": 1,
    "Gestão da Informação": 2,
}


def int_ou_zero(valor):
    try:
        return int(valor)
    except (TypeError, ValueError):
        return 0


def eh_obrigatoria(disc):
    tipo = str(disc.get("tipo", "")).strip().lower()
    fase = int_ou_zero(disc.get("fase"))

    return fase != 0 or tipo in {"ob", "obrigatoria", "obrigatória"}


def parse_time(t: str) -> int:
    """
    Converts '18:30:00' -> minutes since 00:00
    """
    h, m, _ = t.split(":")
    return int(h) * 60 + int(m)


def interval_overlap(a_start, a_end, b_start, b_end) -> bool:
    """
    Returns True if two time intervals overlap
    """
    return not (a_end <= b_start or a_start >= b_end)


def turno_bloqueado(turma, options_turnos) -> bool:
    if not options_turnos:
        return False

    for turno in options_turnos:
        if turno not in TURNOS:
            continue

        block_start, block_end = TURNOS[turno]

        for aula in turma.get("turmas_agenda", []):
            start = parse_time(aula["hora_inicio"])
            end = parse_time(aula["hora_fim"])

            if interval_overlap(start, end, block_start, block_end):
                return True

    return False


def horario_bloqueado(turma, horarios_bloqueados) -> bool:
    if not horarios_bloqueados:
        return False

    for h in horarios_bloqueados:
        try:
            parts = [x.strip() for x in h.split("|")]

            dia_txt = parts[0].strip().lower()

            # CASO 1: DIA BLOQUEADO
            if len(parts) == 1:
                for aula in turma.get("turmas_agenda", []):
                    print(aula)
                    dia = DIA_MAP.get(aula["dia"], "").lower()

                    if dia == dia_txt:
                        return True

            # CASO 2: DIA E HORÁRIO BLOQUEADO
            else:
                horas = parts[1]
                inicio_str, fim_str = [x.strip() for x in horas.split("-")]

                inicio = parse_time(inicio_str + ":00")
                fim = parse_time(fim_str + ":00")

                for aula in turma.get("turmas_agenda", []):
                    dia = DIA_MAP.get(aula["dia"], "").lower()

                    if dia != dia_txt:
                        continue

                    start = parse_time(aula["hora_inicio"])
                    end = parse_time(aula["hora_fim"])

                    if interval_overlap(start, end, inicio, fim):
                        return True

        except Exception:
            continue

    return False


def filtrar_disciplinas(horarios, options_turnos=None, horarios_bloqueados=None):
    """
    Retorna apenas disciplinas + turmas válidas
    após restrições
    """

    resultado = []

    for disciplina in horarios:
        disciplinas_validas = {
            "codigo_disciplina": disciplina["codigo_disciplina"],
            "nome_disciplina": disciplina["nome_disciplina"],
            "fase": disciplina["fase"],
            "tipo": disciplina["tipo"],
            "area": disciplina.get("area"),
            "carga_horaria": disciplina.get("carga_horaria", 0),
            "turmas": []
        }

        for turma in disciplina.get("turmas", []):
            if turno_bloqueado(turma, options_turnos):
                continue

            if horario_bloqueado(turma, horarios_bloqueados):
                continue

            disciplinas_validas["turmas"].append(turma)

        if disciplinas_validas["turmas"]:
            resultado.append(disciplinas_validas)

    return resultado


def possui_conflito_horario(turma1, turma2):
    for a1 in turma1["turmas_agenda"]:
        a1_start = parse_time(a1["hora_inicio"])
        a1_end = parse_time(a1["hora_fim"])

        for a2 in turma2["turmas_agenda"]:
            a2_start = parse_time(a2["hora_inicio"])
            a2_end = parse_time(a2["hora_fim"])

            if interval_overlap(a1_start, a1_end, a2_start, a2_end):
                if a1["dia"] == a2["dia"]:
                    return True

    return False


def selecionar_grade(disciplinas, tipo_opt="Indiferente", max_optativas_horas=0):
    """
    Seleção:
    - Obrigatórias têm prioridade
    - Fases obrigatórias mais iniciais têm prioridade
    - Optativas respeitam a preferência de área
    - Sem conflito de horários
    """

    area_preferida = AREA_PREFERENCIA.get(tipo_opt)

    def prioridade_disciplina(disc):
        obrigatoria = eh_obrigatoria(disc)
        area = int_ou_zero(disc.get("area"))
        area_match = 0 if area_preferida is None or area == area_preferida else 1

        fase = int_ou_zero(disc.get("fase"))

        return (
            0 if obrigatoria else 1,
            fase if obrigatoria else area_match,
            0 if obrigatoria else fase,
            disc.get("nome_disciplina", "")
        )

    disciplinas = sorted(disciplinas, key=prioridade_disciplina)

    selecionadas = []
    turmas_escolhidas = []
    optativas_horas = 0

    for disc in disciplinas:
        obrigatoria = eh_obrigatoria(disc)
        area = int_ou_zero(disc.get("area"))
        carga_horaria = int_ou_zero(disc.get("carga_horaria"))

        if not obrigatoria:
            if area == 0:
                continue

            if max_optativas_horas <= 0:
                continue

            if optativas_horas + carga_horaria > max_optativas_horas:
                continue

        melhor_turma = None

        for turma in disc["turmas"]:
            conflito = False

            for t in turmas_escolhidas:
                if possui_conflito_horario(turma, t):
                    conflito = True
                    break

            if not conflito:
                melhor_turma = turma
                break  

        if melhor_turma:
            selecionadas.append({
                "codigo_disciplina": disc["codigo_disciplina"],
                "nome_disciplina": disc["nome_disciplina"],
                "fase": disc["fase"],
                "tipo": disc["tipo"],
                "carga_horaria": carga_horaria,
                "area": disc.get("area"),
                "turma_escolhida": melhor_turma
            })

            turmas_escolhidas.append(melhor_turma)

            if not obrigatoria:
                optativas_horas += carga_horaria

    return selecionadas
