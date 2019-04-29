<#
.SYNOPSIS
# Sets a Snipe-it Locations

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Set-SnipeitLocation -id 1 -name Location1 -url "https://assets.example.com" -apiKey "token..."

#>
function Set-SnipeitLocation() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$id,

        [string]$name,

        [string]$address,

        [string]$address2,

        [string]$state,

        [string]$country,

        [string]$zip,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{
        name     = $name
        address  = $address
        address2 = $address2
        state    = $state
        country  = $country
        zip      = $zip
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/locations/$id"
        Method = 'Put'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}