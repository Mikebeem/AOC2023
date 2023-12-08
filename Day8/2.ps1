. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$instructions = $inputVal[0].ToCharArray()

$elements = [System.Collections.SortedList] @{}
$currents = @{}
$ends = @{}
$keys=@()
for ($i = 2; $i -lt $inputVal.Count; $i++) {
    $element, $destLeft, $destRight = ($inputVal[$i] | Select-String -Pattern "(\w+)" -AllMatches | Select-Object Matches).Matches.Value
    $elements[$element] = $($destLeft, $destRight)
    if($element -match 'A$'){
        $currents[$element] = $element
        $keys += $element
    }
}
$counter=0

for ($i = 0; $i -lt $instructions.Count; $i++) {
    $instruction = $instructions[$i]
    $currentCounter=0
    foreach($current in $keys){
        $currentVal = $currents[$current]
        if($instruction -eq "L"){
            $currents[$current] = $elements[$currentVal][0]
            if($currents[$current] -match 'Z$'){
                $currentCounter++
                $ends[$current] = $counter+1
            }
        }
        if($instruction -eq "R"){
            $currents[$current] = $elements[$currentVal][1]
            if($currents[$current] -match 'Z$'){
                $currentCounter++
                $ends[$current] = $counter+1
            }
        }
    }
    if($ends.Count -eq $currents.Count){
        [int[]]$values=($ends.Values -join ', ').Split(",")
        lcmm $values
        break
    }
    $counter++
    if($i -eq ($instructions.Count - 1)){
        $i=-1
    }
}

#14631604759649

$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)