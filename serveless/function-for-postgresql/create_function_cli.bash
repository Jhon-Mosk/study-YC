yc resource-manager folder add-access-binding $FOLDER_ID \
--role serverless.mdbProxies.user \
--subject serviceAccount:$SERVICE_ACCOUNT_ID
# done (1s)

yc vpc subnet list
# +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
# |          ID          |         NAME          |      NETWORK ID      | ROUTE TABLE ID |     ZONE      |      RANGE      |
# +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+
# | b0***hj | default-ru-central1-c | en***vh |                | ru-central1-c | [10.130.0.0/24] |
# | e2***q9 | default-ru-central1-b | en***vh |                | ru-central1-b | [10.129.0.0/24] |
# | e9***jl | default-ru-central1-a | en***vh |                | ru-central1-a | [10.128.0.0/24] |
# +----------------------+-----------------------+----------------------+----------------+---------------+-----------------+

cd ..

cd function-for-postgresql/

yc managed-postgresql cluster create \
--name my-pg-database \
--description 'For Serverless' \
--postgresql-version 13 \
--environment production \
--network-name default \
--resource-preset b2.nano \
--host zone-id=ru-central1-c,subnet-id=b0***hj \
--disk-type network-hdd \
--disk-size 10 \
--user name=user1,password=*** \
--database name=db1,owner=user1 \
--websql-access \
--serverless-access
# done (6m50s)
# id: c9***5o
# folder_id: b1***3m
# created_at: "2023-01-07T10:54:25.826459Z"
# name: my-pg-database
# description: For Serverless
# environment: PRODUCTION
# monitoring:
#   - name: Console
#     description: Console charts
#     link: https://console.cloud.yandex.ru/folders/b1***3m/managed-postgresql/cluster/c9***5o?section=monitoring
# config:
#   version: "13"
#   postgresql_config_13:
#     effective_config:
#       max_connections: "100"
#       shared_buffers: "536870912"
#       temp_buffers: "8388608"
#       max_prepared_transactions: "0"
#       work_mem: "4194304"
#       maintenance_work_mem: "67108864"
#       autovacuum_work_mem: "-1"
#       temp_file_limit: "-1"
#       vacuum_cost_delay: "0"
#       vacuum_cost_page_hit: "1"
#       vacuum_cost_page_miss: "10"
#       vacuum_cost_page_dirty: "20"
#       vacuum_cost_limit: "200"
#       bgwriter_delay: "200"
#       bgwriter_lru_maxpages: "100"
#       bgwriter_lru_multiplier: 2
#       bgwriter_flush_after: "524288"
#       backend_flush_after: "0"
#       old_snapshot_threshold: "-1"
#       wal_level: WAL_LEVEL_LOGICAL
#       synchronous_commit: SYNCHRONOUS_COMMIT_ON
#       checkpoint_timeout: "300000"
#       checkpoint_completion_target: 0.5
#       checkpoint_flush_after: "262144"
#       max_wal_size: "1073741824"
#       min_wal_size: "536870912"
#       max_standby_streaming_delay: "30000"
#       default_statistics_target: "1000"
#       constraint_exclusion: CONSTRAINT_EXCLUSION_PARTITION
#       cursor_tuple_fraction: 0.1
#       from_collapse_limit: "8"
#       join_collapse_limit: "8"
#       force_parallel_mode: FORCE_PARALLEL_MODE_OFF
#       client_min_messages: LOG_LEVEL_NOTICE
#       log_min_messages: LOG_LEVEL_WARNING
#       log_min_error_statement: LOG_LEVEL_ERROR
#       log_min_duration_statement: "-1"
#       log_checkpoints: false
#       log_connections: false
#       log_disconnections: false
#       log_duration: false
#       log_error_verbosity: LOG_ERROR_VERBOSITY_DEFAULT
#       log_lock_waits: false
#       log_statement: LOG_STATEMENT_NONE
#       log_temp_files: "-1"
#       search_path: '"$user", public'
#       row_security: true
#       default_transaction_isolation: TRANSACTION_ISOLATION_READ_COMMITTED
#       statement_timeout: "0"
#       lock_timeout: "0"
#       idle_in_transaction_session_timeout: "0"
#       bytea_output: BYTEA_OUTPUT_HEX
#       xmlbinary: XML_BINARY_BASE64
#       xmloption: XML_OPTION_CONTENT
#       gin_pending_list_limit: "4194304"
#       deadlock_timeout: "1000"
#       max_locks_per_transaction: "64"
#       max_pred_locks_per_transaction: "64"
#       array_nulls: true
#       backslash_quote: BACKSLASH_QUOTE_SAFE_ENCODING
#       default_with_oids: false
#       escape_string_warning: true
#       lo_compat_privileges: false
#       operator_precedence_warning: false
#       quote_all_identifiers: false
#       standard_conforming_strings: true
#       synchronize_seqscans: true
#       transform_null_equals: false
#       exit_on_error: false
#       seq_page_cost: 1
#       random_page_cost: 1
#       autovacuum_max_workers: "3"
#       autovacuum_vacuum_cost_delay: "45"
#       autovacuum_vacuum_cost_limit: "700"
#       autovacuum_naptime: "15000"
#       archive_timeout: "30000"
#       track_activity_query_size: "1024"
#       enable_bitmapscan: true
#       enable_hashagg: true
#       enable_hashjoin: true
#       enable_indexscan: true
#       enable_indexonlyscan: true
#       enable_material: true
#       enable_mergejoin: true
#       enable_nestloop: true
#       enable_seqscan: true
#       enable_sort: true
#       enable_tidscan: true
#       max_worker_processes: "8"
#       max_parallel_workers: "8"
#       max_parallel_workers_per_gather: "2"
#       autovacuum_vacuum_scale_factor: 0.00001
#       autovacuum_analyze_scale_factor: 0.0001
#       default_transaction_read_only: false
#       timezone: Europe/Moscow
#       enable_parallel_append: true
#       enable_parallel_hash: true
#       enable_partition_pruning: true
#       enable_partitionwise_aggregate: false
#       enable_partitionwise_join: false
#       max_parallel_maintenance_workers: "2"
#       parallel_leader_participation: true
#       vacuum_cleanup_index_scale_factor: 0.1
#       effective_io_concurrency: "1"
#       effective_cache_size: "107374182400"
#       auto_explain_log_min_duration: "-1"
#       auto_explain_log_analyze: false
#       auto_explain_log_buffers: false
#       auto_explain_log_timing: false
#       auto_explain_log_triggers: false
#       auto_explain_log_verbose: false
#       auto_explain_log_nested_statements: false
#       auto_explain_sample_rate: 1
#       pg_hint_plan_enable_hint: true
#       pg_hint_plan_enable_hint_table: false
#       pg_hint_plan_debug_print: PG_HINT_PLAN_DEBUG_PRINT_OFF
#       max_slot_wal_keep_size: "-1"
#     user_config: {}
#     default_config:
#       max_connections: "100"
#       shared_buffers: "536870912"
#       temp_buffers: "8388608"
#       max_prepared_transactions: "0"
#       work_mem: "4194304"
#       maintenance_work_mem: "67108864"
#       autovacuum_work_mem: "-1"
#       temp_file_limit: "-1"
#       vacuum_cost_delay: "0"
#       vacuum_cost_page_hit: "1"
#       vacuum_cost_page_miss: "10"
#       vacuum_cost_page_dirty: "20"
#       vacuum_cost_limit: "200"
#       bgwriter_delay: "200"
#       bgwriter_lru_maxpages: "100"
#       bgwriter_lru_multiplier: 2
#       bgwriter_flush_after: "524288"
#       backend_flush_after: "0"
#       old_snapshot_threshold: "-1"
#       wal_level: WAL_LEVEL_LOGICAL
#       synchronous_commit: SYNCHRONOUS_COMMIT_ON
#       checkpoint_timeout: "300000"
#       checkpoint_completion_target: 0.5
#       checkpoint_flush_after: "262144"
#       max_wal_size: "1073741824"
#       min_wal_size: "536870912"
#       max_standby_streaming_delay: "30000"
#       default_statistics_target: "1000"
#       constraint_exclusion: CONSTRAINT_EXCLUSION_PARTITION
#       cursor_tuple_fraction: 0.1
#       from_collapse_limit: "8"
#       join_collapse_limit: "8"
#       force_parallel_mode: FORCE_PARALLEL_MODE_OFF
#       client_min_messages: LOG_LEVEL_NOTICE
#       log_min_messages: LOG_LEVEL_WARNING
#       log_min_error_statement: LOG_LEVEL_ERROR
#       log_min_duration_statement: "-1"
#       log_checkpoints: false
#       log_connections: false
#       log_disconnections: false
#       log_duration: false
#       log_error_verbosity: LOG_ERROR_VERBOSITY_DEFAULT
#       log_lock_waits: false
#       log_statement: LOG_STATEMENT_NONE
#       log_temp_files: "-1"
#       search_path: '"$user", public'
#       row_security: true
#       default_transaction_isolation: TRANSACTION_ISOLATION_READ_COMMITTED
#       statement_timeout: "0"
#       lock_timeout: "0"
#       idle_in_transaction_session_timeout: "0"
#       bytea_output: BYTEA_OUTPUT_HEX
#       xmlbinary: XML_BINARY_BASE64
#       xmloption: XML_OPTION_CONTENT
#       gin_pending_list_limit: "4194304"
#       deadlock_timeout: "1000"
#       max_locks_per_transaction: "64"
#       max_pred_locks_per_transaction: "64"
#       array_nulls: true
#       backslash_quote: BACKSLASH_QUOTE_SAFE_ENCODING
#       default_with_oids: false
#       escape_string_warning: true
#       lo_compat_privileges: false
#       operator_precedence_warning: false
#       quote_all_identifiers: false
#       standard_conforming_strings: true
#       synchronize_seqscans: true
#       transform_null_equals: false
#       exit_on_error: false
#       seq_page_cost: 1
#       random_page_cost: 1
#       autovacuum_max_workers: "3"
#       autovacuum_vacuum_cost_delay: "45"
#       autovacuum_vacuum_cost_limit: "700"
#       autovacuum_naptime: "15000"
#       archive_timeout: "30000"
#       track_activity_query_size: "1024"
#       enable_bitmapscan: true
#       enable_hashagg: true
#       enable_hashjoin: true
#       enable_indexscan: true
#       enable_indexonlyscan: true
#       enable_material: true
#       enable_mergejoin: true
#       enable_nestloop: true
#       enable_seqscan: true
#       enable_sort: true
#       enable_tidscan: true
#       max_worker_processes: "8"
#       max_parallel_workers: "8"
#       max_parallel_workers_per_gather: "2"
#       autovacuum_vacuum_scale_factor: 0.00001
#       autovacuum_analyze_scale_factor: 0.0001
#       default_transaction_read_only: false
#       timezone: Europe/Moscow
#       enable_parallel_append: true
#       enable_parallel_hash: true
#       enable_partition_pruning: true
#       enable_partitionwise_aggregate: false
#       enable_partitionwise_join: false
#       max_parallel_maintenance_workers: "2"
#       parallel_leader_participation: true
#       vacuum_cleanup_index_scale_factor: 0.1
#       effective_io_concurrency: "1"
#       effective_cache_size: "107374182400"
#       auto_explain_log_min_duration: "-1"
#       auto_explain_log_analyze: false
#       auto_explain_log_buffers: false
#       auto_explain_log_timing: false
#       auto_explain_log_triggers: false
#       auto_explain_log_verbose: false
#       auto_explain_log_nested_statements: false
#       auto_explain_sample_rate: 1
#       pg_hint_plan_enable_hint: true
#       pg_hint_plan_enable_hint_table: false
#       pg_hint_plan_debug_print: PG_HINT_PLAN_DEBUG_PRINT_OFF
#       max_slot_wal_keep_size: "-1"
#   resources:
#     resource_preset_id: b2.nano
#     disk_size: "10737418240"
#     disk_type_id: network-hdd
#   autofailover: true
#   backup_window_start:
#     hours: 22
#   backup_retain_period_days: "7"
#   access:
#     web_sql: true
#     serverless: true
#   performance_diagnostics:
#     sessions_sampling_interval: "60"
#     statements_sampling_interval: "600"
# network_id: en***vh
# maintenance_window:
#   anytime: {}

yc managed-postgresql cluster list
# +----------------------+----------------+---------------------+--------+---------+
# |          ID          |      NAME      |     CREATED AT      | HEALTH | STATUS  |
# +----------------------+----------------+---------------------+--------+---------+
# | c9***5o | my-pg-database | 2023-01-07 10:54:25 | ALIVE  | RUNNING |
# +----------------------+----------------+---------------------+--------+---------+

yc managed-postgresql cluster get c9***5o
# id: c9***5o
# folder_id: b1***3m
# created_at: "2023-01-07T10:54:25.826459Z"
# name: my-pg-database
# description: For Serverless
# environment: PRODUCTION
# monitoring:
#   - name: Console
#     description: Console charts
#     link: https://console.cloud.yandex.ru/folders/b1***3m/managed-postgresql/cluster/c9***5o?section=monitoring
# config:
#   version: "13"
#   postgresql_config_13:
#     user_config: {}
#   resources:
#     resource_preset_id: b2.nano
#     disk_size: "10737418240"
#     disk_type_id: network-hdd
#   autofailover: true
#   backup_window_start:
#     hours: 22
#   backup_retain_period_days: "7"
#   access:
#     web_sql: true
#     serverless: true
#   performance_diagnostics:
#     sessions_sampling_interval: "60"
#     statements_sampling_interval: "600"
# network_id: en***vh
# health: ALIVE
# status: RUNNING
# maintenance_window:
#   anytime: {}

echo "export CONNECTION_ID=ak***c8" >>~/.bashrc && . ~/.bashrc

echo "export DB_USER=user1" >>~/.bashrc && . ~/.bashrc

echo "export DB_HOST=ak***c8.postgresql-proxy.serverless.yandexcloud.net" >>~/.bashrc && . ~/.bashrc

yc serverless function create \
--name function-for-postgresql \
--description "function for postgresql"
# done (1s)
# id: d4***21
# folder_id: b1***3m
# created_at: "2023-01-07T11:15:24.247Z"
# name: function-for-postgresql
# description: function for postgresql
# log_group_id: ck***qb
# http_invoke_url: https://functions.yandexcloud.net/d4***21
# status: ACTIVE

yc serverless function version create \
--function-name=function-for-postgresql \
--memory=256m \
--execution-timeout=5s \
--runtime=python37 \
--entrypoint=function-for-postgresql.entry \
--service-account-id $SERVICE_ACCOUNT_ID \
--environment VERBOSE_LOG=True \
--environment CONNECTION_ID=$CONNECTION_ID \
--environment DB_USER=$DB_USER \
--environment DB_HOST=$DB_HOST \
--source-path function-for-postgresql.py
# done (3s)
# id: d4***jm
# function_id: d4***21
# created_at: "2023-01-07T11:15:51.872Z"
# runtime: python37
# entrypoint: function-for-postgresql.entry
# resources:
#   memory: "268435456"
# execution_timeout: 5s
# service_account_id: aj***1r
# image_size: "4096"
# status: ACTIVE
# tags:
#   - $latest
# log_group_id: ck***qb
# environment:
#   CONNECTION_ID: ak***c8
#   DB_HOST: ak***c8.postgresql-proxy.serverless.yandexcloud.net
#   DB_USER: user1
#   VERBOSE_LOG: "True"
# log_options:
#   folder_id: b1***3m

yc serverless function version list --function-name function-for-postgresql
# +----------------------+----------------------+----------+-------------------------------+---------+---------------------+
# |          ID          |     FUNCTION ID      | RUNTIME  |          ENTRYPOINT           |  TAGS   |     CREATED AT      |
# +----------------------+----------------------+----------+-------------------------------+---------+---------------------+
# | d4***jm | d4***21 | python37 | function-for-postgresql.entry | $latest | 2023-01-07 11:15:51 |
# +----------------------+----------------------+----------+-------------------------------+---------+---------------------+

yc serverless function invoke --name function-for-postgresql
# {"statusCode": 200, "headers": {"Content-Type": "text/plain"}, "isBase64Encoded": false}

yc serverless trigger create timer \
--name trigger-for-postgresql \
--invoke-function-name function-for-postgresql \
--invoke-function-service-account-id $SERVICE_ACCOUNT_ID \
--cron-expression '* * * * ? *'
# id: a1***p8
# folder_id: b1***3m
# created_at: "2023-01-07T11:22:28.196094029Z"
# name: trigger-for-postgresql
# rule:
#   timer:
#     cron_expression: '* * * * ? *'
#     invoke_function_with_retry:
#       function_id: d4***21
#       function_tag: $latest
#       service_account_id: aj***1r
# status: ACTIVE

yc serverless trigger delete trigger-for-postgresql
# id: a1***p8
# folder_id: b1***3m
# created_at: "2023-01-07T11:22:28.196Z"
# name: trigger-for-postgresql
# rule:
#   timer:
#     cron_expression: '* * * * ? *'
#     invoke_function_with_retry:
#       function_id: d4***21
#       function_tag: $latest
#       service_account_id: aj***1r
# status: PAUSED
