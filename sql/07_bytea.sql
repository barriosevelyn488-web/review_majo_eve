-- Ejercicio de manejo de archivos binarios (BYTEA)

CREATE TABLE IF NOT EXISTS imagenes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    archivo BYTEA
);

INSERT INTO imagenes (nombre, archivo)
SELECT 'imagen.jpg',
       pg_read_binary_file('/tmp/imagen.jpg');

SELECT nombre, OCTET_LENGTH(archivo) AS bytes
FROM imagenes;