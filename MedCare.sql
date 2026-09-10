create table pacientes (
    id serial PRIMARY KEY,
    nome VARCHAR (150),
    email VARCHAR (150),
    cpf VARCHAR (150),
    data_nascimento VARCHAR (150),
    data_cadastro VARCHAR (150),
)

select * from
pacientes

create table especialidade (
    id SERIAL PRIMARY KEY
    nome VARCHAR (150)
)

select * from
especialidade

CREATE TABLE medicos (
    id SERIAL PRIMARY KEY,
    especialidade_id INTEGER NOT NULL,
    nome VARCHAR(150) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    valor_consulta DECIMAL(10,2) NOT NULL CHECK (valor_consulta > 0),
    FOREIGN KEY (especialidade_id) REFERENCES especialidade(id)
)

select * from
medicos

CREATE TABLE consultas (
    id SERIAL PRIMARY KEY,
    medico_id INTEGER NOT NULL,
    paciente_id INTEGER NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Agendada',
    FOREIGN KEY (medico_id) REFERENCES medicos(id),
    FOREIGN KEY (paciente_id) REFERENCES pacientes(id),
    CHECK (status IN ('Agendada', 'Realizada', 'Cancelada'))
)

select * from 
consultas

CREATE TABLE exames_consulta (
    id SERIAL PRIMARY KEY,
    consulta_id INTEGER NOT NULL,
    nome_exame VARCHAR(150) NOT NULL,
    valor_exame DECIMAL(10,2) NOT NULL CHECK (valor_exame >= 0),
    FOREIGN KEY (consulta_id) REFERENCES consultas(id)
);

INSERT INTO pacientes (nome, email, cpf, data_nascimento, data_cadastro) VALUES 
('Renata de Souza', 'renata.souza@gmail.com', '356.746.364-78', '27/10/1989', '07/07/2026'),
('Fernando Pereira', 'pereira.fernando@gmail.com', '226.096.564-89', '04/05/1996', '06/07/2024'),
('Roberta Valentim', 'valen.berta@gmail.com', '900.749.899-92', '06/02/2003', '17/01/2020'),
('Geraldo Fonseca', 'geraldofonseca58@gmail.com', '276.253.888-08', '09/11/1958', '24/04/2025'),
('Paulo Farias', 'paulo_farias13@gmail.com', '374.923.176.21', '01/12/1999', '19/08/2000'),
('João Pedro Gomes', 'joaopedro.gomes@gmail.com', '734.903.574-23', '11/08/2009', '14/06/2022'),
('Karine Santos', 'karinesantos.09@gmail.com', '378.545.008-32', '11/09/1977', '09/12/2025'),
('Juliano Costa', 'juliano.costa@gmail.com', '112.368.855-02', '21/04/2006', '13/03/2023'),
('Yasmin Bragança', 'yasminsantos.09@gmail.com', '309.656.123-59', '13/08/2009', '03/01/2022'),
('Benicio Galleto', 'galleto.benicio@gmail.com', '095.236.434-01', '05/03/2009', '10/11/2024');

INSERT INTO especialidade (nome) values
('Psiquiatria'),
('Urologista'),
('Cardiologia'),
('Pediatria'),
('Ortopedia'),
('Ginecologia'),
('Neurologia'),
('Dermatologia'),
('Oftalmologia'),
('Oncologia')

INSERT INTO medicos (especialidade_id, nome, crm, valor_consulta) VALUES
(1, 'Ana Claúdia de Souza', '954847', 300.00),
(2, 'Bruno Henrique Lima', '234567', 250.00),
(3, 'Carla Moreira', '345678', 220.00),
(4, 'Daniel Oliveira', '456789', 250.00),
(5, 'Eduardo Ferreira', '567890', 320.00),
(6, 'Joana dos Santos', '678901', 300.00),
(7, 'Gabriela Costa', '789012', 300.00),
(8, 'Helena Almeida', '890123', 275.00),
(9, 'Igor Rodrigues', '901234', 380.00),
(10, 'Juliana Ferreira', '012345', 500.00);

INSERT INTO consultas (medico_id, paciente_id, data_hora, status) VALUES
(1, 1, '08/07/2026 08:00:00', 'Realizada'),
(2, 2, '08/07/2026 09:00:00', 'Realizada'),
(3, 3, '08/07/2026 10:00:00', 'Agendada'),
(4, 4, '08/07/2026 11:00:00', 'Cancelada'),
(5, 5, '09/07/2026 08:30:00', 'Realizada'),
(6, 6, '09/07/2026 09:30:00', 'Agendada'),
(7, 7, '09/07/2026 10:30:00', 'Realizada'),
(8, 8, '09/07/2026 13:00:00', 'Agendada'),
(9, 9, '10/07/2026 14:00:00', 'Realizada'),
(10, 10, '10/07/2026 15:00:00', 'Cancelada'),
(1, 11, '10/07/2026 16:00:00', 'Realizada');

INSERT INTO pacientes (nome, email, cpf, data_nascimento, data_cadastro) VALUES
('Carlos Silva', 'carlos.silva@gmail.com', '12345678901', '20/06/1995', '07/07/2026');

select * from
pacientes

INSERT INTO consultas (medico_id, paciente_id, data_hora, status) VALUES
(1, 11, '10/07/2026 16:00:00', 'Realizada');

select * from 
consultas

INSERT INTO exames_consulta (consulta_id, nome_exame, valor_exame) VALUES
(1, 'Hemograma Completo', 80.00),
(2, 'Eletrocardiograma', 150.00),
(3, 'Exame de Sangue', 100.00),
(4, 'Raio-X', 120.00),
(5, 'Ultrassonografia', 200.00),
(6, 'Exame de Urina', 60.00),
(7, 'Tomografia', 350.00),
(8, 'Exame de Glicemia', 50.00),
(9, 'Ressonância Magnética', 500.00),
(10, 'Mamografia', 180.00),
(11, 'Exame de Sangue', 90.00);

select * from 
exames_consulta

SELECT
    m.nome AS medico,
    m.crm,
    e.nome AS especialidade,
    m.valor_consulta
FROM medicos m
JOIN especialidade e ON m.especialidade_id = e.id
ORDER BY m.valor_consulta DESC;

SELECT
    c.id AS id_consulta,
    p.nome AS paciente,
    m.nome AS medico,
    m.valor_consulta + COALESCE(SUM(ec.valor_exame), 0) AS valor_total
FROM consultas c
JOIN pacientes p ON c.paciente_id = p.id
JOIN medicos m ON c.medico_id = m.id
LEFT JOIN exames_consulta ec ON c.id = ec.consulta_id
GROUP BY c.id, p.nome, m.nome, m.valor_consulta
ORDER BY c.id;

SELECT
    nome AS medico,
    crm,
    valor_consulta
FROM medicos
WHERE valor_consulta > 300
ORDER BY valor_consulta DESC;

SELECT
    e.nome AS especialidade,
    SUM(m.valor_consulta + COALESCE(ex.total_exames, 0)) AS total_faturado
FROM consultas c
JOIN medicos m ON c.medico_id = m.id
JOIN especialidade e ON m.especialidade_id = e.id
LEFT JOIN (
    SELECT
        consulta_id,
        SUM(valor_exame) AS total_exames
    FROM exames_consulta
    GROUP BY consulta_id
) ex ON c.id = ex.consulta_id
WHERE c.status = 'Realizada'
GROUP BY e.id, e.nome
ORDER BY total_faturado DESC;