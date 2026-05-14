import sys
import time
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parent.parent
sys.path.append(str(ROOT_DIR))

import streamlit as st
import pandas as pd

from pdf_parser.historico_pdf_parser import extrair_disciplinas

st.set_page_config(
    page_title="Sistema de Recomendação de Grade Curricular",
    page_icon="📚",
    layout="wide"
)

st.image("data/capa_cinfo.png")

st.title("Sistema de Recomendação de Grade Curricular")

pdf_curriculo = st.file_uploader(
    "Faça o upload do Controle Curricular",
    type=["pdf"]
)

if pdf_curriculo:

    disciplinas_pdf = extrair_disciplinas(pdf_curriculo)

    # Separação por status
    aprovadas = [
        d for d in disciplinas_pdf
        if d["status"] == "APROVADO"
    ]

    cursando = [
        d for d in disciplinas_pdf
        if d["status"] == "CURSANDO"
    ]

    # DataFrames
    df_aprovadas = pd.DataFrame(aprovadas)
    df_cursando = pd.DataFrame(cursando)

    # APROVADAS
    df_aprovadas = df_aprovadas[
        ["codigo_disciplina", "nome_disciplina", "nota"]
    ].rename(columns={
        "codigo_disciplina": "Código",
        "nome_disciplina": "Nome",
        "nota": "Nota"
    })


    # CURSANDO
    df_cursando = df_cursando[
        ["codigo_disciplina", "nome_disciplina"]
    ].rename(columns={
        "codigo_disciplina": "Código",
        "nome_disciplina": "Nome"
    })

    # COLUNAS DAS DISCIPLINAS
    disc_col1, disc_col2 = st.columns(2)

    with disc_col1:
        st.subheader("APROVADAS")

        st.dataframe(
            df_aprovadas,
            hide_index=True,
            width="stretch"
        )

    with disc_col2:
        st.subheader("CURSANDO")

        st.dataframe(
            df_cursando,
            hide_index=True,
            width="stretch"
        )

    st.divider()


    # COLUNAS DAS RESTRIÇÕES
    rest_col1, rest_col2, rest_col3 = st.columns(3)

    with rest_col1:

        st.subheader("Restrições de Turnos")

        options_turnos = st.multiselect(
            "Turnos que você não pode ter aula",
            [
                "Todas as manhãs",
                "Todas as tardes",
                "Todas as noites"
            ],
            placeholder="Caso não haja restrição, pule esta etapa"
        )

    with rest_col2:

        st.subheader("Restrições de Horários")

        horarios_ufsc = [
            "07:30 - 08:20",
            "08:20 - 09:10",
            "09:10 - 10:00",
            "10:10 - 11:00",
            "11:00 - 11:50",
            "11:50 - 12:40",

            "13:30 - 14:20",
            "14:20 - 15:10",
            "15:10 - 16:00",
            "16:20 - 17:10",
            "17:10 - 18:00",
            "18:00 - 18:50",

            "18:30 - 19:20",
            "19:20 - 20:10",
            "20:20 - 21:10",
            "21:10 - 22:00",
        ]

        dias_semana = [
            "Segunda",
            "Terça",
            "Quarta",
            "Quinta",
            "Sexta",
        ]

        opcoes_horarios = [
            f"{dia} | {horario}"
            for dia in dias_semana
            for horario in horarios_ufsc
        ]

        horarios_bloqueados = st.multiselect(
            "Horários que você não pode ter aula",
            options=dias_semana + opcoes_horarios,
            placeholder="Caso não haja restrição, pule esta etapa"
        )

    with rest_col3:
        st.subheader("Optativas")
        tipo_opt = st.radio("Preferência por...",
        ["Tecnologia da Informação", "Gestão da Informação", "Indiferente"],
        )

    
    st.divider()
    st.header("Gere sua recomendação de grade curricular")
    botao = st.button("Gerar!", type="primary")

    if botao:
        with st.spinner("Aguarde", show_time=True):
            time.sleep(1)
            st.text('yup')
