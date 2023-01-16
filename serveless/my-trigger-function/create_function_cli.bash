user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ cd my-trigger-function/
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function create --name my-trigger-function
yc serverless function version create \
  --function-name my-trigger-function \
  --memory 256m \
  --execution-timeout 5s \
  --runtime python37 \
  --entrypoint index.handler \
  --service-account-id $SERVICE_ACCOUNT_ID \
  --source-path index.py

done (1s)less function version list --function-name my-trigger-function
id: d4eobqsruur6i13r2gsl
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-07T09:44:28.252Z"
name: my-trigger-function
log_group_id: ckgil0kpv59klot72s65
http_invoke_url: https://functions.yandexcloud.net/d4eobqsruur6i13r2gsl
status: ACTIVE

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function version create \
>   --function-name my-trigger-function \
>   --memory 256m \
>   --execution-timeout 5s \
>   --runtime python37 \
>   --entrypoint index.handler \
>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --source-path index.py
done (2s)
id: d4ed886o60o99dq82itn
function_id: d4eobqsruur6i13r2gsl
created_at: "2023-01-07T09:44:31.195Z"
runtime: python37
entrypoint: index.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "4096"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgil0kpv59klot72s65
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ 
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function version list --function-name my-trigger-function
+----------------------+----------------------+----------+---------------+---------+---------------------+
|          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
+----------------------+----------------------+----------+---------------+---------+---------------------+
| d4ed886o60o99dq82itn | d4eobqsruur6i13r2gsl | python37 | index.handler | $latest | 2023-01-07 09:44:31 |
+----------------------+----------------------+----------+---------------+---------+---------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless trigger create object-storage \
>   --name my-first-trigger \
>   --bucket-id $BUCKET_NAME \
>   --events 'create-object' \
>   --invoke-function-name my-trigger-function \
>   --invoke-function-service-account-id $SERVICE_ACCOUNT_ID
id: a1s3ao616uclkt53fh94
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-07T09:45:21.569890532Z"
name: my-first-trigger
rule:
  object_storage:
    event_type:
      - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
    bucket_id: bucket-for-trigger-b1ghk9uitis1fanhbci6
    invoke_function:
      function_id: d4eobqsruur6i13r2gsl
      function_tag: $latest
      service_account_id: aje7e481l77uk8g0fa1r
status: ACTIVE

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function list
+----------------------+---------------------+----------------------+--------+
|          ID          |        NAME         |      FOLDER ID       | STATUS |
+----------------------+---------------------+----------------------+--------+
| d4elru9uerct0hhl59ne | my-first-function   | b1gp2lhjstd03j7rff3m | ACTIVE |
| d4eobqsruur6i13r2gsl | my-trigger-function | b1gp2lhjstd03j7rff3m | ACTIVE |
+----------------------+---------------------+----------------------+--------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function version list --function-name my-first-function 
+----------------------+----------------------+----------+---------------+---------+---------------------+
|          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
+----------------------+----------------------+----------+---------------+---------+---------------------+
| d4eeudbocuerauf9h8o0 | d4elru9uerct0hhl59ne | python37 | index.handler | $latest | 2023-01-07 09:40:53 |
| d4ens02e9u5qpc05t9dm | d4elru9uerct0hhl59ne | python37 | index.handler |         | 2023-01-07 09:34:29 |
| d4e7o3b41aqs1sogu15o | d4elru9uerct0hhl59ne | python37 | index.handler |         | 2023-01-07 08:15:43 |
+----------------------+----------------------+----------+---------------+---------+---------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function invoke d4elru9uerct0hhl59ne
{"statusCode": 200, "body": "File is uploaded"}
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ yc serverless function logs my-trigger-function
2023-01-07 09:46:20  INFO START RequestID: a1220747-3a1b-4199-aa57-3fc4c42ed13e Version: d4ed886o60o99dq82itn
2023-01-07 09:46:20       📂 Starting function after trigger
2023-01-07 09:46:20       {'messages': [{'event_metadata': {'event_id': '25605ccd-6db2-4ca4-95f1-fefdbf53ab6e', 'event_type': 'yandex.cloud.events.storage.ObjectCreate', 'created_at': '2023-01-07T09:46:19.149276079Z', 'tracing_context': {'trace_id': '9a220bbc23a69eb8', 'span_id': '', 'parent_span_id': ''}, 'cloud_id': 'b1ghk9uitis1fanhbci6', 'folder_id': 'b1gp2lhjstd03j7rff3m'}, 'details': {'bucket_id': 'bucket-for-trigger-b1ghk9uitis1fanhbci6', 'object_id': 'file-2023-01-07__12-46-18.txt'}}]}
2023-01-07 09:46:20  INFO END RequestID: a1220747-3a1b-4199-aa57-3fc4c42ed13e
2023-01-07 09:46:20  INFO REPORT RequestID: a1220747-3a1b-4199-aa57-3fc4c42ed13e Duration: 194.747 ms Billed Duration: 200 ms Memory Size: 256 MB Max Memory Used: 11 MB Queuing Duration: 0.044 ms Function Init Duration: 192.363 ms

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/my-trigger-function$ 
