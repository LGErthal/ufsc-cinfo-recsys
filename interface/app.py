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

    # união dos códigos APROVADAS + CURSANDO
    codigos_excluir = set(
        df_aprovadas["Código"].tolist() +
        df_cursando["Código"].tolist()
    )
    response = get_curriculo(ano_curriculo=ano_curriculo)

    # PARA CURSAR
    df_cursar = [
        {
            "Código": d["codigo_disciplina"],
            "Nome": d["nome_disciplina"],
            "Fase": d["fase"],
            "tipo": d["tipo"],
            "carga_horaria": d["carga_horaria"],
        }
        for d in response
        if (
            d["codigo_disciplina"] not in codigos_excluir
        )
    ]

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
        ).sort_values("Fase")

        st.dataframe(
            df_para_cursar[df_para_cursar["Fase"] != 0], #IGNORAMOS AS OPTATIVAS NESTE PRIMEIRO MOMENTO
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
        codigos = df_para_cursar[df_para_cursar["Fase"] != 0]["Código"].tolist()
        horarios = get_horarios(codigos)
        #st.write(horarios)

        filtered = filtrar_disciplinas(
            horarios,
            options_turnos=options_turnos,
            horarios_bloqueados=horarios_bloqueados
        )

        final_grade = selecionar_grade(filtered)

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

            # pivot-friendly format
            df["slot"] = df["inicio"] + " - " + df["fim"]

            timetable = df.pivot_table(
                index="slot",
                columns="dia",
                values="disciplina",
                aggfunc="first"
            )

            # order columns
            order = ["Seg", "Ter", "Qua", "Qui", "Sex"]
            timetable = timetable.reindex(columns=order)

            return timetable
        
        df_tt = build_timetable(final_grade)
        tt_view = render_timetable(df_tt)
        
        st.subheader("📅 Sua Grade de Horários")
        st.dataframe(tt_view, use_container_width=True)