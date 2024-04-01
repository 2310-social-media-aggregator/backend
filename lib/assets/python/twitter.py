import sys
handle = sys.argv[1]

from twikit import Client
import json
import pandas as pd

client = Client('en-US')

client.login(auth_info_1='FunkyAstronaut5', password='ToiletPaper')
client.save_cookies('cookies.json')
client.load_cookies(path='cookies.json')

user = client.get_user_by_screen_name(handle)
tweets = user.get_tweets('Tweets', count=5)

tweets_to_store = []
for tweet in tweets:
    tweets_to_store.append({
        'created_at': tweet.created_at,
        'id': tweet.id,
    })

df = pd.DataFrame(tweets_to_store)
df.to_csv('tweets.csv', index=False)
df.sort_values(by='created_at', ascending=False)

print(json.dumps(tweets_to_store, indent=4))