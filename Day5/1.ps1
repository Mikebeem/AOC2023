. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = (ImportInput -Raw) -split '(?:\r?\n){2,}'

$null, [bigint[]]$seeds = $inputVal[0].Split(" ")

function getDestination ($list, $sourceVal) {
    #$sourceVal = 53
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
    #$destval = 14
    foreach($inputList in $inputVal){
        $null, $list = $inputList -split '\n'
        $destVal = getDestination $list $destVal
        
    }
    $LocationsList += $destVal
}

($LocationsList | Measure-Object -Minimum).Minimum

# $soilFert = $inputVal[2]
# $fertWater = $inputList = $inputVal[3]
# $waterLight = $inputVal[4]
# $lightTemp = $inputVal[5]
# $tempHum = $inputVal[6]
# $humLocation = $inputVal[7]
# $inputVal[8]


# foreach($part in $inpuVal){
#     $lines = ($part -split '\n')
#     foreach($line in $lines){
#         if($line.StartsWith('seeds')){
            
#         }
#         elseif($line.StartsWith('seed')){

#         }
#     }
    
# }


$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)