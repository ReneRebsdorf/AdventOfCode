$rows = get-content "input.txt"

$PreviousNumber = 0
$numberOfBrokenRecords = 0
for ($i = 0; $i -lt $rows.Count; $i++) {
    write-verbose "Previous number: $PreviousNumber"
    if ($PreviousNumber -eq 0) {
        write-verbose "first iteration or lowest possible value. will not increment"
    }
    if ($PreviousNumber -lt $rows[$i]) {
        write-verbose ("found higher number: {0}" -f $rows[$i])
        $numberOfBrokenRecords++
    }
    $PreviousNumber = $rows[$i]
    write-verbose "Number of broken records: $numberOfBrokenRecords"
}