[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $data = $(Get-Content -Path "./input.txt" -Raw),
    [string]$delimiter = "`n`n"
)

$charArr = [char[]]::new(0)
for ($i = 0; $i -lt 26; $i++) {
    $charArr += [char](65+$i)
}
$parsedData = $data -Split $delimiter

$totalMatchedLetters = 0

for ($i = 0; $i -lt $parsedData.Count; $i++) {
    $NoOfMatchedLetters = 0
    for ($j = 0; $j -lt $charArr.Count; $j++) {
        if ($parsedData[$i] -match $charArr[$j]) {
            $NoOfMatchedLetters++
            $totalMatchedLetters++
        }
    }
    Write-Host "NoOfMatchedLetters in group $i : $NoOfMatchedLetters"
    Write-Host "Total Matched Letters: $totalMatchedLetters"
}