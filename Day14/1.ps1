. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$rocks = 0

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
            $value = ($inputVal.Count - $j)
            if($freeSpaces.Count -gt 0){
                $first, [int[]]$freeSpaces = $freeSpaces
                $value = ($inputVal.Count - $first)
                $freeSpaces += $j
            }
            $rocks += $value
        }
    }
}
$rocks

$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)