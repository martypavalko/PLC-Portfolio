import pandas as pd
import io
import requests
import math

url = "{{URL}}"
org_id = "{{ORG_ID}}"
token = "{{TOKEN}}"
header = {"{{KEY}}" : "{{VALUE}}"}
device_number = 1178
page = 0
df_array = []

while True:
    params = {"o":org_id, "limit":500, "page":page}
    s = requests.get(url=url, params=params, headers=header).content
    json_to_df = pd.read_json(io.StringIO(s.decode('utf-8')))
    if len(json_to_df) != 0:
        df_array.append(json_to_df)
        page += 1
    else:
        break

df = pd.concat(df_array)

i = 0
while i < len(df):
    server_id = df['id'].iloc[i]
    s = requests.get(url=url+server_id+"{{FOLDER}}", params=params, headers=header).content
    i += 1