import requests

# Replace with your actual values
app_id = "857044826528407"
redirect_uri = "https://nexocodai.github.io/"
app_secret = "d00787c668abd74a06c2d91712602704"
# Use the code from the URL without the trailing "#_=_"
auth_code = "AQAh0PXqTmQEuYaPW50v-zUkafyOrSUVcMe254Y47ej5nO52cBfRX69kc3lBnEywJG4vvne_B07JtegRGKe6xoUXQTLdVATxXWyFIHAhzcLFA0qPFPXglyMkMzne7Gls48iaRtIUmxU2wJrs6fG13_g1VssarZZ1jhAEF_SRD710jjhi5lCRTcAsJ3x555RZeXiMuznClOU1OualYjBOnUdBnIilCgfet5rdb1__4YqCmdJdjBW_M8pp2FgsXw9XuaCT2AVaSMiSqaL_s5M26WmQsxz_5ztpQ36Ng2cAlzeykPQKlUMTnkyiFILqYgGRaqxZOyrlVna1yQaFuAuJpRTPtVm32RX39F-gHbkLIl3-UcS3CpiohRLDgnF_C3kp9do#_=_"

token_exchange_url = "https://graph.facebook.com/v12.0/oauth/access_token"
params = {
    "client_id": app_id,
    "redirect_uri": redirect_uri,
    "client_secret": app_secret,
    "code": auth_code
}

response = requests.get(token_exchange_url, params=params)
data = response.json()

if "access_token" in data:
    short_lived_token = data["access_token"]
    print("Short-lived access token:", short_lived_token)
else:
    print("Error:", data)
