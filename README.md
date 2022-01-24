1. Создание кластера через CLI:
yc managed-clickhouse cluster create --name sergicz1 --environment production --version 21.11 --network-name default --host type=clickhouse,assign-public-ip=true,zone-id=ru-central1-c --service-account sergicz --clickhouse-resource-preset s2.small --database name=db --clickhouse-disk-size 50G --clickhouse-disk-type network-ssd --user name=clickhouse,password=clickhouse

2. dbt установился, проинициализировался, debug отработал, данные из S3 в исходные таблицы загрузились (отдельными командами без цикла), DBeaver к базе подключился, модели из Stage и Star отработали - вьюшки и витрина создалась, запросы к витрине выполнились. Результаты запросов в Q2.1.jpg, Q3.3.jpg, Q4.2jpg
3. Profiles.yml имеет такой вид:
clickhouse_starschema:
  target: dev
  outputs:
    dev:
      type: clickhouse
      schema: db
      host: rc1c-njfxh96x4eg7o27c.mdb.yandexcloud.net
      port: 9440
      user: clickhouse
      password: clickhouse
      secure: True
     
4. Обнаруженные проблемы:
- не отработала команда dbt run-operation generate_source --args '{"schema_name": "dbt", "generate_columns": True, "include_descriptions": True}' - вылазит ошибка
root@5a4e47ed8d75:~/clickhouse_starschema# dbt run-operation generate_source --args '{"schema_name": "db", "generate_columns": True, "include_descriptions": True, "database_name": "db"}'
Running with dbt=0.20.0
Encountered an error while running operation: Database Error
  Code: 62.
  DB::Exception: Syntax error: failed at position 587 ('where') (line 16, col 9): where table_schema ilike 'db'
          and table_name ilike '%'
          and table_name not ilike ''
  . Expected one of: Dot, token. Stack trace:
  
- не отработало создание суррогатного ключа {{ dbt_utils.surrogate_key(['LO_CUSTKEY', 'C_CUSTKEY', 'S_SUPPKEY']) }} - ругается на регистр функции md5, а после исправления на MD5  на тип string, дальше копаться не стал

- не отрабатывало dbt docs generate - ругался на несколько баз в каталоге, исправил удалением строки database:db в sources.yml
- не отработали тесты по той же причине что и в лекции - неизвестен тип boolean
