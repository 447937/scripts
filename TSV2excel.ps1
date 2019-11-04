#TSV2excel
#Extremely slow for large files, more effective is to use LibreOffice from command line - just UTFG!
#TLDR Not really effective, but very spectacular :)

$itemInfo = "Source TSV File"
$wFol = "WORK FOLDER aka CACHE"
mkdir $wFol

$XL = New-Object -comobject Excel.Application   #vytvori excel
$XL.Visible = $True                             #zobrazi okno - pozdeji jde smazat, ale je je to efektni
$WB = $XL.Workbooks.Add()                       #dělá magii
$WS = $WB.Worksheets.Item(1)                    #dělá magii


$pRadku = Get-Content -Path $itemInfo                               #pocet radku jako $pRadku.Count

function Zapis-Radek {
    $Inow = Get-Content -Path "$wFol\$pocitadlo" -Delimiter "`t"
    $pItem = Get-Content -Path "$wFol\$pocitadlo"
    $ipocitadlo = 1
    if ( $ipocitadlo -le $pItem.Count ) {
        foreach($i in $Inow)
        {
            $WS.cells.item($pocitadlo,$ipocitadlo) = Get-Content -Path $wFol\$pocitadlo -Delimiter "`t" | Select-Object -Index $($ipocitadlo-1) | Out-String
            $WS.columns.autofit()
            $ipocitadlo++
        }
    }
}

$pocitadlo=1
while($pocitadlo -le $pRadku.Count) {
    $Rnow=Get-Content -Path $itemInfo | Select-Object -Index $($pocitadlo-1) | Out-String
    $Rnow > "$wFol\$pocitadlo"
    Zapis-Radek    
    $pocitadlo++
}

rmdir $wFol
