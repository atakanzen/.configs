# Setting Up Prompt

Import-Module Terminal-Icons

function prompt {


    $CurrentFolder = Split-Path -Path $pwd -Leaf
    $UserName = [Security.Principal.WindowsIdentity]::GetCurrent().Name.split("\")[1];
    if ($UserName -eq "az852913") {
        $CurrentUser = "atakan"
    } else {
        $CurrentUser = $UserName
    }

    $Date = Get-Date -Format 'dddd hh:mm:ss tt'

    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    
    Write-host ($(if ($IsAdmin) { ' 聯 ' } else { '  ' })) -BackgroundColor DarkRed -ForegroundColor White -NoNewline
    Write-Host " $($CurrentUser) " -BackgroundColor Blue -ForegroundColor White -NoNewline
    If ($CurrentFolder -like "*:*")
        {Write-Host " $CurrentFolder "  -ForegroundColor White -BackgroundColor DarkRed -NoNewline}
        else {Write-Host " .\$CurrentFolder\ "  -ForegroundColor White -BackgroundColor DarkRed -NoNewline}

    Write-Host "  $date " -BackgroundColor Blue -ForegroundColor White -NoNewline
    Write-Host "" 
    return "=> "
} #end prompt function

# PSReadLine 


Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionView ListView
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar

# Fzf

Import-Module PSFzf
Set-PSFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

# Aliases 

Set-Alias vim nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias cat Get-Content

# Utilities

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue | 
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
