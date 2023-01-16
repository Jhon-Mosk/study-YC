Jhon_Mosk@DESKTOP-D761754 MINGW64 /f/Project/ShmakovSMM/studyYC/serveless/API
$ yc serverless api-gateway create \
>   --name hello-world \
>   --spec=spec.yaml \
>   --description "hello world"
done (6s)
id: d5do64vg3bkob7l3evno
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-11T17:35:44.804Z"
name: hello-world
description: hello world
status: ACTIVE
domain: d5do64vg3bkob7l3evno.apigw.yandexcloud.net
log_group_id: ckgco2ijpoath9cpi54j
connectivity: {}
log_options:
  folder_id: b1gp2lhjstd03j7rff3m


Jhon_Mosk@DESKTOP-D761754 MINGW64 /f/Project/ShmakovSMM/studyYC/serveless/API
$ yc serverless api-gateway list
+----------------------+-------------+----------------------+--------+
|          ID          |    NAME     |      FOLDER ID       | STATUS |
+----------------------+-------------+----------------------+--------+
| d5do64vg3bkob7l3evno | hello-world | b1gp2lhjstd03j7rff3m | ACTIVE |
+----------------------+-------------+----------------------+--------+


Jhon_Mosk@DESKTOP-D761754 MINGW64 /f/Project/ShmakovSMM/studyYC/serveless/API
$ yc serverless api-gateway get --name hello-world
id: d5do64vg3bkob7l3evno
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-11T17:35:44.804Z"
name: hello-world
description: hello world
status: ACTIVE
domain: d5do64vg3bkob7l3evno.apigw.yandexcloud.net
log_group_id: ckgco2ijpoath9cpi54j
connectivity: {}
log_options:
  folder_id: b1gp2lhjstd03j7rff3m


Jhon_Mosk@DESKTOP-D761754 MINGW64 /f/Project/ShmakovSMM/studyYC/serveless/API
$ yc serverless function create \
>   --name function-for-user-requests \
>   --description "function for response to user"
done (1s)
id: d4e4ekp63ramqjpcene9
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-11T17:42:43.192Z"
name: function-for-user-requests
description: function for response to user
log_group_id: ckgjv93fpab94if3pbhe
http_invoke_url: https://functions.yandexcloud.net/d4e4ekp63ramqjpcene9
status: ACTIVE


user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/API$ yc serverless function version create \
>   --function-name=function-for-user-requests \
>   --memory=256m \
-executi>   --execution-timeout=5s \
>   --runtime=python37 \
-entrypo>   --entrypoint=function-for-user-requests.handler \
 --servi>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --environment VERBOSE_LOG=True \
>   --environment CONNECTION_ID=$CONNECTION_ID \
>   --environment DB_USER=$DB_USER \
>   --environment DB_HOST=$DB_HOST \
-source->   --source-path function-for-user-requests.py
done (4s)
id: d4e7tkholbjnabn8e6al
function_id: d4e4ekp63ramqjpcene9
created_at: "2023-01-11T18:05:44.777Z"
runtime: python37
entrypoint: function-for-user-requests.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "4096"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgjv93fpab94if3pbhe
environment:
  CONNECTION_ID: akflmqa0t36jmqro49c8
  DB_HOST: akflmqa0t36jmqro49c8.postgresql-proxy.serverless.yandexcloud.net
  DB_USER: user1
  VERBOSE_LOG: "True"
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/API$ yc serverless api-gateway update \
>   --name hello-world \
>   --spec=spec.yaml
done (3s)
id: d5do64vg3bkob7l3evno
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-11T17:35:44.804Z"
name: hello-world
description: hello world
status: ACTIVE
domain: d5do64vg3bkob7l3evno.apigw.yandexcloud.net
log_group_id: ckgco2ijpoath9cpi54j
connectivity: {}
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/API$
