
# Notas de la clase — PostgreSQL I, Clase 05

**Autoras:** Evelyn Barrios y María José

## Reto: reproduce el pipeline sin copiar SQL

Objetivo: reconstruir de memoria (sin copiar y pegar) el pipeline de
importación visto en clase, verificando en cada paso el resultado esperado.

1. **Importa JSON** → carga `data/categorias.json` → 4 categorías.
2. **Importa XML** → carga `data/juegos.xml` → 20 juegos.
3. **Compara** → 8 juegos sobre el promedio global de precio, 10 juegos
   sobre el promedio de su propia categoría.
4. **Audita** → conteo de juegos por categoría con `LEFT JOIN` → 5 en cada
   categoría.

## Rutas de archivo en WSL

La ruta varía según en qué carpeta guarde cada quien sus archivos y con qué
usuario de Windows/Linux esté trabajando — el ejemplo de abajo es solo ilustrativo,
ajusta usuario y carpeta a tu caso real.

Windows: `C:\Users\<tu_usuario>\<tu_carpeta>\archivo.json`
WSL:     `/mnt/c/Users/<tu_usuario>/<tu_carpeta>/archivo.json`

La conversión siempre sigue el mismo patrón: la letra de unidad (`C:`) pasa
a minúscula bajo `/mnt/`, y las `\` se cambian por `/`.

Si el servidor de PostgreSQL corre en la misma WSL que el cliente `psql`,
esa misma ruta sirve tanto para `\copy` (lado cliente) como para funciones
que leen del lado del servidor (`lo_import()`, `pg_read_binary_file()`).

## ¿Por qué compactar el JSON/XML a una sola línea?

`\copy tabla(columna) FROM archivo` en modo texto trata **cada línea del
archivo como una fila**. Un JSON o XML "bonito" (con saltos de línea
internos) rompe esa suposición antes de poder parsearse. Se compacta con:

```bash
jq -c . data/categorias.json > /tmp/categorias_min.json
tr -d '\n\r' < data/juegos.xml > /tmp/juegos_min.xml
```

O en un solo paso con `FROM PROGRAM`:

```sql
\copy temporal_xml(data) FROM PROGRAM 'tr -d "\r\n" < data/juegos.xml'
```

## Extracción de datos

- **JSON** (`JSONB`): `jsonb_array_elements(data)` separa el array en filas;
  `elem->>'campo'` extrae cada valor como texto.
- **XML**: `xpath('/ruta', data)` + `unnest(...)` (un `xpath()` por columna),
  o de forma más legible con
  `XMLTABLE('/ruta/nodo' PASSING data COLUMNS ...)`.

## LEFT JOIN vs INNER JOIN (paso "Audita")

Se usa `LEFT JOIN` (no `INNER JOIN`) para que las categorías sin ningún
juego asociado sigan apareciendo en el resultado con conteo 0. Se cuenta
`j.juego_id` y no `*`, porque `COUNT` ignora los `NULL` que deja el
`LEFT JOIN` en las categorías sin coincidencia.

## Ejercicios complementarios

**Arrays:** los arrays en PostgreSQL empiezan en índice **1**, no en 0.
`cardinality(array)` cuenta elementos; `valor = ANY(array)` busca un valor
dentro del array (no se puede usar `=` directo).

**BYTEA:** guarda bytes crudos directamente en la fila (a diferencia de los
*large objects*, que se guardan aparte y se referencian por OID).
`pg_read_binary_file(ruta)` lee un archivo completo y lo devuelve como
`bytea` — requiere permisos de superusuario y que el archivo sea legible
por el proceso del servidor.

## Evidencias

Las capturas de pantalla de cada paso ejecutado están en `docs/evidencias/`.
>>>>>>> 11796ea547e31450dc20bbb7cf5d41e6720bc988
