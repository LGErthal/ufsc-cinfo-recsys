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
    """
    Seleciona todas as colunas da tabela CURRICULO, filtrando pelo ANO CURRICULO,
    ordenando primeiro por TIPO (Ob antes de Op) e depois por FASE.
    """
    
    response = (
        supabase
        .table("curriculo")
        .select("*")
        .eq("ano_curriculo", ano_curriculo)
        .order("tipo", desc=False)  # Corrigido: 'desc=False' em vez de 'ascending=True'
        .order("fase", desc=False)  # Corrigido: 'desc=False' em vez de 'ascending=True'
        .execute()
    )
    
    return response.data


def get_horarios(codigos_disciplinas: list, ano_curriculo):

    response = (
        supabase
        .table("curriculo")
        .select("""
            codigo_disciplina,
            nome_disciplina,
            fase,
            tipo,
            area,
            carga_horaria,
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
        .eq("ano_curriculo", ano_curriculo)
        .in_("codigo_disciplina", codigos_disciplinas)
        .execute()
    )

    return response.data