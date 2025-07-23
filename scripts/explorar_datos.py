import pandas as pd
from pathlib import Path

DATA_DIR = Path(__file__).resolve().parents[1] / "data"

def resumen():
    for archivo in DATA_DIR.glob("*.csv"):
        df = pd.read_csv(archivo)
        print(f"Resumen de {archivo.name}")
        print(df.head())
        print(df.describe(include="all"))
        print("-" * 40)

if __name__ == "__main__":
    resumen()