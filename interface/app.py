import sys
import time
from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parent.parent
sys.path.append(str(ROOT_DIR))

import streamlit as st
import pandas as pd

from pdf_parser.historico_pdf_parser import extrair_disciplinas
from db_conn.supabase_conn import get_curriculo, get_horarios
from recsys.rec_sys import filtrar_disciplinas, selecionar_grade
from utils.disciplinas_handler import equivalencias_2016, calcular_optativas
from utils.timetable_handler import build_timetable, render_timetable

st.set_page_config(
    page_title="Sistema de Recomendação de Grade Curricular",
    page_icon="📚",
    layout="wide"
)

st.image("data/capa_cinfo.png")

st.title("Sistema de Recomendação de Grade Curricular")

st.subheader("Faça o upload do Controle Curricular")
pdf_curriculo = st.file_uploader(
    "Anexe o PDF",
    type=["pdf"]
)

st.subheader("Curriculo")
ano_curriculo = st.radio("Selecione o ano do seu curriculo",
["2016", "2026"],
)

if pdf_curriculo:

    disciplinas_df = extrair_disciplinas(pdf_curriculo)

    # Separação por status
    aprovadas = [
        d for d in disciplinas_df
        if d["status"] == "APROVADO"
    ]

    cursando = [
        d for d in disciplinas_df
        if d["status"] == "CURSANDO"
    ]

    df_aprovadas_raw = pd.DataFrame(aprovadas)
    df_cursando_raw = pd.DataFrame(cursando)

    # APROVADAS
    df_aprovadas = df_aprovadas_raw[["codigo_disciplina", "nome_disciplina", "nota", "carga_horaria", "tipo" ]]

    # CURSANDO
    df_cursando = df_cursando_raw[["codigo_disciplina", "nome_disciplina", "carga_horaria", "tipo"]]

    # união dos códigos APROVADAS + CURSANDO
    codigos_excluir = set(
        df_aprovadas["codigo_disciplina"].tolist() +
        df_cursando["codigo_disciplina"].tolist()
    )

    curriculo = get_curriculo(ano_curriculo=ano_curriculo)

    # PARA CURSAR
    df_cursar = pd.DataFrame([
        {
            "codigo_disciplina": d["codigo_disciplina"],
            "nome_disciplina": d["nome_disciplina"],
            "fase": d["fase"],
            "tipo": d["tipo"],
            "carga_horaria": d["carga_horaria"],
        }
        for d in curriculo
        if (
            d["codigo_disciplina"] not in codigos_excluir
        )
    ])

    if ano_curriculo == '2016':
        df_cursar = equivalencias_2016(
            df_cursar,
            codigos_excluir
    )
        
    # linha de optativas
    row_optativas = calcular_optativas(
        df_aprovadas,
        df_cursando,
        ano_curriculo
    )

    # adiciona ao dataframe
    df_cursar = pd.concat(
        [df_cursar, pd.DataFrame([row_optativas])],
        ignore_index=True
    ) 

    # COLUNAS DAS DISCIPLINAS
    disc_col1, disc_col2, disc_col3 = st.columns(3)

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

    with disc_col3:
        st.subheader("PARA CURSAR")
        df_para_cursar = pd.DataFrame(
            df_cursar
        ).sort_values("fase")

        st.dataframe(
            df_para_cursar[(df_para_cursar["fase"] != 0) | (df_para_cursar["codigo_disciplina"] == "OPT")],
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
        gerar_opt = st.radio("Gerar grade com optativas?",
        ["Sim", "Não, apenas disciplinas obrigatórias"],
        )

        if gerar_opt == 'Sim':
            tipo_opt = st.radio("Preferência por...",
            ["Tecnologia da Informação", "Gestão da Informação", "Indiferente"],
            )
    
    st.divider()

    st.header("Gere sua recomendação de grade curricular")
    botao = st.button("Gerar!", type="primary")

    if botao:
        codigos = df_para_cursar[df_para_cursar["Fase"] != 9]["Código"].tolist()
        horarios = get_horarios(codigos)

        filtered = filtrar_disciplinas(
            horarios,
            options_turnos=options_turnos,
            horarios_bloqueados=horarios_bloqueados
        )

        final_grade = selecionar_grade(filtered)
        
        df_tt = build_timetable(final_grade)
        tt_view = render_timetable(df_tt)
        
        st.subheader("Sua Grade de Horários")
        st.dataframe(tt_view, use_container_width=True)