# This has one unresolved bug: It may return one entry too many (154 should have been 153 in my input)
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $passports = $(Get-Content -Path "./input.txt" -Raw),
    [string]$delimiter = "`n`n`n`n", # use `r`n`r`n for script file due to CRLF vs. input file which is just LF
    [string[]]$matchWords = @(
        "byr:(19[2-9][0-9]|200[0-2])"
        "iyr:(201[0-9]|2020)"
        "eyr:(202[0-9]|2030)"
        "hgt:(1[5-8][0-9]cm|19[0-3]cm|59in|6[0-9]in|7[0-6]in)"
        "hcl:#[0-9a-f]{6}"
        "ecl:(amb|blu|brn|gry|grn|hzl|oth)"
        "pid:[0-9]{9}"
    )
)
$parsedData = $passports -Split $delimiter
$validPassports = 0

for ($i = 0; $i -lt $parsedData.Count; $i++) {
    $matchCounter=0
    for ($j = 0; $j -lt $matchWords.Count; $j++) {
        if ($parsedData[$i] -match $matchWords[$j]) {
            Write-Verbose "$($parsedData[$i]) match $($matchWords[$j])"
            $matchCounter++
        } else {
            Write-Verbose "$($parsedData[$i]) did not match $($matchWords[$j])"
        }
    }
    if ($matchCounter -eq $matchWords.Count) {
        Write-Verbose "Valid passort found: $($parsedData[$i])"
        $validPassports++
    }
}
Write-Host "Valid Passports: $validPassports"
return $validPassports