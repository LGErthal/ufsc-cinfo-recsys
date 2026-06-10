
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
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN5001') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Fundamentos de Biblioteconomia', 0, 'CIN5001', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN5001') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN5033') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Conservação e Restauração de', 0, 'CIN5033', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN5033') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '07324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '07324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7139') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Introdução às Tecnologias da', 0, 'CIN7139', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7139') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7140') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Pesquisa Bibliográfica', 0, 'CIN7140', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7140') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7142') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Evolução do Pensamento Filosófico e', 0, 'CIN7142', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7142') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 3 AND hora_inicio = '17:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 3, '17:10:00', '18:00:00');
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
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7202') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Sociedade da Informação', 0, 'CIN7202', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7202') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7203') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Ética Profissional', 0, 'CIN7203', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7203') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
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
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 4 AND hora_inicio = '17:10:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 4, '17:10:00', '18:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7205') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Recuperação da Informação', 0, 'CIN7205', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7205') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7206') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Fontes Gerais de Informação', 0, 'CIN7206', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7206') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '02324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '02324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7410') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Laboratório de Empreendimentos Sociais', 0, 'CIN7410', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7410') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7506') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Representação Descritiva I', 0, 'CIN7506', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7506') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7507') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Sisitemas de Classificação', 0, 'CIN7507', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7507') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05324C')
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


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 6 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 6, '18:30:00', '20:10:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7508') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Fontes Especializadas de Informação', 0, 'CIN7508', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7508') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7509') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estudos de Usuários', 0, 'CIN7509', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7509') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7605') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Representação Descritiva II', 0, 'CIN7605', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7605') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7606') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Organização de Bibliotecas', 0, 'CIN7606', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7606') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06324C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7607') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Indexação', 0, 'CIN7607', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7607') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7608') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Formação e Desenvolvimento de', 0, 'CIN7608', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7608') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7702') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Práticas de Tratamento de Informação', 0, 'CIN7702', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7702') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '07324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '07324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7703') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Referência e Serviços de Informação', 0, 'CIN7703', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7703') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '07324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '07324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7704') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Projeto de Pesquisa', 0, 'CIN7704', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7704') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '07324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '07324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7705') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Publicação Bibliográfica', 0, 'CIN7705', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7705') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '07324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '07324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7706') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Tratamentos de Multimeios', 0, 'CIN7706', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7706') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '07324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '07324C')
            RETURNING id INTO v_turma_id;
        END IF;

        -- Insere as agendas correspondentes ligadas à turma deste currículo (Evitando duplicados na agenda)


        IF NOT EXISTS (
            SELECT 1 FROM turmas_agenda 
            WHERE turma_id = v_turma_id AND dia = 5 AND hora_inicio = '18:30:00'
        ) THEN
            INSERT INTO turmas_agenda (turma_id, dia, hora_inicio, hora_fim)
            VALUES (v_turma_id, 5, '18:30:00', '22:00:00');
        END IF;


    END LOOP;


    -- Garantir que a disciplina exista em pelo menos um currículo padrão (2026)
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7801') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Trabalho de Conclusão de Curso', 0, 'CIN7801', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7801') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '08324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '08324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'CIN7802') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Estágio Supervisionado 288 30', 0, 'CIN7802', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'CIN7802') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '08324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '08324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '03324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '03324C')
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
          AND turma = '04324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '04324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'JOR5300') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Comunicação', 0, 'JOR5300', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'JOR5300') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '06324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '06324C')
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
          AND turma = '01324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324C')
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
          AND turma = '01324D';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '01324D')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'LSB7244') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Língua Brasileira de Sinais - Libras I', 0, 'LSB7244', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'LSB7244') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '08324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '08324C')
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
    IF NOT EXISTS (SELECT 1 FROM curriculo WHERE codigo_disciplina = 'PSI5112') THEN
        INSERT INTO curriculo (ano_curriculo, fase, nome_disciplina, carga_horaria, codigo_disciplina, tipo, area)
        VALUES (2026, 0, 'Relações Humanas', 0, 'PSI5112', 'Op', 0);
    END IF;

    -- PERMANENTE: Loop para iterar em TODOS os currículos associados a este código (Ex: 2016 e 2026)
    FOR r_curr IN (SELECT id FROM curriculo WHERE codigo_disciplina = 'PSI5112') LOOP
        
        v_turma_id := NULL;

        -- Busca se a turma já existe para este currículo específico
        SELECT id INTO v_turma_id
        FROM turmas
        WHERE semestre_id = v_semestre_id
          AND curriculo_disciplina = r_curr.id
          AND turma = '05324C';

        -- Se a turma não existir para este currículo, insere
        IF v_turma_id IS NULL THEN
            INSERT INTO turmas (semestre_id, curriculo_disciplina, turma)
            VALUES (v_semestre_id, r_curr.id, '05324C')
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


END $$;
