function chewy {

    [CmdletBinding()]
        param (
            [Parameter(Mandatory = $true)]
            [string]$prompt
        )

    $apiKey = "insert here"
    #$model = "code-davinci-002"
    #$model = "davinci-codex"
    $model = "text-davinci-002"
    # Define the endpoint URL and parameters for the request
    #$endpoint = "https://api.openai.com/v1/engines/davinci-codex/completions"
    $endpoint = "https://api.openai.com/v1/engines/$model/completions"
    
    $parameters = @{
        #"prompt" = "Write a powershell script to get the current time and display it on screen"
        "prompt" = $prompt
        <#
        "max_tokens" = 1024
        "temperature" = 0
        #"stop" = "`n"
        #>
        "temperature" = 1
        "max_tokens" = 256
        "top_p" = 1
        #"frequency_penalty" = 0
        #"presence_penalty" = 0
    }

    # Add the API key to the headers of the request
    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $apiKey"
    }

    # Make the request to the API and store the response in a variable
    Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body (ConvertTo-Json $parameters) -OutVariable response | Out-Null
    $generatedCode = $response.choices.text

    # Print the generated code
    Write-Host $generatedCode
}
