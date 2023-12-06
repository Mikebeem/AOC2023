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