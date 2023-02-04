# API_KEY = "000"

import requests
from gtts import gTTS
import os


print("Chewy v1.0")
print("Denver Sanchez")
print("decniner@gmail.com")
print("A sophisticated chatbot leveraging OpenAI's GPT-3 language model.")

previous_prompt = ""
previous_answer = ""

API_KEY = "000"

print("")
name = input("Please enter your name: ")
print("")

def generate_response(prompt):
    model = "text-davinci-002"
    endpoint = f"https://api.openai.com/v1/engines/{model}/completions"

    parameters = {
        "prompt": prompt,
        "temperature": 1,
        "max_tokens": 2048,
        "top_p": 1
    }

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {API_KEY}"
    }

    response = requests.post(endpoint, headers=headers, json=parameters)
    answer = response.json()["choices"][0]["text"]
    tts = gTTS(answer)
    tts.save("answer.mp3")
    #os.system("mpg321 answer.mp3")


    global previous_prompt
    global previous_answer

    previous_prompt = prompt
    previous_answer = answer

    #print(answer)
    print("\033[32m" + answer + "\033[0m")
    print("")
  
while True:
    user_input = input(f"{name}: ")
    if user_input.lower() == "exit":
        break
    if any(word in user_input.lower() for word in ["more", "who", "what", "when", "where", "why", "how", "which"]):
        if previous_answer:
            new_prompt = f"{previous_prompt} {previous_answer} {user_input}"
            generate_response(new_prompt)
        else:
            generate_response(user_input)
    else:
        generate_response(user_input)
