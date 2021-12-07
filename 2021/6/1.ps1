$data = Get-Content "./input.txt"
# $data = "3,4,3,1,2"
$state = [System.Collections.ArrayList][System.Int32[]]$data.Split(",")

for ($day = 0; $day -lt 80; $day++) {
    $newState = [System.Collections.ArrayList]@()
    for ($idx = 0; $idx -lt $state.Count; $idx++) {
        if ($state[$idx] -eq 0) {
            # Add new fish and reset time
            $newState.Add(8) | Out-Null
            $state[$idx] = 6
        }
        else {
            $state[$idx]--
        }
    }
    $state = $state + $newState
    Write-Host "Day $day"
}
write-host "Number of fish: $($state.Count)"