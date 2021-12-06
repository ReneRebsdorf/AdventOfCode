$data = Get-Content "./input.txt"
$boardData = $data[2..($data.count-1)]
$boardData = $boardData -Replace "^ ",""
$boardData = $boardData -Replace "\s+",","
function Get-WinningBoardScore {
    param (
        [Object[]]$board,
        [Int32]$WinningNumber
    )

    $sum = 0
    # Replace X's with Integers (0)
    foreach ($row in $board) {
        foreach ($num in $row) {
            if ($num -ne "X") {
                $sum += [int]$num
            }
        }
    }
    $sum = $sum * $WinningNumber
    $sum
    Pause
    return 
}

# Array of selected numbers
[int[]]$roll = @($data[0] -split ',')

$boardStart = 0
$boardEnd = $boardStart + 4

$boards = @()
while ($boardData.count -gt $boardEnd) {
    $board = @(0..4)
    for ($i = 0; $i -lt $board.Count; $i++) {
        $board[$i] = $boardData[$boardStart + $i] -split ','
    }
    # Add to boards array without unrolling the board array
    $boards += , $board

    $boardStart += 6
    $boardEnd += 6
}

# Loop through the rolls
$winners = @()
for ($i = 0; $i -lt $roll.Count; $i++) {
    # Find matches
    foreach ($board in $boards) {
        for ($j=0; $j -lt $board.count; $j++) {
            for ($k=0; $k -lt $board[$j].count; $k++) {
                if ($board[$j][$k] -eq $roll[$i]) {
                    $board[$j][$k] = "X"
                }
            }
            # Write-Host $board[$j]
        }
        # Write-Host ""
    }

    # Check for winners
    for ($b=0;$b -lt $boards.count; $b++) {
        # Row Check
        for ($j = 0; $j -lt $boards[$b].Count; $j++) {
            if (($boards[$b][$j] -match "X").Count -eq 5) {
                if ($boards.Count -eq ($winners.count+1)) {
                    # Needed to check this winner wasn't already added
                    # Using the column check
                    if ($winners.Contains($b)) {
                        continue
                    }
                    Get-WinningBoardScore -board $boards[$b] -WinningNumber $roll[$i]
                }
                else {
                    if ($winners.Contains($b)) {
                        continue
                    }
                    $winners += $b
                    Write-Host ("Winners: {0}" -f $winners.Count)
                }
            }
        }
        
        # Column Check
        for ($j = 0; $j -lt $boards[$b].Count; $j++) {
            $column = @()
            for ($k = 0; $k -lt $boards[$b].Count; $k++) {
                $column += $boards[$b][$k][$j]
            }
            if (($column -match "X").Count -eq 5) {
                if ($boards.Count -eq ($winners.count+1)) {
                    # Needed to check this winner wasn't already added
                    # Using the row check
                    if ($winners.Contains($b)) {
                        continue
                    }
                    Get-WinningBoardScore -board $boards[$b] -WinningNumber $roll[$i]
                }
                else {
                    if ($winners.Contains($b)) {
                        continue
                    }
                    $winners += $b
                    Write-Host ("Winners: {0}" -f $winners.Count)
                }
            }
        }
    }
}