$data = Get-Content -Path ".\input.txt"

$ErrorActionPreference = "stop"

$grid = @()
$longestX = 0

# Create Grid
foreach ($line in $data) {
    # Process coordinates
    $startCoordinateX = [int]$line.Split(' -> ')[0].Split(',')[0]
    $startCoordinateY = [int]$line.Split(' -> ')[0].Split(',')[1]

    $endCoordinateX = [int]$line.Split(' -> ')[1].Split(',')[0]
    $endCoordinateY = [int]$line.Split(' -> ')[1].Split(',')[1]

    # Find Start/Stop for iteration
    if ($startCoordinateX -le $endCoordinateX) {
        $startX = $startCoordinateX
        $endX = $endCoordinateX
    }
    else {
        $startX = $endCoordinateX
        $endX = $startCoordinateX
    }

    if ($startCoordinateY -le $endCoordinateY) {
        $startY = $startCoordinateY
        $endY = $endCoordinateY
    }
    else {
        $startY = $endCoordinateY
        $endY = $startCoordinateY
    }

    $isDiagonalLine = $false
    if ($startX -eq $endX) {
        # $isHorizontalLine = $true
    }
    elseif ($startY -eq $endY) {
        # $isVerticalLine = $true
    }
    else {
        $isDiagonalLine = $true
    }
    
    # Ensure the grid is large enough to hold the coordinates
    ## Expand on X
    if ($endX -gt $longestX) {
        $longestX = $endX

        # Since X expanded, we have to increase length on all rows
        for ($i = 0; $i -lt $grid.Count; $i++) {
            $existingRowLength = $grid[$i].Length
            for ($j = 0; $j -le $endX-$existingRowLength; $j++) {
                $grid[$i] += 0
            }
        }
    }

    ## Expand on Y
    if ($grid.Length -le $endY) {
        $gridLength = $grid.Length
        for ($i = 0; $i -le $endY-$gridLength; $i++) {
            $newRow = @()
            for ($j = 0; $j -le $longestX; $j++) {
                $newRow += 0
            }
            $grid += , $newRow
        }
    }

    # Iterate through coordinates
    if ($isDiagonalLine) {
        # Populate diagonal line
        $x = $startCoordinateX
        $y = $startCoordinateY
        if ($startCoordinateX -lt $endCoordinateX) {
            $lrMode = $true
        }
        else {
            $lrMode = $false
        }
        if ($startCoordinateY -lt $endCoordinateY) {
            $upMode = $true
        }
        else {
            $upMode = $false
        }
        
        while ($x -ne $endCoordinateX) {
            $grid[$y][$x] += 1
            if ($lrMode) {
                $x += 1
            }
            else {
                $x -= 1
            }
            if ($upMode) {
                $y += 1
            }
            else {
                $y -= 1
            }
        }
        $grid[$y][$x] += 1
    }
    else {
        for ($x = $startX; $x -le $endX; $x++) {
            for ($y = $startY; $y -le $endY; $y++) {
                $grid[$y][$x] += 1
            }
        }
    }

    # for ($i = 0; $i -lt $grid.Count; $i++) {
    #     $outputRow = ""
    #     for ($j = 0; $j -lt $grid[$i].Count; $j++) {
    #         $outputRow += [string]$grid[$i][$j]
    #     }
    #     $outputRow
    # }
    # ""
}

# Find how many points where most lines overlap
$overlapCount = 0
for ($i = 0; $i -lt $grid.Count; $i++) {
    for ($j = 0; $j -lt $grid[$i].Count; $j++) {
        if ($grid[$i][$j] -gt 1) {
            $overlapCount++
        }
    }
}
"Overlap Count: $overlapCount"