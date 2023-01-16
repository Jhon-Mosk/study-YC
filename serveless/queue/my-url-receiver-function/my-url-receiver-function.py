import logging
import os
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

verboseLogging = eval(os.environ['VERBOSE_LOG'])  ## Convert to bool
queue_url = os.environ['QUEUE_URL']

def log(logString):
    if verboseLogging:
        logger.info(logString)

def handler(event, context):

    # Get url
    try:
        url = event['queryStringParameters']['url']
    except Exception as error:
        logger.error(error)
        statusCode = 400
        return {
            'statusCode': statusCode
        }

    # Create client
    client = boto3.client(
        service_name='sqs',
        endpoint_url='https://message-queue.api.cloud.yandex.net',
        region_name='ru-central1'
    )

    # Send message to queue
    client.send_message(
        QueueUrl=queue_url,
        MessageBody=url
    )
    log('Successfully sent test message to queue')

    statusCode = 200

    return {
        'statusCode': statusCode
    }
