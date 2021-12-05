[string[]]$data = get-content ".\input.txt"


# Oxygen Generator
$oxygenData = $data
$i = 0
while ($oxygenData.Count -gt 1) {
    $dataStartingWith0 = @()
    $dataStartingWith1 = @()

    for ($j = 0; $j -lt $oxygenData.Count; $j++) {
        if ($oxygenData[$j][$i] -eq "0") {
            $dataStartingWith0 += $oxygenData[$j]
        } else {
            $dataStartingWith1 += $oxygenData[$j]
        }
    }

    # Proceed with most common data for next iteration
    # In case of tie, the Ones win
    if ($dataStartingWith1.Count -ge $dataStartingWith0.count) {
        $oxygenData = $dataStartingWith1
    } else {
        $oxygenData = $dataStartingWith0
    }
    $i++
}
$OxygenGeneratorRating = $oxygenData
write-host "Oxygen Generator Rating: $OxygenGeneratorRating"

# CO2 Scrubber
$scrubberData = $data
$i = 0
while ($scrubberData.Count -gt 1) {
    $dataStartingWith0 = @()
    $dataStartingWith1 = @()

    for ($j = 0; $j -lt $scrubberData.Count; $j++) {
        if ($scrubberData[$j][$i] -eq "0") {
            $dataStartingWith0 += $scrubberData[$j]
        } else {
            $dataStartingWith1 += $scrubberData[$j]
        }
    }

    # Proceed with least common data for next iteration
    # In case of tie, the Zeros win
    if ($dataStartingWith0.Count -le $dataStartingWith1.count) {
        $scrubberData = $dataStartingWith0
    } else {
        $scrubberData = $dataStartingWith1
    }
    $i++
}
$ScrubberRating = $scrubberData
write-host "CO2 Scrubber rating: $ScrubberRating"

write-host ("life support rating: {0}" -f  ([convert]::ToInt32($oxygenData,2) * [convert]::ToInt32($scrubberData,2)))