user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ export SERVICE_ACCOUNT=$(yc iam service-account create \
>   --name service-account-for-cf \
>   --description "service account for cloud functions" \
>   --format json | jq -r .)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc iam service-account list
+----------------------+------------------------+
|          ID          |          NAME          |
+----------------------+------------------------+
| aje7e481l77uk8g0fa1r | service-account-for-cf |
| ajetl1sng1kvgcjhovhr | study                  |
+----------------------+------------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo $SERVICE_ACCOUNT
{ "id": "aje7e481l77uk8g0fa1r", "folder_id": "b1gp2lhjstd03j7rff3m", "created_at": "2023-01-07T07:53:31.716965471Z", "name": "service-account-for-cf", "description": "service account for cloud functions" }
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo "export SERVICE_ACCOUNT_ID=aje7e481l77uk8g0fa1r" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo $SERVICE_ACCOUNT_ID
aje7e481l77uk8g0fa1r
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo "export FOLDER_ID=$(yc config get folder-id)" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo $FOLDER_ID
b1gp2lhjstd03j7rff3m
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc resource-manager folder add-access-binding $FOLDER_ID \
>   --subject serviceAccount:$SERVICE_ACCOUNT_ID \
>   --role editor
done (1s)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function create --name my-first-function
done (1s)
id: d4elru9uerct0hhl59ne
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-07T08:13:12.475Z"
name: my-first-function
log_group_id: ckgndknuhqntdgrrfitg
http_invoke_url: https://functions.yandexcloud.net/d4elru9uerct0hhl59ne
status: ACTIVE

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ ls
cli.bash
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ sudo nano index.py
[sudo] password for user:
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version create \
    --fu>     --function-name my-first-function \
>     --memory 256m \
>     --execution-timeout 5s \
>     --runtime python37 \
--entryp>     --entrypoint index.handler \
>     --service-account-id $SERVICE_ACCOUNT_ID \
>     --source-path index.py
done (5s)
id: d4e7o3b41aqs1sogu15o
function_id: d4elru9uerct0hhl59ne
created_at: "2023-01-07T08:15:43.694Z"
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
log_group_id: ckgndknuhqntdgrrfitg
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function list
+----------------------+-------------------+----------------------+--------+
|          ID          |       NAME        |      FOLDER ID       | STATUS |
+----------------------+-------------------+----------------------+--------+
| d4elru9uerct0hhl59ne | my-first-function | b1gp2lhjstd03j7rff3m | ACTIVE |
+----------------------+-------------------+----------------------+--------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version list --function-name my-first-function 
+----------------------+----------------------+----------+---------------+---------+---------------------+
|          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
+----------------------+----------------------+----------+---------------+---------+---------------------+
| d4e7o3b41aqs1sogu15o | d4elru9uerct0hhl59ne | python37 | index.handler | $latest | 2023-01-07 08:15:43 |
+----------------------+----------------------+----------+---------------+---------+---------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function invoke d4elru9uerct0hhl59ne
{"statusCode": 200, "body": "Hello World!"}
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function allow-unauthenticated-invoke my-first-function
done (1s)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function get my-first-function
id: d4elru9uerct0hhl59ne
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-07T08:13:12.475Z"
name: my-first-function
log_group_id: ckgndknuhqntdgrrfitg
http_invoke_url: https://functions.yandexcloud.net/d4elru9uerct0hhl59ne
status: ACTIVE

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ zip my-first-function.zip index.py requirements.txt 
  adding: index.py (deflated 54%)
  adding: requirements.txt (deflated 13%)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version create \
  --func>   --function-name my-first-function \
>   --memory 256m \
>   --execution-timeout 5s \
>   --runtime python37 \
-->   --entrypoint index.handler \
ervice-a>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --source-path my-first-function.zip
done (13s)
id: d4ens02e9u5qpc05t9dm
function_id: d4elru9uerct0hhl59ne
created_at: "2023-01-07T09:34:29.938Z"
runtime: python37
entrypoint: index.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "14704640"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgndknuhqntdgrrfitg
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo "export ACCESS_KEY=YCAJEIaKBMcNsoNSgoMqQglBG" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo "export SECRET_KEY=YCNBP5E8PSN6GmqHXS0nv5pzGHR4qUHWLo_EDS82" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ echo "export BUCKET_NAME=bucket-for-trigger-b1ghk9uitis1fanhbci6" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version list --function-name my-first-function
+----------------------+----------------------+----------+---------------+---------+---------------------+
|          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
+----------------------+----------------------+----------+---------------+---------+---------------------+
| d4ens02e9u5qpc05t9dm | d4elru9uerct0hhl59ne | python37 | index.handler | $latest | 2023-01-07 09:34:29 |
| d4e7o3b41aqs1sogu15o | d4elru9uerct0hhl59ne | python37 | index.handler |         | 2023-01-07 08:15:43 |
+----------------------+----------------------+----------+---------------+---------+---------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version create \
>   --function-name my-first-function \
>   --memory 256m \
>   --execution-timeout 5s \
>   --runtime python37 \
>   --entrypoint index.handler \
>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --source-version-id <ID> \
ironment>   --environment ACCESS_KEY=$ACCESS_KEY \
>   --environment SECRET_KEY=$SECRET_KEY \
> yc serverless function version create   --function-name my-first-function   --memory 256m   --execution-timeout 5s   --runtime python37   --entrypoint index.handler   --service-account-id $SERVICE_ACCOUNT_ID   --source-version-id <ID>   --environment ACCESS_KEY=$ACCESS_KEY   --environment SECRET_KEY=$SECRET_KEY \qqqqqqqqqqqqqqqqqqqqqq
bash: ID: No such file or directory
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version create \
>   --function-name my-first-function \
>   --memory 256m \
>   --execution-timeout 5s \
 --runti>   --runtime python37 \
>   --entrypoint index.handler \
>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --source-version-id <ID> \
>   --environment ACCESS_KEY=$ACCESS_KEY \
>   --environment SECRET_KEY=$SECRET_KEY \
> yc serverless function version create   --function-name my-first-function   --memory 256m   --execution-timeout 5s   --runtime python37   --entrypoint index.handler   --service-account-id $SERVICE_ACCOUNT_ID   --source-version-id <ID>   --environment ACCESS_KEY=$ACCESS_KEY   --environment SECRET_KEY=$SECRET_KEY yc serverless function version create   --function-name my-first-function   --memory 
256m   --execution-timeout 5s   --runtime python37   --entrypoint index.handler   --service-account-id $SERVICE_ACCOUNT_ID   --source-version-id <ID>   --environment ACCESS_KEY=$ACCESS_KEY   --environment SECRET_KEY=$SECRET_KEY \qqqqqqqqqqqqqqqqqqqqqq
bash: ID: No such file or directory
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version create \
  --func>   --function-name my-first-function \
>   --memory 256m \
>   --execution-timeout 5s \
>   --runtime python37 \
>   --entrypoint index.handler \
>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --source-version-id d4elru9uerct0hhl59ne \
>   --environment ACCESS_KEY=$ACCESS_KEY \
>   --environment SECRET_KEY=$SECRET_KEY \
>   --environment BUCKET_NAME=$BUCKET_NAME
ERROR: rpc error: code = NotFound desc = Function version d4elru9uerct0hhl59ne not found


server-request-id: 7b917af7-de03-4f06-84d1-b2489ffc6dcb
client-request-id: 393b9c82-a91a-41d4-8e3c-dd2cdbb2d069
server-trace-id: f4c87d7ca403e0d9:d1a22f17ac1690d1:f4c87d7ca403e0d9:1
client-trace-id: 948449e8-066f-4e3b-b0d3-eb2c343d408e

Use server-request-id, client-request-id, server-trace-id, client-trace-id for investigation of issues in cloud support
If you are going to ask for help of cloud support, please send the following trace file: /home/user/.config/yandex-cloud/logs/2023-01-07T12-39-56.338-yc_serverless_function_version_create.txt
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version create \
>   --function-name my-first-function \
memory 2>   --memory 256m \
>   --execution-timeout 5s \
>   --runtime python37 \
>   --entrypoint index.handler \
>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --source-version-id d4ens02e9u5qpc05t9dm \
>   --environment ACCESS_KEY=$ACCESS_KEY \
>   --environment SECRET_KEY=$SECRET_KEY \
>   --environment BUCKET_NAME=$BUCKET_NAME
done (12s)
id: d4eeudbocuerauf9h8o0
function_id: d4elru9uerct0hhl59ne
created_at: "2023-01-07T09:40:53.366Z"
runtime: python37
entrypoint: index.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "14704640"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgndknuhqntdgrrfitg
environment:
  ACCESS_KEY: YCAJEIaKBMcNsoNSgoMqQglBG
  BUCKET_NAME: bucket-for-trigger-b1ghk9uitis1fanhbci6
  SECRET_KEY: YCNBP5E8PSN6GmqHXS0nv5pzGHR4qUHWLo_EDS82
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function list
+----------------------+-------------------+----------------------+--------+
|          ID          |       NAME        |      FOLDER ID       | STATUS |
+----------------------+-------------------+----------------------+--------+
| d4elru9uerct0hhl59ne | my-first-function | b1gp2lhjstd03j7rff3m | ACTIVE |
+----------------------+-------------------+----------------------+--------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function version list --function-name my-first-function 
+----------------------+----------------------+----------+---------------+---------+---------------------+
|          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
+----------------------+----------------------+----------+---------------+---------+---------------------+
| d4eeudbocuerauf9h8o0 | d4elru9uerct0hhl59ne | python37 | index.handler | $latest | 2023-01-07 09:40:53 |
| d4ens02e9u5qpc05t9dm | d4elru9uerct0hhl59ne | python37 | index.handler |         | 2023-01-07 09:34:29 |
| d4e7o3b41aqs1sogu15o | d4elru9uerct0hhl59ne | python37 | index.handler |         | 2023-01-07 08:15:43 |
+----------------------+----------------------+----------+---------------+---------+---------------------+

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function invoke d4elru9uerct0hhl59ne
{"statusCode": 200, "body": "File is uploaded"}
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless$ yc serverless function get my-first-function
id: d4elru9uerct0hhl59ne
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-07T08:13:12.475Z"
name: my-first-function
log_group_id: ckgndknuhqntdgrrfitg
http_invoke_url: https://functions.yandexcloud.net/d4elru9uerct0hhl59ne
status: ACTIVE
