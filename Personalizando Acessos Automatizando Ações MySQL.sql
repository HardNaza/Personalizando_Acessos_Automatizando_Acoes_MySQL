################################################
## PARTE 1 – PERSONALIZANDO ACESSOS COM VIEWS ##
################################################

-----------------------------------------------------
-- NÚMERO DE EMPREGADOS POR DEPARTAMENTO E LOCALIDADE
-----------------------------------------------------

CREATE VIEW view_num_empregados_por_departamento_localidade AS
SELECT d.department_name, d.location, COUNT(e.employee_id) AS num_empregados
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.location;

-----------------------------------------
-- LISTA DE DEPARTAMENTOS E SEUS GERENTES
-----------------------------------------

CREATE VIEW view_departamentos_gerentes AS
SELECT d.department_name, e.first_name, e.last_name AS gerente
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id;

----------------------------------------------------------------------------
-- PROJETOS COM MAIOR NÚMERO DE EMPREGADOS (ORDENADOS POR ORDEM DECRESCENTE)
----------------------------------------------------------------------------

CREATE VIEW view_projetos_maior_num_empregados AS
SELECT p.project_name, COUNT(e.employee_id) AS num_empregados
FROM projects p
JOIN employees_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
GROUP BY p.project_id
ORDER BY num_empregados DESC;

----------------------------------------------
-- LISTA DE PROJETOS, DEPARTAMENTOS E GERENTES
----------------------------------------------

CREATE VIEW view_projetos_departamentos_gerentes AS
SELECT p.project_name, d.department_name, e.first_name, e.last_name AS gerente
FROM projects p
JOIN departments d ON p.department_id = d.department_id
JOIN employees e ON d.manager_id = e.employee_id;

-------------------------------------------------------
-- EMPREGADOS QUE POSSUEM DEPENDENTES E SE SÃO GERENTES
-------------------------------------------------------

CREATE VIEW view_empregados_dependentes_gerentes AS
SELECT e.first_name, e.last_name, IF(e.manager_id IS NULL, 'Não', 'Sim') AS gerente
FROM employees e
JOIN dependents d ON e.employee_id = d.employee_id;

------------------------------------------------------------------------------
--CRIAR USUÁRIO "GERENTE" COM ACESSO ÀS INFORMAÇÕES DE EMPLOYEE E DEPARTAMENTO
------------------------------------------------------------------------------

CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha_gerente';
GRANT SELECT ON database_name.view_num_empregados_por_departamento_localidade TO 'gerente'@'localhost';
GRANT SELECT ON database_name.view_departamentos_gerentes TO 'gerente'@'localhost';
GRANT SELECT ON database_name.departments TO 'gerente'@'localhost';
GRANT SELECT ON database_name.employees TO 'gerente'@'localhost';

------------------------------------------------------------------------
-- CRIAR USUÁRIO "EMPLOYEE" COM ACESSO APENAS ÀS INFORMAÇÕES DE EMPLOYEE
------------------------------------------------------------------------

CREATE USER 'employee'@'localhost' IDENTIFIED BY 'senha_employee';
GRANT SELECT ON database_name.employees TO 'employee'@'localhost';

-- OBS: CERTIFIQUE-SE DE SUBSTITUIR 'DATABASE_NAME' PELO NOME DO SEU BANCO DE DADOS.

###########################################################
## PARTE 2 – CRIANDO GATILHOS PARA CENÁRIO DE E-COMMERCE ##
###########################################################

-----------------------------------------------------
-- 1 TRIGGER "BEFORE DELETE" PARA A TABELA "USUARIOS"
-----------------------------------------------------

CREATE TRIGGER before_delete_usuario
BEFORE DELETE ON Usuarios
FOR EACH ROW
BEGIN
    -- Ações a serem executadas antes da remoção de um usuário
    INSERT INTO tabela_backup_usuarios (id, nome, email) VALUES (OLD.id, OLD.nome, OLD.email);
END;

-----------------------------------------------------
-- 2 Trigger "before update" para a tabela "Usuarios"
-----------------------------------------------------

CREATE TRIGGER before_update_usuario
BEFORE UPDATE ON Usuarios
FOR EACH ROW
BEGIN
    -- Ações a serem executadas antes da atualização de um usuário
    IF NEW.nome <> OLD.nome THEN INSERT INTO tabela_log (acao, usuario_id) VALUES ('Atualização de nome', OLD.id);
END;

----------------------------------------------------------
-- 3 Trigger "before delete" para a tabela "Colaboradores"
----------------------------------------------------------

CREATE TRIGGER before_delete_colaborador
BEFORE DELETE ON Colaboradores
FOR EACH ROW
BEGIN
	-- Ações a serem executadas antes da remoção de um colaborador
	INSERT INTO tabela_backup_colaboradores (id, nome, salario_base) VALUES (OLD.id, OLD.nome, OLD.salario_base);
END;

----------------------------------------------------------
-- 4 Trigger "before update" para a tabela "Colaboradores"
----------------------------------------------------------

CREATE TRIGGER before_update_colaborador
BEFORE UPDATE ON Colaboradores
FOR EACH ROW
BEGIN
	-- Ações a serem executadas antes da atualização de um colaborador
	IF NEW.salario_base <> OLD.salario_base THEN INSERT INTO tabela_log (acao, colaborador_id) VALUES ('Atualização de salário base', OLD.id);
END;

-- OBS: LEMBRE-SE DE SUBSTITUIR AS TABELAS E COLUNAS MENCIONADAS PELOS NOMES CORRETOS DO SEU BANCO DE DADOS.