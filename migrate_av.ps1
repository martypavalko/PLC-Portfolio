class Product {
    [string]$displayName
    [string]$uninstallString
    [string]$guid
    [string]$version
}

function ProductExists() {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$publisher
    )
    $productArray = @()
    $proudcts = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where-Object { $_.Publisher -like "*$publisher*" } | Select-Object DisplayName,UninstallString,DisplayVersion,Version,PSChildName
    if (($proudcts | Measure-Object).Count -eq 0) {
        return $false, $null
    }
    else {
        foreach ($product in $products) {
            $p = [Product]::new()
            $p.displayName = $product.DisplayName
            $p.guid = $product.PSChildName
            $p.uninstallString = $proudct.UninstallString
            $p.version = $product.DisplayVersion
            $productArray.Add($p)
        }

        return $true, $productArray
    }
}

function Uninstall() {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Product[]]$productArray,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty]
        [string[]]$publishers,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty]
        [string]$login,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty]
        [string]$passwd
    )

    foreach ($product in $productArray) {
        if ($product.displayName -in $publishers) {
            Start-Process -FilePath msiexec.exe -ArgumentList @( '/X ' + $product.guid, '/qn', "KLLOGIN='$login'", "KLPASSWD='$passwd'") -Wait
        }
        if ($product.displayName -in $publishers) {
            Start-Process -FilePath msiexec.exe -ArgumentList @( '/X ' + $product.guid, '/qn') -Wait
        }
    }

}

function isLaptop() {
    $ChassisType = (Get-CimInstance -ClassName Win32_SystemEnclosure).ChassisTypes
    if ($ChassisType -eq 9 -or $ChassisType -eq 10 -or $ChassisType -eq 14) {
        return $true
    } else {
        return $false
    }

}

function Install() {
    Start-Process -FilePath "$currentDir\{{EXECUTABLE}}" -ArgumentList @( '--quiet',  '--products="{{PRODUCTS}}"', '--group="{{GROUP}}"')
    Start-Process -FilePath "$currentDir\{{EXECUTABLE}}" -ArgumentList @( '--quiet',  '--products="{{PRODUCTS}}"', '--group="{{GROUP}}"')
    Start-Process -FilePath "C:\Program Files\{{AV}}\{{EXECUTABLE" -ArgumentList "/AUTO"
}

function Log() {

}

function main() {
    $product1Exists, $product1Products = ProductExists -publisher "{{PUBLISHER}}"
    if (!($product1Exists)) {
        return
    }
    
    $product2Exists, $product2Products = ProductExists -publisher "{{PUBLISHER}}"
    if (!($product2Exists)) {
        Install
    } else {
        Uninstall
        Install
    }
}

main