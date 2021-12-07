# $data = "16,1,2,0,4,2,7,1,2,14"
$data = Get-Content "input.txt"
$arr = [int[]]$data.split(",")

# Find highest position
$highestPosition = 0
for ($i = 0; $i -lt $arr.Count; $i++) {
    if ($arr[$i] -gt $highestPosition) {
        $highestPosition = $arr[$i]
    }
}

$lowestFuelCost = [int]::MaxValue
$cheapestPosition = [int]::MaxValue
# Find positions to loop through
for ($i = 0; $i -le $highestPosition; $i++) {
    # Determine fuel cost for this position
    $fuelCost = 0
    for ($j = 0; $j -lt $arr.Count; $j++) {
        if ($arr[$j] -gt $i) {
            $fuelCost += $arr[$j]-$i
        }
        else {
            $fuelCost += $i-$arr[$j]
        }
    }
    if ($fuelCost -lt $lowestFuelCost) {
        $lowestFuelCost = $fuelCost
        $cheapestPosition = $i
    }
}
"Highest Position: $highestPosition"
"Least fuel used: $lowestFuelCost"
"Cheapest position: $cheapestPosition"