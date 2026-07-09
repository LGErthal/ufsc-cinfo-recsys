
CREATE TABLE IF NOT EXISTS semestres (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    semestre VARCHAR(10) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS turmas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    created_at TIMESTAMP DEFAULT NOW(),

    semestre_id INTEGER NOT NULL
        REFERENCES semestres(id),

    curriculo_disciplina INTEGER NOT NULL
        REFERENCES curriculo(id),

    turma VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS turmas_agenda (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    turma_id INTEGER NOT NULL
        REFERENCES turmas(id),

    dia INTEGER NOT NULL,

    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS unique_turma
ON turmas (
    semestre_id,
    curriculo_disciplina,
    turma
);

CREATE INDEX IF NOT EXISTS idx_curriculo_codigo
ON curriculo(codigo_disciplina);

CREATE INDEX IF NOT EXISTS idx_turmas_semestre
ON turmas(semestre_id);

CREATE INDEX IF NOT EXISTS idx_turmas_agenda_turma
ON turmas_agenda(turma_id);

CREATE INDEX IF NOT EXISTS idx_turmas_agenda_dia
ON turmas_agenda(dia);

ALTER TABLE semestres DISABLE ROW LEVEL SECURITY;
ALTER TABLE turmas DISABLE ROW LEVEL SECURITY;
ALTER TABLE turmas_agenda DISABLE ROW LEVEL SECURITY;


INSERT INTO semestres (semestre)
VALUES ('20262')
ON CONFLICT (semestre) DO NOTHING;


DO $$
DECLARE
    v_semestre_id INTEGER;
    v_turma_id INTEGER;
    r_curr RECORD;
BEGIN

SELECT id
INTO v_semestre_id
FROM semestres
WHERE semestre = '20262';


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CAD5103') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Administração I', 0, 'CAD5103', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CAD5103') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CAD5103') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Administração I', 0, 'CAD5103', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CAD5103') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342D';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342D')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7141') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Lógica Instrumental I', 0, 'CIN7141', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7141') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7143') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Empreendedorismo I', 0, 'CIN7143', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7143') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7144') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Tutoria Acadêmica I', 0, 'CIN7144', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7144') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '15:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '15:10:00', '16:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7145') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Gestão da Informação', 0, 'CIN7145', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7145') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '16:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '16:20:00', '18:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7201') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Sistemas de Organização do', 0, 'CIN7201', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7201') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7204') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Tutoria Acadêmica II', 0, 'CIN7204', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7204') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '17:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '17:10:00', '18:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7301') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução à Representação Temática', 0, 'CIN7301', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7301') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7301') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução à Representação Temática', 0, 'CIN7301', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7301') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7302') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução à Representação Descritiva', 0, 'CIN7302', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7302') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7302') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução à Representação Descritiva', 0, 'CIN7302', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7302') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7303') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Metodologia da Pesquisa', 0, 'CIN7303', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7303') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7303') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Metodologia da Pesquisa', 0, 'CIN7303', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7303') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7304') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução à Bancos de Dados', 0, 'CIN7304', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7304') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '08:20:00', '10:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7304') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução à Bancos de Dados', 0, 'CIN7304', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7304') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7306') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Competência Informacional', 0, 'CIN7306', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7306') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '08:20:00', '10:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7306') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Competência Informacional', 0, 'CIN7306', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7306') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7309') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Gestão de Processos Organizacionais', 0, 'CIN7309', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7309') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7309') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Gestão de Processos Organizacionais', 0, 'CIN7309', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7309') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '08:20:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7401') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estudos Métricos da Informação', 0, 'CIN7401', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7401') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '08:20:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7401') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estudos Métricos da Informação', 0, 'CIN7401', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7401') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7402') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Editoração Científica', 0, 'CIN7402', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7402') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7402') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Editoração Científica', 0, 'CIN7402', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7402') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7403') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Acessibilidade e Inclusão Digital', 0, 'CIN7403', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7403') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '17:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '17:10:00', '18:00:00');
        END IF;


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '17:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '17:10:00', '18:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7404') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Planejamento Estratégico', 0, 'CIN7404', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7404') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '07:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '07:30:00', '08:20:00');
        END IF;


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '07:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '07:30:00', '08:20:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7404') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Planejamento Estratégico', 0, 'CIN7404', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7404') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7405') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Projeto de Informatização', 0, 'CIN7405', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7405') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7405') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Projeto de Informatização', 0, 'CIN7405', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7405') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7406') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Preservação Digital', 0, 'CIN7406', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7406') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '08:20:00', '10:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7406') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Preservação Digital', 0, 'CIN7406', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7406') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7412') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Marketing da Informação', 0, 'CIN7412', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7412') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7412') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Marketing da Informação', 0, 'CIN7412', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7412') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7501') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Arquitetura da Informação e Usabilidade', 0, 'CIN7501', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7501') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7502') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Mineração de Texto', 0, 'CIN7502', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7502') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7503') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Bancos de Dados', 0, 'CIN7503', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7503') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7504') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Gerenciamento de Projetos', 0, 'CIN7504', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7504') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7505') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estágio em Ciência da Informação', 0, 'CIN7505', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7505') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '14:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '14:20:00', '16:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7601') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Linked Data', 0, 'CIN7601', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7601') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7602') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Mídias Sociais', 0, 'CIN7602', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7602') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7603') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Empreendedorismo II', 0, 'CIN7603', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7603') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7604') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'TCC', 0, 'CIN7604', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7604') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '16:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '16:20:00', '18:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7903') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Inteligência Competitiva', 0, 'CIN7903', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7903') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7904') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Avaliação de Desempenho', 0, 'CIN7904', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7904') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7905') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Teoria da Decisão', 0, 'CIN7905', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7905') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7907') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Lógica Aplicada I', 0, 'CIN7907', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7907') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7913') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Lógica Instrumental II', 0, 'CIN7913', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7913') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7917') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Visualização da Informação', 0, 'CIN7917', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7917') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7917') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Visualização da Informação', 0, 'CIN7917', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7917') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7925') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução a Algoritmos', 0, 'CIN7925', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7925') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7927') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Gestão da Informação Pública', 0, 'CIN7927', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7927') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7935') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Liderança e Gerência', 0, 'CIN7935', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7935') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7936') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Proteção de Dados Pessoais', 0, 'CIN7936', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7936') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '08:20:00', '10:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7936') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Proteção de Dados Pessoais', 0, 'CIN7936', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7936') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7938') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Segurança da Informação', 0, 'CIN7938', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7938') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7943') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Experiência do Usuário (UX) User', 0, 'CIN7943', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7943') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7945') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Fontes de Informação Tecnológica', 0, 'CIN7945', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7945') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7946') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Pitch de Carreira', 0, 'CIN7946', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7946') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '20:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '20:20:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7950') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Programa de Intercâmbio I', 0, 'CIN7950', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7950') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'HST7921') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'História do Brasil Contemporâneo', 0, 'HST7921', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'HST7921') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '08:20:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'HST7921') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'História do Brasil Contemporâneo', 0, 'HST7921', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'HST7921') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '03342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'INE5111') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estatística Aplicada I', 0, 'INE5111', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'INE5111') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342A';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342A')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '08:20:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '08:20:00', '10:00:00');
        END IF;


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '10:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '10:10:00', '11:50:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'INE5111') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estatística Aplicada I', 0, 'INE5111', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'INE5111') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 2 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 2, '18:30:00', '20:10:00');
        END IF;


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'LLV7802') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Leitura e Produção do Texto', 0, 'LLV7802', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'LLV7802') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'LLV7802') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Leitura e Produção do Texto', 0, 'LLV7802', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'LLV7802') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342D';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342D')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'MTM3110') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Cálculo 1', 0, 'MTM3110', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'MTM3110') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01342';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01342')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '18:30:00', '20:10:00');
        END IF;


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


END $$;
