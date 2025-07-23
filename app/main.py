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

@st.cache_data
def cargar_datos():
    engine = get_engine()
    query = """
        select order_date, total_price, category_name
        from fact_sales
        join dim_products using(product_id)
        join stg_categories using(category_id)
    """
    return pd.read_sql(query, engine)

df = cargar_datos()

st.subheader("Ingresos por fecha")
ingresos = df.groupby("order_date")["total_price"].sum().reset_index()
st.line_chart(ingresos, x="order_date", y="total_price")

st.subheader("Ventas por categoría")
ventas = df.groupby("category_name")["total_price"].sum().reset_index()
fig = px.bar(ventas, x="category_name", y="total_price", title="Ingresos por categoría")
st.plotly_chart(fig, use_container_width=True)