 . ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$total=0
for ($i = 0; $i -lt $inputVal.Count; $i++) {
    $line = $inputVal[$i]
    $symbols = $null
    $symbolRegex = "[$((($inputVal -replace '\d' -replace '\.').ToCharArray() | Sort-Object -Unique) -join '\')]"

    if($i -ne 0){
        $symbols += ($inputVal[$i-1] | Select-String -Pattern $symbolRegex -AllMatches | Select-Object Matches).Matches
    }
    if($i -ne ($inputVal.Count-1)){
        $symbols += ($inputVal[$i+1] | Select-String -Pattern $symbolRegex -AllMatches | Select-Object Matches).Matches
    }
    $symbols += ($inputVal[$i] | Select-String -Pattern $symbolRegex -AllMatches | Select-Object Matches).Matches
    $numbers = ($line | Select-String -Pattern "\d+" -AllMatches | Select-Object Matches).Matches

    foreach($number in $numbers){
        if(($symbols | Where-Object {$_.index -le ([math]::Min(($number.Index + $number.Length),($line.Length-1))) -and ($_.index -ge [math]::Max(0,($number.Index - 1)))}).Count -gt 0){
            $total += $number.Value
        } 
    }
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)