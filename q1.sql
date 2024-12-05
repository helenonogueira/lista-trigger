-- Crie uma trigger que registra a data e hora da última atualização de um registro na tabela de sua escolha:

CREATE TABLE exemplo (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    ultima_atualizacao TIMESTAMP
);

CREATE OR REPLACE FUNCTION atualiza_data_hora()
RETURNS TRIGGER AS $$
BEGIN
    NEW.ultima_atualizacao := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER atualiza_trigger
BEFORE UPDATE ON exemplo
FOR EACH ROW
EXECUTE FUNCTION atualiza_data_hora();