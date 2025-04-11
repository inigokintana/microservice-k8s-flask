import asyncio
import json
from dapr.clients import DaprClient
import time

def perform_selects():
    with DaprClient() as d:
        sql_binding = "pgdb-dvdrental"

        sqlCmd = ('select title, description from film where film_id=(SELECT FLOOR(RANDOM()*(1000 - 1 + 1)) + 1);')
        payload = {'sql': sqlCmd}

        # print(sqlCmd, flush=True)

        try:
        # Select using Dapr output binding via HTTP Post
            resp = d.invoke_binding(binding_name=sql_binding, operation='query',
                                     binding_metadata=payload)
            # print(resp, flush=True)
            result = resp.json()
            print("Selected DB result:", result, flush=True)
            print("-----------------", flush=True)
            return result
        except Exception as e:
             print(e, flush=True)
             raise SystemExit(e)

def invoke_ollama_via_dapr(prompt, model="llama3.2:1b"):
    """Invokes Ollama via Dapr service invocation."""

    with DaprClient() as d:
        # Define the payload to be sent to the Ollama API
        payload = {
            "model": model,
            "prompt": prompt,
            "stream": False
        }

        # Define the Dapr service invocation endpoint
        resp = d.invoke_method(
            app_id='ollama-llm.ollama',
            method_name='api/generate',
            data=json.dumps(payload),
            http_verb='POST'
        )
    
        # Print the response
        # print(resp.content_type, flush=True)
        # print(resp.text(), flush=True)
        # print(str(resp.status_code), flush=True)

        time.sleep(2)
        return resp.text()

if __name__ == "__main__":
    """Main function to demonstrate Ollama invocation via Dapr."""
    tries = 0
    success = 0
    fail = 0
    while True:
        # Get a random film title and description from the database
        # and use it to generate a prompt for the LLM

        # 1 - Get a random film title and description from the database
        result=perform_selects()
        title_direct = result[0][0]
        description_direct = result[0][1]
        print("Selected DB result:", flush=True)
        print(f"Film Title: {title_direct}")
        print(f"Film Description: {description_direct}")
        
        # 2 - Use the description to generate a prompt for the LLM
        # Use the description to generate a prompt for the LLM
        prompt = "Please try to guess only the title of the following film description: " + description_direct
        # Calling Ollama LLM via Dapr
        llm_tittle_guess = invoke_ollama_via_dapr(prompt, model="llama3.2:1b")
        print("LLM guess: " + llm_tittle_guess, flush=True)

        # 3 - Compare the LLM guess with the actual title
        # count number of tries and print the result
        tries += 1
        response_text = llm_tittle_guess["response"]
        # Split the response string to find the title
        parts = response_text.split("\"")
        # The film title is likely the text enclosed in the first pair of double quotes
        if len(parts) > 1:
            film_title = parts[1]
            print(film_title)
        else:
            print("Could not extract the film title from the response.")
        # Compare the LLM guess with the actual title
        if film_title.lower() == title_direct.lower():
            success += 1
            print("LLM guess is correct: ", flush=True)  
        else:
            fail += 1
            print("LLM guess is incorrect: ", flush=True) 
        # results
        print("Results: Tries = " + str(tries) + " - Success = " + str(success) + " - Error = " + str(fail) , flush=True)
        print("----------------------------------------------", flush=True)

        # 4 - Wait for a while before the next iteration
        time.sleep(5)
