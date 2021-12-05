$data = get-content ".\input.txt"

# Instantiate variables for columns
$NoOfRows = $data.Count
Write-Verbose "Number of rows: $NoOfRows"
$NoOfColumns = $data[0].Length
Write-Verbose "Number of columns: $NoOfColumns"
for ($i = 0; $i -lt $NoOfColumns; $i++) {
    $varName = "NoOfZeros$i"
    if (Get-Variable $varName -ErrorAction "SilentlyContinue") {
        Set-Variable $varName 0
    }
    else {
        New-Variable $varName 0
    }

    $varName = "NoOfOnes$i"
    if (Get-Variable $varName -ErrorAction "SilentlyContinue") {
        Set-Variable $varName 0
    }
    else {
        New-Variable $varName 0
    }
}

# Loop each row in the file
for ($i = 0; $i -lt $NoOfRows; $i++) {
    # Loop each cell in the row
    for ($j = 0; $j -lt $NoOfColumns; $j++) {
        $zeroVar = (Get-Variable "NoOfZeros$j").Value
        $OneVar = (Get-Variable "NoOfOnes$j").Value

        if ($data[$i][$j] -eq "0") {
            Set-Variable -Name "NoOfZeros$j" -Value ($zeroVar + 1)
        } else {
            Set-Variable -Name "NoOfOnes$j" -Value ($OneVar + 1)
        }
    }
}

# Calculate
$epsilonNumber = ""
$gammaNumber = ""
for ($i = 0; $i -lt $NoOfColumns; $i++) {
    if ((Get-Variable "NoOfZeros$i").Value -gt (Get-Variable "NoOfOnes$i").Value) {
        Write-Verbose "Column $i has more zeros than ones"
        $gammaNumber = "$gammaNumber" + "0"
        $epsilonNumber = "$epsilonNumber" + "1"
    } else {
        Write-Verbose "Column $i has more ones than zeros"
        $gammaNumber = "$gammaNumber" + "1"
        $epsilonNumber = "$epsilonNumber" + "0"
    }
}

Write-Verbose "Epsilon number: $epsilonNumber"
Write-Verbose "Gamma number: $gammaNumber"
Write-Verbose ("Power Consumption: {0}" -f ([convert]::ToInt32($epsilonNumber,2) * [convert]::ToInt32($gammaNumber,2)))