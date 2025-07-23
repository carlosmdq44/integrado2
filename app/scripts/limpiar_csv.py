import pandas as pd
from pathlib import Path

DATA_DIR = Path(__file__).resolve().parents[1] / "data"

def limpiar_archivo(nombre):
    ruta = DATA_DIR / nombre
    df = pd.read_csv(ruta)
    df.columns = [c.strip().lower() for c in df.columns]
    if "created_at" in df.columns:
        df["created_at"] = pd.to_datetime(df["created_at"])
    if "order_date" in df.columns:
        df["order_date"] = pd.to_datetime(df["order_date"]).dt.date
    df.to_csv(ruta, index=False)
    print(f"Archivo limpio: {ruta}")

if __name__ == "__main__":
    for archivo in DATA_DIR.glob("*.csv"):
        limpiar_archivo(archivo.name)