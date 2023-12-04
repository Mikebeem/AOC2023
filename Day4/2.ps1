. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput
$cardArray = @()
for ($i = 0; $i -lt $inputVal.Count; $i++) {
    $cardArray += 1
}

foreach($line in $inputVal){
    $card, $drawn, $myNumbers = $line.Split(":").Split("|")
    $drawn = ($drawn | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value
    $myNumbers = ($myNumbers | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value
    [int]$cardId = ($card | Select-String -Pattern "(\d+)" | Select-Object Matches).Matches.Value
    
    $winning = (Compare-Object $drawn $myNumbers -ExcludeDifferent).Count
    for ($i = $cardId; $i -lt ($cardId+$winning); $i++) {
        if($cardArray[$i]){
            $cardArray[$i] += $cardArray[($cardId-1)]
        }
    }
}
($cardArray | Measure-Object -Sum).Sum
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)