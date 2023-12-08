function ImportInput{
    param (
        [Switch]$Sample,
        [Switch]$Raw
    )
    if($Sample){
        if($Raw){
            return (Get-Content .\sample.txt -Raw)
        }
        return (Get-Content .\sample.txt)
    }
    else{
        if($Raw){
            return (Get-Content .\input.txt -Raw)
        }
        return (Get-Content .\input.txt)
    }
}

function gcd ($a, $b) {
    while ($b -ne 0) {
      $temp = $a
      $a = $b
      $b = $temp % $b
    }
    return $a
}

function lcm ($a, $b) {
    return $a * $b / (gcd $a $b)
}

function lcmm ($numbers) {
    $result = $numbers[0]
    for ($i = 1; $i -lt $numbers.Length; $i++) {
        $result = lcm $result $numbers[$i]
    }
    return $result
}