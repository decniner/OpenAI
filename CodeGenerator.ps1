function _generate-PSScript{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$prompt,
        [float]$temperature = 1.0,
        [string]$model = "davinci-codex"
    )

    $apiKey = "sk-n0DNx0fYTxlVO3WmlKDxT3BlbKFJLbGrmvX8bDd93CVfgHSG"

    # Define the endpoint URL and parameters for the request
    $endpoint = "https://api.openai.com/v1/engines/$model/completions"
    $parameters = @{
        "prompt" = $prompt
        "max_tokens" = 1024
        "temperature" = $temperature
    }

    # Add the API key to the headers of the request
    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $apiKey"
    }

    # Make the request to the API and store the response in a variable
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body (ConvertTo-Json $parameters)
    $generatedCode = $response.choices.text

    # Print the generated code
    Write-Host $generatedCode
}
