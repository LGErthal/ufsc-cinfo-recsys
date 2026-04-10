import pdfplumber
import re
from typing import List, Dict

# Variáveis
PDF_PATH = "./files/historico2.pdf"


def extrair_nome(bloco: str) -> str:
    """Remove código, carga horária e metadados"""

    # remove códigos duplicados no início
    bloco = re.sub(r"^(?:[A-Z]{3}\d{4})+", "", bloco).strip()

    # remove código restante
    bloco = re.sub(r"^(CIN\d+|[A-Z]{3}\d{4})\s+", "", bloco)

    # corta antes da carga horária (número isolado)
    partes = re.split(r"\s+\d+\b", bloco)
    nome = partes[0]

    # remove informação final (status etc)
    nome = re.sub(r"\b(Cursando|Ob|Op|EX|FS)\b.*", "", nome)

    return nome.strip()


def extrair_disciplinas(pdf_upload) -> List[Dict]:
    """
    Extrai disciplinas do PDF do histórico.
    """
    with pdfplumber.open(pdf_upload) as pdf:
        texto = ""
        for page in pdf.pages:
            texto += page.extract_text() + "\n"

    linhas = texto.split("\n")

    disciplinas = []
    codigos_vistos = set()

    for linha in linhas:
        partes = re.split(r"(?=(CIN\d+|[A-Z]{3}\d{4}))", linha)

        blocos = []
        i = 1
        while i < len(partes):
            bloco = partes[i] + partes[i + 1]
            blocos.append(bloco.strip())
            i += 2

        for bloco in blocos:
            codigo_match = re.match(r"(CIN\d+|[A-Z]{3}\d{4})", bloco)

            if not codigo_match:
                continue

            codigo = codigo_match.group(1)

            if codigo in codigos_vistos:
                continue

            if "Não Cursou" in bloco:
                continue

            if "Cursando" in bloco:
                disciplinas.append({
                    "codigo_disciplina": codigo,
                    "nome_disciplina": extrair_nome(bloco),
                    "nota": None,
                    "status": "CURSANDO"
                })
                codigos_vistos.add(codigo)
                continue

            match_nota = re.search(r"(\d{4}/\d)\s+(\d+\.\d)", bloco)

            if match_nota:
                nota = float(match_nota.group(2))

                if nota >= 6:
                    disciplinas.append({
                        "codigo_disciplina": codigo,
                        "nome_disciplina": extrair_nome(bloco),
                        "nota": nota,
                        "status": "APROVADO"
                    })
                    codigos_vistos.add(codigo)

    return disciplinas


if __name__ == "__main__":
    disciplinas = extrair_disciplinas()

    for d in disciplinas:
        print(d)