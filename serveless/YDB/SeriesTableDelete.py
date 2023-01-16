import boto3

def delete_serie_table():
    ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ghk9uitis1fanhbci6/etn0s60acnb01kg3t91e")

    table = ydb_docapi_client.Table('docapitest/series')
    table.delete()

if __name__ == '__main__':
    delete_serie_table()
    print("Table Series deleted")
