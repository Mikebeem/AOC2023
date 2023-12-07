. ..\General\general.ps1
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$inputVal = ImportInput

$values = @{
    "A" = 14
    "K" = 13
    "Q" = 12
    "J" = 1
    "T" = 10
    "9" = 9
    "8" = 8
    "7" = 7
    "6" = 6
    "5" = 5
    "4" = 4
    "3" = 3
    "2" = 2
}

$strengthArray = @()
for ($i = 0; $i -lt $inputVal.Count; $i++) {
    $hand = $inputVal[$i]
    $cards, [int]$bid = $hand.Split(" ")

    $cardArray = $cards.ToCharArray() | ForEach-Object {[int]$values[[string]$_]}
    $cardCount = ($cardArray | Group-Object | Sort-Object Count -Descending)
    $jokers = ($cardCount | Where-Object {$_.Name -eq 1}).Count
    $index=0
    if($cardCount[0].Name -eq 1 -and $jokers -ne 5){
        $index=1
    }elseif($jokers -eq 5){
        $jokers = 0
    }

    if($cardCount[$index].Count + $jokers -eq 5){ #Five of a kind
        $type = 7
    } elseif($cardCount[$index].Count + $jokers -eq 4) { #Four of a kind
        $type = 6
    } elseif($cardCount[$index].Count + $jokers -eq 3 -and $cardCount[$index+1].Count -eq 2 ) { #Full house
        $type = 5
    } elseif($cardCount[$index].Count + $jokers -eq 3 -and $cardCount[$index+1].Count -eq 1 ) { #Three of a kind
        $type = 4
    } elseif($cardCount[$index].Count -eq 2 -and $cardCount[$index+1].Count -eq 2 ) { #Two pair
        $type = 3
    } elseif($cardCount[$index].Count + $jokers -eq 2) { #One pair
        $type = 2
    } else{ #High card
        $type = 1
    }
    $strengthArray += @{
        type = [int]$type
        first = [int]$cardArray[0]
        second = [int]$cardArray[1]
        thirth= [int]$cardArray[2]
        fourth = [int]$cardArray[3]
        fifth = [int]$cardArray[4]
        bid = $bid
        hand = $cards
    }
}
$rank=1
$total=0
$strengthArray | Sort-Object type,first,second,thirth,fourth,fifth | ForEach-Object{
    $total += $rank * $_.bid
    $rank++
}
$total
#246894760
$stopwatch.Stop()
write-host ("That took {0} Seconds. It took {1} in Milliseconds" -f $Stopwatch.Elapsed.TotalSeconds, $Stopwatch.Elapsed.TotalMilliseconds)