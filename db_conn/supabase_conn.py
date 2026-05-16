import os

from supabase import create_client, Client


SUPABASE_URL = 'https://ebiapqslvifugmknaisr.supabase.co'
SUPABASE_KEY = 'sb_secret_OzBD7N8CNwh-m74xU7tITg_xIlNIH1F'

supabase: Client = create_client(
    SUPABASE_URL,
    SUPABASE_KEY
)


# =========================================================
# CURRICULO
# =========================================================
def get_curriculo(
    ano_curriculo: int
):

    response = (
        supabase
        .table("curriculo")
        .select("*")
        .eq("ano_curriculo", ano_curriculo)
        .order("fase")
        .execute()
    )


    return response.data


def get_horarios(codigos_disciplinas: list):

    response = (
        supabase
        .table("curriculo")
        .select("""
            codigo_disciplina,
            nome_disciplina,
            fase,
            tipo,
            turmas:turmas!inner(
                id,
                semestre_id,
                turmas_agenda!inner(
                    dia,
                    hora_inicio,
                    hora_fim
                )
            )
        """)
        .in_("codigo_disciplina", codigos_disciplinas)
        .execute()
    )

    return response.data