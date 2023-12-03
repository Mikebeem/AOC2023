 . ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$symbHash = @{}
$total=0
for ($i = 0; $i -lt $inputVal.Count; $i++) {
    $line = $inputVal[$i]
    $symbols = $numbers = $null
    $symbols = ($inputVal[$i] | Select-String -Pattern "\*" -AllMatches | Select-Object Matches).Matches

    if($i -ne 0){
        $numbers += ($inputVal[$i-1] | Select-String -Pattern "\d+" -AllMatches | Select-Object Matches).Matches
    }
    if($i -ne ($inputVal.Count-1)){
        $numbers += ($inputVal[$i+1] | Select-String -Pattern "\d+" -AllMatches | Select-Object Matches).Matches
    }
    $numbers += ($inputVal[$i] | Select-String -Pattern "\d+" -AllMatches | Select-Object Matches).Matches
    
    foreach($number in $numbers){
        $index = $null
        $index = ($symbols | Where-Object {$_.index -le ([math]::Min(($number.Index + $number.Length),($line.Length-1))) -and ($_.index -ge [math]::Max(0,($number.Index - 1)))}).Index
        if($index){
            
            if($symbHash["$($i)-$($index)"]){
                $total+= [int]$symbHash["$($i)-$($index)"] * $number.Value
            } else{
                $symbHash["$($i)-$($index)"] = $number.Value
            }
        } 
    }
}

$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)