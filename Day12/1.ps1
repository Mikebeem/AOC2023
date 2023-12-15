. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput -Sample
$global:total=0
function Generate-Combinations {
    param (
        [Parameter(Mandatory=$true)]
        [string] $str,
        [Parameter(Mandatory=$true)]
        [int[]] $groupLengths,
        $totalDamaged
    )
    # Base case: If there are no more placeholders, check if the string is valid
    if ($str -notmatch '\?') {
        $groups = ($str | Select-String -Pattern "#+" -AllMatches | Select-Object Matches).Matches

        if($groupLengths.Count -eq $groups.Count){
            $i = ($groupLengths.Count-1)
            while($groups[$i].Length -eq $groupLengths[$i]){
                if($i -eq 0){
                    $global:total++
                    return
                }
                $i--
            }
        }
        return
    }

    foreach ($char in '.', '#') {
        [regex]$pattern = "\?"
        $break = $false
        $newStr = $pattern.replace($str, $char, 1)
        $maxDamaged = ($pattern.replace($newStr, "#").ToCharArray() | Where-Object {$_ -eq '#'} | Measure-Object).Count
        $currentDamaged = ($newStr.ToCharArray() | Where-Object {$_ -eq '#'} | Measure-Object).Count
        $newSubstr = $newStr.Substring(0,$($newStr.Length - ($totalDamaged - $groupLengths[0])))

        if($newSubstr -notmatch "\?"){
            $firstDamage = (($newSubstr -split "\.") -ne '')[0]
            if($firstDamage.Length -ne $groupLengths[0]){
                $break = $true
            }
        }
        if($maxDamaged -ge $totalDamaged -and $currentDamaged -le $totalDamaged -and $break -eq $false){
            Generate-Combinations $newStr $groupLengths $totalDamaged
        }
    }
}
$lines=0
foreach($line in $inputVal){
    $lines++
    $springs, $groupLengths = $line.Split(" ").Split(",")
    $totalDamaged = ($groupLengths | Measure-Object -Sum).Sum
    
    $before = $total
    Generate-Combinations $springs $groupLengths $totalDamaged
    $after = $total - $before
    $after
    if($lines % 20 -eq 0)
    {"Line: $lines - Arrangements: $total - Seconds: $($Stopwatch.Elapsed.TotalSeconds)"}
}
$total
#7007
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)