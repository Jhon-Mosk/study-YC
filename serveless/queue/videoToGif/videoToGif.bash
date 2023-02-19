export SERVICE_ACCOUNT=$(yc iam service-account create --name ffmpeg-account-for-cf \
    --description "service account for serverless" \
    --format json | jq -r .)

yc iam service-account list
# +----------------------+------------------------+
# |          ID          |          NAME          |
# +----------------------+------------------------+
# | aj***a1r             | service-account-for-cf |
# | aj***m4              | ffmpeg-account-for-cf  |
# | aj***hr              | study                  |
# +----------------------+------------------------+

echo "export SERVICE_ACCOUNT_FFMPEG_ID=aj***m4" >>~/.bashrc && . ~/.bashrc

echo $SERVICE_ACCOUNT_FFMPEG_ID
# aj***m4

echo "export FOLDER_ID=$(yc config get folder-id)" >>~/.bashrc && . ~/.bashrc

echo $FOLDER_ID
# b1***f3m

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role storage.viewer
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role storage.uploader
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role ymq.reader
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role ymq.writer
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role ydb.admin
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role serverless.functions.invoker
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role lockbox.payloadViewer
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
    --subject serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --role editor
# done (1s)

yc resource-manager folder list-access-bindings $FOLDER_ID
# +------------------------------+----------------+----------------------+
# |           ROLE ID            |  SUBJECT TYPE  |      SUBJECT ID      |
# +------------------------------+----------------+----------------------+
# | editor                       | serviceAccount | aj***m4              |
# | serverless.functions.invoker | serviceAccount | aj***m4              |
# | admin                        | serviceAccount | aj***hr              |
# | storage.viewer               | serviceAccount | aj***m4              |
# | storage.uploader             | serviceAccount | aj***m4              |
# | ymq.writer                   | serviceAccount | aj***m4              |
# | serverless.mdbProxies.user   | serviceAccount | aj***1r              |
# | editor                       | serviceAccount | aj***hr              |
# | editor                       | serviceAccount | aj***1r              |
# | storage.editor               | serviceAccount | aj***1r              |
# | ydb.admin                    | serviceAccount | aj***m4              |
# | ymq.reader                   | serviceAccount | aj***m4              |
# | lockbox.payloadViewer        | serviceAccount | aj***m4              |
# +------------------------------+----------------+----------------------+

yc resource-manager folder set-access-bindings $FOLDER_ID \
    --access-binding role=storage.viewer,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=storage.uploader,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=ymq.reader,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=ymq.writer,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=ydb.admin,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=serverless.functions.invoker,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=lockbox.payloadViewer,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID \
    --access-binding role=editor,subject=serviceAccount:$SERVICE_ACCOUNT_FFMPEG_ID
# WARN: All current access-bindings will be deleted. Are you sure?[y/N] y
# done (1s)

yc iam access-key create --service-account-name ffmpeg-account-for-cf
# access_key:
#     id: aj***g4
#     service_account_id: aj***m4
#     created_at: "2023-01-16T18:29:12.841656910Z"
#     key_id: YC***yI
# secret: YC***1v

yc lockbox secret create --name ffmpeg-sa-key \
    --folder-id $FOLDER_ID \
    --description "keys for serverless" \
    --payload '[{"key": "ACCESS_KEY_ID", "text_value": YC***yI}, {"key": "SECRET_ACCESS_KEY", "text_value": "YC***1v"}]'
# id: e6***fc
# folder_id: b1***3m
# created_at: "2023-01-16T18:31:43.010Z"
# name: ffmpeg-sa-key
# description: keys for serverless
# status: ACTIVE
# current_version:
#     id: e6***ei
#     secret_id: e6***fc
#     created_at: "2023-01-16T18:31:43.010Z"
#     status: ACTIVE
#     payload_entry_keys:
#         - ACCESS_KEY_ID
#         - SECRET_ACCESS_KEY

yc lockbox secret list
# +----------------------+---------------+------------+---------------------+----------------------+--------+
# |          ID          |     NAME      | KMS KEY ID |     CREATED AT      |  CURRENT VERSION ID  | STATUS |
# +----------------------+---------------+------------+---------------------+----------------------+--------+
# | e6***fc | ffmpeg-sa-key |            | 2023-01-16 18:31:43 | e6***ei | ACTIVE |
# +----------------------+---------------+------------+---------------------+----------------------+--------+

yc lockbox secret get --name ffmpeg-sa-key
# id: e6***fc
# folder_id: b1***3m
# created_at: "2023-01-16T18:31:43.010Z"
# name: ffmpeg-sa-key
# description: keys for serverless
# status: ACTIVE
# current_version:
#     id: e6***ei
#     secret_id: e6***fc
#     created_at: "2023-01-16T18:31:43.010Z"
#     status: ACTIVE
#     payload_entry_keys:
#         - ACCESS_KEY_ID
#         - SECRET_ACCESS_KEY

echo "export SECRET_ID=e6***fc" >>~/.bashrc && . ~/.bashrc

echo $SECRET_ID
# e6***fc

aws configure
AWS Access Key ID [****************EBGA]: YC***yI
AWS Secret Access Key [****************gOav]: YC***1v
Default region name [ru-central1]: ru-central1
Default output format [None]:
# {
#     "QueueUrl": "https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/ffmpeg"
# }

echo "export YMQ_QUEUE_URL=https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/ffmpeg" >>~/.bashrc && . ~/.bashrc

echo $YMQ_QUEUE_URL
# https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/ffmpeg

aws sqs get-queue-attributes \
    --endpoint https://message-queue.api.cloud.yandex.net \
    --queue-url $YMQ_QUEUE_URL \
    --attribute-names QueueArn
# {
#     "Attributes": {
#         "QueueArn": "yrn:yc:ymq:ru-central1:b1***3m:ffmpeg"
#     }
# }

echo "export YMQ_QUEUE_ARN=yrn:yc:ymq:ru-central1:b1***3m:ffmpeg" >>~/.bashrc && . ~/.bashrc

echo $YMQ_QUEUE_ARN
# yrn:yc:ymq:ru-central1:b1***3m:ffmpeg

yc ydb database create ffmpeg \
    --serverless \
    --folder-id $FOLDER_ID
# done (7s)
# id: et***oh
# folder_id: b1***3m
# created_at: "2023-01-16T18:50:51Z"
# name: ffmpeg
# status: PROVISIONING
# endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***oh
# serverless_database:
#     storage_size_limit: "53687091200"
# location_id: ru-central1
# backup_config:
#     backup_settings:
#         - name: daily
#         backup_schedule:
#             daily_backup_schedule:
#             execute_time:
#                 hours: 17
#         backup_time_to_live: 604800s
#         type: SYSTEM
# document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh
# monitoring_config: {}

yc ydb database list
# +----------------------+--------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
# |          ID          |  NAME  | DESCRIPTION |                                                   ENDPOINT                                                   |     CREATED AT      | STATUS  |
# +----------------------+--------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
# | et***oh | ffmpeg |             | grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***oh | 2023-01-16 18:50:51 | RUNNING |
# | et***1e | ydb809 |             | grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***1e | 2023-01-13 17:54:01 | RUNNING |
# +----------------------+--------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+

yc ydb database get --name ffmpeg
# id: et***oh
# folder_id: b1***3m
# created_at: "2023-01-16T18:50:51Z"
# name: ffmpeg
# status: RUNNING
# endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***oh
# serverless_database:
#     storage_size_limit: "53687091200"
# location_id: ru-central1
# backup_config:
#     backup_settings:
#         - name: daily
#         backup_schedule:
#             daily_backup_schedule:
#                 execute_time:
#                     hours: 17
#             next_execute_time: "2023-01-17T17:00:00.912749Z"
#         backup_time_to_live: 604800s
#         type: SYSTEM
# document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh
# monitoring_config: {}

echo "export DOCAPI_ENDPOINT=https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh" >>~/.bashrc && . ~/.bashrc

echo $DOCAPI_ENDPOINT
# https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh

aws dynamodb create-table \
    --cli-input-json file://tasks.json \
    --endpoint-url $DOCAPI_ENDPOINT \
    --region ru-central1

echo "export S3_BUCKET=storage-for-ffmpeg-b1***3m" >>~/.bashrc && . ~/.bashrc

echo $S3_BUCKET
# storage-for-ffmpeg-b1***3m

echo $SERVICE_ACCOUNT_FFMPEG_ID
# aj***m4

echo $SECRET_ID
# e6***fc

echo $YMQ_QUEUE_URL
# https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/ffmpeg

echo $DOCAPI_ENDPOINT
# https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh

echo $S3_BUCKET
# storage-for-ffmpeg-b1***3m

pipreqs $PWD --force
# INFO: Successfully saved requirements file in /serveless/queue/videoToGif/requirements.txt

zip src.zip index.py requirements.txt ffmpeg
# adding: index.py (deflated 66%)
# adding: requirements.txt (deflated 10%)
# adding: ffmpeg (deflated 63%)

yc serverless function create \
    --name ffmpeg-api \
    --description "function for ffmpeg-api"
# done (2s)
# id: d4***28
# folder_id: b1***3m
# created_at: "2023-01-16T19:09:44.622Z"
# name: ffmpeg-api
# description: function for ffmpeg-api
# log_group_id: ck***v8
# http_invoke_url: https://functions.yandexcloud.net/d4***28
# status: ACTIVE

yc serverless function create \
    --name ffmpeg-converter \
    --description "function for ffmpeg-converter"
# done (1s)
# id: d4***or
# folder_id: b1***3m
# created_at: "2023-01-16T19:10:10.928Z"
# name: ffmpeg-converter
# description: function for ffmpeg-converter
# log_group_id: ck***1v
# http_invoke_url: https://functions.yandexcloud.net/d4***or
# status: ACTIVE

yc serverless function version create \
    --function-name ffmpeg-api \
    --memory=256m \
    --execution-timeout=5s \
    --runtime=python37 \
    --entrypoint=index.handle_api \
    --service-account-id $SERVICE_ACCOUNT_FFMPEG_ID \
    --environment SECRET_ID=$SECRET_ID \
    --environment YMQ_QUEUE_URL=$YMQ_QUEUE_URL \
    --environment DOCAPI_ENDPOINT=$DOCAPI_ENDPOINT \
    --package-bucket-name $S3_BUCKET \
    --package-object-name src.zip
# done (40s)
# id: d4***tj
# function_id: d4***28
# created_at: "2023-01-16T19:10:44.730Z"
# runtime: python37
# entrypoint: index.handle_api
# resources:
#     memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***m4
# image_size: "73125888"
# status: ACTIVE
# tags:
#     - $latest
# log_group_id: ck***v8
# environment:
#     DOCAPI_ENDPOINT: https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh
#     SECRET_ID: e6***fc
#     YMQ_QUEUE_URL: https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/ffmpeg
# log_options:
#     folder_id: b1***3m

yc serverless function version create \
    --function-name ffmpeg-converter \
    --memory=2048m \
    --execution-timeout=600s \
    --runtime=python37 \
    --entrypoint=index.handle_process_event \
    --service-account-id $SERVICE_ACCOUNT_FFMPEG_ID \
    --environment SECRET_ID=$SECRET_ID \
    --environment YMQ_QUEUE_URL=$YMQ_QUEUE_URL \
    --environment DOCAPI_ENDPOINT=$DOCAPI_ENDPOINT \
    --environment S3_BUCKET=$S3_BUCKET \
    --package-bucket-name $S3_BUCKET \
    --package-object-name src.zip
# done (37s)
# id: d4***of
# function_id: d4***or
# created_at: "2023-01-16T19:12:39.516Z"
# runtime: python37
# entrypoint: index.handle_process_event
# resources:
#     memory: "2147483648"
# execution_timeout: 600s
# service_account_id: aj***m4
# image_size: "73125888"
# status: ACTIVE
# tags:
#     - $latest
# log_group_id: ck***1v
# environment:
#     DOCAPI_ENDPOINT: https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***oh
#     S3_BUCKET: storage-for-ffmpeg-b1***3m
#     SECRET_ID: e6***fc
#     YMQ_QUEUE_URL: https://message-queue.api.cloud.yandex.net/b1***i6/dj***l1/ffmpeg
# log_options:
#     folder_id: b1***3m

yc serverless trigger create message-queue \
    --name ffmpeg \
    --queue $YMQ_QUEUE_ARN \
    --queue-service-account-id $SERVICE_ACCOUNT_FFMPEG_ID \
    --invoke-function-name ffmpeg-converter \
    --invoke-function-service-account-id $SERVICE_ACCOUNT_FFMPEG_ID \
    --batch-size 1 \
    --batch-cutoff 10s
# id: a1***e5
# folder_id: b1***3m
# created_at: "2023-01-16T19:16:19.068086505Z"
# name: ffmpeg
# rule:
#     message_queue:
#         queue_id: yrn:yc:ymq:ru-central1:b1***3m:ffmpeg
#         service_account_id: aj***m4
#     batch_settings:
#         size: "1"
#         cutoff: 10s
#     invoke_function:
#         function_id: d4***or
#         function_tag: $latest
#         service_account_id: aj***m4
# status: ACTIVE

yc serverless trigger delete ffmpeg
# id: a1***e5
# folder_id: b1***3m
# created_at: "2023-01-16T19:16:19.068Z"
# name: ffmpeg
# rule:
#     message_queue:
#         queue_id: yrn:yc:ymq:ru-central1:b1***3m:ffmpeg
#         service_account_id: aj***m4
#     batch_settings:
#         size: "1"
#         cutoff: 10s
#     invoke_function:
#         function_id: d4***or
#         function_tag: $latest
#         service_account_id: aj***m4
# status: PAUSED
