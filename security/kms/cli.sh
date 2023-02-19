yc iam service-account create \
  --name kms \
  --description "for testing kms"
# id: aj***v5
# folder_id: b1***gg
# created_at: "2023-01-28T11:13:25.879792581Z"
# name: kms
# description: for testing kms

yc iam role list
# +---------------------------------------------+-------------+
# |                     ID                      | DESCRIPTION |
# +---------------------------------------------+-------------+
# | admin                                       |             |
# | ai.speechkit-stt.user                       |             |
# | ai.speechkit-tts.user                       |             |
# | ai.translate.user                           |             |
# | ai.vision.user                              |             |
# | alb.admin                                   |             |
# | alb.editor                                  |             |
# | alb.user                                    |             |
# | alb.viewer                                  |             |
# | api-gateway.admin                           |             |
# | api-gateway.editor                          |             |
# | api-gateway.viewer                          |             |
# | api-gateway.websocketWriter                 |             |
# | audit-trails.admin                          |             |
# | audit-trails.auditor                        |             |
# | audit-trails.configViewer                   |             |
# | audit-trails.editor                         |             |
# | audit-trails.viewer                         |             |
# | backup.admin                                |             |
# | backup.editor                               |             |
# | backup.viewer                               |             |
# | cdn.admin                                   |             |
# | cdn.editor                                  |             |
# | cdn.viewer                                  |             |
# | certificate-manager.admin                   |             |
# | certificate-manager.certificates.downloader |             |
# | cloudbeaver.admin                           |             |
# | cloudbeaver.editor                          |             |
# | cloudbeaver.viewer                          |             |
# | compute.admin                               |             |
# | compute.auditor                             |             |
# | compute.disks.user                          |             |
# | compute.images.user                         |             |
# | compute.operator                            |             |
# | compute.snapshotSchedules.editor            |             |
# | compute.snapshotSchedules.viewer            |             |
# | compute.viewer                              |             |
# | container-registry.admin                    |             |
# | container-registry.editor                   |             |
# | container-registry.images.puller            |             |
# | container-registry.images.pusher            |             |
# | container-registry.images.scanner           |             |
# | container-registry.viewer                   |             |
# | data-transfer.admin                         |             |
# | data-transfer.privateAdmin                  |             |
# | data-transfer.publicAdmin                   |             |
# | data-transfer.viewer                        |             |
# | datalens.admin                              |             |
# | datalens.creator                            |             |
# | datalens.instances.admin                    |             |
# | datalens.instances.user                     |             |
# | dataproc.agent                              |             |
# | dataproc.provisioner                        |             |
# | dataproc.user                               |             |
# | datasphere.admin                            |             |
# | datasphere.communities.admin                |             |
# | datasphere.communities.developer            |             |
# | datasphere.communities.editor               |             |
# | datasphere.communities.viewer               |             |
# | datasphere.community-projects.admin         |             |
# | datasphere.community-projects.developer     |             |
# | datasphere.community-projects.editor        |             |
# | datasphere.community-projects.viewer        |             |
# | datasphere.user                             |             |
# | dns.admin                                   |             |
# | dns.auditor                                 |             |
# | dns.editor                                  |             |
# | dns.viewer                                  |             |
# | editor                                      |             |
# | functions.admin                             |             |
# | functions.auditor                           |             |
# | functions.editor                            |             |
# | functions.functionInvoker                   |             |
# | functions.mdbProxiesUser                    |             |
# | functions.viewer                            |             |
# | gitlab.admin                                |             |
# | gitlab.viewer                               |             |
# | iam.admin                                   |             |
# | iam.auditor                                 |             |
# | iam.editor                                  |             |
# | iam.serviceAccounts.accessKeyAdmin          |             |
# | iam.serviceAccounts.admin                   |             |
# | iam.serviceAccounts.apiKeyAdmin             |             |
# | iam.serviceAccounts.authorizedKeyAdmin      |             |
# | iam.serviceAccounts.keyAdmin                |             |
# | iam.serviceAccounts.tokenCreator            |             |
# | iam.serviceAccounts.user                    |             |
# | iam.viewer                                  |             |
# | iot.devices.writer                          |             |
# | iot.registries.writer                       |             |
# | k8s.admin                                   |             |
# | k8s.cluster-api.cluster-admin               |             |
# | k8s.cluster-api.editor                      |             |
# | k8s.cluster-api.viewer                      |             |
# | k8s.clusters.agent                          |             |
# | k8s.editor                                  |             |
# | k8s.tunnelClusters.agent                    |             |
# | k8s.viewer                                  |             |
# | kms.admin                                   |             |
# | kms.editor                                  |             |
# | kms.keys.encrypterDecrypter                 |             |
# | kms.viewer                                  |             |
# | load-balancer.admin                         |             |
# | load-balancer.privateAdmin                  |             |
# | load-balancer.viewer                        |             |
# | loadtesting.admin                           |             |
# | loadtesting.editor                          |             |
# | loadtesting.generatorClient                 |             |
# | loadtesting.loadTester                      |             |
# | loadtesting.viewer                          |             |
# | lockbox.admin                               |             |
# | lockbox.editor                              |             |
# | lockbox.payloadViewer                       |             |
# | lockbox.viewer                              |             |
# | logging.admin                               |             |
# | logging.editor                              |             |
# | logging.reader                              |             |
# | logging.viewer                              |             |
# | logging.writer                              |             |
# | managed-clickhouse.admin                    |             |
# | managed-clickhouse.auditor                  |             |
# | managed-clickhouse.editor                   |             |
# | managed-clickhouse.viewer                   |             |
# | managed-elasticsearch.admin                 |             |
# | managed-elasticsearch.editor                |             |
# | managed-elasticsearch.viewer                |             |
# | managed-greenplum.admin                     |             |
# | managed-greenplum.auditor                   |             |
# | managed-greenplum.editor                    |             |
# | managed-greenplum.viewer                    |             |
# | managed-kafka.admin                         |             |
# | managed-kafka.auditor                       |             |
# | managed-kafka.editor                        |             |
# | managed-kafka.viewer                        |             |
# | managed-mongodb.admin                       |             |
# | managed-mongodb.auditor                     |             |
# | managed-mongodb.editor                      |             |
# | managed-mongodb.viewer                      |             |
# | managed-mysql.admin                         |             |
# | managed-mysql.auditor                       |             |
# | managed-mysql.editor                        |             |
# | managed-mysql.viewer                        |             |
# | managed-opensearch.admin                    |             |
# | managed-opensearch.auditor                  |             |
# | managed-opensearch.editor                   |             |
# | managed-opensearch.viewer                   |             |
# | managed-postgresql.admin                    |             |
# | managed-postgresql.auditor                  |             |
# | managed-postgresql.editor                   |             |
# | managed-postgresql.viewer                   |             |
# | managed-redis.admin                         |             |
# | managed-redis.auditor                       |             |
# | managed-redis.editor                        |             |
# | managed-redis.viewer                        |             |
# | managed-sqlserver.admin                     |             |
# | managed-sqlserver.auditor                   |             |
# | managed-sqlserver.editor                    |             |
# | managed-sqlserver.viewer                    |             |
# | marketplace.meteringAgent                   |             |
# | mdb.admin                                   |             |
# | mdb.dataproc.agent                          |             |
# | mdb.hadoop.agent                            |             |
# | mdb.viewer                                  |             |
# | monitoring.admin                            |             |
# | monitoring.editor                           |             |
# | monitoring.viewer                           |             |
# | organization-manager.admin                  |             |
# | organization-manager.federations.admin      |             |
# | organization-manager.federations.viewer     |             |
# | organization-manager.groups.memberAdmin     |             |
# | organization-manager.organizations.owner    |             |
# | organization-manager.viewer                 |             |
# | quota-manager.requestOperator               |             |
# | resource-manager.admin                      |             |
# | resource-manager.auditor                    |             |
# | resource-manager.clouds.member              |             |
# | resource-manager.clouds.owner               |             |
# | resource-manager.editor                     |             |
# | resource-manager.viewer                     |             |
# | serverless-containers.admin                 |             |
# | serverless-containers.auditor               |             |
# | serverless-containers.containerInvoker      |             |
# | serverless-containers.editor                |             |
# | serverless-containers.viewer                |             |
# | serverless.containers.admin                 |             |
# | serverless.containers.editor                |             |
# | serverless.containers.invoker               |             |
# | serverless.containers.viewer                |             |
# | serverless.functions.admin                  |             |
# | serverless.functions.invoker                |             |
# | serverless.mdbProxies.user                  |             |
# | smart-captcha.admin                         |             |
# | smart-captcha.editor                        |             |
# | smart-captcha.viewer                        |             |
# | storage.admin                               |             |
# | storage.configViewer                        |             |
# | storage.configurer                          |             |
# | storage.editor                              |             |
# | storage.uploader                            |             |
# | storage.viewer                              |             |
# | viewer                                      |             |
# | vpc.admin                                   |             |
# | vpc.bridgeAdmin                             |             |
# | vpc.gateways.editor                         |             |
# | vpc.gateways.user                           |             |
# | vpc.gateways.viewer                         |             |
# | vpc.privateAdmin                            |             |
# | vpc.publicAdmin                             |             |
# | vpc.securityGroups.admin                    |             |
# | vpc.securityGroups.user                     |             |
# | vpc.user                                    |             |
# | vpc.viewer                                  |             |
# | ydb.admin                                   |             |
# | ydb.editor                                  |             |
# | ydb.viewer                                  |             |
# | yds.admin                                   |             |
# | yds.editor                                  |             |
# | yds.viewer                                  |             |
# | yds.writer                                  |             |
# | ymq.admin                                   |             |
# | ymq.reader                                  |             |
# | ymq.writer                                  |             |
# | yq.admin                                    |             |
# | yq.editor                                   |             |
# | yq.invoker                                  |             |
# | yq.viewer                                   |             |
# +---------------------------------------------+-------------+

yc iam user-account get ***
# yandex_passport_user_account:
#   login: ***
#   default_email: ***

yc iam service-account add-access-binding aj***v5 \
  --role editor --subject userAccount:aj***h6
# effective_deltas:
#   - action: ADD
#     access_binding:
#       role_id: editor
#       subject:
#         id: aj***h6
#         type: userAccount

yc resource-manager folder list
# +----------------------+-------+--------+--------+
# |          ID          | NAME  | LABELS | STATUS |
# +----------------------+-------+--------+--------+
# | b1***gg | study |        | ACTIVE |
# +----------------------+-------+--------+--------+

yc --folder-name study iam key create \
  --service-account-name kms --output key.json
# id: aj***e2
# service_account_id: aj***v5
# created_at: "2023-01-28T11:23:47.132165403Z"
# key_algorithm: RSA_2048

yc config profile create yc-lab23-profile
# Profile 'yc-lab23-profile' created and activated

yc config set service-account-key key.json
# Profile 'yc-lab23-profile' created and activated

yc config list
# service-account-key:
#   id: aj***e2
#   service_account_id: aj***v5
#   created_at: "2023-01-28T11:23:47.132165403Z"
#   key_algorithm: RSA_2048
#   public_key: |
#     -----BEGIN PUBLIC KEY-----
#     MI***AB
#     -----END PUBLIC KEY-----
#   private_key: |
#     -----BEGIN PRIVATE KEY-----
#     MI***==
#     -----END PRIVATE KEY-----

yc config profile activate default
# Profile 'default' activated

yc --folder-name study kms symmetric-key \
  add-access-binding ab***nf --role kms.admin \
  --subject serviceAccount:aj***v5
# done (2s)

yc config profile activate yc-lab23-profile
# Profile 'yc-lab23-profile' activated

yc kms symmetric-key rotate ab***nf
# id: ab***nf
# folder_id: b1***gg
# created_at: "2023-01-28T12:07:20Z"
# name: key-lab23
# status: ACTIVE
# primary_version:
#   id: ab***ft
#   key_id: ab***nf
#   status: ACTIVE
#   algorithm: AES_256
#   created_at: "2023-01-28T12:12:25Z"
#   primary: true
# default_algorithm: AES_256
# rotated_at: "2023-01-28T12:12:25Z"
