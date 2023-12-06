. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = (ImportInput -Raw) -split '(?:\r?\n){2,}'

$null, [bigint[]]$seeds = $inputVal[0].Split(" ")

function getDestination ($list, $sourceVal) {
    $destVal = $sourceVal
    foreach($line in $list){
        [bigint]$destination, [bigint]$source, [bigint]$length = $line.Split(" ")
        if($sourceVal -ge $source -and $sourceVal -le ($source+$length)){
            $destVal = $sourceVal+($destination-$source)
            break
        }
    }
    return $destVal
}

$LocationsList = @()
foreach($seed in $seeds){
    $destVal = $seed
    foreach($inputList in $inputVal){
        $null, $list = $inputList -split '\n'
        $destVal = getDestination $list $destVal
        
    }
    $LocationsList += $destVal
}

($LocationsList | Measure-Object -Minimum).Minimum

$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)