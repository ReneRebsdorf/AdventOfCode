[string[]]$boardingPasses = 
 #@("FBFBBFFRLR","BFFFBBFRRR","FFFBBBFRRR","BBFFBBFRLL")
 Get-Content ".\input.txt"

$seatIds = [int[]]@()
$seats = @(0..127)
for ($i = 0; $i -lt $seats.Count; $i++) {
    $seats[$i] = 0..7
}

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
    #Write-Verbose "Boarding Pass Row: $($rows[0])"
    #Write-Verbose "Boarding Pass Column: $($columns[0])"
    $seats[$rows[0]][$columns[0]] = 1

    $seatId = (($rows[0]*8)+$columns[0])
    #Write-Verbose "Seat ID: $seatId"
    $seatIds+=$seatId
}

for ($i = 0; $i -lt $seats.Count; $i++) {
    for ($j = 0; $j -lt $seats[$i].Count; $j++) {
        if ($seats[$i][$j] -ne 1) {
            Write-Verbose "Available Seat: Row: $i Column: $j"
            $seatId = (($i*8)+$j)
            Write-Verbose "Seat ID: $seatId"
            
            if ($seatIds.contains($seatId-1) -and $seatIds.Contains($seatId+1)) {
                Write-Verbose "This seat has neighbor ids"
                return $seatId
            }
        }
    }
}