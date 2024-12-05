-- Crie uma trigger que verifica se o valor do campo idade é maior ou igual à 18 anos 
-- antes de inserir um novo registro na tabela funcionários, se a idade for menor que 18,
-- ele será considerado menor aprendiz:

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    idade INT,
    tipo_funcionario VARCHAR(50)
);

CREATE OR REPLACE FUNCTION verifica_idade()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.idade < 18 THEN
        NEW.tipo_funcionario := 'Menor Aprendiz';
    ELSE
        NEW.tipo_funcionario := 'Regular';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER verifica_idade_trigger
BEFORE INSERT ON funcionarios
FOR EACH ROW
EXECUTE FUNCTION verifica_idade();