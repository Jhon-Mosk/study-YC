import json
import logging
import requests
import os
 
#Эти библиотеки нужны для работы с PostgreSQL
import psycopg2
import psycopg2.errors
import psycopg2.extras
 
CONNECTION_ID = os.getenv("CONNECTION_ID")
DB_USER = os.getenv("DB_USER")
DB_HOST = os.getenv("DB_HOST")
 
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
 
#Запись в базу данных
def save(result, time, context):
    connection = psycopg2.connect(
        database=CONNECTION_ID, # Идентификатор подключения
        user=DB_USER, # Пользователь БД
        password=context.token["access_token"],
        host=DB_HOST, # Точка входа
        port=6432,
        sslmode="require")
 
    cursor = connection.cursor()   
    postgres_insert_query = """INSERT INTO measurements (result, time) VALUES (%s,%s)"""
    record_to_insert = (result, time)
    cursor.execute(postgres_insert_query, record_to_insert)
    connection.commit()
 
#Формируем запрос
def generateQuery():
    select = f"SELECT * FROM measurements LIMIT 50"
    result = select
    return result
 
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
 
def handler(event, context):
    try:
        secret = event['queryStringParameters']['secret']
        if secret != 'cecfb23c-bc86-4ca2-b611-e79bc77e5c31':
            raise Exception()
    except Exception as error:
        logger.error(error)
        statusCode = 401
        return {
            'statusCode': statusCode
        }
 
    sql = generateQuery()
    log(f'Exec: {sql}')
 
    connection = getConnString(context)
    log(f'Connecting: {connection}')
    cursor = connection.cursor()
    try:
        cursor.execute(sql)
        statusCode = 200
        return {
            'statusCode': statusCode,
            'body': json.dumps(cursor.fetchall()),
        }
    except psycopg2.errors.UndefinedTable as error:
        connection.rollback()
        logger.error(error)
        statusCode = 500
    except Exception as error:
        logger.error(error)
        statusCode = 500
    cursor.close()
    connection.close()
 
    return {
        'statusCode': statusCode,
        'body': json.dumps({
            'event': event,
        }),
    }
