# Data ingestion
# [string[]]$data = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
# [string[]]$data = "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
# [string[]]$data = Get-Content "small-input.txt"
[string[]]$data = Get-Content "input.txt"

# Variable creation
$arr = @(
    ("a","b","c","e","f","g"), # 0
    ("c","f"), # 1
    ("a","c","d","e","g"), # 2
    ("a","c","d","f","g"), # 3
    ("b","c","d","f"), # 4
    ("a","b","d","f","g"), # 5
    ("a","b","d","e","f","g"), # 6
    ("a","c","f"), # 7
    ("a","b","c","d","e","f","g"), # 8
    ("a","b","c","d","f","g") # 9
)

$obj = @{}
for ($i = 0; $i -lt $arr.Count; $i++) {
    $obj.Add(
        $i, @{
            NumberOfOccurrences = 0
            NumberOfSegmentsUsed = $arr[$i].Length
        }
    )
}

# Same wire connections are used within the same entry
# Iteration
for ($i = 0; $i -lt $data.Count; $i++) {
    $signalPatterns = $data[$i].split(" | ")[0].Split(" ")
    $outputValues = $data[$i].split(" | ")[1].Split(" ")

    # Iterate over the output values
    for ($j = 0; $j -lt $outputValues.Count; $j++) {
        # If the current output value length matches a wire connection length
        # Add one to its occurrences
        for ($k = 0; $k -lt $arr.Count; $k++) {
            if ($outputValues[$j].Length -eq $obj[$k].NumberOfSegmentsUsed) {
                $obj[$k].NumberOfOccurrences++
            }
        }
    }
}

Write-Verbose ("Sum of occurrences for 1,4,7,8: {0}" -f ($obj[1].NumberOfOccurrences + $obj[4].NumberOfOccurrences + $obj[7].NumberOfOccurrences + $obj[8].NumberOfOccurrences))