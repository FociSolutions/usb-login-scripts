echo "Checking if windows openssh client is installed"
$openSsh = Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Client*' | Select-Object Name, State

if($openSsh.State -ne "Installed")
{
    Add-WindowsCapability -Name $openSsh.Name -Online
}

echo "Setting git to use C:/Windows/System32/OpenSSH/ssh.exe"
& git config --global core.sshcommand "C:/Windows/System32/OpenSSH/ssh.exe"

echo "Adding powershell exclusion to windows defender"
& Add-MpPreference -ControlledFolderAccessAllowedApplications "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

echo "Checking if powershell profile is set up"
if (!(Test-Path -Path $PROFILE ))
{ 
    & New-Item -Type File -Path $PROFILE -Force 
}

$profileContent=@'
$sshAgentStopped = 'Stopped' -eq (Get-Service -Name 'ssh-agent' -ErrorAction SilentlyContinue).status
Write-Verbose -Message ('SSH Agent Status is stopped: {0}' -f $sshAgentStopped)

if ($sshAgentStopped) {
    Write-Verbose -Message 'Stating SSh Agent'
    Start-Service -Name 'ssh-agent'
}
'@

echo "Adding startup script for powershell profile"
& Add-Content $PROFILE $profileContent

echo "removeing powershell exclusion to windows defender"
Remove-MpPreference -ControlledFolderAccessAllowedApplications "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"