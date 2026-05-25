import pandas as pd

DIA_MAP_INV = {
    2: "Seg",
    3: "Ter",
    4: "Qua",
    5: "Qui",
    6: "Sex",
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

    order = ["Seg", "Ter", "Qua", "Qui", "Sex"]
    timetable = timetable.reindex(columns=order)
    return timetable
        
