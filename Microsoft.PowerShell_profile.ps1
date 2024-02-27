Import-Module PSReadLine

# change cursor for vi mode
$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command')
    {
        # command mode - block cursor
        Write-Host -NoNewline "`e[1 q"
    } else
    {
        # insert mode - blinking cursor
        Write-Host -NoNewline "`e[5 q"
    }
}

# Add Vi Mode
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange

Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# keymaps
Set-PSReadLineKeyHandler -Key Ctrl+u -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key Ctrl+c -ViMode Insert -Function ViCommandMode


# ALias
Set-Alias .. cd..
function ls
{ Get-ChildItem | out-host -paging 
}
function la
{ Get-ChildItem -Force @args | out-host -paging 
}
Set-Alias vi nvim
# Set-Alias vi neovide

function which($name)
{ get-command $name | Format-Table Path, Name 
}
function gst
{ git status 
}
Set-Alias lg lazygit

function tig
{
    bash -c tig
}

function l
{
    eza -lah --git $argv
}

function lsstart
{
    live-server --port 1412
}

Set-Alias bash 'C:\Program Files\Git\bin\gbash.exe'

function eg
{
    vi 'C:\Users\Dobin\.gitconfig'
}

$env:_ZO_ECHO = '1'
Invoke-Expression (& { ( zoxide init powershell | Out-String) })
