import datetime
import logging
import requests
import os

#Эти библиотеки нужны для работы с PostgreSQL
import psycopg2
import psycopg2.errors

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

# Это обработчик. Он будет вызван первым при запуске функции
def entry(event, context):

    #Выводим в журнал значения входных параметров event и context
    log(event)
    log(context)

    # Тут мы запоминаем текущее время, отправляем запрос к yandex.ru и вычисляем время выполнения запроса
    try:
        now = datetime.datetime.now()
        #здесь указано два таймаута: 1c для установки связи с сервисом и 3 секунды на получение ответа
        response = requests.get('https://yandex.ru', timeout=(1.0000, 3.0000))
        timediff = datetime.datetime.now() - now
        #сохраняем результат запроса
        result = response.status_code
    #если в процессе запроса сработали таймауты, то в результат записываем соответствующие коды
    except requests.exceptions.ReadTimeout:
        result = 601
    except requests.exceptions.ConnectTimeout:
        result = 602
    except requests.exceptions.Timeout:
        result = 603
    log(f'Result: {result} Time: {timediff.total_seconds()}')    
    save(result, timediff.total_seconds(), context)

    #возвращаем результат запроса
    return {
        'statusCode': result,
        'headers': {
            'Content-Type': 'text/plain'
        },
        'isBase64Encoded': False
    }
