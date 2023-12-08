. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$instructions = $inputVal[0].ToCharArray()

$elements = [System.Collections.SortedList] @{}
for ($i = 2; $i -lt $inputVal.Count; $i++) {
    $element, $destLeft, $destRight = ($inputVal[$i] | Select-String -Pattern "(\w+)" -AllMatches | Select-Object Matches).Matches.Value
    $elements[$element] = $($destLeft, $destRight)

}
$current = "AAA"
$counter=0
for ($i = 0; $i -lt $instructions.Count; $i++) {
    $instruction = $instructions[$i]

    if($instruction -eq "L"){
        $next = $elements[$current][0]
    }
    if($instruction -eq "R"){
        $next = $elements[$current][1]
    }
    $current = $next
    $counter++
    if($next -eq "ZZZ"){
        $counter
        break
    }
    if($i -eq ($instructions.Count - 1)){
        $i=-1
    }
}

$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)