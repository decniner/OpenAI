# Import necessary modules
Import-Module -Name PowerShellStandard.Library

$previous_prompt = ""
$previous_answer = ""

# Function to send request to OpenAI API
function Chewy {
    param(
        [string]$prompt
    )
    $headers = @{ "Content-Type" = "application/json" }
    $body = @{
        "prompt" = $prompt,
        "model" = "text-davinci-002",
        "temperature" = 0.5,
        "max_tokens" = 2048,
        "stop" = "Bye"
    }
    try {
        $response = Invoke-WebRequest -Uri https://api.openai.com/v1/engines/davinci/completions -Method POST -Headers $headers -Body (ConvertTo-Json $body) -ErrorAction Stop
        $answer = ($response.Content | ConvertFrom-Json).choices.text
        return $answer
    } catch {
        Write-Error "An error occurred while sending the request to OpenAI: $_"
        return ""
    }
}

# Function to check for exit keyword
function Check-ExitKeyword {
    param(
        [string]$input
    )
    $stopWords = "bye", "goodbye", "exit"
    $inputLower = $input.ToLower()
    foreach ($stopWord in $stopWords) {
        if ($inputLower -eq $stopWord) {
            return $true
        }
    }
    return $false
}

# Main loop
while($true) {
    $prompt = "$previous_answer $previous_prompt"
    $answer = Chewy -prompt $prompt
    if ($answer -eq "") {
        Write-Error "An error occurred while getting the answer from OpenAI, please try again later."
        break
    }
    Write-Host $answer
    $previous_answer = $answer
    $previous_prompt = Read-Host "What is your next question?"
    if (Check-ExitKeyword -input $previous_prompt) {
        Write-Host "Goodbye!"
        break
    }
    $log = "[$(Get-Date)] `n User: $previous_prompt `n Chewy: $answer `n"
    Add-Content -Path "c:\temp\history.log" -Value $log
}
