# utils/disciplinas_handler.py

import pandas as pd


EQUIVALENCIAS_2016 = {

    "CIN7410": {
        "equivale": ["CIN7408", "CIN7307"],
        "conta_optativa": False
    },

    "CIN7936": {
        "equivale": ["CIN7305"],
        # só conta como optativa
        # se NÃO estiver sendo usada
        # como equivalência obrigatória
        "conta_optativa_condicional": True
    },
}


def equivalencias_2016(
    df: pd.DataFrame,
    codigos_concluidos: set
) -> pd.DataFrame:
    """
    Remove disciplinas equivalentes
    caso o aluno já tenha concluído
    a disciplina principal.
    """

    codigos_remover = set()

    for principal, regra in EQUIVALENCIAS_2016.items():

        equivalentes = regra["equivale"]

        if principal in codigos_concluidos:
            codigos_remover.update(equivalentes)

    df_filtrado = df[
        ~df["codigo_disciplina"].isin(codigos_remover)
    ].copy()

    return df_filtrado


def calcular_optativas(
    df_aprovadas,
    df_cursando,
    ano_curriculo
):

    df_disciplinas = pd.concat(
        [df_aprovadas, df_cursando],
        ignore_index=True
    )

    df_disciplinas = df_disciplinas.drop_duplicates(
        subset=["codigo_disciplina"]
    )

    disciplinas = df_disciplinas["codigo_disciplina"].tolist()

    if ano_curriculo == "2016":

        # CIN7410 conta como obrigatória
        df_disciplinas = df_disciplinas[
            df_disciplinas["codigo_disciplina"] != "CIN7410"
        ]

        # CIN7936 só conta se CIN7305 tiver sido cursada
        if "CIN7936" in disciplinas and "CIN7305" not in disciplinas:
            df_disciplinas = df_disciplinas[
                df_disciplinas["codigo_disciplina"] != "CIN7936"
            ]

    # somente disciplinas não obrigatórias
    df_optativas = df_disciplinas[
        df_disciplinas["tipo"] != "Ob"
    ]

    total_horas = df_optativas["carga_horaria"].sum()

    if ano_curriculo == "2016":
        horas_restantes = max(0, 576 - total_horas)

    elif ano_curriculo == "2026":
        horas_restantes = max(0, 450 - total_horas)

    else:
        horas_restantes = 0

    return {
        "codigo_disciplina": "OPT",
        "nome_disciplina": "OPTATIVAS",
        "fase": 0,
        "tipo": "Op/EX",
        "area": 0,
        "carga_horaria": horas_restantes,
    }