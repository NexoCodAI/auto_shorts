import requests

app_id = "857044826528407"
app_secret = "d00787c668abd74a06c2d91712602704"
short_lived_token = "EAAMLekxxGpcBOzMOn1m1C7ZCYfwJOaMBa0HZCXdLcZB7dchx3RlVN8XvHPmnKQ1ZBjJONWWuZCBv3juMoh4YfmB4ST7r3p7ZATysDRBRSy9ZAAfNk24NutSwlAeRqCPQGYLYjHoay1nfm31oDSE7OyiNRYG9ZAvIb839q8PACyoKa1R4i63tNkLOuz5lYKr2OHjRKyZCait40UU1R6IIyz4MuxHTrqk8O4wZCdGrHPmhcfxGJdkpZCG0jkvwsDFh59u"

token_exchange_url = "https://graph.facebook.com/v12.0/oauth/access_token"
params = {
    "grant_type": "fb_exchange_token",
    "client_id": app_id,
    "client_secret": app_secret,
    "fb_exchange_token": short_lived_token
}

response = requests.get(token_exchange_url, params=params)
data = response.json()
if "access_token" in data:
    long_lived_token = data["access_token"]
    print("Long-lived access token:", long_lived_token)
else:
    print("Error:", data)
