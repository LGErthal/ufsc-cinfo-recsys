import os
import streamlit as st
from supabase import create_client, Client


SUPABASE_URL = st.secrets["SUPABASE_URL"]
SUPABASE_KEY = st.secrets["API_KEY"]


supabase: Client = create_client(
    SUPABASE_URL,
    SUPABASE_KEY
)


def get_curriculo(
    ano_curriculo: int
):
    """Seleciona todas as colunas da tabela CURRICULO, filtrando pelo ANO CURRICULO e ordernando pela coluna FASE ASC"""
    
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