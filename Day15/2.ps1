. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput 

$steps = $inputVal -split ","
$total = 0
$boxes=@{}
foreach($step in $steps){
    $label = ($step | Select-String '[a-z]+|\=|\-' ).Matches.Value
    $operation = ($step | Select-String '\=|\-' ).Matches.Value
    $focus = ($step | Select-String '\d' ).Matches.Value
    $current = 0
    for ($i = 0; $i -lt $label.Length; $i++) {
        $current += [byte][char]$label[$i]
        $current = ($current * 17) % 256
    }
    if($operation -eq "="){
        if($boxes[$current].Count -gt 0 -and $($boxes[$current].keys).indexOf($label) -ge 0){
            $index = $($boxes[$current].keys).indexOf($label)
            $boxes[$current].Remove($label)
            $boxes[$current].Insert($index, $label, $focus)
        }
        else{
            $boxes[$current] += [ordered]@{
                $label = $focus
            }
        }
        
    }
    elseif($boxes[$current].Count -gt 0){
        $boxes[$current].Remove($label)
    }
   
}
foreach($box in $boxes.Keys){
    $i=1
    foreach($lens in $boxes[$box].Keys){
        $total += ($box+1) * $i * $boxes[$box][$lens]
        $i++
    }
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)