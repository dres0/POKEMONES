-- CREATE TABLE pokemones(
--     pokedex SERIAL,
--     name VARCHAR(50),
--     type1 VARCHAR(50),
--     type2 VARCHAR(50),
--     PRIMARY KEY(pokedex)
-- );
-- SELECT * FROM pokemones;

-- \copy pokemones FROM 'pokemones.csv' csv header;
-- SELECT * FROM pokemones;
-- SELECT name AS nombres, pokedex FROM pokemones;
-- SELECT pokedex FROM pokemones WHERE name = 'Squirtle';
-- SELECT * FROM pokemones WHERE type1 = 'Fire';
-- SELECT * FROM pokemones WHERE type1 = 'Normal' AND type2 = 'Flying';
-- SELECT * FROM pokemones WHERE type1 = 

\c dres0
DROP DATABASE pokemones;
CREATE DATABASE pokemones; 
\c pokemones

CREATE TABLE pokemones(
    pokedex SERIAL,
    nombre VARCHAR(30),
    type1 VARCHAR(20),
    type2 VARCHAR(20),
    PRIMARY KEY(pokedex)
);
SELECT * FROM pokemones;

\copy pokemones FROM 'pokemonesKanto.csv' csv header;
SELECT * FROM pokemones LIMIT 10;

CREATE TABLE mis_pokemones(
    pokedex INT,
    fecha_caputra DATE,
    lugar VARCHAR(30),
    huevo BOOLEAN,
    peso FLOAT,
    estatura FLOAT,
    FOREIGN KEY (pokedex) REFERENCES pokemones(pokedex)
);
SELECT * FROM mis_pokemones;

\copy mis_pokemones FROM 'mis_pokemones.csv' csv header;
SELECT * FROM mis_pokemones LIMIT 5;

--Consulta con alias
SELECT pokedex AS número FROM pokemones WHERE nombre = 'Eevee';
INSERT INTO mis_pokemones (pokedex, fecha_caputra, lugar, huevo, peso, estatura)
VALUES (133, '2021-04-12', 'El baño de Carlitos', false, 15.6, 0.3);
INSERT INTO mis_pokemones (pokedex, fecha_caputra, lugar, huevo, peso, estatura)
VALUES (134, '2021-04-12', 'Fondo de bikini', false, 25.6, 0.8);

SELECT * FROM mis_pokemones ORDER BY fecha_caputra DESC LIMIT 3;
SELECT * FROM mis_pokemones WHERE EXTRACT(YEAR FROM fecha_caputra) = 2021;
SELECT SUM(peso) AS total FROM mis_pokemones;

ALTER TABLE pokemones
ADD rocket BOOLEAN;
SELECT * FROM pokemones LIMIT 1;

INSERT INTO pokemones (pokedex ,nombre, type1, type2, rocket)
VALUES (152 ,'pichu', 'electrico', '', false );

SELECT * FROM pokemones ORDER BY pokedex DESC LIMIT 1;

UPDATE pokemones SET rocket = false; 

SELECT rocket AS capturado_por_los_malos FROM pokemones LIMIT 2;

--agrupar por tipo1
SELECT type1, COUNT(*) FROM pokemones GROUP BY type1;

--ejecutar consulta con order by fat shaming
SELECT * FROM mis_pokemones ORDER BY peso DESC LIMIT 5;

--agregar dos indices a dos columnas
CREATE INDEX index_pokedex_pokemones ON pokemones(pokedex);
SELECT * FROM pg_indexes WHERE tablename = 'pokemones';

--eliminar indice de la columna
DROP INDEX index_pokedex_pokemones;
SELECT * FROM pg_indexes WHERE = 'pokemones';