import streamlit as st
import pandas as pd
import plotly.express as px
from sqlalchemy import create_engine
import os

st.set_page_config(page_title="E-commerce Dashboard", layout="wide")
st.title("Ventas e-commerce")

def get_engine():
    user = os.getenv("POSTGRES_USER")
    pwd = os.getenv("POSTGRES_PASSWORD")
    db = os.getenv("POSTGRES_DB")
    host = os.getenv("POSTGRES_HOST", "localhost")
    port = os.getenv("POSTGRES_PORT", 5432)
    return create_engine(f"postgresql://{user}:{pwd}@{host}:{port}/{db}")

@st.cache_data(show_spinner=False)
def cargar_datos():
    engine = get_engine()
    query = """
        SELECT o.order_date, oi.total_price, c.category_name
        FROM fact_sales oi
        JOIN dim_products p ON oi.product_id = p.product_id
        JOIN stg_categories c ON p.category_id = c.category_id
        JOIN raw.orders o ON oi.order_id = o.order_id
    """
    return pd.read_sql(query, engine)

try:
    df = cargar_datos()
    st.subheader("Ingresos por fecha")
    ingresos = df.groupby("order_date")["total_price"].sum().reset_index()
    st.line_chart(ingresos, x="order_date", y="total_price")

    st.subheader("Ventas por categoría")
    ventas = df.groupby("category_name")["total_price"].sum().reset_index()
    fig = px.bar(ventas, x="category_name", y="total_price", title="Ingresos por categoría")
    st.plotly_chart(fig, use_container_width=True)
except Exception as e:
    st.error(f"No pude cargar datos aún. ¿Se crearon las tablas/vistas? Detalle: {e}")
    st.stop()