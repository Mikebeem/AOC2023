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
    $firstDifference = @()
    $previous = @()
    while($difference.Count -ne ($difference | Where-Object {$_ -eq 0}).Count){
        $firstDifference += $difference[0]
        $difference = getDifs $difference
    }
    for ($j = ($firstDifference.Count - 1); $j -ge 0; $j--) {
        $previous += $firstDifference[$j] - $previous[-1]
    }
    $extrapolated += ($sequence[0] - $previous[-1])
}

($extrapolated | Measure-Object -Sum).Sum
#864
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)