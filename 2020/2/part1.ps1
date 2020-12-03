[string[]]$data = Get-Content "C:\Users\rre\source\repos\ReneRebsdorf\AdventOfCode\2020\2\input.txt"
# [string[]]$data = @(
#     "1-3 a: abcde"
#     "1-3 b: cdefg"
#     "2-9 c: ccccccccc"
#     "7-10 z: gzjtmtcrzv"
#     "10-13 g: cgbmglsdwwlhqk"
# )

$goodPasswordCount = 0
$badPasswordsCount = 0

foreach ($line in $data) {
    # Getting Policy and password

    [int]$startNumber = ($line | Select-String -Pattern "^\d+").Matches[0].Value
    write-verbose "start number: $startNumber"

    [string]$lastNumber = ($line | Select-String -Pattern "[-]\d+\s.").Matches[0].Value
    $lastNumber = $lastNumber.Remove(0,1)
    $lastNumber = $lastNumber.Remove($lastNumber.Length-2,2)
    $lastNumber = $lastNumber -as [int]
    Write-verbose "last number: $lastNumber" # all except first and last two characters in [-]\d+\s.

    $policyLetter = ($line | Select-String -Pattern "^\d+[-]\d+\s.").Matches[0].Value[-1] # last character in match
    Write-Verbose "Policy Letter: $policyLetter"

    $password = ($line | Select-String -Pattern "\w+$").Matches[0].Value
    Write-Verbose "Password to match: $password"

    # Match password against policy
    $goodPassword = $false

    $passwordMatches = ([regex]::Matches($password, $policyLetter)).count
    if ($passwordMatches -ge $startNumber) {
        write-verbose "$password has policy letter: $policyLetter at least $startNumber times"
        if ($passwordMatches -le $lastNumber) {
            Write-Verbose "$password has policy letter: $policyLetter a maximum of $lastNumber times"
            $goodPassword = $true
        }
    }

    # Increment password counters
    if ($goodPassword) {
        $goodPasswordCount++
    } else {
        $badPasswordsCount++
    }
}

Write-Host "Good Passwords: $goodPasswordCount"
Write-Host "Bad Passwords: $badPasswordsCount"