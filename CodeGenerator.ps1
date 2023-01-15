function Generate-PasswordScript {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$apiKey
    )
    try {
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

        # Make the request to the API and store the response in a variable
        Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body (ConvertTo-Json $parameters) -OutVariable response
        $generatedCode = $response.choices[0].text

        # Print the generated code
        Write-Host $generatedCode
    } catch {
        Write-Error "An error occurred while trying to generate the password script: $($_.Exception.Message)"
    }
}

# Call the function
$apiKey = "YOUR_API_KEY"
Generate-PasswordScript -apiKey $apiKey
