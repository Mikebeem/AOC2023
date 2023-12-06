. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = (ImportInput -Raw) -split '(?:\r?\n){2,}'

$null, [Int64[]]$seeds = $inputVal[0].Split(" ")
$pairs = ($inputVal[0] | Select-String "(\d+)\s(\d+)" -AllMatches | Select-Object Matches).Matches.Value

$pairHash = [System.Collections.SortedList] $pairHash
foreach($pair in $pairs){
    $pairHash[[Int64]$pair.Split(" ")[0]] = [Int64]$pair.Split(" ")[1]
}
function getDestination ($list, $sourceVal) {
    $destVal = $sourceVal
    foreach($line in $list){
        [Int64]$destination, [Int64]$source, [Int64]$length = $line.Split(" ")
        if($sourceVal -ge $source -and $sourceVal -le ($source+$length)){
            $destVal = $sourceVal+($destination-$source)
            break
        }
    }
    return $destVal
}
function drillDown ([int]$lowestSeed, $range, $stepSize) {
    [Int64]$lowestLocation = [Int64]::MaxValue
    for ([Int64]$seed = ($lowestSeed-$range); $seed -lt ($lowestSeed + $range); $seed+=$stepSize) {
        $destVal = $seed
        foreach($inputList in $inputVal){
            $null, $list = $inputList -split '\n'
            $destVal = getDestination $list $destVal
        }
        
        if($lowestLocation -gt $destVal){
            $lowestLocation = $destVal
            $lowestSeedLocation = @($seed,$destVal)
        }
    }
    return $lowestSeedLocation 
}

[Int64]$lowestLocation = [Int64]::MaxValue
foreach($pair in $pairHash.Keys){
    [Int64]$firstSeed = $pair
    [Int64]$lastSeed = $pair + $pairHash[$pair]-1

    # Grote stappen snel thuis
    for ([Int64]$seed = $firstSeed; $seed -lt $lastSeed; $seed+=[Math]::Floor(($lastSeed-$firstSeed)/1000)) {
        $destVal = $seed
        foreach($inputList in $inputVal){
            $null, $list = $inputList -split '\n'
            $destVal = getDestination $list $destVal
        }
        
        if($lowestLocation -gt $destVal){
            $lowestLocation = $destVal
            $lowestSeed = $seed
        }
    }
}

$lowestSeedLocation = drillDown $lowestSeed 100000 100
$lowestSeedLocation = drillDown $lowestSeedLocation[0] 1000 10
$lowestSeedLocation = drillDown $lowestSeedLocation[0] 100 1
$lowestSeedLocation[1]
#78775051
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)