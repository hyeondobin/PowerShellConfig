
Import-Module PSReadLine

function Import-VsDevShell {
  $vsPath = "F:\Program Files/Microsoft Visual Studio/2022/Community/Common7/Tools/Microsoft.VisualStudio.DevShell.dll"

  if (Test-Path $vsPath) {
    Import-Module $vsPath
    Enter-VsDevShell -VsInstallPath "F:/Program Files/Microsoft Visual Studio/2022/Community" -SkipAutomaticLocation -Arch amd64
    Write-Host "Loaded MSVC dev shell"
  }
}

Import-VsDevShell

# ALias
Set-Alias .. cd..
Set-Alias lz lazygit
Set-Alias vi nvim


function which($name)
{ get-command $name | Format-Table Path, Name 
}

function gst
{ git status 
}


function tig
{
    bash -c tig
}

function l
{
    eza -lah --git-repos-no-status --git $argv
}

function eg
{
    vi 'C:\Users\Dobin\.gitconfig'
}

function y
{
    $tmp = [System.IO.Path]::GetTempFileName() 
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path)
    {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# oh-my-posh init pwsh | Invoke-Expression
