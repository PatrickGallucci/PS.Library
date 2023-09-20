$ErrorActionPreference = 'Continue'
function Import-PSModule {
    
  param
  (
    [Parameter(Mandatory=$true,HelpMessage='The module to install or load.')]
    [Object]$m
  )
  Write-Verbose -Message ('Importing module {0}' -f $m)
    if (!(Get-Module | Where-Object { $_.Name -eq $m })) {
        # If module is not imported, but available on disk then import
        if (Get-Module -ListAvailable | Where-Object { $_.Name -eq $m }) {
            Import-Module -Name $m -Force
        }
        else {
            # If module is not imported, not available on disk, but is in online gallery then install and import
            if (Find-Module -Name $m | Where-Object { $_.Name -eq $m }) {
                Install-Module -Name $m -Force -Scope CurrentUser -AllowClobber
                Import-Module -Name $m -Force
            }
        }
    }
}
# Show PS Version and date/time
$Path = '\\hchb.local\pdfs\Internal\UserData\Common\DnA\PS\DnA.PS.Repository'

Import-Module -Name PowerShellGet

$repo = @{
    Name = 'PSGallery.HCHB.DnA'
    SourceLocation = $Path
    PublishLocation = $Path
    InstallationPolicy = 'Trusted'
}
Register-PSRepository @repo

Write-Verbose -Message ('PowerShell Version: {0} - ExecutionPolicy: {1}' -f $psversiontable.psversion, (Get-ExecutionPolicy))
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Write-Verbose -Message $profile


if (Test-Path -Path $env:HOMEDRIVE\PLG\PROJECTS\PS) { $PSRoot = "$env:HOMEDRIVE\PLG\PROJECTS\PS" }

# Set Path to PSRoot
Set-Location -Path $PSRoot
Write-Verbose -Message ('Setting PSRoot {0}' -f $PSRoot)

Import-PSModule  -m Pester  

exit

Write-Verbose -Message 'Importing local PS modules'
Import-PSModule  -m ImportExcel 
Import-PSModule  -m PSScriptTools  
Import-PSModule  -m Pester  
Import-PSModule  -m PowerShellNotebook  
Import-PSModule  -m ADSNotebook  
Import-PSModule  -m PSScriptAnalyzer  
Import-PSModule  -m platyPS  
Import-PSModule  -m SHiPS  
Import-PSModule  -m SqlServer  
#Import-PSModule  Az 
Import-PSModule  -m PSLogging  
Import-PSModule  -m AzureAD  
Import-PSModule  -m VSTeam  
Import-PSModule  -m PSRule  
Import-PSModule  -m PSRule.Rules.Azure  
Import-PSModule  -m PSRule.Rules.CAF  
Import-PSModule  -m PSRule.Monitor  
Import-PSModule  -m PSDocs  
Import-PSModule  -m PSDocs.Azure  