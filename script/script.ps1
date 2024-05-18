
param($lnk)
$sh = New-Object -ComObject WScript.Shell
$target = $sh.CreateShortcut($lnk).TargetPath
echo $target