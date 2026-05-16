
CREATE TABLE IF NOT EXISTS semestres (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    semestre VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS secoes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    created_at TIMESTAMP DEFAULT NOW(),

    semestre_id INTEGER NOT NULL
        REFERENCES semestres(id),

    curriculo_disciplina INTEGER NOT NULL
        REFERENCES curriculo(id),

    turma VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS secoes_agenda (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    secao_id INTEGER NOT NULL
        REFERENCES secoes(id),

    dia INTEGER NOT NULL,

    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS unique_secao
ON secoes (
    semestre_id,
    curriculo_disciplina,
    turma
);

CREATE INDEX IF NOT EXISTS idx_curriculo_codigo
ON curriculo(codigo_disciplina);

CREATE INDEX IF NOT EXISTS idx_secoes_semestre
ON secoes(semestre_id);

CREATE INDEX IF NOT EXISTS idx_secoes_agenda_secao
ON secoes_agenda(secao_id);

CREATE INDEX IF NOT EXISTS idx_secoes_agenda_dia
ON secoes_agenda(dia);

ALTER TABLE semestres DISABLE ROW LEVEL SECURITY;
ALTER TABLE secoes DISABLE ROW LEVEL SECURITY;
ALTER TABLE secoes_agenda DISABLE ROW LEVEL SECURITY;


INSERT INTO semestres (semestre)
VALUES ('20261')
ON CONFLICT (semestre) DO NOTHING;


DO $$
DECLARE
    v_semestre_id INTEGER;
    v_secao_id INTEGER;
    v_curriculo_disciplina INTEGER;
BEGIN

SELECT id
INTO v_semestre_id
FROM semestres
WHERE semestre = '20261';



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CAD5103'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Administração I',
        0,
        'CAD5103',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN5001'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Fundamentos de Biblioteconomia',
        0,
        'CIN5001',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7139'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Introdução às Tecnologias da',
        0,
        'CIN7139',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7140'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Pesquisa Bibliográfica',
        0,
        'CIN7140',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '20:10:00'
    );


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7141'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Lógica Instrumental I',
        0,
        'CIN7141',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7142'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Evolução do Pensamento Filosófico e',
        0,
        'CIN7142',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7143'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Empreendedorismo I',
        0,
        'CIN7143',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7144'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Tutoria Acadêmica I',
        0,
        'CIN7144',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '17:10:00',
        '18:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7201'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Sistemas de Organização do',
        0,
        'CIN7201',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7202'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Sociedade da Informação',
        0,
        'CIN7202',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7203'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Ética Profissional',
        0,
        'CIN7203',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7204'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Tutoria Acadêmica II',
        0,
        'CIN7204',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '17:10:00',
        '18:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7205'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Recuperação da Informação',
        0,
        'CIN7205',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7206'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Fontes Gerais de Informação',
        0,
        'CIN7206',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '02324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '02324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7301'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Introdução à Representação Temática',
        0,
        'CIN7301',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7302'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Introdução à Representação Descritiva',
        0,
        'CIN7302',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7303'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Metodologia da Pesquisa',
        0,
        'CIN7303',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7304'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Introdução à Bancos de Dados',
        0,
        'CIN7304',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7306'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Competência Informacional',
        0,
        'CIN7306',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7309'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Gestão de Processos Organizacionais',
        0,
        'CIN7309',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '20:10:00'
    );


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7401'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Estudos Métricos da Informação',
        0,
        'CIN7401',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7402'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Editoração Científica',
        0,
        'CIN7402',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7403'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Acessibilidade e Inclusão Digital',
        0,
        'CIN7403',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '17:10:00',
        '18:00:00'
    );


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '17:10:00',
        '18:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7404'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Planejamento Estratégico',
        0,
        'CIN7404',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7405'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Projeto de Informatização',
        0,
        'CIN7405',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7406'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Preservação Digital',
        0,
        'CIN7406',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7410'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Laboratório de Empreendimentos Sociais',
        0,
        'CIN7410',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7412'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Marketing da Informação',
        0,
        'CIN7412',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7412'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Marketing da Informação',
        0,
        'CIN7412',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7506'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Representação Descritiva I',
        0,
        'CIN7506',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '05324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '05324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7507'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Sisitemas de Classificação',
        0,
        'CIN7507',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '05324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '05324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '22:00:00'
    );


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7508'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Fontes Especializadas de Informação',
        0,
        'CIN7508',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '05324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '05324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7509'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Estudos de Usuários',
        0,
        'CIN7509',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '05324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '05324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7605'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Representação Descritiva II',
        0,
        'CIN7605',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '06324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '06324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7606'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Organização de Bibliotecas',
        0,
        'CIN7606',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '06324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '06324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7607'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Indexação',
        0,
        'CIN7607',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '06324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '06324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7608'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Formação e Desenvolvimento de',
        0,
        'CIN7608',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '06324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '06324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7702'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Práticas de Tratamento de Informação',
        0,
        'CIN7702',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '07324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '07324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7703'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Referência e Serviços de Informação',
        0,
        'CIN7703',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '07324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '07324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7704'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Projeto de Pesquisa',
        0,
        'CIN7704',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '07324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '07324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7705'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Publicação Bibliográfica',
        0,
        'CIN7705',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '07324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '07324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7706'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Tratamentos de Multimeios',
        0,
        'CIN7706',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '07324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '07324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7801'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Trabalho de Conclusão de Curso',
        0,
        'CIN7801',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '08324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '08324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'CIN7936'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Proteção de Dados Pessoais',
        0,
        'CIN7936',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        4,
        '20:20:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'HST7921'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'História do Brasil Contemporâneo',
        0,
        'HST7921',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '03324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '03324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'INE5111'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Estatística Aplicada I',
        0,
        'INE5111',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '04324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '04324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '20:10:00'
    );


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'JOR5300'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Comunicação',
        0,
        'JOR5300',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '06324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '06324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        2,
        '18:30:00',
        '20:10:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'LLV7802'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Leitura e Produção do Texto',
        0,
        'LLV7802',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'LLV7802'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Leitura e Produção do Texto',
        0,
        'LLV7802',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '01324D'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '01324D'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        6,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'LSB7244'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Língua Brasileira de Sinais - Libras I',
        0,
        'LSB7244',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '08324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '08324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        3,
        '18:30:00',
        '22:00:00'
    );


END IF;



-- =====================================================
-- BUSCA DISCIPLINA
-- =====================================================

SELECT id
INTO v_curriculo_disciplina
FROM curriculo
WHERE codigo_disciplina = 'PSI5112'
LIMIT 1;

-- =====================================================
-- CRIA DISCIPLINA SE NÃO EXISTIR
-- =====================================================

IF v_curriculo_disciplina IS NULL THEN

    INSERT INTO curriculo (
        ano_curriculo,
        fase,
        nome_disciplina,
        carga_horaria,
        codigo_disciplina,
        tipo,
        area
    )
    VALUES (
        2026,
        0,
        'Relações Humanas',
        0,
        'PSI5112',
        'Op',
        0
    )
    RETURNING id INTO v_curriculo_disciplina;

END IF;

-- =====================================================
-- INSERE SEÇÃO
-- =====================================================

IF NOT EXISTS (
    SELECT 1
    FROM secoes s
    WHERE s.semestre_id = v_semestre_id
    AND s.curriculo_disciplina = v_curriculo_disciplina
    AND s.turma = '05324C'
) THEN

    INSERT INTO secoes (
        semestre_id,
        curriculo_disciplina,
        turma
    )
    VALUES (
        v_semestre_id,
        v_curriculo_disciplina,
        '05324C'
    )
    RETURNING id INTO v_secao_id;


    INSERT INTO secoes_agenda (
        secao_id,
        dia,
        hora_inicio,
        hora_fim
    )
    VALUES (
        v_secao_id,
        5,
        '18:30:00',
        '20:10:00'
    );


END IF;


END $$;
