$vmname = Read-Host -Prompt 'Name of your Virtual Machine'
$ip = Read-Host 'Whats the IP'
$image = Read-Host 'Whats the name of your Putty image'
$name = Read-Host 'What is your username?'
$pass = Read-Host 'What is your password?' -AsSecureString
$cdssh = cd 'C:\Program Files\PuTTY'									#pfad zu putty
$openssh = putty.exe -load $image -pw $pass								#pw withd nicht richtig angegeben

New-Item "P:\VM-Skripts\New_VM\$vmname" -type directory
New-Item "P:\VM-Skripts\New_VM\$vmname\ssh.ps1" -type file

$output =  "cd 'C:\Program Files\Oracle\VirtualBox'
.\VBoxManage.exe startvm $vmname --type headless
for($i=1; $i -le 10; $i++){if (Test-Connection ($ip) -ErrorAction SilentlyContinue){cmd.exe /c $cdssh, $openssh; break} else {}}
cd 'P:\VM-Skripts\New_VM\'"

$output | Out-File -filepath "P:\VM-Skripts\New_VM\$vmname\ssh.ps1"