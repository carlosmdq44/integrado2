import os
from pathlib import Path
import pandas as pd
from sqlalchemy import create_engine

DATA_DIR = Path(__file__).resolve().parents[1] / "data"

def cargar_tabla(csv_name, table_name, engine):
    df = pd.read_csv(DATA_DIR / csv_name)
    df.to_sql(table_name, engine, schema="raw", if_exists="append", index=False)
    print(f"Cargado {csv_name} en {table_name}")

def get_engine():
    user = os.getenv("POSTGRES_USER")
    pwd = os.getenv("POSTGRES_PASSWORD")
    db = os.getenv("POSTGRES_DB")
    host = os.getenv("POSTGRES_HOST", "localhost")
    port = os.getenv("POSTGRES_PORT", 5432)
    return create_engine(f"postgresql://{user}:{pwd}@{host}:{port}/{db}")

if __name__ == "__main__":
    engine = get_engine()
    cargar_tabla("customers.csv", "customers", engine)
    cargar_tabla("products.csv", "products", engine)
    cargar_tabla("categories.csv", "categories", engine)
    cargar_tabla("orders.csv", "orders", engine)
    cargar_tabla("order_items.csv", "order_items", engine)