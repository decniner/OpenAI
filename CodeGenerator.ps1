function Generate-Script {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$apiKey,
        [Parameter(Mandatory = $true)]
        [string]$prompt,
        [string]$filePath = ""
    )
    try {
        # Define the endpoint URL and parameters for the request
        $endpoint = "https://api.openai.com/v1/engines/davinci-codex/completions"
        $parameters = @{
            "prompt" = $prompt
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

        # Write the code to a file
        if($filePath -ne ""){
            $generatedCode | Out-File $filePath -Force
        Write-Host "Script saved to $filePath"
    }
} catch {
    Write-Error "An error occurred while trying to generate the script: $($_.Exception.Message)"
}
}

#Call the function
$apiKey = "YOUR_API_KEY"
$prompt = "Write a PowerShell script that generates a random password with 8 characters"
$filePath = "C:\path\to\file.ps1"
Generate-Script -apiKey $apiKey -prompt $prompt -filePath $filePath

<#
This version of the script includes a new parameter `$filePath` which is optional, you can use it to specify the path and name of the file where you want to save the generated code. If you don't provide a value for this parameter, the script will only display the code on the console. Also, the `Out-File` cmdlet has the `-Force` parameter that is used to overwrite the file if it already exists, otherwise you will get an error.
Please remember to replace the YOUR_API_KEY with your actual API key that you got from OpenAI in the script.
It's important to review the generated code carefully and test it properly before using it in production, also, make sure to follow the OpenAI's terms of service and guidelines when using GPT-3 API.
#>
