. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$times = ($inputVal[0] | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value
$distances = ($inputVal[1] | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value
$total=1

for ($i = 0; $i -lt $times.Count; $i++) {
    $waysToWin = 0
    $time = $times[$i]
    $distance = $distances[$i]
    for ($button = 0; $button -lt $times[$i]; $button++) {
        $remaining = $time - $button
        $myDistance = $remaining * $button
        if($myDistance -gt $distance){
            $waysToWin++
        }
    }

    if($waysToWin -ne 0){
        $total = $total * $waysToWin
    }
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)