#$numbers = @(1721,979,366,299,675,1456)
[int[]]$numbers = Get-Content "C:\Users\rre\source\repos\ReneRebsdorf\AdventOfCode\2020\1\input.txt"
$goodNumbers = @()
:loopI for ($i = 0; $i -lt $numbers.Count; $i++) {
    #Write-Verbose "$($numbers[$i])"
    :loopJ for ($j = 0; $j -lt $numbers.Count; $j++) {
        #Write-Verbose "- $($numbers[$j])"
        :loopK for ($k = 0; $k -lt $numbers.Count; $k++) {
            #Write-Verbose "  - $($numbers[$k])"
            $output = $numbers[$i]+$numbers[$j]+$numbers[$k]
            if ($output -eq 2020) {
                write-host "Found the number! using $($numbers[$i]) + $($numbers[$j]) +  $($numbers[$k])"
                $goodNumbers += $numbers[$i]
                $goodNumbers += $numbers[$j]
                $goodNumbers += $numbers[$k]
                break loopI
            }
        }
    }
}
write-host "good numbers: $goodNumbers"
$result = 1
foreach ($gNumber in $goodNumbers) {
    write-host "Multplying $gnumber to $result"
    $result = $result*$gNumber
}
write-host "return:"
return $result