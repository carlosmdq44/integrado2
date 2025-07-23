import os
from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine, text

DATA_DIR = Path(__file__).resolve().parents[1] / "data"

def cargar_tabla(csv_name, table_name, engine):
    df = pd.read_csv(DATA_DIR / csv_name)
    df.to_sql(table_name, engine, schema="raw", if_exists="replace", index=False)
    print(f"✅ Cargado: {csv_name} → {table_name}")

def get_engine():
    user = os.getenv("POSTGRES_USER")
    pwd = os.getenv("POSTGRES_PASSWORD")
    db = os.getenv("POSTGRES_DB")
    host = os.getenv("POSTGRES_HOST", "localhost")
    port = os.getenv("POSTGRES_PORT", 5432)
    return create_engine(f"postgresql://{user}:{pwd}@{host}:{port}/{db}")

if __name__ == "__main__":
    engine = get_engine()

    # 👉 Crear el esquema raw si no existe
    with engine.connect() as conn:
        conn.execute(text("CREATE SCHEMA IF NOT EXISTS raw"))

    # Cargar tablas en el esquema raw
    cargar_tabla("usuarios.csv", "usuarios", engine)
    cargar_tabla("productos.csv", "productos", engine)
    cargar_tabla("categorias.csv", "categorias", engine)
    cargar_tabla("carrito.csv", "carrito", engine)
    cargar_tabla("detalle_ordenes.csv", "detalle_ordenes", engine)
    cargar_tabla("ordenes.csv", "ordenes", engine)
    cargar_tabla("direcciones_envio.csv", "direcciones_envio", engine)
    cargar_tabla("metodos_pago.csv", "metodos_pago", engine)
    cargar_tabla("ordenes_metodospago.csv", "ordenes_metodospago", engine)
    cargar_tabla("historial_pagos.csv", "historial_pagos", engine)
    cargar_tabla("resenas_productos.csv", "resenas_productos", engine)