cd my-trigger-function/

yc serverless function create --name my-trigger-function

yc serverless function version create \
--function-name my-trigger-function \
--memory 256m \
--execution-timeout 5s \
--runtime python37 \
--entrypoint index.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-path index.py

yc serverless function version list --function-name my-trigger-function

yc serverless function version create \
--function-name my-trigger-function \
--memory 256m \
--execution-timeout 5s \
--runtime python37 \
--entrypoint index.handler \
--service-account-id $SERVICE_ACCOUNT_ID \
--source-path index.py
# done (2s)
# id: d4***tn
# function_id: d4***sl
# created_at: "2023-01-07T09:44:31.195Z"
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
# log_group_id: ck***65
# log_options:
#   folder_id: b1***3m

yc serverless function version list --function-name my-trigger-function
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
# +----------------------+----------------------+----------+---------------+---------+---------------------+
# | d4***tn | d4***sl | python37 | index.handler | $latest | 2023-01-07 09:44:31 |
# +----------------------+----------------------+----------+---------------+---------+---------------------+

yc serverless trigger create object-storage \
--name my-first-trigger \
--bucket-id $BUCKET_NAME \
--events 'create-object' \
--invoke-function-name my-trigger-function \
--invoke-function-service-account-id $SERVICE_ACCOUNT_ID
# id: a1***94
# folder_id: b1***3m
# created_at: "2023-01-07T09:45:21.569890532Z"
# name: my-first-trigger
# rule:
#   object_storage:
#     event_type:
#       - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
#     bucket_id: bucket-for-trigger-b1***i6
#     invoke_function:
#       function_id: d4***sl
#       function_tag: $latest
#       service_account_id: aj***1r
# status: ACTIVE

yc serverless function list
# +----------------------+---------------------+----------------------+--------+
# |          ID          |        NAME         |      FOLDER ID       | STATUS |
# +----------------------+---------------------+----------------------+--------+
# | d4***ne              | my-first-function   | b1***3m              | ACTIVE |
# | d4***sl              | my-trigger-function | b1***3m              | ACTIVE |
# +----------------------+---------------------+----------------------+--------+

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

yc serverless function logs my-trigger-function
# 2023-01-07 09:46:20  INFO START RequestID: a1220747-3a1b-4199-aa57-3fc4c42ed13e Version: d4***tn
# 2023-01-07 09:46:20       📂 Starting function after trigger
# 2023-01-07 09:46:20       {'messages': [{'event_metadata': {'event_id': '25605ccd-6db2-4ca4-95f1-fefdbf53ab6e', 'event_type': 'yandex.cloud.events.storage.ObjectCreate', 'created_at': '2023-01-07T09:46:19.149276079Z', 'tracing_context': {'trace_id': '9a***b8', 'span_id': '', 'parent_span_id': ''}, 'cloud_id': 'b1***i6', 'folder_id': 'b1***3m'}, 'details': {'bucket_id': 'bucket-for-trigger-b1***i6', 'object_id': 'file-2023-01-07__12-46-18.txt'}}]}
# 2023-01-07 09:46:20  INFO END RequestID: a1220747-3a1b-4199-aa57-3fc4c42ed13e
# 2023-01-07 09:46:20  INFO REPORT RequestID: a1220747-3a1b-4199-aa57-3fc4c42ed13e Duration: 194.747 ms Billed Duration: 200 ms Memory Size: 256 MB Max Memory Used: 11 MB Queuing Duration: 0.044 ms Function Init Duration: 192.363 ms
