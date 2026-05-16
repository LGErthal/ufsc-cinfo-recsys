from datetime import datetime


# -----------------------------
# Helpers
# -----------------------------

DIA_MAP = {
    2: "Segunda",
    3: "Terça",
    4: "Quarta",
    5: "Quinta",
    6: "Sexta",
}


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


# -----------------------------
# Turnos restriction
# -----------------------------

TURNOS = {
    "Todas as manhãs": (7 * 60 + 30, 12 * 60),
    "Todas as tardes": (13 * 60 + 30, 17 * 60 + 30),
    "Todas as noites": (18 * 60 + 30, 22 * 60),
}


def is_blocked_by_turno(turma, options_turnos) -> bool:
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


# -----------------------------
# Horário específico (dia + hora)
# -----------------------------

def is_blocked_by_schedule(turma, horarios_bloqueados) -> bool:
    if not horarios_bloqueados:
        return False

    for h in horarios_bloqueados:
        try:
            parts = [x.strip() for x in h.split("|")]

            dia_txt = parts[0].strip().lower()

            # CASE 1: ONLY DAY BLOCK
            if len(parts) == 1:
                for aula in turma.get("turmas_agenda", []):
                    print(aula)
                    dia = DIA_MAP.get(aula["dia"], "").lower()

                    if dia == dia_txt:
                        return True

            # CASE 2: DAY + TIME BLOCK
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


# -----------------------------
# Main filter
# -----------------------------

def filtrar_disciplinas(horarios, options_turnos=None, horarios_bloqueados=None):
    """
    Returns ONLY valid disciplinas + turmas
    after applying constraints.
    """

    resultado = []

    for disciplina in horarios:
        disciplinas_validas = {
            "codigo_disciplina": disciplina["codigo_disciplina"],
            "nome_disciplina": disciplina["nome_disciplina"],
            "fase": disciplina["fase"],
            "tipo": disciplina["tipo"],
            "turmas": []
        }

        for turma in disciplina.get("turmas", []):
            if is_blocked_by_turno(turma, options_turnos):
                continue

            if is_blocked_by_schedule(turma, horarios_bloqueados):
                continue

            disciplinas_validas["turmas"].append(turma)

        # only keep if at least one valid turma exists
        if disciplinas_validas["turmas"]:
            resultado.append(disciplinas_validas)

    return resultado


def has_time_conflict(turma1, turma2):
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

def selecionar_grade(disciplinas):
    """
    Greedy selection:
    - lower fase wins
    - no time conflicts allowed
    """

    # sort by fase (priority)
    disciplinas = sorted(disciplinas, key=lambda d: d["fase"])

    selecionadas = []
    turmas_escolhidas = []

    for disc in disciplinas:
        melhor_turma = None

        for turma in disc["turmas"]:
            conflito = False

            for t in turmas_escolhidas:
                if has_time_conflict(turma, t):
                    conflito = True
                    break

            if not conflito:
                melhor_turma = turma
                break  # pick first valid one

        if melhor_turma:
            selecionadas.append({
                "codigo_disciplina": disc["codigo_disciplina"],
                "nome_disciplina": disc["nome_disciplina"],
                "fase": disc["fase"],
                "turma_escolhida": melhor_turma
            })

            turmas_escolhidas.append(melhor_turma)

    return selecionadas
