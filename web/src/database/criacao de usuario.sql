-- SCRIPTS DE CRIAÇÃO E PERMISSIONAMENTO DO USUÁRIO PADRÃO PARA A CONFIGURAÇÃO NO MAIN.JS
-- PRIMEIRO CRIE TODO O BANCO DE DADOS, DEPOIS RODE OS COMANDOS DE CRIAÇÃO DE USUÁRIO

-- Criando usuário padrão de insert e select (data viz) para o sistema
CREATE USER 'user_select'@'localhost' IDENTIFIED BY 'luminou6@2026';
-- a principio o usuario será apenas local (localhost), mas futuramente sera de acesso remoto ('user_insert'@'%')

-- Garantindo as permissões necessárias para o usuário
GRANT INSERT, SELECT ON bd_luminousix.* TO 'user_select'@'localhost';

-- Criando usuário padrão de insert (arduino) para o sistema
CREATE USER 'user_insert'@'localhost' IDENTIFIED BY 'luminou6@2026';

-- Garantindo as permissões necessárias para o usuário
GRANT INSERT ON bd_luminousix.* TO 'user_insert'@'localhost';