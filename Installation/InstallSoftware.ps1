echo "Checking if Chocolatey is installed"
if (-Not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

echo "Enabling Hyper-V"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
echo "Enabling WSL"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

echo "Checking if windows openssh client is installed"
$openSsh = Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Client*' | Select-Object Name, State

if($openSsh.State -ne "Installed")
{
    echo "Adding OpenSSH Client"
    Add-WindowsCapability -Name $openSsh.Name -Online
}

echo "Installing Google Chrome"
cinst googlechrome -y
echo "Installing 7-Zip"
cinst 7zip.install -y
echo "Installing Git"
cinst git -y
echo "Installing NodeJs"
cinst nodejs.install -y
echo "Installing PoshGit"
cinst poshgit -y
echo "Installing VSCode"
cinst vscode -y
echo "Installing Docker Desktop"
cinst docker-desktop -y
echo "Installing Terminus"
cinst terminus -y
