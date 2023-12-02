. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$total=0
foreach($line in $inputVal){
    $sets = $line.Split(":")[1].Trim().Split(";").Trim()
    $colors = @{
        "red" = 0
        "green" = 0
        "blue" = 0
    }
    $power = 1
    foreach($set in $sets){
        $colorsInSet = ($set | Select-String -Pattern "(\d+)\s(\w+)" -AllMatches | Select-Object Matches).Matches
        foreach($colorInSet in $colorsInSet.Value){
            [int]$number, $color = $colorInSet.Split()
            if($number -gt $colors[$color]){
                $colors[$color] = $number
            }
        }
    }
    foreach($value in $colors.Values){
        $power = $power * $value
    }
    $total += $power
}
$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)