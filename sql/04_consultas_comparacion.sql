-- Paso 3: Consultas de comparación y promedios

-- A) 8 juegos con precio por encima del promedio global
SELECT codigo, titulo, precio 
FROM juegos 
WHERE precio > (SELECT AVG(precio) FROM juegos);

-- B) 10 juegos con precio por encima del promedio de su propia categoría
SELECT j1.codigo, j1.titulo, j1.precio, j1.categoria_id
FROM juegos j1
WHERE j1.precio > (
    SELECT AVG(j2.precio)
    FROM juegos j2
    WHERE j2.categoria_id = j1.categoria_id
);