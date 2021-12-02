$input = get-content "input.txt"

$horisontalPosition = 0
$depth = 0

for ($i = 0; $i -lt $input.Count; $i++) {
    $dataObject = $input[$i].Split(' ')
    $command = $dataObject[0]
    $value = [int]$dataObject[1]

    switch ($command) {
        "forward" {
            $horisontalPosition += $value
            break
        }
        "back" {
            $horisontalPosition -= $value
            break
        }
        "up" {
            $depth -= $value
            break
        }
        "down" {
            $depth += $value
            break
        }
        Default {
            throw "Unknown command: $command"
        }
    }
}
Write-Host ($horisontalPosition*$depth)