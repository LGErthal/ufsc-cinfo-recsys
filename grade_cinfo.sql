
        CREATE TABLE disciplinas (
            id SERIAL PRIMARY KEY,
            codigo VARCHAR(10),
            nome TEXT
        );
        
        CREATE TABLE turmas (
            id SERIAL PRIMARY KEY,
            course_id INTEGER REFERENCES disciplinas(id),
            turma VARCHAR(10)
        );
        
        CREATE TABLE grade (
            id SERIAL PRIMARY KEY,
            section_id INTEGER REFERENCES turmas(id),
            dia_semana INTEGER,
            hora_inicio TIME,
            hora_fim TIME
        );
    
INSERT INTO disciplinas (id, codigo, nome) VALUES (1, 'CIN7141', 'Lógica Instrumental I');
INSERT INTO turmas (id, course_id, turma) VALUES (1, 1, '01342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (1, 5, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (2, 'CIN7143', 'Empreendedorismo I');
INSERT INTO turmas (id, course_id, turma) VALUES (2, 2, '01342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (2, 3, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (3, 'CIN7144', 'Tutoria Acadêmica I');
INSERT INTO turmas (id, course_id, turma) VALUES (3, 3, '01342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (3, 2, '15:10:00', '16:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (4, 'CIN7145', 'Gestão da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (4, 4, '01342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (4, 2, '16:20:00', '18:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (5, 'CIN7201', 'Sistemas de Organização do');
INSERT INTO turmas (id, course_id, turma) VALUES (5, 5, '02342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (5, 6, '08:20:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (6, 5, '02342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (6, 6, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (6, 'CIN7202', 'Sociedade da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (7, 6, '02342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (7, 3, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (8, 6, '02342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (8, 4, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (7, 'CIN7203', 'Ética Profissional');
INSERT INTO turmas (id, course_id, turma) VALUES (9, 7, '02342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (9, 5, '07:30:00', '09:10:00');
INSERT INTO turmas (id, course_id, turma) VALUES (10, 7, '02342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (10, 4, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (8, 'CIN7204', 'Tutoria Acadêmica II');
INSERT INTO turmas (id, course_id, turma) VALUES (11, 8, '02342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (11, 4, '17:10:00', '18:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (9, 'CIN7205', 'Recuperação da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (12, 9, '02342B');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (12, 2, '14:20:00', '17:40:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (10, 'CIN7206', 'Fontes Gerais de Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (13, 10, '02342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (13, 2, '08:20:00', '10:00:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (13, 3, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (14, 10, '02342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (14, 3, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (11, 'CIN7301', 'Introdução à Representação Temática');
INSERT INTO turmas (id, course_id, turma) VALUES (15, 11, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (15, 3, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (16, 11, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (16, 5, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (12, 'CIN7302', 'Introdução à Representação Descritiva');
INSERT INTO turmas (id, course_id, turma) VALUES (17, 12, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (17, 6, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (18, 12, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (18, 3, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (13, 'CIN7303', 'Metodologia da Pesquisa');
INSERT INTO turmas (id, course_id, turma) VALUES (19, 13, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (19, 2, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (20, 13, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (20, 2, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (14, 'CIN7304', 'Introdução à Bancos de Dados');
INSERT INTO turmas (id, course_id, turma) VALUES (21, 14, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (21, 4, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (22, 14, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (22, 5, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (15, 'CIN7306', 'Competência Informacional');
INSERT INTO turmas (id, course_id, turma) VALUES (23, 15, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (23, 6, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (24, 15, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (24, 2, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (16, 'CIN7309', 'Gestão de Processos Organizacionais');
INSERT INTO turmas (id, course_id, turma) VALUES (25, 16, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (25, 3, '10:10:00', '11:50:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (25, 4, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (26, 16, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (26, 3, '18:30:00', '20:10:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (26, 4, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (17, 'CIN7401', 'Estudos Métricos da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (27, 17, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (27, 2, '08:20:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (28, 17, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (28, 3, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (18, 'CIN7402', 'Editoração Científica');
INSERT INTO turmas (id, course_id, turma) VALUES (29, 18, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (29, 6, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (30, 18, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (30, 6, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (19, 'CIN7403', 'Acessibilidade e Inclusão Digital');
INSERT INTO turmas (id, course_id, turma) VALUES (31, 19, '04342B');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (31, 4, '16:20:00', '18:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (20, 'CIN7404', 'Planejamento Estratégico');
INSERT INTO turmas (id, course_id, turma) VALUES (32, 20, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (32, 4, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (33, 20, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (33, 6, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (21, 'CIN7405', 'Projeto de Informatização');
INSERT INTO turmas (id, course_id, turma) VALUES (34, 21, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (34, 5, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (35, 21, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (35, 4, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (22, 'CIN7406', 'Preservação Digital');
INSERT INTO turmas (id, course_id, turma) VALUES (36, 22, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (36, 6, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (37, 22, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (37, 2, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (23, 'CIN7412', 'Marketing da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (38, 23, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (38, 3, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (39, 23, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (39, 5, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (24, 'CIN7501', 'Arquitetura da Informação e Usabilidade');
INSERT INTO turmas (id, course_id, turma) VALUES (40, 24, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (40, 2, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (25, 'CIN7502', 'Mineração de Texto');
INSERT INTO turmas (id, course_id, turma) VALUES (41, 25, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (41, 3, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (26, 'CIN7503', 'Bancos de Dados');
INSERT INTO turmas (id, course_id, turma) VALUES (42, 26, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (42, 6, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (27, 'CIN7504', 'Gerenciamento de Projetos');
INSERT INTO turmas (id, course_id, turma) VALUES (43, 27, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (43, 6, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (28, 'CIN7505', 'Estágio em Ciência da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (44, 28, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (44, 2, '14:20:00', '16:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (29, 'CIN7601', 'Linked Data');
INSERT INTO turmas (id, course_id, turma) VALUES (45, 29, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (45, 3, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (30, 'CIN7602', 'Mídias Sociais');
INSERT INTO turmas (id, course_id, turma) VALUES (46, 30, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (46, 6, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (31, 'CIN7603', 'Empreendedorismo II');
INSERT INTO turmas (id, course_id, turma) VALUES (47, 31, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (47, 2, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (32, 'CIN7604', 'TCC');
INSERT INTO turmas (id, course_id, turma) VALUES (48, 32, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (48, 4, '16:20:00', '18:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (33, 'CIN7904', 'Avaliação de Desempenho');
INSERT INTO turmas (id, course_id, turma) VALUES (49, 33, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (49, 4, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (34, 'CIN7906', 'Inovação e Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (50, 34, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (50, 3, '18:30:00', '20:10:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (50, 5, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (35, 'CIN7907', 'Lógica Aplicada I');
INSERT INTO turmas (id, course_id, turma) VALUES (51, 35, '02342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (51, 5, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (36, 'CIN7913', 'Lógica Instrumental II');
INSERT INTO turmas (id, course_id, turma) VALUES (52, 36, '04342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (52, 4, '14:20:00', '16:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (37, 'CIN7917', 'Visualização da Informação');
INSERT INTO turmas (id, course_id, turma) VALUES (53, 37, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (53, 4, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (38, 'CIN7919', 'Informação, Direito e Cidadania');
INSERT INTO turmas (id, course_id, turma) VALUES (54, 38, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (54, 4, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (39, 'CIN7925', 'Introdução a Algoritmos');
INSERT INTO turmas (id, course_id, turma) VALUES (55, 39, '01342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (55, 4, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (40, 'CIN7935', 'Liderança e Gerência');
INSERT INTO turmas (id, course_id, turma) VALUES (56, 40, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (56, 2, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (41, 'CIN7936', 'Proteção de Dados Pessoais');
INSERT INTO turmas (id, course_id, turma) VALUES (57, 41, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (57, 2, '08:20:00', '10:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (58, 41, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (58, 4, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (42, 'CIN7943', 'Experiência do Usuário (UX) User');
INSERT INTO turmas (id, course_id, turma) VALUES (59, 42, '01342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (59, 4, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (43, 'CIN7944', 'Curadoria Digital');
INSERT INTO turmas (id, course_id, turma) VALUES (60, 43, '06342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (60, 4, '20:20:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (44, 'CIN7945', 'Fontes de Informação Tecnológica');
INSERT INTO turmas (id, course_id, turma) VALUES (61, 44, '05342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (61, 2, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (45, 'CIN7950', 'Programa de Intercâmbio I');
INSERT INTO turmas (id, course_id, turma) VALUES (62, 45, '06342');
INSERT INTO disciplinas (id, codigo, nome) VALUES (46, 'HST7921', 'História do Brasil Contemporâneo');
INSERT INTO turmas (id, course_id, turma) VALUES (63, 46, '03342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (63, 5, '08:20:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (64, 46, '03342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (64, 6, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (47, 'INE5111', 'Estatística Aplicada I');
INSERT INTO turmas (id, course_id, turma) VALUES (65, 47, '04342A');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (65, 3, '08:20:00', '10:00:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (65, 4, '10:10:00', '11:50:00');
INSERT INTO turmas (id, course_id, turma) VALUES (66, 47, '04342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (66, 2, '18:30:00', '20:10:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (66, 5, '18:30:00', '20:10:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (48, 'LLV7802', 'Leitura e Produção do Texto');
INSERT INTO turmas (id, course_id, turma) VALUES (67, 48, '01342C');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (67, 6, '18:30:00', '22:00:00');
INSERT INTO turmas (id, course_id, turma) VALUES (68, 48, '01342D');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (68, 6, '18:30:00', '22:00:00');
INSERT INTO disciplinas (id, codigo, nome) VALUES (49, 'MTM3110', 'Cálculo');
INSERT INTO turmas (id, course_id, turma) VALUES (69, 49, '01342');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (69, 3, '18:30:00', '20:10:00');
INSERT INTO grade (section_id, dia_semana, hora_inicio, hora_fim)
                        VALUES (69, 5, '18:30:00', '20:10:00');