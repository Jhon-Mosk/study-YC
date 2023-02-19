export SERVICE_ACCOUNT=$(
  yc iam service-account create \
  --name service-account-for-cf \
  --description "service account for cloud functions" \
  --format json | jq -r .
)

yc iam service-account list
# +----------------------+------------------------+
# |          ID          |          NAME          |
# +----------------------+------------------------+
# | aj***1r | service-account-for-cf |
# | aj***hr | study                  |
# +----------------------+------------------------+

echo $SERVICE_ACCOUNT
# { "id": "aj***1r", "folder_id": "b1***3m", "created_at": "2023-01-07T07:53:31.716965471Z", "name": "service-account-for-cf", "description": "service account for cloud functions" }

echo "export SERVICE_ACCOUNT_ID=aj***1r" >>~/.bashrc && . ~/.bashrc

echo $SERVICE_ACCOUNT_ID
# aj***1r

echo "export FOLDER_ID=$(yc config get folder-id)" >>~/.bashrc && . ~/.bashrc

echo $FOLDER_ID
# b1***3m

yc resource-manager folder add-access-binding $FOLDER_ID \
--subject serviceAccount:$SERVICE_ACCOUNT_ID \
--role editor
# done (1s)

yc serverless function create --name my-first-function
# done (1s)
# id: d4***ne
# folder_id: b1***3m
# created_at: "2023-01-07T08:13:12.475Z"
# name: my-first-function
# log_group_id: ck***tg
# http_invoke_url: https://functions.yandexcloud.net/d4***ne
# status: ACTIVE

ls
# cli.bash

sudo nano index.py
# [sudo] password for user:

yc serverless function version create \
--function-name my-first-function \
--memory 256m \
--execution-timeout 5s \
--runtime python37 \
--entrypoint index.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-path index.py
# done (5s)
# id: d4***5o
# function_id: d4***ne
# created_at: "2023-01-07T08:15:43.694Z"
# runtime: python37
# entrypoint: index.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "4096"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***tg
# log_options:
#   folder_id: b1***3m

yc serverless function list
# +----------------------+-------------------+----------------------+--------+
# |          ID          |       NAME        |      FOLDER ID       | STATUS |
# +----------------------+-------------------+----------------------+--------+
# | d4***ne              | my-first-function | b1***3m              | ACTIVE |
# +----------------------+-------------------+----------------------+--------+

yc serverless function version list --function-name my-first-function
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# | d4***5o | d4***ne | python37 | index.handler | $latest | 2023-01-07 08:15:43 |
# +----------------------+----------------------+----------+---------------+---------+---------------------+

yc serverless function invoke d4***ne
# {"statusCode": 200, "body": "Hello World!"}

yc serverless function allow-unauthenticated-invoke my-first-function
# done (1s)

yc serverless function get my-first-function
# id: d4***ne
# folder_id: b1***3m
# created_at: "2023-01-07T08:13:12.475Z"
# name: my-first-function
# log_group_id: ck***tg
# http_invoke_url: https://functions.yandexcloud.net/d4***ne
# status: ACTIVE

zip my-first-function.zip index.py requirements.txt
# adding: index.py (deflated 54%)
# adding: requirements.txt (deflated 13%)

yc serverless function version create \
--function-name my-first-function \
--memory 256m \
--execution-timeout 5s \
--runtime python37 \
--entrypoint index.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-path my-first-function.zip
# done (13s)
# id: d4***dm
# function_id: d4***ne
# created_at: "2023-01-07T09:34:29.938Z"
# runtime: python37
# entrypoint: index.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "14704640"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***tg
# log_options:
#   folder_id: b1***3m

echo "export ACCESS_KEY=YC***BG" >>~/.bashrc && . ~/.bashrc

echo "export SECRET_KEY=YC***82" >>~/.bashrc && . ~/.bashrc

echo "export BUCKET_NAME=bucket-for-trigger-b1***i6" >>~/.bashrc && . ~/.bashrc

yc serverless function version list --function-name my-first-function
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# | d4***dm | d4***ne | python37 | index.handler | $latest | 2023-01-07 09:34:29 |
# | d4***5o | d4***ne | python37 | index.handler |         | 2023-01-07 08:15:43 |
# +----------------------+----------------------+----------+---------------+---------+---------------------+

yc serverless function version create \
--function-name my-first-function \
--memory 256m \
--execution-timeout 5s \
--runtime python37 \
--entrypoint index.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-version-id d4***dm \
--environment ACCESS_KEY=$ACCESS_KEY \
--environment SECRET_KEY=$SECRET_KEY \
--environment BUCKET_NAME=$BUCKET_NAME
# done (12s)
# id: d4***o0
# function_id: d4***ne
# created_at: "2023-01-07T09:40:53.366Z"
# runtime: python37
# entrypoint: index.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "14704640"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***tg
# environment:
#   ACCESS_KEY: YC***BG
#   BUCKET_NAME: bucket-for-trigger-b1***i6
#   SECRET_KEY: YC***82
# log_options:
#   folder_id: b1***3m

yc serverless function list
# +----------------------+-------------------+----------------------+--------+
# |          ID          |       NAME        |      FOLDER ID       | STATUS |
# +----------------------+-------------------+----------------------+--------+
# | d4***ne              | my-first-function | b1***3m              | ACTIVE |
# +----------------------+-------------------+----------------------+--------+

yc serverless function version list --function-name my-first-function
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# | d4***o0 | d4***ne | python37 | index.handler | $latest | 2023-01-07 09:40:53 |
# | d4***dm | d4***ne | python37 | index.handler |         | 2023-01-07 09:34:29 |
# | d4***5o | d4***ne | python37 | index.handler |         | 2023-01-07 08:15:43 |
# +----------------------+----------------------+----------+---------------+---------+---------------------+

yc serverless function invoke d4***ne
# {"statusCode": 200, "body": "File is uploaded"}

yc serverless function get my-first-function
# id: d4***ne
# folder_id: b1***3m
# created_at: "2023-01-07T08:13:12.475Z"
# name: my-first-function
# log_group_id: ck***tg
# http_invoke_url: https://functions.yandexcloud.net/d4***ne
# status: ACTIVE
