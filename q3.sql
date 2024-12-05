-- Crie uma trigger que gere uma nova entrada na tabela historico_produtos sempre que um registro na tabela produtos é atualizado:

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    preco NUMERIC
);

CREATE TABLE historico_produtos (
    id SERIAL PRIMARY KEY,
    produto_id INT,
    nome_anterior VARCHAR(100),
    preco_anterior NUMERIC,
    data_atualizacao TIMESTAMP
);

CREATE OR REPLACE FUNCTION gera_historico_produtos()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO historico_produtos (produto_id, nome_anterior, preco_anterior, data_atualizacao)
    VALUES (OLD.id, OLD.nome, OLD.preco, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER historico_trigger
AFTER UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION gera_historico_produtos();