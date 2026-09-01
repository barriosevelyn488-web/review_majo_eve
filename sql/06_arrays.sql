-- Ejercicio de manipulación de Arreglos (Arrays)

CREATE TABLE IF NOT EXISTS Estudiantes (
    id SERIAL PRIMARY KEY,
    codigo CHAR(4),
    nombre VARCHAR(30),
    parciales INT[3]
);

INSERT INTO Estudiantes (codigo, nombre, parciales)
VALUES ('E001', 'Pedro', ARRAY[90, 95, 97]);

SELECT 
    nombre,
    parciales[1] AS parcial_1,
    CARDINALITY(parciales) AS cantidad,
    95 = ANY(parciales) AS obtuvo_95
FROM Estudiantes;