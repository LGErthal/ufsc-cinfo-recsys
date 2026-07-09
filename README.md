# UFSC CINFO Recsys

Sistema de recomendação de grade curricular para estudantes de Ciência da Informação da UFSC.

O projeto lê o controle curricular em PDF do aluno, identifica disciplinas aprovadas e em andamento, consulta o currículo e os horários cadastrados no Supabase e monta uma sugestão de grade sem conflitos de horário, respeitando restrições informadas pelo usuário.

## Funcionalidades

- Upload do controle curricular em PDF.
- Identificação automática de disciplinas aprovadas e cursando.
- Suporte aos currículos de 2016 e 2026.
- Cálculo de disciplinas restantes e carga horária de optativas pendente.
- Aplicação de regras de equivalência entre disciplinas.
- Filtros por turnos e horários indisponíveis.
- Preferência por optativas de Tecnologia da Informação ou Gestão da Informação.
- Geração de uma grade recomendada em formato de tabela semanal.

## Tecnologias

- Python
- Streamlit
- Pandas
- pdfplumber
- Supabase

## Estrutura do Projeto

```text
.
├── data/
│   ├── cadastro_turma_*.pdf        # PDFs usados para montar dados de turmas
│   ├── curriculo.csv               # Dados de currículo
│   └── output/                     # SQL gerado a partir dos dados
├── db_conn/
│   └── supabase_conn.py            # Consultas ao Supabase
├── interface/
│   └── app.py                      # Aplicação Streamlit
├── pdf_parser/
│   ├── historico_pdf_parser.py     # Parser do controle curricular do aluno
│   └── pdf_parser.py               # Parser dos PDFs de cadastro de turmas
├── recsys/
│   └── rec_sys.py                  # Algoritmo de filtragem e recomendação
├── utils/
│   ├── disciplinas_handler.py      # Equivalências e cálculo de optativas
│   └── timetable_handler.py        # Montagem e renderização da grade
└── requirements.txt
```

## Como Instalar

### 1. Clonar o repositório

```bash
git clone https://github.com/LGErthal/ufsc-cinfo-recsys.git
cd ufsc-cinfo-recsys
```

### 2. Criar e ativar um ambiente virtual

No macOS/Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

No Windows:

```bash
python -m venv .venv
.venv\Scripts\activate
```

### 3. Instalar as dependências

```bash
pip install -r requirements.txt
```

### 4. Configurar o banco de dados

Antes de executar a aplicação, o banco precisa ter os dados de currículo e de turmas.

Use o arquivo `data/curriculo.csv` para criar e popular a tabela `curriculo`. Essa tabela deve conter as disciplinas do currículo, com informações como código, nome, fase, carga horária, tipo, área e ano do currículo.

Depois, gere os dados de turmas a partir dos PDFs de cadastro de turmas da UFSC. Para isso, ajuste no arquivo `pdf_parser/pdf_parser.py` as variáveis de configuração, se necessário:

```python
PDF_PATH = "./data/input/20262_biblio.pdf"
OUTPUT_SQL = "grade_biblio_20262.sql"
SEMESTRE = "20262"
```

Em seguida, rode:

```bash
python pdf_parser/pdf_parser.py
```

Esse script lê o PDF informado em `PDF_PATH` e gera um arquivo `.sql` com os comandos necessários para criar/popular as tabelas de turmas e horários. Execute o SQL gerado no banco depois de criar a tabela `curriculo`.

O banco usado pela aplicação deve ter, principalmente, as tabelas:

- `curriculo`
- `semestres`
- `turmas`
- `turmas_agenda`

## Como Executar

Com o ambiente virtual ativado, rode:

```bash
streamlit run interface/app.py
```

Depois, abra o endereço exibido pelo Streamlit no navegador. Normalmente será:

```text
http://localhost:8501
```

## Como Usar

1. Faça upload do PDF de controle curricular.
2. Selecione o ano do currículo: `2016` ou `2026`.
3. Confira as listas de disciplinas aprovadas, cursando e para cursar.
4. Informe turnos em que você não pode ter aula, se houver.
5. Informe dias ou horários bloqueados, se houver.
6. Escolha se deseja incluir optativas na recomendação.
7. Caso escolha optativas, selecione a área de preferência.
8. Clique em `Gerar!`.

O sistema exibirá uma grade semanal recomendada e a lista de disciplinas selecionadas.

## Como o Sistema Funciona

### 1. Leitura do histórico

O arquivo `pdf_parser/historico_pdf_parser.py` usa `pdfplumber` para extrair texto do controle curricular em PDF. Ele procura códigos de disciplinas, carga horária, tipo, nota e status.

Disciplinas com nota maior ou igual a `6.0` são classificadas como `APROVADO`. Disciplinas marcadas como `Cursando` são classificadas como `CURSANDO`.

### 2. Consulta do currículo

O arquivo `db_conn/supabase_conn.py` consulta a tabela `curriculo` no Supabase para buscar as disciplinas do currículo selecionado.

Depois, o sistema remove da lista de disciplinas pendentes tudo que o aluno já aprovou ou está cursando.

### 3. Regras de equivalência e optativas

O arquivo `utils/disciplinas_handler.py` aplica equivalências entre disciplinas dos currículos de 2016 e 2026.

Também calcula quantas horas de optativas ainda faltam:

- Currículo 2016: até `576` horas de optativas.
- Currículo 2026: até `540` horas de optativas.

### 4. Busca de horários disponíveis

Com a lista de disciplinas pendentes, o sistema consulta o Supabase para buscar turmas e horários cadastrados.

Cada turma contém uma agenda com:

- dia da semana;
- hora de início;
- hora de fim.

### 5. Aplicação das restrições do aluno

O arquivo `recsys/rec_sys.py` remove turmas que batem com:

- turnos bloqueados, como manhã, tarde ou noite;
- dias bloqueados;
- horários específicos bloqueados.

Também existe uma regra especial para `CIN7505`: ela só aparece quando não existe nenhuma disciplina disponível das fases 1, 2, 3 ou 4.

### 6. Seleção da grade

O recomendador ordena as disciplinas por prioridade:

1. Obrigatórias vêm antes de optativas.
2. Obrigatórias de fases mais iniciais vêm antes.
3. Optativas que combinam com a área preferida vêm antes.
4. Disciplinas são selecionadas apenas se não causarem conflito de horário.

O sistema também respeita:

- limite geral de `468` horas na grade recomendada;
- limite de horas optativas restantes do aluno;
- conflitos entre turmas no mesmo dia e horário.

### 7. Renderização da grade

O arquivo `utils/timetable_handler.py` transforma as disciplinas escolhidas em uma tabela semanal com dias da semana nas colunas e horários da UFSC nas linhas.

## Geração de Dados de Turmas

O arquivo `pdf_parser/pdf_parser.py` é usado para extrair turmas dos PDFs de cadastro de turma e gerar SQL de carga no banco.

Ele lê códigos, nomes, turmas e horários no formato usado pela UFSC e gera comandos SQL para popular:

- `semestres`
- `turmas`
- `turmas_agenda`

Os arquivos `.sql` na raiz e em `data/output/` são exemplos de cargas geradas.

## Observações

- O app depende de dados corretos no Supabase para funcionar.
- O controle curricular enviado precisa estar em um formato compatível com o parser atual.
- As credenciais do Supabase não devem ser commitadas no repositório.
- Caso a estrutura dos PDFs da UFSC mude, os parsers em `pdf_parser/` podem precisar de ajustes.
