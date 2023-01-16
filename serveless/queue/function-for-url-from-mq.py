import logging
import os
import boto3
import datetime
import requests

#Эти библиотеки нужны для работы с PostgreSQL
import psycopg2
import psycopg2.errors
import psycopg2.extras

CONNECTION_ID = os.getenv("CONNECTION_ID")
DB_USER = os.getenv("DB_USER")
DB_HOST = os.getenv("DB_HOST")
QUEUE_URL = os.environ['QUEUE_URL']

# Настраиваем функцию для записи информации в журнал функции
# Получаем стандартный логер языка Python
logger = logging.getLogger()
logger.setLevel(logging.INFO)
# Вычитываем переменную VERBOSE_LOG, которую мы указываем в переменных окружения 
verboseLogging = eval(os.environ['VERBOSE_LOG'])  ## Convert to bool

#Функция log, которая запишет текст в журнал выполнения функции, если в переменной окружения VERBOSE_LOG будет значение True
def log(logString):
    if verboseLogging:
        logger.info(logString)

#Получаем подключение
def getConnString(context):
    """
    Extract env variables to connect to DB and return a db string
    Raise an error if the env variables are not set
    :return: string
    """
    connection = psycopg2.connect(
        database=CONNECTION_ID, # Идентификатор подключения
        user=DB_USER, # Пользователь БД
        password=context.token["access_token"],
        host=DB_HOST, # Точка входа
        port=6432,
        sslmode="require")
    return connection

"""
    Create SQL query with table creation
"""
def makeCreateDataTableQuery(table_name):
    query = f"""CREATE TABLE public.{table_name} (
    url text,
    result integer,
    time float
    )"""
    return query

def makeInsertDataQuery(table_name, url, result, time):
    query = f"""INSERT INTO {table_name} 
    (url, result,time)
    VALUES('{url}', {result}, {time})
    """
    return query

def handler(event, context):

    # Create client
    client = boto3.client(
        service_name='sqs',
        endpoint_url='https://message-queue.api.cloud.yandex.net',
        region_name='ru-central1'
    )

    # Receive sent message
    messages = client.receive_message(
        QueueUrl=QUEUE_URL,
        MaxNumberOfMessages=1,
        VisibilityTimeout=60,
        WaitTimeSeconds=1
    ).get('Messages')

    if messages is None:
        return {
            'statusCode': 200
        }

    for msg in messages:
        log('Received message: "{}"'.format(msg.get('Body')))

    # Get url from message
    url = msg.get('Body');

    # Check url
    try:
        now = datetime.datetime.now()
        response = requests.get(url, timeout=(1.0000, 3.0000))
        timediff = datetime.datetime.now() - now
        result = response.status_code
    except requests.exceptions.ReadTimeout:
        result = 601
    except requests.exceptions.ConnectTimeout:
        result = 602
    except requests.exceptions.Timeout:
        result = 603
    log(f'Result: {result} Time: {timediff.total_seconds()}')
    
    connection = getConnString(context)
    log(f'Connecting: {connection}')    
    cursor = connection.cursor()

    table_name = 'custom_request_result'
    sql = makeInsertDataQuery(table_name, url, result, timediff.total_seconds())

    log(f'Exec: {sql}')
    try:
        cursor.execute(sql)
    except psycopg2.errors.UndefinedTable as error:
        log(f'Table not exist - create and repeate insert')
        connection.rollback()
        logger.error(error)
        createTable = makeCreateDataTableQuery(table_name)
        log(f'Exec: {createTable}')
        cursor.execute(createTable)
        connection.commit()
        log(f'Exec: {sql}')
        cursor.execute(sql)
    except Exception as error:
        logger.error( error)

    connection.commit()
    cursor.close()
    connection.close()

    # Delete processed messages
    for msg in messages:
        client.delete_message(
            QueueUrl=QUEUE_URL,
            ReceiptHandle=msg.get('ReceiptHandle')
        )
        print('Successfully deleted message by receipt handle "{}"'.format(msg.get('ReceiptHandle')))

    statusCode = 200

    return {
        'statusCode': statusCode
    }
