# Proyecto Integrador 2 – Data Engineering

Este repositorio contiene el desarrollo de un proyecto integrador del bootcamp de Data Engineering, enfocado en la construcción de un pipeline completo de datos para un e‑commerce, desde la ingesta hasta la visualización final.

---

## 🧩 Avances del Proyecto

### 🔹 Avance 1 – Ingesta Inicial
- Configuración de `docker-compose` con PostgreSQL.
- Creación de tablas `raw` a partir de archivos CSV.

### 🔹 Avance 2 – Limpieza y Staging
- Scripts en Python para limpiar e importar los CSV.
- Modelos en DBT para construir las tablas de `staging`.

### 🔹 Avance 3 – Modelado Dimensional
- Implementación del modelo en estrella.
- Uso de macros para Slowly Changing Dimensions (SCD) tipo 2.
- Creación de modelos `intermediate` y `marts`.
- Pruebas de calidad de datos con `dbt test`.

### 🔹 Avance 4 – Visualización
- Construcción de un dashboard interactivo con Streamlit.
- Gráficos de ingresos por fecha y ventas por categoría.

---

## ⚙️ Cómo usar

1. Clonar el repositorio:
```bash
git clone https://github.com/carlosmdq44/integrado2.git
cd integrado2
Copiar el archivo de entorno:

bash
Copiar
Editar
cp .env.example .env
# Editar y completar variables como POSTGRES_DB, POSTGRES_USER, etc.
Levantar los servicios:

bash
Copiar
Editar
docker compose --env-file .env up --build
Una vez iniciado, accedé al dashboard en http://localhost:8501

📁 Estructura del proyecto
bash
Copiar
Editar
├── app/
│   ├── dbt_integrado2/         # Proyecto DBT (modelos, profiles.yml)
│   ├── sql/                    # Scripts de creación de tablas RAW
│   ├── main.py                 # App de Streamlit
│   └── requirements.txt        # Librerías de Python
├── .env.example
├── docker-compose.yml
├── README.md
└── Dockerfile
🧪 Validaciones
dbt debug para verificar conexión y configuración

dbt run para construir los modelos

dbt test para pruebas de calidad de datos

🛠️ Tecnologías utilizadas
PostgreSQL

Docker & Docker Compose

Python + Pandas + SQLAlchemy

DBT (Data Build Tool)

Streamlit

GitHub

🙌 Autor
Desarrollado por Carlos Figueroa como parte del Proyecto Integrador 2 del bootcamp Soy Henry.