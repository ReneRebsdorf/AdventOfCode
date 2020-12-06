[string[]]$boardingPasses = 
 #@("FBFBBFFRLR","BFFFBBFRRR","FFFBBBFRRR","BBFFBBFRLL")
 Get-Content ".\input.txt"
$seatIds = [int[]]@()
foreach ($boardingPass in $boardingPasses) {
    $boardingPass = $boardingPass.ToCharArray()
    $firstRow = 0
    $lastRow = 127
    $firstColumn = 0
    $lastColumn = 7

    [int[]]$rows=$firstRow..$lastRow
    [int[]]$columns=$firstColumn..$lastColumn
    
    foreach ($character in $boardingPass) {
        switch ($character) {
            "F" { 
                $lastRow = $lastRow-$rows.Length/2
                break 
            }
            "B" { 
                $firstRow = $firstrow+$rows.length/2
                break 
            }

            "L" { 
                $lastColumn = $lastColumn-$columns.Length/2
                break 
            }
            "R" { 
                $firstColumn = $firstColumn+$columns.length/2
                break
            }
            default { Write-Error "unhandled character: $character in $boardingPass"; break}
        }
        [int[]]$rows=$firstRow..$lastRow
        [int[]]$columns=$firstColumn..$lastColumn
    }
    Write-Verbose "Boarding Pass Row: $($rows[0])"
    Write-Verbose "Boarding Pass Column: $($columns[0])"

    $seatId = ($rows[0]*8)+$columns[0]
    Write-Verbose "Seat ID: $seatId"
    $seatIds+=$seatId
}
Write-Host "Highest SeatId: $(($seatIds | measure -Maximum).Maximum)"
