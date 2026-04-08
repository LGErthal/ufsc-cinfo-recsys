import pdfplumber
import re
from typing import List, Dict

# Variáveis
PDF_PATH = "./files/historico.pdf"


def extrair_disciplinas() -> List[Dict]:
    """"
    Extrai as disciplinas do histórico acadêmico a partir do arquivo PDF.
    Retorna uma lista de dicionários contendo o código, nome e nota das disciplinas.
    """
    with pdfplumber.open(PDF_PATH) as pdf:
        texto = ""
        for page in pdf.pages:
            texto += page.extract_text() + "\n"

    linhas = texto.split("\n")

    disciplinas = []
    codigos_vistos = set()

    pattern = re.compile(
        r"(CIN\d+|[A-Z]{3}\d{4})\s+(.+?)\s+\d+\s+\d{4}/\d\s+(\d+\.\d)\s+FS"
    )

    for linha in linhas:
        matches = pattern.findall(linha)

        for match in matches:
            codigo, nome, nota = match
            nota = float(nota)

            if nota > 6 and codigo not in codigos_vistos:
                disciplinas.append({
                    "codigo": codigo,
                    "nome": nome.strip(),
                    "nota": nota
                })
                codigos_vistos.add(codigo)

    return disciplinas


if __name__ == "__main__":
    disciplinas = extrair_disciplinas()
    
    for d in disciplinas:
        print(d)
