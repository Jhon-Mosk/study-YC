export SERVICE_ACCOUNT_SHORTENER_ID=$(yc iam service-account create --name serverless-shortener \
  --description "service account for serverless" \
  --format json | jq -r .)

yc iam service-account list
# +----------------------+----------------------+
# |          ID          |         NAME         |
# +----------------------+----------------------+
# | aj***io              | serverless-shortener |
# +----------------------+----------------------+

echo "export SERVICE_ACCOUNT_SHORTENER_ID=aj***io" >>~/.bashrc && . ~/.bashrc

echo $SERVICE_ACCOUNT_SHORTENER_ID
# { "id": "aj***io", "folder_id": "b1***gg", "created_at": "2023-01-19T16:00:39.168578321Z", "name": "serverless-shortener", "description": "service account for serverless" }

echo "export FOLDER_ID=$(yc config get folder-id)" >>~/.bashrc && . ~/.bashrc

echo $FOLDER_ID
# b1***gg

echo "export OAUTH_TOKEN=$(yc config get token)" >>~/.bashrc && . ~/.bashrc

echo $OAUTH_TOKEN
# y0***Ro

echo "export CLOUD_ID=$(yc config get cloud-id)" >>~/.bashrc && . ~/.bashrc

echo $CLOUD_ID
# b1***i6

yc resource-manager folder add-access-binding $FOLDER_ID \
  --subject serviceAccount:$SERVICE_ACCOUNT_SHORTENER_ID \
  --role editor
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
  --subject serviceAccount:$SERVICE_ACCOUNT_SHORTENER_ID \
  --role ydb.admin
# done (1s)

yc resource-manager folder add-access-binding $FOLDER_ID \
  --subject serviceAccount:$SERVICE_ACCOUNT_SHORTENER_ID \
  --role storage.viewer
# done (1s)

yc ydb database create for-serverless-shortener \
  --serverless \
  --folder-id $FOLDER_ID
# done (9s)
# id: et***dc
# folder_id: b1***gg
# created_at: "2023-01-19T16:12:28Z"
# name: for-serverless-shortener
# status: PROVISIONING
# endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***dc
# serverless_database:
#   storage_size_limit: "53687091200"
# location_id: ru-central1
# backup_config:
#   backup_settings:
#     - name: daily
#       backup_schedule:
#         daily_backup_schedule:
#           execute_time:
#             hours: 17
#       backup_time_to_live: 604800s
#       type: SYSTEM
# document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***dc
# monitoring_config: {}

yc ydb database list
# +----------------------+--------------------------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
# |          ID          |           NAME           | DESCRIPTION |                                                   ENDPOINT                                                   |     CREATED AT      | STATUS  |
# +----------------------+--------------------------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+
# | et***dc | for-serverless-shortener |             | grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***dc | 2023-01-19 16:12:28 | RUNNING |
# +----------------------+--------------------------+-------------+--------------------------------------------------------------------------------------------------------------+---------------------+---------+

yc ydb database get --name for-serverless-shortener
# id: et***dc
# folder_id: b1***gg
# created_at: "2023-01-19T16:12:28Z"
# name: for-serverless-shortener
# status: RUNNING
# endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1***i6/et***dc
# serverless_database:
#   storage_size_limit: "53687091200"
# location_id: ru-central1
# backup_config:
#   backup_settings:
#     - name: daily
#       backup_schedule:
#         daily_backup_schedule:
#           execute_time:
#             hours: 17
#         next_execute_time: "2023-01-19T17:00:00.897727Z"
#       backup_time_to_live: 604800s
#       type: SYSTEM
# document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***dc
# monitoring_config: {}

echo "export YDB_ENDPOINT=grpcs://ydb.serverless.yandexcloud.net:2135" >>~/.bashrc && . ~/.bashrc

echo $YDB_ENDPOINT
# grpcs://ydb.serverless.yandexcloud.net:2135

echo "export YDB_DATABASE=/ru-central1/b1***i6/et***dc" >>~/.bashrc && . ~/.bashrc

echo $YDB_DATABASE
# /ru-central1/b1***i6/et***dc

curl https://storage.yandexcloud.net/yandexcloud-ydb/install.sh | bash
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100  7341  100  7341    0     0  28019      0 --:--:-- --:--:-- --:--:-- 27912
# Downloading ydb 2.1.1
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
# 100 55.3M  100 55.3M    0     0  15.2M      0  0:00:03  0:00:03 --:--:-- 15.2M
# Yandex.Cloud YDB CLI 2.1.1

# ydb PATH has been added to your '/home/user/.bashrc' profile
# To complete installation, start a new shell (exec -l $SHELL) or type 'source "/home/user/.bashrc"' in the current one

exec -l $SHELL

yc iam key create \
  --service-account-name serverless-shortener \
  --output serverless-shortener.sa
# id: aj***t8
# service_account_id: aj***io
# created_at: "2023-01-19T16:18:09.756259114Z"
# key_algorithm: RSA_2048

echo "export SA_KEY_FILE=$PWD/serverless-shortener.sa" >>~/.bashrc && . ~/.bashrc

echo $SA_KEY_FILE
# /serveless/serverless-shortener/serverless-shortener.sa

ydb \
  --endpoint $YDB_ENDPOINT \
  --database $YDB_DATABASE \
  --sa-key-file $SA_KEY_FILE \
  discovery whoami \
  --groups
# User SID: aj***io@as

# User has no groups

ydb \
  --endpoint $YDB_ENDPOINT \
  --database $YDB_DATABASE \
  --sa-key-file $SA_KEY_FILE \
  scripting yql --file links.yql

ydb \
  --endpoint $YDB_ENDPOINT \
  --database $YDB_DATABASE \
  --sa-key-file $SA_KEY_FILE \
  scheme describe links
# Columns:
# ┌──────┬───────┬────────┬─────┐
# | Name | Type  | Family | Key |
# ├──────┼───────┼────────┼─────┤
# | id   | Utf8? |        | K0  |
# | link | Utf8? |        |     |
# └──────┴───────┴────────┴─────┘

# Storage settings:
# Store large values in "external blobs": false

# Column families:
# ┌─────────┬──────┬─────────────┬────────────────┐
# | Name    | Data | Compression | Keep in memory |
# ├─────────┼──────┼─────────────┼────────────────┤
# | default |      | None        |                |
# └─────────┴──────┴─────────────┴────────────────┘

# Auto partitioning settings:
# Partitioning by size: true
# Partitioning by load: false
# Preferred partition size (Mb): 2048
# Min partitions count: 1

pipreqs $PWD --force
# INFO: Successfully saved requirements file in /serveless/serverless-shortener/requirements.txt

yc serverless function create \
  --name for-serverless-shortener \
  --description "function for serverless-shortener"
# done (2s)
# id: d4***6d
# folder_id: b1***gg
# created_at: "2023-01-19T16:30:13.689Z"
# name: for-serverless-shortener
# description: function for serverless-shortener
# log_group_id: ck***t0
# http_invoke_url: https://functions.yandexcloud.net/d4***6d
# status: ACTIVE

yc serverless function version create \
  --function-name for-serverless-shortener \
  --memory=256m \
  --execution-timeout=5s \
  --runtime=python37 \
  --entrypoint=index.handler \
  --service-account-id $SERVICE_ACCOUNT_SHORTENER_ID \
  --environment USE_METADATA_CREDENTIALS=1 \
  --environment endpoint=grpcs://ydb.serverless.yandexcloud.net:2135 \
  --environment database=$YDB_DATABASE \
  --source-path src.zip
# done (10s)
# id: d4***of
# function_id: d4***6d
# created_at: "2023-01-19T16:30:55.929Z"
# runtime: python37
# entrypoint: index.handler
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***io
# image_size: "12308480"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***t0
# environment:
#   USE_METADATA_CREDENTIALS: "1"
#   database: /ru-central1/b1***i6/et***dc
#   endpoint: grpcs://ydb.serverless.yandexcloud.net:2135
# log_options:
#   folder_id: b1***gg

yc serverless function allow-unauthenticated-invoke for-serverless-shortener
# done (2s)

yc serverless api-gateway create \
  --name for-serverless-shortener \
  --spec=for-serverless-shortener.yml \
  --description "for serverless shortener"
# done (6s)
# id: d5***sh
# folder_id: b1***gg
# created_at: "2023-01-19T16:33:57.130Z"
# name: for-serverless-shortener
# description: for serverless shortener
# status: ACTIVE
# domain: d5***sh.apigw.yandexcloud.net
# log_group_id: ck***gt
# connectivity: {}
# log_options:
#   folder_id: b1***gg

yc serverless api-gateway list
# +----------------------+--------------------------+----------------------+--------+
# |          ID          |           NAME           |      FOLDER ID       | STATUS |
# +----------------------+--------------------------+----------------------+--------+
# | d5***sh              | for-serverless-shortener | b1***gg              | ACTIVE |
# +----------------------+--------------------------+----------------------+--------+

yc serverless api-gateway get --name for-serverless-shortener
# id: d5***sh
# folder_id: b1***gg
# created_at: "2023-01-19T16:33:57.130Z"
# name: for-serverless-shortener
# description: for serverless shortener
# status: ACTIVE
# domain: d5***sh.apigw.yandexcloud.net
# log_group_id: ck***gt
# connectivity: {}
# log_options:
#   folder_id: b1***gg
