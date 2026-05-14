from pdf_parser.historico_pdf_parser import extrair_disciplinas
from db_conn.supabase_conn import check_table

tabela = 'curriculo'

# Dados do PDF
disciplinas_pdf = extrair_disciplinas()

# Dados do banco
disciplinas_db_raw = check_table(tabela)

# Normaliza banco (padroniza "codigo")
disciplinas_db = [
    {
        "codigo_disciplina": d["codigo_disciplina"],
        "nome_disciplina": d["nome_disciplina"]
    }
    for d in disciplinas_db_raw
]

# -------------------------
# Separação por status
# -------------------------
aprovadas = [d for d in disciplinas_pdf if d["status"] == "APROVADO"]
cursando = [d for d in disciplinas_pdf if d["status"] == "CURSANDO"]

# -------------------------
# Sets de códigos
# -------------------------
codigos_feitos = set(d["codigo_disciplina"] for d in disciplinas_pdf)
codigos_db = set(d["codigo_disciplina"] for d in disciplinas_db)

# -------------------------
# Disciplinas faltantes
# -------------------------
faltantes = codigos_db - codigos_feitos

disciplinas_faltantes = [
    d for d in disciplinas_db if d["codigo_disciplina"] in faltantes
]

# -------------------------
# Saída
# -------------------------
print("\nAPROVADAS:")
for d in aprovadas:
    print(d)

print("\nCURSANDO:")
for d in cursando:
    print(d)

print("\nFALTANTES:")
for d in disciplinas_faltantes:
    print(d)