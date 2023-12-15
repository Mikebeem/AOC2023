. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput 

$steps = $inputVal -split ","
$total = 0
foreach($step in $steps){
    $current = 0
    for ($i = 0; $i -lt $step.Length; $i++) {
        $current += [byte][char]$step[$i]
        $current = ($current * 17) % 256
    }
    $total += $current
}
$total

$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)