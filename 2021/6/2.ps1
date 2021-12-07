$data = Get-Content "./input.txt"
# $data = "3,4,3,1,2"
$state = [System.Collections.ArrayList][System.Int32[]]$data.Split(",")

$hash = @{}
for ($i = 0; $i -lt 10; $i++) {
    $hash.Add($i, 0)
}

for ($i = 0; $i -lt $state.Count; $i++) {
    $hash[$state[$i]]++
}

for ($day = 0; $day -lt 256; $day++) {
    $newFish = $hash[0]
    for ($i = 0; $i -le 8; $i++) {
        $hash[$i] = $hash[$i+1]
    }
    $hash[8] = $newFish
    $hash[6] += $newFish
}

$sum = 0
for ($i = 0; $i -lt 10; $i++) {
    $sum += $hash[$i]
}
write-host "Number of fish: $sum"