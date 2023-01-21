$previousPrompt = ""
$previousAnswer = ""
$Global:name = Read-Host -Prompt "Enter your name"


Add-Type -AssemblyName System.Speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
#$speak.Speak("Welcome.  My name is Chewy. I am an Artificial Intelligence computer program created by Denver Sanchez.  How can I help you?")

function chewy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$prompt
    )

    $apiKey = "    "
    $model = "text-davinci-002"
    $endpoint = "https://api.openai.com/v1/engines/$model/completions"
    
    $parameters = @{
        "prompt" = $prompt
        "temperature" = 1
        "max_tokens" = 1024
        "top_p" = 1
    }

    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $apiKey"
    }

    Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body (ConvertTo-Json $parameters) -OutVariable response | Out-Null
    $answer = $response.choices.text

    # Store previous prompt and answer
    $previousPrompt = $prompt
    $previousAnswer = $answer

    # Print the generated code
    #$answer.split(".") |
    #$answer -replace '\.', "`r`n" -replace '^\s+' |
    #($answer -replace '\.', "`r`n" ) -replace '^\s+','' -replace '$','. ' |
    $answer |
    #answer -replace '\.', "`r`n") |
    
    foreach {
         Write-Host $_ -ForegroundColor Green
         #$speak.Speak($_)
    }
}

# Continuously prompt the user for a question
while ($true) {
    $input = Read-Host "$Name"
    if ($input -eq "exit") {
        break
    }
    # check if the input contains a question word
    if ($input -match "\b(more|who|what|when|where|why|how|which)\b") {
        # check if previous answer exists
        if ($previousAnswer) {
            # use previous prompt and answer in the new prompt to include context
            $newPrompt = "$previousPrompt $previousAnswer $input"
            chewy -prompt $newPrompt
        } else {
            chewy -prompt $input
        }
    } else {
        chewy -prompt $input
    }
}
