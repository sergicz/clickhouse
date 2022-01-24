1. Создание кластера через CLI:
yc managed-clickhouse cluster create --name sergicz1 --environment production --version 21.11 --network-name default --host type=clickhouse,assign-public-ip=true,zone-id=ru-central1-c --service-account sergicz --clickhouse-resource-preset s2.small --database name=db --clickhouse-disk-size 50G --clickhouse-disk-type network-ssd --user name=clickhouse,password=clickhouse

2. Результаты запросов в Q2.1.jpg, Q3.3.jpg, Q4.2jpg

3. Обнаруженные проблемы:
- не отработала команда dbt run-operation generate_source --args '{"schema_name": "dbt", "generate_columns": True, "include_descriptions": True}'
