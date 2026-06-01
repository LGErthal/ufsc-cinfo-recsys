import pandas as pd


def int_ou_zero(valor):
    try:
        return int(valor)
    except (TypeError, ValueError):
        return 0


DIA_MAP_INV = {
    2: "Segunda",
    3: "Terça",
    4: "Quarta",
    5: "Quinta",
    6: "Sexta",
}

def build_timetable(final_grade):
    rows = []
    for disc in final_grade:
        turma = disc["turma_escolhida"]
        for aula in turma["turmas_agenda"]:
            rows.append({
                "dia": DIA_MAP_INV[aula["dia"]],
                "inicio": aula["hora_inicio"][:5],
                "fim": aula["hora_fim"][:5],
                "disciplina": disc["codigo_disciplina"]
            })
    return pd.DataFrame(rows)
        

def render_timetable(df):
    if df.empty:
        return pd.DataFrame()

    df["slot"] = df["inicio"] + " - " + df["fim"]
    timetable = df.pivot_table(
        index="slot",
        columns="dia",
        values="disciplina",
        aggfunc="first"
    )

    order = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta"]
    timetable = timetable.reindex(columns=order)
    return timetable
        

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