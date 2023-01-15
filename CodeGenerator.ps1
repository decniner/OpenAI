function _generate-PSScript{

    [CmdletBinding()]
        param (
            [Parameter(Mandatory = $true)]
            [string]$prompt
        )

    $apiKey = "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"

    # Define the endpoint URL and parameters for the request
    $endpoint = "https://api.openai.com/v1/engines/davinci-codex/completions"
    $parameters = @{
        "prompt" = "Write a powershell script to get the current time and display it on screen"
        "max_tokens" = 1024
        #"stop" = "`n"
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
