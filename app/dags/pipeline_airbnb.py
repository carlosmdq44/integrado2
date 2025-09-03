from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="elt_airbnb_pipeline",
    start_date=datetime(2025, 1, 1),
    schedule_interval="@daily",
    catchup=False,
    tags=["elt", "airbnb"],
) as dag:

    extract = BashOperator(
        task_id="extract",
        bash_command="python scripts/extract.py data/raw/airbnb/AB_NYC.csv"
    )

    load = BashOperator(
        task_id="load",
        bash_command="python scripts/load.py"
    )

    staging = BashOperator(
        task_id="transform_staging",
        bash_command="python scripts/transform_staging.py"
    )

    core = BashOperator(
        task_id="transform_core",
        bash_command="python scripts/transform_core.py"
    )

    gold = BashOperator(
        task_id="gold",
        bash_command="python scripts/gold.py"
    )

    validate = BashOperator(
        task_id="validate",
        bash_command="python scripts/quality_checks.py"
    )

    extract >> load >> staging >> core >> gold >> validate