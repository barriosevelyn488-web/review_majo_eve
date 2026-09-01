# PostgreSQL I · Clase 05
## Reto: reproduce el pipeline sin copiar SQL

**Autoras:** Evelyn Barrios y María José

**Práctica guiada:** trabajando en parejas, una persona dicta la intención y
la otra escribe el SQL. El reto tiene 4 pasos, cada uno con su resultado
esperado.

| # | Paso | Qué hace | Resultado esperado |
|---|------|----------|---------------------|
| 1 | **Importa JSON** | Carga `data/categorias.json` | 4 categorías |
| 2 | **Importa XML**  | Carga `data/juegos.xml` | 20 juegos |
| 3 | **Compara**       | Juegos sobre el promedio global y sobre el promedio de su categoría | 8 juegos / 10 juegos |
| 4 | **Audita**        | Cuenta juegos por categoría con `LEFT JOIN` | 5 juegos en cada categoría |

Además se incluyen dos ejercicios complementarios de la misma clase
(arrays y `BYTEA`), documentados en `docs/notas.md`.

## Estructura del proyecto

```
data/
  categorias.json      dataset del paso 1
  juegos.xml            dataset del paso 2
  imagen.jpg             dataset del ejercicio de BYTEA

sql/
  01_setup_tablas.sql          tablas categorias y juegos
  02_import_json.sql            paso 1 · Importa JSON
  03_import_xml.sql             paso 2 · Importa XML
  04_consultas_comparacion.sql  paso 3 · Compara
  05_auditoria_joins.sql        paso 4 · Audita
  06_arrays.sql                  ejercicio complementario: columnas array
  07_bytea.sql                    ejercicio complementario: BYTEA

docs/
  notas.md              apuntes de la clase
  evidencias/            capturas de pantalla de cada paso ejecutado

.gitignore
README.md
```

## Cómo ejecutar

```bash
psql -d clase_refuerzo -f sql/01_setup_tablas.sql
psql -d clase_refuerzo -f sql/02_import_json.sql
psql -d clase_refuerzo -f sql/03_import_xml.sql
psql -d clase_refuerzo -f sql/04_consultas_comparacion.sql
psql -d clase_refuerzo -f sql/05_auditoria_joins.sql
psql -d clase_refuerzo -f sql/06_arrays.sql
psql -d clase_refuerzo -f sql/07_bytea.sql
```

Antes de correr `02`, `03` y `07`, ajusta las rutas de archivo a donde
tengas `data/` en tu máquina (ver `docs/notas.md`).

## Flujo de trabajo (ramas)

- `main` — versión estable.
- `dev` — integración de las ramas `feature/*`.
- `feature/documentation` — README y notas de esta documentación.
- `feature/codigo-clase` - Por paso del reto (importa-json, importa-xml, compara, audita).