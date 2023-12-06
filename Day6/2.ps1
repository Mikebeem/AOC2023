. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

[decimal]$time = ($inputVal[0] | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value -join ""
[decimal]$distance = ($inputVal[1] | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value -join ""

[decimal]$total=0
for ($button = 0; $button -lt $time; $button++) {
    $remaining = $time - $button
    $myDistance = $remaining * $button
    if($myDistance -gt $distance){
        $total++
    }
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)