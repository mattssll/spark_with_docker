image_name := 'pyspark-example:dev'
aws_access_key_id := 'AKIAZSYGLRZMLR66XIWN'
aws_secret_access_key := 'WQHf897e8LV6m17sBHgU7rLO8yWYqt7C34l8kX5/'
postgres_user := 'postgres'
postgres_password := 'postgres'
postgres_host := 'localhost'
postgres_port := '5432'
postgres_db_name := 'test'
table_name := 'public.population'

build:
    docker build -t {{image_name}} .

run:
    docker run --mount type=bind,source="$(pwd)",target=/opt/application \
        -e AWS_ACCESS_KEY_ID={{aws_access_key_id}} -e AWS_SECRET_ACCESS_KEY={{aws_secret_access_key}} \
        -e POSTGRES_USER={{postgres_user}} -e POSTGRES_PASSWORD={{postgres_password}} -e POSTGRES_HOST={{postgres_host}} \
        -e POSTGRES_PORT={{postgres_port}} -e POSTGRES_DB_NAME={{postgres_db_name}} -e TABLE_NAME={{table_name}} \
        {{image_name}} driver local:///opt/application/main.py

shell:
    docker run -it \
    -e AWS_ACCESS_KEY_ID={{aws_access_key_id}} -e AWS_SECRET_ACCESS_KEY={{aws_secret_access_key}} \
    {{image_name}} /opt/spark/bin/pyspark --packages com.amazonaws:aws-java-sdk-bundle:1.11.375,org.apache.hadoop:hadoop-aws:3.2.0
