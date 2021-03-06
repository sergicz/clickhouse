1. Создание кластера через CLI:
yc managed-clickhouse cluster create --name sergicz1 --environment production --version 21.11 --network-name default --host type=clickhouse,assign-public-ip=true,zone-id=ru-central1-c --service-account sergicz --clickhouse-resource-preset s2.small --database name=db --clickhouse-disk-size 50G --clickhouse-disk-type network-ssd --user name=clickhouse,password=clickhouse

2. dbt установился, проинициализировался, dbt debug отработал, данные из S3 в исходные таблицы загрузились (отдельными командами без цикла), DBeaver к базе подключился, модели из Stage и Star отработали - вьюшки и витрина создалась, запросы к витрине выполнились. Результаты запросов в Q2.1.jpg, Q3.3.jpg, Q4.2jpg
![image](https://user-images.githubusercontent.com/98316269/150785865-7caf5cb3-ae66-466e-bcaf-ec6914aedc90.png)
![image](https://user-images.githubusercontent.com/98316269/150785958-f1d449a8-9b94-48a9-8096-ff5ce843d633.png)
![image](https://user-images.githubusercontent.com/98316269/150786007-57c3eedf-a0dd-422b-b810-15fcb84076ce.png)

3. Profiles.yml имеет такой вид:

![image](https://user-images.githubusercontent.com/98316269/150786144-3cfe5972-5d47-46c0-a3ee-d2db92b6f1bc.png)
     
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
  
- не отработало создание суррогатного ключа {{ dbt_utils.surrogate_key(['LO_CUSTKEY', 'C_CUSTKEY', 'S_SUPPKEY']) }} - ругается на регистр функции md5, а после исправления на MD5  на тип string, лечится заменой строки в dbt_utils
![image](https://user-images.githubusercontent.com/98316269/150790430-6c2b02e0-21be-4179-a6a8-0e2c2aacedf5.png)
получаем суррогатный ключ такого вида (только непонятно, это правильно или нет):
![image](https://user-images.githubusercontent.com/98316269/150791362-72212dbd-38eb-4d90-ab3b-3b73ba8c519d.png)

- не отрабатывало dbt docs generate - ругался на несколько баз в каталоге, исправил удалением строки database:db в sources.yml
![image](https://user-images.githubusercontent.com/98316269/150785530-a11d0127-121f-4b2d-ad64-00b5ef520c77.png)

- не отрабатывали тесты по той же причине что и в лекции - неизвестен тип boolean, добавил test.sql в /usr/local/lib/python3.8/dist-packages/dbt/include/clickhouse/macros/materializations# по статье https://github.com/silentsokolov/dbt-clickhouse/pull/18/commits/888605b19d20e445fc10e17cf6971989400ee236 - заработало
![image](https://user-images.githubusercontent.com/98316269/150785322-4cca167e-3981-42b1-bc42-db8b263c2690.png)
