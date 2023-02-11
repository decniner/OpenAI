import openai
import requests
from gtts import gTTS
import os

# Initialize the OpenAI API client
openai.api_key = "INSERT_API"

print("Chewy v1.1")
print("Denver Sanchez")
print("decniner@gmail.com")
print("A sophisticated chatbot leveraging OpenAI's GPT-3 language model.")
print("")

# Store the context of the conversation in a variable
context = ""

# Store a set of previous responses to check for repetitions
previous_responses = set()

# Main loop to handle user input and respond with a generated response
while True:
    # Get the user's input
    user_input = input("You: ")

    # Update the context with the user's input
    context = context + " " + user_input

    # Generate a response using the OpenAI API
    response = openai.Completion.create(
        engine="text-davinci-002",
        prompt=(f"{context}\nUser: {{}}"),
        max_tokens=2048,
        n=1,
        stop=None,
        top_p=1.0,
        temperature=0.5,
    ).choices[0].text

    # Extract the generated response from the API's output
    generated_response = response.strip().split("\n")[-1].strip()
    
    # Check if the generated response has already been used
    if generated_response in previous_responses:
        # If it has, reset the context and previous_responses
        context = ""
        previous_responses = set()
    else:
        # If not, add it to the set of previous responses
        previous_responses.add(generated_response)

    # Print the generated response
    #print(context)  
    print("\033[32m" + response + "\033[0m")
    print("")
    tts = gTTS(response)
    tts.save("response.mp3")
    # Update the context with the generated response
    context = context + " " + generated_response
