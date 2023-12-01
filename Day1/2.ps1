. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput
$hashNmbrs = @{
    'one' = 1
    'two' = 2
    'three' = 3
    'four' = 4
    'five' = 5 
    'six'= 6
    'seven'= 7
    'eight'= 8
    'nine'= 9
}
$total=0

foreach($line in $inputVal){
    $last = $first = ""
    for ($i = 3; $i -le $line.Length; $i++) {
        if($null -ne ($hashNmbrs.Keys | ? { $line.Substring(0,$i) -match $_ })){
            $first = $Matches.Values[0]
            break
        }
    }
    for ($i = $line.Length-3; $i -ge 0; $i--) {
        if($null -ne ($hashNmbrs.Keys | ? { $line.Substring($i) -match $_ })){
            $last = $Matches.Values[0]
            break
        }
    }
    $regex = [regex]::new("\d")
    $matches = [regex]::Matches(($line -replace $first,$hashNmbrs[$first]), $regex)
    $first = $matches[0].Value
    $matches = [regex]::Matches(($line -replace $last,$hashNmbrs[$last]), $regex)
    $last = $matches[-1].Value
    [bigint] $total += "$first$last"
}

$total
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)