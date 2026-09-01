-- Paso 4: Auditoría de cobertura de juegos por categoría

SELECT 
    c.codigo, 
    c.nombre, 
    COUNT(j.juego_id) AS juegos
FROM categorias AS c
LEFT JOIN juegos AS j
    ON j.categoria_id = c.categoria_id
GROUP BY c.categoria_id, c.codigo, c.nombre
ORDER BY c.categoria_id;