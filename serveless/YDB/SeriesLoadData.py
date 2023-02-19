from decimal import Decimal
import json
import boto3

def load_series(series):
    ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1***i6/et***1e")

    table = ydb_docapi_client.Table('docapitest/series')
    for serie in series:
        series_id = int(serie['series_id'])
        title = serie['title']
        print("Series added:", series_id, title)
        table.put_item(Item = serie)

if __name__ == '__main__':
    with open("seriesdata.json") as json_file:
        serie_list = json.load(json_file, parse_float = Decimal)
    load_series(serie_list)
