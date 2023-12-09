. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput
function getDifs ($sequence){
    $differences = @()
    for ($i = 1; $i -lt $sequence.Count; $i++) {
        $difference = $sequence[$i] - $sequence[$i-1]
        $differences += $difference
    }
    return $differences
}
[int[]]$extrapolated = @()
foreach($line in $inputVal){
    [int[]]$sequence = $line.Split(" ")
    $difference = getDifs $sequence
    $lastDifference = @()
    while($difference.Count -ne ($difference | Where-Object {$_ -eq 0}).Count){
        $lastDifference += $difference[-1]
        $difference = getDifs $difference
    }
    $extrapolated += ($sequence[-1] + ($lastDifference | Measure-Object -Sum).Sum)
}

($extrapolated | Measure-Object -Sum).Sum
#1647269739
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)