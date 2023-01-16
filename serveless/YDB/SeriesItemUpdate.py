from decimal import Decimal
from pprint import pprint
import boto3

def update_serie(title, series_id, release_date,  rating):
    ydb_docapi_client = boto3.resource('dynamodb', endpoint_url = "https://docapi.serverless.yandexcloud.net/ru-central1/b1ghk9uitis1fanhbci6/etn0s60acnb01kg3t91e")

    table = ydb_docapi_client.Table('docapitest/series')

    response = table.update_item(
        Key = {
            'series_id': series_id,
            'title': title
        },
        UpdateExpression = "set info.release_date = :d, info.rating = :r ",
        ExpressionAttributeValues = {
            ':d': release_date,
            ':r': Decimal(rating)
        },
        ReturnValues = "UPDATED_NEW"
    )
    return response

if __name__ == '__main__':
    update_response = update_serie(
        "Supernatural", 3, "2005-09-13", 8)
    print("Series updated:")
    pprint(update_response, sort_dicts = False)
