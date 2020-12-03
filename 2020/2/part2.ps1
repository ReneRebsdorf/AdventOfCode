[string[]]$data = Get-Content "C:\Users\rre\source\repos\ReneRebsdorf\AdventOfCode\2020\2\input.txt"
# [string[]]$data = @(
#     "1-3 a: abcde"
#     "1-3 b: cdefg"
#     "2-9 c: ccccccccc"
#     "7-10 z: gzjtmtcrzv"
#     "10-13 g: cgbmglsdwwlhqk"
#     "1-30 a: abdf"
# )

$goodPasswordCount = 0
$badPasswordsCount = 0
$weirdPasswordsCount = 0

foreach ($line in $data) {
    # Getting Policy and password

    [int]$startNumber = ($line | Select-String -Pattern "^\d+").Matches[0].Value
    write-verbose "start number: $startNumber"

    [string]$lastNumber = ($line | Select-String -Pattern "[-]\d+\s.").Matches[0].Value
    $lastNumber = $lastNumber.Remove(0,1)
    $lastNumber = $lastNumber.Remove($lastNumber.Length-2,2)
    $lastNumber = $lastNumber -as [int]
    Write-verbose "last number: $lastNumber" # all except first and last two characters in [-]\d+\s.

    [char]$policyLetter = ($line | Select-String -Pattern "^\d+[-]\d+\s.").Matches[0].Value[-1] # last character in match
    Write-Verbose "Policy Letter: $policyLetter"

    [string]$password = ($line | Select-String -Pattern "\w+$").Matches[0].Value
    Write-Verbose "Password to match: $password"

    # Match password against policy
    $goodPassword = $false
    $weirdPassword = $false
    if ($password.Length -ge $lastNumber) {
        Write-Verbose "Last number is within bounds of string array - OK to make next checks"
    } else {
        Write-Warning "Weird Password: $lastNumber is out of length of password ($($password.Length))"
        $weirdPassword = $true
        $weirdPasswordsCount++
    }

    if (!$weirdPassword) {
        if ($password[$startNumber-1] -eq $policyLetter) {
            write-verbose "$password has policy letter: $policyLetter at first position"
            if ($password[$lastNumber-1] -eq $policyLetter) {
                Write-verbose "$password has policy letter: $policyLetter at both first and last position"
            } else {
                Write-Verbose "$password only has policy letter: $policyLetter at the first number (index: $startNumber)"
                $goodPassword = $true
            }
        } else {
            write-verbose "$password does not have policy letter: $policyLetter at last position"
            if ($password[$lastNumber-1] -eq $policyLetter) {
                Write-Verbose "$password only has policy letter: $policyLetter at the last position (index: $lastNumber)"
                $goodPassword = $true
            } else {
                Write-verbose "$password has policy letter: $policyLetter at both first and last position"
            }
        }
    }

    # Increment password counters
    if ($goodPassword) {
        Write-Verbose "good password"
        $goodPasswordCount++
    } else {
        Write-Verbose "bad password"
        $badPasswordsCount++
    }
}

Write-Host "Good Passwords: $goodPasswordCount"
Write-Host "Bad Passwords: $badPasswordsCount"
Write-Host "Weird Passwords: $weirdPasswordsCount"