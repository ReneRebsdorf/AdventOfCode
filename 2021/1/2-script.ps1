$rows = get-content "input.txt"

$slidingWindow = @(0,0,0)
$PreviousNumber = 0
$numberOfBrokenRecords = 0
for ($i = 0; $i -lt $rows.Count; $i++) {
    write-verbose "Previous number: $PreviousNumber"
    write-verbose ("New number: {0}" -f $rows[$i])
    Write-Verbose "Sliding window: $slidingWindow"

    # Inject the current number into the sliding window
    $slidingWindow[0] = [int]$rows[$i]
    if ($i+1 -lt $rows.Count) {
        $slidingWindow[1] = [int]$rows[$i+1]
    }
    else {
        $slidingWindow[1] = 0
    }
    if ($i+2 -lt $rows.Count) {
        $slidingWindow[2] = [int]$rows[$i+2]
    }
    else {
        $slidingWindow[2] = 0
    }

    Write-Verbose "new sliding window: $slidingWindow"

    # Sum the current sliding window
    $sum = $slidingWindow[0] + $slidingWindow[1] + $slidingWindow[2]

    if ($PreviousNumber -lt $sum -and $PreviousNumber -ne 0) {
        write-verbose ("found higher number: {0}" -f $sum)
        $numberOfBrokenRecords++
    }
    $PreviousNumber = $sum
    write-verbose "Number of broken records: $numberOfBrokenRecords"
    # Pause
}