. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput
$total=0

foreach($line in $inputVal){
    $regex = [regex]::new("\d")
    $matches = [regex]::Matches($line, $regex)
    $first = $matches[0].Value
    $last = $matches[-1].Value
    [bigint] $total += "$first$last"
}

$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)