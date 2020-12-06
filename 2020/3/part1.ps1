[CmdletBinding()]
param (
    [string[]]$orgData = $(Get-Content "C:\Users\rre\source\repos\ReneRebsdorf\AdventOfCode\2020\3\input.txt"),
    [int]$xSteps = 3,
    [int]$ySteps = 1
)

$OuchATree = 0

function New-Pattern {
    param (
        [Parameter(Mandatory=$true)][string[]]$orgData,
        [Parameter(Mandatory=$false)][string[]]$existingData
    )
    $multipliedData = @()
    for ($i = 0; $i -lt $orgData.Count; $i++) {
        $newData = $orgData[$i]
        if ($existingData) {
            $newData = $existingData[$i]+$newData
        }
        $multipliedData += $newData
    }
    return $multipliedData
}

$data = New-Pattern -orgData $orgData
$xPos = 0
$yPos = 0
$currPos = $data[$xPos][$yPos]

while ($data[$yPos] -ne $data[-1]) {
    Write-Verbose "We haven't reached the bottom yet"
    $xPos += $xSteps
    $yPos += $ySteps
    while ($xPos -gt ($data[0].Length-$xSteps)) {
        Write-Verbose "The next step would cause out of bounds. Increasing map size"
        $data = New-Pattern -orgData $orgData -existingData $data
    }
    $currPos = $data[$yPos][$xPos]
    try {
        if ($currPos -eq '#') {
            Write-Verbose "We hit a tree!"
            $data[$yPos] = $data[$yPos].Remove($xPos,1).Insert($xPos,'X')
            $OuchATree++
        } else {
            Write-Verbose "We didn't hit a tree!"
            $data[$yPos] = $data[$yPos].Remove($xPos,1).Insert($xPos,'O')
        }
    }
    catch {
        Write-Error "Error Occured"
        Write-Error "yPos: $yPos"
        Write-Error "xPos: $xPos"
        Write-Error "currPos: $currPos"
    }
}

Write-Host "Number of tree reparations to be perform: $OuchATree"
return $OuchATree