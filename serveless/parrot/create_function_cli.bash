yc serverless function create \
--name parrot \
--description "function for Alice"
# done (1s)
# id: d4***jb
# folder_id: b1***3m
# created_at: "2023-01-07T09:51:21.765Z"
# name: parrot
# description: function for Alice
# log_group_id: ck***ka
# http_invoke_url: https://functions.yandexcloud.net/d4***jb
# status: ACTIVE

zip parrot.zip parrot.py requirements.txt
# adding: parrot.py (deflated 57%)
# adding: requirements.txt (deflated 13%)

yc serverless function version create \
--function-name=parrot \
--memory=256m \
--execution-timeout=5s \
--runtime=python37 \
--entrypoint=parrot.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-path parrot.zip
# done (14s)
# id: d4***oj
# function_id: d4***jb
# created_at: "2023-01-07T09:54:49.780Z"
# runtime: python37
# entrypoint: parrot.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "14704640"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***ka
# log_options:
#   folder_id: b1***3m

yc serverless function version list --function-name parrot
# +----------------------+----------------------+----------+----------------+---------+---------------------+
# |          ID          |     FUNCTION ID      | RUNTIME  |   ENTRYPOINT   |  TAGS   |     CREATED AT      |
# +----------------------+----------------------+----------+----------------+---------+---------------------+
# | d4***oj | d4***jb | python37 | parrot.handler | $latest | 2023-01-07 09:54:49 |
# +----------------------+----------------------+----------+----------------+---------+---------------------+

yc serverless function version create \
--function-name parrot \
--memory 256m \
--execution-timeout 5s \
--runtime python37 \
--entrypoint parrot.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-version-id d4***oj \
--environment ACCESS_KEY=$ACCESS_KEY \
--environment SECRET_KEY=$SECRET_KEY \
--environment BUCKET_NAME=$BUCKET_NAME
# done (12s)
# id: d4***at
# function_id: d4***jb
# created_at: "2023-01-07T09:56:46.346Z"
# runtime: python37
# entrypoint: parrot.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "14704640"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***ka
# environment:
#   ACCESS_KEY: YC***BG
#   BUCKET_NAME: bucket-for-trigger-b1***i6
#   SECRET_KEY: YC***82
# log_options:
#   folder_id: b1***3m

yc serverless function allow-unauthenticated-invoke parrot
# done (1s)
