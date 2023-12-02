. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$colors = @{
            "red" = 12
            "green" = 13
            "blue" = 14
        }

$total=0
foreach($line in $inputVal){
    $numbers = ($line | Select-String -Pattern "\d+" | Select-Object Matches).Matches
    $gameId = $numbers[0].Value
    $sets = $line.Split(":")[1].Trim().Split(";").Trim()
    $valid = $false
    foreach($set in $sets){
        $colorsInSet = ($set | Select-String -Pattern "(\d+)\s(\w+)" -AllMatches | Select-Object Matches).Matches
        foreach($colorInSet in $colorsInSet.Value){
            [int]$number, $color = $colorInSet.Split()
            if($number -gt $colors[$color]){
                $valid = $false
                break
            }
            else{
                $valid = $true
            }
        }
        if(-not $valid){
            break
        }   
    }
    if($valid){
        $total += $gameId
    }
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)