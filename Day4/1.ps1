. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput
$total=0
$line = $inputVal[0]
foreach($line in $inputVal){
    $card, $drawn, $myNumbers = $line.Split(":").Split("|")
    $drawn = ($drawn | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value
    $myNumbers = ($myNumbers | Select-String -Pattern "(\d+)" -AllMatches | Select-Object Matches).Matches.Value
    
    $winning = Compare-Object $drawn $myNumbers -ExcludeDifferent
    $score=0
    for ($i = 0; $i -lt $winning.Count; $i++) {
        if($score -le 0){
            $score = 1
        } else{
            $score *= 2
        }
        
    }
    $total += $score
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)