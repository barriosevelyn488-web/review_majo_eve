-- Paso 2: Importación de juegos desde XML

CREATE TEMP TABLE temporal_xml (data XML);

INSERT INTO temporal_xml (data)
SELECT pg_read_file('/tmp/juegos.xml')::xml;

INSERT INTO juegos (codigo, titulo, precio, fecha_lanzamiento, categoria_id)
SELECT 
    (xpath('//codigo/text()', x))[1]::text,
    (xpath('//titulo/text()', x))[1]::text,
    (xpath('//precio/text()', x))[1]::text::NUMERIC(8,2),
    (xpath('//fecha_lanzamiento/text()', x))[1]::text::DATE,
    (xpath('//categoria_id/text()', x))[1]::text::INT
FROM (
    SELECT unnest(xpath('/juegos/juego', data)) AS x 
    FROM temporal_xml
) subquery;

DROP TABLE temporal_xml;

-- Verificación: Demostrar que se cargaron 20 juegos
SELECT COUNT(*) AS total_juegos FROM juegos;