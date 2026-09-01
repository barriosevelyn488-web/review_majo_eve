-- Paso 1: Importación de categorías desde JSON

CREATE TEMP TABLE temporal_json (data JSONB);

INSERT INTO temporal_json (data)
SELECT pg_read_file('/tmp/categorias.json')::jsonb;

INSERT INTO categorias (codigo, nombre, descripcion)
SELECT 
    x->>'codigo',
    x->>'nombre',
    x->>'descripcion'
FROM temporal_json, jsonb_array_elements(data) AS x;

DROP TABLE temporal_json;

-- Verificación: Demostrar que se cargaron 4 categorías
SELECT COUNT(*) AS total_categorias FROM categorias;