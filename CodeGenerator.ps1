# Store your API key in a variable
$apiKey = "YOUR_API_KEY"

# Define the endpoint URL and parameters for the request
$endpoint = "https://api.openai.com/v1/engines/davinci-codex/completions"
$parameters = @{
    "prompt" = "Write a PowerShell script that generates a random password with 8 characters"
    "max_tokens" = 2048
    "stop" = "`n"
}

# Add the API key to the headers of the request
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $apiKey"
}

# Make the request to the API
$response = Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body (ConvertTo-Json $parameters)

# Store the generated code in a variable
$generatedCode = $response.choices[0].text

# Print the generated code
Write-Host $generatedCode
