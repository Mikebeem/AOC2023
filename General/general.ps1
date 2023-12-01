function ImportInput {
    param (
        [Switch]$Sample
    )
    if($Sample){
        return (Get-Content .\sample.txt)
    }
    else{
        return (Get-Content .\input.txt)
    }
}