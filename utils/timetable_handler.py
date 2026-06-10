import pandas as pd
from datetime import time

SLOTS_UFSC = [
    # Manhã
    (time(7, 30), time(8, 20)),
    (time(8, 20), time(9, 10)),
    (time(9, 10), time(10, 0)),
    (time(10, 10), time(11, 0)),
    (time(11, 0), time(11, 50)),
    # Tarde
    (time(13, 30), time(14, 20)),
    (time(14, 20), time(15, 10)),
    (time(15, 10), time(16, 0)),
    (time(16, 20), time(17, 10)),
    (time(17, 10), time(18, 0)),
    # Noite
    (time(18, 30), time(19, 20)),
    (time(19, 20), time(20, 10)),
    (time(20, 20), time(21, 10)),
    (time(21, 10), time(22, 0)),
]

DIA_MAP_INV = {
    2: "Segunda", 3: "Terça", 4: "Quarta", 
    5: "Quinta", 6: "Sexta"
}

def str_para_time(txt):
    return time(int(txt.split(":")[0]), int(txt.split(":")[1]))

def formatar_rotulo(ini_str):
    if ini_str == "11:00":
        return "11:50"
    if ini_str == "17:10":
        return "17:10\n18:00"
    if ini_str == "21:10":
        return "22:00"
    return ini_str

def build_timetable(final_grade):
    rows = []
    for disc in final_grade:
        turma = disc["turma_escolhida"]
        for aula in turma["turmas_agenda"]:
            aula_inicio = str_para_time(aula["hora_inicio"])
            aula_fim = str_para_time(aula["hora_fim"])
            dia_semana = DIA_MAP_INV[aula["dia"]]

            for slot_ini, slot_fim in SLOTS_UFSC:
                if aula_inicio <= slot_ini and aula_fim >= slot_fim:
                    ini_str = slot_ini.strftime("%H:%M")
                    rows.append({
                        "dia": dia_semana,
                        "slot": formatar_rotulo(ini_str),
                        "disciplina": disc["codigo_disciplina"]
                    })
    return pd.DataFrame(rows)


def render_timetable(df):
    if df.empty:
        return pd.DataFrame()

    timetable = df.pivot_table(
        index="slot", 
        columns="dia", 
        values="disciplina", 
        aggfunc="first"
    )

    # Gera a estrutura de ordenação aplicando a nova regra de rótulos
    ordem_linhas = [formatar_rotulo(ini.strftime("%H:%M")) for ini, _ in SLOTS_UFSC]
    ordem_colunas = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

    return timetable.reindex(index=ordem_linhas, columns=ordem_colunas).fillna("")

def int_ou_zero(valor):
    try:
        return int(valor)
    except (TypeError, ValueError):
        return 0

        

def montar_recomendacao(df_para_cursar, gerar_opt):
    fases = df_para_cursar["fase"].apply(int_ou_zero)
    if "area" in df_para_cursar.columns:
        areas = df_para_cursar["area"].apply(int_ou_zero)
    else:
        areas = df_para_cursar["fase"].apply(lambda _: 0)
    obrigatorias = df_para_cursar[
        (fases != 0) &
        (df_para_cursar["codigo_disciplina"] != "OPT")
    ]

    codigos = obrigatorias["codigo_disciplina"].tolist()
    max_optativas_horas = 0

    optativas_restantes = df_para_cursar[
        df_para_cursar["codigo_disciplina"] == "OPT"
    ]

    horas_optativas_restantes = 0
    if not optativas_restantes.empty:
        horas_optativas_restantes = int_ou_zero(
            optativas_restantes.iloc[0]["carga_horaria"]
        )

    tem_optativas_restantes = horas_optativas_restantes > 0

    if gerar_opt == "Sim" and tem_optativas_restantes:
        optativas = df_para_cursar[
            (fases == 0) &
            (areas != 0) &
            (df_para_cursar["codigo_disciplina"] != "OPT") &
            (df_para_cursar["tipo"] != "Ob")
        ]

        codigos += optativas["codigo_disciplina"].tolist()
        max_optativas_horas = horas_optativas_restantes

    return list(dict.fromkeys(codigos)), max_optativas_horas