yc serverless api-gateway create \
--name hello-world \
--spec=spec.yaml \
--description "hello world"
# done (6s)
# id: d5***no
# folder_id: b1***3m
# created_at: "2023-01-11T17:35:44.804Z"
# name: hello-world
# description: hello world
# status: ACTIVE
# domain: d5***no.apigw.yandexcloud.net
# log_group_id: ck***4j
# connectivity: {}
# log_options:
#   folder_id: b1***3m

yc serverless api-gateway list
# +----------------------+-------------+----------------------+--------+
# |          ID          |    NAME     |      FOLDER ID       | STATUS |
# +----------------------+-------------+----------------------+--------+
# | d5***no              | hello-world | b1***3m              | ACTIVE |
# +----------------------+-------------+----------------------+--------+

yc serverless api-gateway get --name hello-world
# id: d5***no
# folder_id: b1***3m
# created_at: "2023-01-11T17:35:44.804Z"
# name: hello-world
# description: hello world
# status: ACTIVE
# domain: d5***no.apigw.yandexcloud.net
# log_group_id: ck***4j
# connectivity: {}
# log_options:
#   folder_id: b1***3m

yc serverless function create \
--name function-for-user-requests \
--description "function for response to user"
# done (1s)
# id: d4***e9
# folder_id: b1***3m
# created_at: "2023-01-11T17:42:43.192Z"
# name: function-for-user-requests
# description: function for response to user
# log_group_id: ck***he
# http_invoke_url: https://functions.yandexcloud.net/d4***e9
# status: ACTIVE

yc serverless function version create \
--function-name=function-for-user-requests \
--memory=256m \
--execution-timeout=5s \
--runtime=python37 \
--entrypoint=function-for-user-requests.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--environment VERBOSE_LOG=True \
--environment CONNECTION_ID=$CONNECTION_ID \
--environment DB_USER=$DB_USER \
--environment DB_HOST=$DB_HOST \
--source-path function-for-user-requests.py
# done (4s)
# id: d4***al
# function_id: d4***e9
# created_at: "2023-01-11T18:05:44.777Z"
# runtime: python37
# entrypoint: function-for-user-requests.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "4096"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***he
# environment:
#   CONNECTION_ID: ak***c8
#   DB_HOST: ak***c8.postgresql-proxy.serverless.yandexcloud.net
#   DB_USER: user1
#   VERBOSE_LOG: "True"
# log_options:
#   folder_id: b1***3m

yc serverless api-gateway update \
--name hello-world \
--spec=spec.yaml
# done (3s)
# id: d5***no
# folder_id: b1***3m
# created_at: "2023-01-11T17:35:44.804Z"
# name: hello-world
# description: hello world
# status: ACTIVE
# domain: d5***no.apigw.yandexcloud.net
# log_group_id: ck***4j
# connectivity: {}
# log_options:
#   folder_id: b1***3m
