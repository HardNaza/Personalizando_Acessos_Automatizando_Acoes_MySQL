SCRIPTS SQL - PERSONALIZANDO ACESSOS COM VIEWS E CRIANDO GATILHOS PARA UM CENÁRIO DE E-COMMERCE

Este repositório contém scripts SQL para personalizar acessos usando views e criar gatilhos para um cenário de e-commerce. Os scripts estão divididos em duas partes:

################################################
## Parte 1 - Personalizando Acessos com Views ##
################################################
Esta parte tem como foco a criação de views para personalizar o acesso a dados específicos.

-------------------------------------------------------------
-- View: Número de Funcionários por Departamento e Localidade
-------------------------------------------------------------
Esta view exibe o número de funcionários em cada departamento e sua respectiva localidade.

--------------------------------------
-- View: Departamentos e Seus Gerentes
--------------------------------------
Esta view lista todos os departamentos juntamente com os nomes de seus respectivos gerentes.

--------------------------------------------------
-- View: Projetos com Maior Número de Funcionários
--------------------------------------------------
Esta view fornece uma lista de projetos ordenados em ordem decrescente com base no número de funcionários atribuídos a cada projeto.

-------------------------------------------
-- View: Projetos, Departamentos e Gerentes
-------------------------------------------
Esta view combina informações das tabelas projects, departments e employees para exibir o nome do projeto, nome do departamento e os nomes dos gerentes correspondentes.

---------------------------------------------------------
-- View: Funcionários com Dependentes e Status de Gerente
---------------------------------------------------------
Esta view mostra os funcionários que possuem dependentes e indica se são gerentes ou não.

------------------------------------------------------------------------------------
-- Criando Usuário "gerente" com Acesso às Informações de Funcionário e Departamento
------------------------------------------------------------------------------------
Um usuário chamado "gerente" é criado com acesso à view_num_empregados_por_departamento_localidade, view_departamentos_gerentes, departments e employees.

-----------------------------------------------------------------------------
-- Criando Usuário "employee" com Acesso Apenas às Informações de Funcionário
-----------------------------------------------------------------------------
Um usuário chamado "employee" é criado com acesso apenas à tabela employees.

##############################################################
## Parte 2 - Criando Gatilhos para um Cenário de E-commerce ##
##############################################################
Esta parte se concentra na criação de gatilhos (triggers) para um cenário de e-commerce.

-------------------------------------------------------
-- Gatilho 1 - "BEFORE DELETE" para a Tabela "Usuarios"
-------------------------------------------------------
Este gatilho é acionado antes da exclusão de um usuário na tabela "Usuarios". Ele realiza ações antes da remoção do usuário e insere os dados do usuário em uma tabela de backup.

-------------------------------------------------------
-- Gatilho 2 - "BEFORE UPDATE" para a Tabela "Usuarios"
-------------------------------------------------------
Este gatilho é acionado antes da atualização de um usuário na tabela "Usuarios". Ele realiza ações antes da atualização do usuário e insere informações sobre a ação realizada em uma tabela de log.

------------------------------------------------------------
-- Gatilho 3 - "BEFORE DELETE" para a Tabela "Colaboradores"
------------------------------------------------------------
Este gatilho é acionado antes da exclusão de um colaborador na tabela "Colaboradores". Ele realiza ações antes da remoção do colaborador e insere os dados do colaborador em uma tabela de backup.

------------------------------------------------------------
-- Gatilho 4 - "BEFORE UPDATE" para a Tabela "Colaboradores"
------------------------------------------------------------
Este gatilho é acionado antes da atualização de um colaborador na tabela "Colaboradores". Ele realiza ações antes da atualização do colaborador e insere informações sobre a ação realizada em uma tabela de log.

**Observação:** Lembre-se de substituir os nomes de tabelas e colunas mencionados pelos nomes corretos do seu banco de dados.