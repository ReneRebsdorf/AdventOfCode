[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $data = $(Get-Content -Path "./input.txt" -Raw),
#     "ehovjgfzaql
# qhazvjlgeof
# kfgljqhavzoe
# jvlzfhgoeqa
# veolzqfjgah

# bdlitrzuwh
# epfmuhgvstibr",
    [string]$delimiter = "`n`n"
)

$charArr = [char[]]::new(0)
for ($i = 0; $i -lt 26; $i++) {
    $charArr += [char](65+$i)
}
$parsedData = $data -Split $delimiter

$totalMatchedLetters = 0

for ($i = 0; $i -lt $parsedData.Count; $i++) {

    [string[]]$group=$parsedData[$i] -split "`n"
    $NoOfMatchedLetters = 0
    $processedGroup = @()
    foreach ($line in $group) {
        # Remove empty strings
        if ($line -ne "") {
            $processedGroup += $line
        }
    }

    foreach ($character in $charArr) {
        if ($parsedData[$i].Split($character.ToString().ToLower()).Length -eq ($processedGroup.Length+1)) {
            $NoOfMatchedLetters++
        }
    }

    $parsedData[$i]
    Write-Host "NoOfMatchedLetters in processedGroup $i : $NoOfMatchedLetters"

    $totalMatchedLetters += $NoOfMatchedLetters
    Write-Host "Total Matched Letters: $totalMatchedLetters"
    Write-Host ""
}
Write-Host "Total Matched Letters: $totalMatchedLetters"