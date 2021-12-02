$input = get-content "input.txt"

$horisontalPosition = 0
$depth = 0
$aim = 0

for ($i = 0; $i -lt $input.Count; $i++) {
    $dataObject = $input[$i].Split(' ')
    $command = $dataObject[0]
    $value = [int]$dataObject[1]

    # Write-Verbose ($dataObject | ConvertTo-Json)

    switch ($command) {
        "forward" {
            $horisontalPosition += $value
            $depth += $aim * $value
            break
        }
        "back" {
            $horisontalPosition -= $value
            break
        }
        "up" {
            $aim -= $value
            break
        }
        "down" {
            $aim += $value
            break
        }
        Default {
            throw "Unknown command: $command"
        }
    }

    # Write-Verbose "Horisontal Position: $horisontalPosition"
    # Write-Verbose "Depth: $depth"
    # Write-Verbose "Aim: $aim"
    # Pause
}
Write-Host ($horisontalPosition*$depth)