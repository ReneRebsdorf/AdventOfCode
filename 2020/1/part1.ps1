#$numbers = @(1721,979,366,299,675,1456)
[int[]]$numbers = Get-Content "C:\Users\rre\source\repos\ReneRebsdorf\AdventOfCode\2020\1\input.txt"

for ($i = 0; $i -lt $numbers.Count; $i++) {
    Write-Verbose "$($numbers[$i])"

    for ($j = 0; $j -lt $numbers.Count; $j++) {
        Write-Verbose "- $($numbers[$j])"
        if ($numbers[$j] -eq $numbers[$i]) {
            Write-Verbose "skipping itself"
        } else {
            $output = $numbers[$i]+$numbers[$j]
            if ($output -eq 2020) {
                write-verbose "Found the number! using $($numbers[$i]) and $($numbers[$j])"
                return $numbers[$i]*$numbers[$j]
            }
        }
    }
}