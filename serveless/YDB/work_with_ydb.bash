echo "export ENDPOINT=https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***1e" >>~/.bashrc && . ~/.bashrc

curl \
-H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
-H "Authorization: Bearer $(yc iam create-token)" \
-H "Content-Type: application.json" \
-d '{"TableName": "docapitest/series","AttributeDefinitions":[{"AttributeName": "series_id", "AttributeType": "N"},{"AttributeName": "title", "AttributeType": "S"}],"KeySchema":[{"AttributeName": "series_id", "KeyType": "HASH"},{"AttributeName": "title", "KeyType": "RANGE"}]}' \
$ENDPOINT
{"TableDescription":{"AttributeDefinitions":[{"AttributeName":"series_id","AttributeType":"N"},{"AttributeName":"title","AttributeType":"S"}],"CreationDateTime":1673633232.02,"ItemCount":0,"KeySchema":[{"AttributeName":"series_id","KeyType":"HASH"},{"AttributeName":"title","KeyType":"RANGE"}],"TableName":"docapitest/series","TableSizeBytes":0,"TableStatus":"ACTIVE"}}

curl \
-H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
-H "Authorization: Bearer $(yc iam create-token)" \
-H "Content-Type: application.json" \
-d '{"TableName": "docapitest/series", "Item": {"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}, "series_info": {"S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."}, "release_date": {"S": "2006-02-03"}}}' \
$ENDPOINT
{}

curl \
-H 'X-Amz-Target: DynamoDB_20120810.GetItem' \
-H "Authorization: Bearer $(yc iam create-token)" \
-H "Content-Type: application.json" \
-d '{"TableName": "docapitest/series", "Key": {"series_id":{"N":"1"}, "title":{"S":"IT Crowd"}}}' \
$ENDPOINT
{"Item":{"release_date":{"S":"2006-02-03"},"series_id":{"N":"1"},"series_info":{"S":"The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."},"title":{"S":"IT Crowd"}}}

curl \
-H 'X-Amz-Target: DynamoDB_20120810.DeleteTable' \
-H "Authorization: Bearer $(yc iam create-token)" \
-H "Content-Type: application.json" \
-d '{"TableName": "docapitest/series"}' \
$ENDPOINT
{"TableDescription":{"AttributeDefinitions":[{"AttributeName":"series_id","AttributeType":"N"},{"AttributeName":"title","AttributeType":"S"}],"CreationDateTime":1673633232.02,"ItemCount":1,"KeySchema":[{"AttributeName":"series_id","KeyType":"HASH"},{"AttributeName":"title","KeyType":"RANGE"}],"TableName":"docapitest/series","TableSizeBytes":505,"TableStatus":"ACTIVE"}}

pip install awscli
# Collecting awscli
#   Downloading awscli-1.27.49-py3-none-any.whl (4.0 MB)
#      |████████████████████████████████| 4.0 MB 532 kB/s
# Collecting rsa<4.8,>=3.1.2
#   Downloading rsa-4.7.2-py3-none-any.whl (34 kB)
# Collecting botocore==1.29.49
#   Downloading botocore-1.29.49-py3-none-any.whl (10.3 MB)
#      |████████████████████████████████| 10.3 MB 38.1 MB/s
# Requirement already satisfied: PyYAML<5.5,>=3.10 in /usr/lib/python3/dist-packages (from awscli) (5.3.1)
# Collecting docutils<0.17,>=0.10
#   Downloading docutils-0.16-py2.py3-none-any.whl (548 kB)
#      |████████████████████████████████| 548 kB 45.2 MB/s
# Requirement already satisfied: colorama<0.4.5,>=0.2.5 in /usr/lib/python3/dist-packages (from awscli) (0.4.3)
# Collecting s3transfer<0.7.0,>=0.6.0
#   Downloading s3transfer-0.6.0-py3-none-any.whl (79 kB)
#      |████████████████████████████████| 79 kB 7.7 MB/s
# Requirement already satisfied: pyasn1>=0.1.3 in /usr/lib/python3/dist-packages (from rsa<4.8,>=3.1.2->awscli) (0.4.2)
# Requirement already satisfied: urllib3<1.27,>=1.25.4 in /usr/lib/python3/dist-packages (from botocore==1.29.49->awscli) (1.25.8)
# Collecting python-dateutil<3.0.0,>=2.1
#   Downloading python_dateutil-2.8.2-py2.py3-none-any.whl (247 kB)
#      |████████████████████████████████| 247 kB 38.2 MB/s
# Collecting jmespath<2.0.0,>=0.7.1
#   Downloading jmespath-1.0.1-py3-none-any.whl (20 kB)
# Requirement already satisfied: six>=1.5 in /usr/lib/python3/dist-packages (from python-dateutil<3.0.0,>=2.1->botocore==1.29.49->awscli) (1.14.0)
# Installing collected packages: rsa, python-dateutil, jmespath, botocore, docutils, s3transfer, awscli
# Successfully installed awscli-1.27.49 botocore-1.29.49 docutils-0.16 jmespath-1.0.1 python-dateutil-2.8.2 rsa-4.7.2 s3transfer-0.6.0

aws configure
AWS Access Key ID [None]: YC***GA
AWS Secret Access Key [None]: YC***av
Default region name [None]: ru-central1
Default output format [None]:

aws dynamodb create-table \
--table-name docapitest/series \
--attribute-definitions \
AttributeName=series_id,AttributeType=N \
AttributeName=title,AttributeType=S \
--key-schema \
AttributeName=series_id,KeyType=HASH \
AttributeName=title,KeyType=RANGE \
--endpoint $ENDPOINT
# {
#     "TableDescription": {
#         "AttributeDefinitions": [
#             {
#                 "AttributeName": "series_id",
#                 "AttributeType": "N"
#             },
#             {
#                 "AttributeName": "title",
#                 "AttributeType": "S"
#             }
#         ],
#         "TableName": "docapitest/series",
#         "KeySchema": [
#             {
#                 "AttributeName": "series_id",
#                 "KeyType": "HASH"
#             },
#             {
#                 "AttributeName": "title",
#                 "KeyType": "RANGE"
#             }
#         ],
#         "TableStatus": "ACTIVE",
#         "CreationDateTime": 1673634766.11,
#         "TableSizeBytes": 0,
#         "ItemCount": 0
#     }
# }

aws dynamodb put-item \
--table-name docapitest/series \
--item '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}, "series_info": {"S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."}, "release_date": {"S": "2006-02-03"}}' \
--endpoint $ENDPOINT

aws dynamodb put-item \
--table-name docapitest/series \
--item '{"series_id": {"N": "2"}, "title": {"S": "Silicon Valley"}, "series_info": {"S": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky."}, "release_date": {"S": "2014-04-06"}}' \
--endpoint $ENDPOINT

aws dynamodb get-item --consistent-read \
--table-name docapitest/series \
--key '{"series_id": {"N": "1"}, "title": {"S": "IT Crowd"}}' \
--endpoint $ENDPOINT
# {
#     "Item": {
#         "release_date": {
#             "S": "2006-02-03"
#         },
#         "series_id": {
#             "N": "1"
#         },
#         "series_info": {
#             "S": "The IT Crowd is a British sitcom produced by Channel 4, written by Graham Linehan, produced by Ash Atalla and starring Chris ODowd, Richard Ayoade, Katherine Parkinson, and Matt Berry."
#         },
#         "title": {
#             "S": "IT Crowd"
#         }
#     }
# }

aws dynamodb query \
--table-name docapitest/series \
--key-condition-expression "series_id = :name" \
--expression-attribute-values '{":name":{"N":"2"}}' \
--endpoint $ENDPOINT
# {
#     "Items": [
#         {
#             "release_date": {
#                 "S": "2014-04-06"
#             },
#             "series_id": {
#                 "N": "2"
#             },
#             "series_info": {
#                 "S": "Silicon Valley is an American comedy television series created by Mike Judge, John Altschuler and Dave Krinsky."
#             },
#             "title": {
#                 "S": "Silicon Valley"
#             }
#         }
#     ],
#     "Count": 1,
#     "ScannedCount": 1,
#     "ConsumedCapacity": null
# }

aws dynamodb delete-table \
--table-name docapitest/series \
--endpoint $ENDPOINT
# {
#     "TableDescription": {
#         "AttributeDefinitions": [
#             {
#                 "AttributeName": "title",
#                 "AttributeType": "S"
#             },
#             {
#                 "AttributeName": "series_id",
#                 "AttributeType": "N"
#             }
#         ],
#         "TableName": "docapitest/series",
#         "KeySchema": [
#             {
#                 "AttributeName": "series_id",
#                 "KeyType": "HASH"
#             },
#             {
#                 "AttributeName": "title",
#                 "KeyType": "RANGE"
#             }
#         ],
#         "TableStatus": "ACTIVE",
#         "CreationDateTime": 1673634766.11,
#         "TableSizeBytes": 825,
#         "ItemCount": 2
#     }
# }

pip install boto3
# Collecting boto3
#   Downloading boto3-1.26.49-py3-none-any.whl (132 kB)
#      |████████████████████████████████| 132 kB 551 kB/s
# Requirement already satisfied: botocore<1.30.0,>=1.29.49 in /home/user/.local/lib/python3.8/site-packages (from boto3) (1.29.49)
# Requirement already satisfied: jmespath<2.0.0,>=0.7.1 in /home/user/.local/lib/python3.8/site-packages (from boto3) (1.0.1)
# Requirement already satisfied: s3transfer<0.7.0,>=0.6.0 in /home/user/.local/lib/python3.8/site-packages (from boto3) (0.6.0)
# Requirement already satisfied: python-dateutil<3.0.0,>=2.1 in /home/user/.local/lib/python3.8/site-packages (from botocore<1.30.0,>=1.29.49->boto3) (2.8.2)
# Requirement already satisfied: urllib3<1.27,>=1.25.4 in /usr/lib/python3/dist-packages (from botocore<1.30.0,>=1.29.49->boto3) (1.25.8)
# Requirement already satisfied: six>=1.5 in /usr/lib/python3/dist-packages (from python-dateutil<3.0.0,>=2.1->botocore<1.30.0,>=1.29.49->boto3) (1.14.0)
# Installing collected packages: boto3
# Successfully installed boto3-1.26.49

python3 SeriesCreateTable.py
# Table status: ACTIVE

python3 SeriesLoadData.py
# Series added: 1 IT Crowd
# Series added: 2 Silicon Valley
# Series added: 3 House of Cards
# Series added: 3 The Office
# Series added: 3 True Detective
# Series added: 4 The Big Bang Theory
# Series added: 5 Twin Peaks

python3 SeriesItemPut.py
# Series added successfully:
# {'ResponseMetadata': {'RequestId': 'fcc36e75-bda6-4cfa-ae1a-1484e5b94582',
#                       'HTTPStatusCode': 200,
#                       'HTTPHeaders': {'content-security-policy': 'default-src '
#                                                                  "'none'; "
#                                                                  'base-uri '
#                                                                  "'none'",
#                                       'content-type': 'application/x-amz-json-1.0',
#                                       'server': 'YDB Document API '
#                                                 '(2023-1-e5a05b86c)',
#                                       'strict-transport-security': 'max-age=31536000; '
#                                                                    'includeSubDomains',
#                                       'x-amz-crc32': '2745614147',
#                                       'x-amzn-requestid': 'fcc36e75-bda6-4cfa-ae1a-1484e5b94582',
#                                       'x-content-type-options': 'nosniff',
#                                       'x-frame-options': 'DENY',
#                                       'x-request-id': 'fcc36e75-bda6-4cfa-ae1a-1484e5b94582',
#                                       'x-xss-protection': '1; mode=block',
#                                       'date': 'Fri, 13 Jan 2023 18:52:42 GMT',
#                                       'content-length': '2'},
#                       'RetryAttempts': 0}}

python3 SeriesItemGet.py
# Record read:
# {'info': {'release_date': '2015-09-13',
#           'series_info': 'Supernatural is an American television series '
#                          'created by Eric Kripke'},
#  'series_id': Decimal('3'),
#  'title': 'Supernatural'}

python3 SeriesItemUpdate.py
# Series updated:
# {'Attributes': {'info': {'rating': Decimal('8'),
#                          'release_date': '2005-09-13',
#                          'series_info': 'Supernatural is an American '
#                                         'television series created by Eric '
#                                         'Kripke'}},
#  'ResponseMetadata': {'RequestId': '39e02131-3a9b-46dc-a64c-a3dcdcfa43e8',
#                       'HTTPStatusCode': 200,
#                       'HTTPHeaders': {'content-security-policy': 'default-src '
#                                                                  "'none'; "
#                                                                  'base-uri '
#                                                                  "'none'",
#                                       'content-type': 'application/x-amz-json-1.0',
#                                       'server': 'YDB Document API '
#                                                 '(2023-1-e5a05b86c)',
#                                       'strict-transport-security': 'max-age=31536000; '
#                                                                    'includeSubDomains',
#                                       'x-amz-crc32': '771210736',
#                                       'x-amzn-requestid': '39e02131-3a9b-46dc-a64c-a3dcdcfa43e8',
#                                       'x-content-type-options': 'nosniff',
#                                       'x-frame-options': 'DENY',
#                                       'x-request-id': '39e02131-3a9b-46dc-a64c-a3dcdcfa43e8',
#                                       'x-xss-protection': '1; mode=block',
#                                       'date': 'Fri, 13 Jan 2023 18:55:31 GMT',
#                                       'content-length': '175'},
#                       'RetryAttempts': 0}}

python3 SeriesItemDelete.py
# Deleting...
# Series data deleted:
# {'ResponseMetadata': {'RequestId': '571fdf77-50b3-4213-9095-bd86b819f6ee',
#                       'HTTPStatusCode': 200,
#                       'HTTPHeaders': {'content-security-policy': 'default-src '
#                                                                  "'none'; "
#                                                                  'base-uri '
#                                                                  "'none'",
#                                       'content-type': 'application/x-amz-json-1.0',
#                                       'server': 'YDB Document API '
#                                                 '(2023-1-e5a05b86c)',
#                                       'strict-transport-security': 'max-age=31536000; '
#                                                                    'includeSubDomains',
#                                       'x-amz-crc32': '2745614147',
#                                       'x-amzn-requestid': '571fdf77-50b3-4213-9095-bd86b819f6ee',
#                                       'x-content-type-options': 'nosniff',
#                                       'x-frame-options': 'DENY',
#                                       'x-request-id': '571fdf77-50b3-4213-9095-bd86b819f6ee',
#                                       'x-xss-protection': '1; mode=block',
#                                       'date': 'Fri, 13 Jan 2023 18:56:33 GMT',
#                                       'content-length': '2'},
#                       'RetryAttempts': 0}}

python3 SeriesQuery.py
# Series with ID = 3 and names beginning with T

# 3 : The Office
# {'release_date': '2005-03-24T00:00:00Z'}

# 3 : True Detective
# {'release_date': '2014-01-12T00:00:00Z'}

python3 SeriesTableScan.py
# Series with IDs from 1 to 3...

# 3 : House of Cards
# {'release_date': '2013-02-01T00:00:00Z'}

# 3 : The Office
# {'release_date': '2005-03-24T00:00:00Z'}

# 3 : True Detective
# {'release_date': '2014-01-12T00:00:00Z'}

# 1 : IT Crowd
# {'release_date': '2006-02-03T00:00:00Z'}

# 2 : Silicon Valley
# {'release_date': '2014-04-06T00:00:00Z'}

python3 SeriesTableDelete.py
# Table Series deleted
