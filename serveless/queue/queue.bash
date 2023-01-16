user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC$ yc iam access-key create --service-account-name service-account-for-cf
access_key:
  id: ajeluatbc8236umarko2
  service_account_id: aje7e481l77uk8g0fa1r
  created_at: "2023-01-16T17:07:39.756844995Z"
  key_id: YCAJEAqb_nSvwlK7LRk44fFvp
secret: YCPoH92uLpifGGbdozZh8QEZ2qGVawz2ut4iSQgh

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC$ echo "export VERBOSE_LOG=True" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC$ echo "export AWS_ACCESS_KEY_ID=YCAJEAqb_nSvwlK7LRk44fFvp" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC$ echo "export AWS_SECRET_ACCESS_KEY=YCPoH92uLpifGGbdozZh8QEZ2qGVawz2ut4iSQgh" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC$ echo "export QUEUE_URL=https://message-queue.api.cloud.yandex.net/b1ghk9uitis1fanhbci6/dj600000000b34ve06l1/my-first-queue" >> ~/.bashrc && . ~/.bashrc
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC$ 

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ pipreqs $PWD --force
INFO: Successfully saved requirements file in /mnt/f/Project/ShmakovSMM/studyYC/serveless/queue/requirements.txt
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ zip my-url-receiver-function my-url-receiver-function.py requirements.txt
  adding: my-url-receiver-function.py (deflated 51%)
  adding: requirements.txt (stored 0%)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ yc serverless function create \
>   --name  my-url-receiver-function \
escripti>   --description "function for url"
done (2s)
id: d4e7clhrs8n4i0nlh8fc
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-16T17:15:11.792Z"
name: my-url-receiver-function
description: function for url
log_group_id: ckgnmrlfo28kkg6gq76v
http_invoke_url: https://functions.yandexcloud.net/d4e7clhrs8n4i0nlh8fc
status: ACTIVE

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ yc serverless function version create \
  --func>   --function-name=my-url-receiver-function \
>   --memory=256m \
>   --execution-timeout=5s \
>   --runtime=python37 \
>   --entrypoint=my-url-receiver-function.handler \
ervice-a>   --service-account-id $SERVICE_ACCOUNT_ID \
>   --environment VERBOSE_LOG=$VERBOSE_LOG \
>   --environment AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
>   --environment AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
>   --environment QUEUE_URL=$QUEUE_URL \
>   --source-path my-url-receiver-function.zip 
done (4s)
id: d4eb5dc0v1ai918inkib
function_id: d4e7clhrs8n4i0nlh8fc
created_at: "2023-01-16T17:15:33.281Z"
runtime: python37
entrypoint: my-url-receiver-function.handler
resources:
  memory: "268435456"
execution_timeout: 5s
service_account_id: aje7e481l77uk8g0fa1r
image_size: "24576"
status: ACTIVE
tags:
  - $latest
log_group_id: ckgnmrlfo28kkg6gq76v
environment:
  AWS_ACCESS_KEY_ID: ajeluatbc8236umarko2
  AWS_SECRET_ACCESS_KEY: YCPoH92uLpifGGbdozZh8QEZ2qGVawz2ut4iSQgh
  QUEUE_URL: https://message-queue.api.cloud.yandex.net/b1ghk9uitis1fanhbci6/dj600000000b34ve06l1/my-first-queue
  VERBOSE_LOG: "True"
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ yc serverless api-gateway get-spec \
>   --name hello-world >> hello-world-new.yaml
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ yc serverless api-gateway update \
>   --name hello-world \
>   --spec=hello-world-new.yaml
done (3s)
id: d5do64vg3bkob7l3evno
folder_id: b1gp2lhjstd03j7rff3m
created_at: "2023-01-11T17:35:44.804Z"
name: hello-world
description: hello world
status: ACTIVE
domain: d5do64vg3bkob7l3evno.apigw.yandexcloud.net
log_group_id: ckgco2ijpoath9cpi54j
connectivity: {}
log_options:
  folder_id: b1gp2lhjstd03j7rff3m

user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ pipreqs $PWD --force
INFO: Successfully saved requirements file in /mnt/f/Project/ShmakovSMM/studyYC/serveless/queue/requirements.txt
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$ zip function-for-url-from-mq function-for-url-from-mq.py requirements.txt
  adding: function-for-url-from-mq.py (deflated 59%)
  adding: requirements.txt (deflated 2%)
user@DESKTOP-D761754:/mnt/f/Project/ShmakovSMM/studyYC/serveless/queue$
