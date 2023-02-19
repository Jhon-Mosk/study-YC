yc iam access-key create --service-account-name service-account-for-cf
# access_key:
#   id: aj***o2
#   service_account_id: aj***1r
#   created_at: "2023-01-16T17:07:39.756844995Z"
#   key_id: YC***vp
# secret: YC***gh

echo "export VERBOSE_LOG=True" >>~/.bashrc && . ~/.bashrc

echo "export AWS_ACCESS_KEY_ID=YC***vp" >>~/.bashrc && . ~/.bashrc

echo "export AWS_SECRET_ACCESS_KEY=YC***gh" >>~/.bashrc && . ~/.bashrc

echo "export QUEUE_URL=https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/my-first-queue" >>~/.bashrc && . ~/.bashrc

pipreqs $PWD --force
# INFO: Successfully saved requirements file in /serveless/queue/requirements.txt

zip my-url-receiver-function my-url-receiver-function.py requirements.txt
# adding: my-url-receiver-function.py (deflated 51%)
# adding: requirements.txt (stored 0%)

yc serverless function create \
--name my-url-receiver-function \
--description "function for url"
# done (2s)
# id: d4***fc
# folder_id: b1***3m
# created_at: "2023-01-16T17:15:11.792Z"
# name: my-url-receiver-function
# description: function for url
# log_group_id: ck***6v
# http_invoke_url: https://functions.yandexcloud.net/d4***fc
# status: ACTIVE

yc serverless function version create \
--function-name=my-url-receiver-function \
--memory=256m \
--execution-timeout=5s \
--runtime=python37 \
--entrypoint=my-url-receiver-function.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--environment VERBOSE_LOG=$VERBOSE_LOG \
--environment AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
--environment AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
--environment QUEUE_URL=$QUEUE_URL \
--source-path my-url-receiver-function.zip
# done (4s)
# id: d4***ib
# function_id: d4***fc
# created_at: "2023-01-16T17:15:33.281Z"
# runtime: python37
# entrypoint: my-url-receiver-function.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "24576"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***6v
# environment:
#   AWS_ACCESS_KEY_ID: aj***o2
#   AWS_SECRET_ACCESS_KEY: YC***gh
#   QUEUE_URL: https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/my-first-queue
#   VERBOSE_LOG: "True"
# log_options:
#   folder_id: b1***3m

yc serverless api-gateway get-spec \
--name hello-world >>hello-world-new.yaml

yc serverless api-gateway update \
--name hello-world \
--spec=hello-world-new.yaml
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

pipreqs $PWD --force
# INFO: Successfully saved requirements file in /serveless/queue/requirements.txt

zip function-for-url-from-mq function-for-url-from-mq.py requirements.txt
# adding: function-for-url-from-mq.py (deflated 59%)
# adding: requirements.txt (deflated 2%)

yc serverless function create \
--name function-for-url-from-mq \
--description "function for url from mq"
# done (1s)
# id: d4***4b
# folder_id: b1***3m
# created_at: "2023-01-16T17:40:40.068Z"
# name: function-for-url-from-mq
# description: function for url from mq
# log_group_id: ck***hj
# http_invoke_url: https://functions.yandexcloud.net/d4***4b
# status: ACTIVE

yc serverless function version create \
--function-name=function-for-url-from-mq \
--memory=256m \
--execution-timeout=5s \
--runtime=python37 \
--entrypoint=function-for-url-from-mq.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--environment VERBOSE_LOG=True \
--environment CONNECTION_ID=$CONNECTION_ID \
--environment DB_USER=$DB_USER \
--environment DB_HOST=$DB_HOST \
--environment AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
--environment AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
--environment QUEUE_URL=$QUEUE_URL \
--source-path function-for-url-from-mq.zip
# done (19s)
# id: d4***vp
# function_id: d4***4b
# created_at: "2023-01-16T17:40:52.560Z"
# runtime: python37
# entrypoint: function-for-url-from-mq.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "21442560"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***hj
# environment:
#   AWS_ACCESS_KEY_ID: YC***vp
#   AWS_SECRET_ACCESS_KEY: YC***gh
#   CONNECTION_ID: ak***c8
#   DB_HOST: ak***c8.postgresql-proxy.serverless.yandexcloud.net
#   DB_USER: user1
#   QUEUE_URL: https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/my-first-queue
#   VERBOSE_LOG: "True"
# log_options:
#   folder_id: b1***3m

yc serverless trigger create timer \
--name trigger-for-mq \
--invoke-function-name function-for-url-from-mq \
--invoke-function-service-account-id $SERVICE_ACCOUNT_ID \
--cron-expression '* * * * ? *'
# id: a1***g6
# folder_id: b1***3m
# created_at: "2023-01-16T18:03:04.533389255Z"
# name: trigger-for-mq
# rule:
#   timer:
#     cron_expression: '* * * * ? *'
#     invoke_function_with_retry:
#       function_id: d4***4b
#       function_tag: $latest
#       service_account_id: aj***1r
# status: ACTIVE

yc serverless trigger delete trigger-for-mq
# id: a1***g6
# folder_id: b1***3m
# created_at: "2023-01-16T18:03:04.533Z"
# name: trigger-for-mq
# rule:
#   timer:
#     cron_expression: '* * * * ? *'
#     invoke_function_with_retry:
#       function_id: d4***4b
#       function_tag: $latest
#       service_account_id: aj***1r
# status: PAUSED
