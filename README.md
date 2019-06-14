# Introduction

This project attempts to be a repository that helps setup a windows box for git ssh-agent and multiple ssh keys. This repository attempts to recreate the functionality found in https://github.com/pivotal-legacy/usb-login-scripts however made for windows using powershell instead of bash for MAC.

# How To Use

1. Encrypt a USB key using bitlocker.
1. Copy .ssh onto the USB key
1. Add your ssh keys into the .ssh folder
1. Run ConfigureGit.ps1 in an admin powershell prompt. This will
    * Enable the OpenSSH Client
    * Set git to use the SSH Client
    * Add a Powershell profile
    * Add a script to enable ssh-agent at start of powershell
1. ensure you have navigated to the .ssh folder of the usb stick
1. run AddSshKeysToAgent.ps1

the script has two paramaters as found below

``` powershell
Param(
    # Integer number of hours to keep key installed (defaults to loading key until 6:20pm local time)
    [Parameter(Mandatory = $false)]
    [Alias("h")]
    [Int32]
    $Hours,

    # If specified, will not try to unmount the volume (unmounting is only attempted if the path begins with /Volumes/)
    [Parameter(Mandatory = $false)]
    [Alias("k")]
    [Switch]
    $Keep
)
```
