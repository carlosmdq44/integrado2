FROM python:3.11-slim

WORKDIR /app

# git por si dbt necesita bajar paquetes, y limpiar apt
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Descargar dependencias de dbt si existen
RUN dbt deps || true

CMD ["streamlit", "run", "main.py", "--server.port", "8501", "--server.address", "0.0.0.0"]