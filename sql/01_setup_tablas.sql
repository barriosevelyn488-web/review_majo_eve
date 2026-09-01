-- Creación del esquema base para categorías y juegos

CREATE TABLE IF NOT EXISTS categorias (
    categoria_id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS juegos (
    juego_id SERIAL PRIMARY KEY,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    precio NUMERIC(8,2) NOT NULL,
    fecha_lanzamiento DATE,
    categoria_id INT REFERENCES categorias(categoria_id) ON DELETE SET NULL
);