user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ yc serverless function create \
>   --name parrot \
>   --description "function for Alice"
done (1s)
id: d4ed5jq552vlahl1fljb
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-07T09:51:21.765Z"
name: parrot
description: function for Alice
log_group_id: ckgcrujuu69fhf79soka
http_invoke_url: https://functions.yandexcloud.net/d4ed5jq552vlahl1fljb
status: ACTIVE

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ zip parrot.zip parrot.py requirements.txt 
  adding: parrot.py (deflated 57%)
  adding: requirements.txt (deflated 13%)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ yc serverless function version create \
>   --function-name=parrot \
>   --memory=256m \
>   --execution-timeout=5s \
>   --runtime=python37 \
>   --entrypoint=parrot.handler \
>   --service-account-id $SERVICE_ACCOUNT_ID \
-source->   --source-path parrot.zip
done (14s)
id: d4eh905sscp0je3gq1oj
function_id: d4ed5jq552vlahl1fljb
created_at: "2023-01-07T09:54:49.780Z"
runtime: python37
entrypoint: parrot.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "14704640"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgcrujuu69fhf79soka
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ yc serverless function version list --function-name parrot
+----------------------+----------------------+----------+----------------+---------+---------------------+
|          ID          |     FUNCTION ID      | RUNTIME  |   ENTRYPOINT   |  TAGS   |     CREATED AT      |
+----------------------+----------------------+----------+----------------+---------+---------------------+
| d4eh905sscp0je3gq1oj | d4ed5jq552vlahl1fljb | python37 | parrot.handler | $latest | 2023-01-07 09:54:49 |
+----------------------+----------------------+----------+----------------+---------+---------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ yc serverless function version create \
>   --function-name parrot \
>   --memory 256m \
>   --execution-timeout 5s \
>   --runtime python37 \
>   --entrypoint parrot.handler \
vice-acc>   --service-account-id $SERVICE_ACCOUNT_ID \
-source->   --source-version-id d4eh905sscp0je3gq1oj \
>   --environment ACCESS_KEY=$ACCESS_KEY \
>   --environment SECRET_KEY=$SECRET_KEY \
>   --environment BUCKET_NAME=$BUCKET_NAME
done (12s)
id: d4ebvu931nq8eft6dsat
function_id: d4ed5jq552vlahl1fljb
created_at: "2023-01-07T09:56:46.346Z"
runtime: python37
entrypoint: parrot.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "14704640"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgcrujuu69fhf79soka
environment:
  ACCESS_KEY: YCAJEIaKBMcNsoNSgoMqQglBG
  BUCKET_NAME: bucket-for-trigger-b1ghk9uitis1fanhbci6
  SECRET_KEY: YCNBP5E8PSN6GmqHXS0nv5pzGHR4qUHWLo_EDS82
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ yc serverless function allow-unauthenticated-invoke parrot
done (1s)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/parrot$ 
