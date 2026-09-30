param([ValidateSet('ProgramOnly','ProgramAndCache','Everything')][string]$Mode='ProgramOnly')
$ErrorActionPreference='Stop'
$install=[IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'Programs\DavidResearchMonitor'))
$expected=[IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'Programs\DavidResearchMonitor'))
if($install -ne $expected){throw 'Unexpected installation path.'}
$diagnostics=Join-Path $install 'ResearchMonitor.Diagnostics.exe'
if(Test-Path -LiteralPath $diagnostics){& $diagnostics --remove-scheduler | Out-Null}
$shell=New-Object -ComObject WScript.Shell
foreach($shortcut in @((Join-Path ([Environment]::GetFolderPath('StartMenu')) 'Programs\David Research Monitor.lnk'),(Join-Path ([Environment]::GetFolderPath('Desktop')) 'David Research Monitor.lnk'))){if(Test-Path -LiteralPath $shortcut){Remove-Item -LiteralPath $shortcut -Force}}
if(Test-Path -LiteralPath $install){Remove-Item -LiteralPath $install -Recurse -Force}
if($Mode -in @('ProgramAndCache','Everything')){
    $cache=[IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'DavidResearchMonitor\cache'))
    if($cache -ne [IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'DavidResearchMonitor\cache'))){throw 'Unexpected cache path.'}
    if(Test-Path -LiteralPath $cache){Remove-Item -LiteralPath $cache -Recurse -Force}
}
if($Mode -eq 'Everything'){
    $data=[IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'DavidResearchMonitor'))
    $reports=[IO.Path]::GetFullPath((Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'David Research Monitor'))
    if($data -ne [IO.Path]::GetFullPath((Join-Path $env:LOCALAPPDATA 'DavidResearchMonitor')) -or $reports -ne [IO.Path]::GetFullPath((Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'David Research Monitor'))){throw 'Unexpected data path.'}
    if(Test-Path -LiteralPath $data){Remove-Item -LiteralPath $data -Recurse -Force}
    if(Test-Path -LiteralPath $reports){Remove-Item -LiteralPath $reports -Recurse -Force}
}
Write-Host "Uninstall complete ($Mode). Node, DokoBot, LM Studio, browsers, and models were not changed."
