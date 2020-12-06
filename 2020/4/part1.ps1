[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $passports = $(Get-Content -Path "./input.txt" -Raw),
    # "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
    # byr:1937 iyr:2017 cid:147 hgt:183cm

    # iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
    # hcl:#cfa07d byr:1929

    # hcl:#ae17e1 iyr:2013
    # eyr:2024
    # ecl:brn pid:760753108 byr:1931
    # hgt:179cm

    # hcl:#cfa07d eyr:2025 pid:166559648
    # iyr:2011 ecl:brn hgt:59in",
    [string]$delimiter = "`n`n`n`n", # use `r`n`r`n for script file due to CRLF vs. input file which is just LF
    [string[]]$matchWords = @(
        "byr:"
        "iyr:"
        "eyr:"
        "hgt:"
        "hcl:"
        "ecl:"
        "pid:"
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
        Write-Verbose "all matches found in $($parsedData[$i])"
        $validPassports++
    }
}
Write-Host "Valid Passports: $validPassports"
return $validPassports