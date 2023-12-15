. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput 

function north ($inputVal) {
    $rocks = 0
    $outputVal = @() + $inputVal
    for ($i = 0; $i -lt $inputVal[0].Length; $i++) {
        [int[]]$freeSpaces = @()
        
        for ($j = 0; $j -lt $inputVal.Count; $j++) {
            $line = $inputVal[$j]
            if($line[$i] -eq "#"){
                [int[]]$freeSpaces = @()
            }
            elseif ($line[$i] -eq "."){
                $freeSpaces += $j
            } else{
                if($freeSpaces.Count -gt 0){
                    $first, [int[]]$freeSpaces = $freeSpaces
                    $value = ($inputVal.Count - $first)
                    $freeSpaces += $j
                    $outputVal[$first] = $outputVal[$first].remove($i,1).insert($i,"O")
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,".")
                } else{
                    $value = ($inputVal.Count - $j)
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,"O")
                }
                $rocks += $value
            }
        }
    }
    return $outputVal
}

function south ($inputVal){
    $rocks = 0
    $outputVal = @() + $inputVal
    for ($i = 0; $i -lt $inputVal[0].Length; $i++) {
        [int[]]$freeSpaces = @()
        
        for ($j = ($inputVal.Count-1); $j -ge 0; $j--) {
            $line = $inputVal[$j]
            if($line[$i] -eq "#"){
                [int[]]$freeSpaces = @()
            }
            elseif ($line[$i] -eq "."){
                $freeSpaces += $j
            } else{
                if($freeSpaces.Count -gt 0){
                    $first, [int[]]$freeSpaces = $freeSpaces
                    $value = ($inputVal.Count - $first)
                    $freeSpaces += $j
                    $outputVal[$first] = $outputVal[$first].remove($i,1).insert($i,"O")
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,".")
                } else{
                    $value = ($inputVal.Count - $j)
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,"O")
                }
                $rocks += $value
            }
        }
    }
    return $outputVal
}

function west ($inputVal) {
    $outputVal = @() + $inputVal
    $rocks = 0
    for ($j = 0; $j -lt $inputVal.Count; $j++) {
    
        [int[]]$freeSpaces = @()
        
        for ($i = 0; $i -lt $inputVal[0].Length; $i++) {
            $line = $inputVal[$j]
            if($line[$i] -eq "#"){
                [int[]]$freeSpaces = @()
            }
            elseif ($line[$i] -eq "."){
                $freeSpaces += $i
            } else{
                if($freeSpaces.Count -gt 0){
                    $first, [int[]]$freeSpaces = $freeSpaces
                    $value = ($inputVal.Count - $first)
                    $freeSpaces += $i
                    $outputVal[$j] = $outputVal[$j].remove($first,1).insert($first,"O")
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,".")
                } else{
                    $value = ($inputVal.Count - $j)
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,"O")
                }
                $rocks += $value
            }
        }
    }
    return $outputVal
}
function east ($inputVal) {
    $outputVal = @() + $inputVal
    $rocks = 0
    for ($j = 0; $j -lt $inputVal.Count; $j++) {
        [int[]]$freeSpaces = @()
        
        for ($i = ($inputVal[0].Length-1); $i -ge 0; $i--) {
            $line = $inputVal[$j]
            if($line[$i] -eq "#"){
                [int[]]$freeSpaces = @()
            }
            elseif ($line[$i] -eq "."){
                $freeSpaces += $i
            } else{
                if($freeSpaces.Count -gt 0){
                    $first, [int[]]$freeSpaces = $freeSpaces
                    $value = ($inputVal.Count - $first)
                    $freeSpaces += $i
                    $outputVal[$j] = $outputVal[$j].remove($first,1).insert($first,"O")
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,".")
                } else{
                    $value = ($inputVal.Count - $j)
                    $outputVal[$j] = $outputVal[$j].remove($i,1).insert($i,"O")
                }
                $rocks += $value
            }
        }
    }
    return $outputVal
}

function calcLoad ($beams) {
    $rocks=0
    for ($j = 0; $j -lt $beams.Count; $j++) {
        for ($i = 0; $i -lt $beams[0].Length; $i++) {
            $line = $beams[$j]
            if($line[$i] -eq "O"){
                $rocks += ($beams.Count - $j)
            }
        }
    }
    return $rocks
}

$eastVal=@() + $inputVal
$testoutput = @{}

for ($i = 1; $i -lt 150; $i++) {
    $nortVal = north $eastVal
    $westVal = west $nortVal
    $southVal = south $westVal
    $eastVal = east $southVal
    $testoutput[$i] = calcLoad $eastVal 
}
$double = $testoutput.GetEnumerator() | Group-Object Value | ? { $_.Count -gt 1 } | sort Count
$rest = (1000000000 - $double[0].Group[-1].Name) % ($double[0].Group[-2].Name - $double[0].Group[-1].Name)
$testoutput[$double[0].Group[-1].Name + $rest]

$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)