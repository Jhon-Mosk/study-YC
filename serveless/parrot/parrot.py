import os
import datetime
import boto3
import pytz

ACCESS_KEY = os.getenv("ACCESS_KEY")
SECRET_KEY = os.getenv("SECRET_KEY")
BUCKET_NAME = os.getenv("BUCKET_NAME")
TIME_ZONE = os.getenv("TIME_ZONE", "Europe/Moscow")

TEMP_FILENAME = "/tmp/temp_file"
TEXT_FOR_TEMP_FILE = "This is text file"

def write_temp_file(text_for_s3):
    TEXT_FOR_TEMP_FILE = text_for_s3
    temp_file = open(TEMP_FILENAME, 'w')    
    temp_file.write(TEXT_FOR_TEMP_FILE)
    temp_file.close()
    print("\U0001f680 Temp file is written")

def get_now_datetime_str():
    now = datetime.datetime.now(pytz.timezone(TIME_ZONE))
    return now.strftime('%Y-%m-%d__%H-%M-%S')

def get_s3_instance():
    session = boto3.session.Session()
    return session.client(
        aws_access_key_id=ACCESS_KEY,
        aws_secret_access_key=SECRET_KEY,
        service_name='s3',
        endpoint_url='https://storage.yandexcloud.net'
    )

def upload_dump_to_s3():
    print("\U0001F4C2 Starting upload to Object Storage")
    get_s3_instance().upload_file(
        Filename=TEMP_FILENAME,
        Bucket=BUCKET_NAME,
        Key=f'file-{get_now_datetime_str()}.txt'
    )
    print("\U0001f680 Uploaded")


def remove_temp_files():
    os.remove(TEMP_FILENAME)
    print("\U0001F44D That's all!")

def handler(event, context):
    """
    Entry-point for Serverless Function.
    :param event: request payload.
    :param context: information about current execution context.
    :return: response to be serialized as JSON.
    """
    text = 'Hello! I\'ll repeat anything you say to me.'
    if 'request' in event and \
            'original_utterance' in event['request'] \
            and len(event['request']['original_utterance']) > 0:
        text = event['request']['original_utterance']
        write_temp_file(text)
        upload_dump_to_s3()
        remove_temp_files()
    return {
        'version': event['version'],
        'session': event['session'],
        'response': {
            # Respond with the original request or welcome the user if this is the beginning of the dialog and the request has not yet been made.
            'text': text,
            # Don't finish the session after this response.
            'end_session': 'false'
        },
    }
