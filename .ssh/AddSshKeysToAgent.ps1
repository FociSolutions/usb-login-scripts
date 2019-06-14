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

$currentDriveLetter = (get-location).Drive.Name
$timeToKeep

if (-not $Hours) {
    $date = [DateTime]::Now;
    $endOfDay = Get-Date -Year $date.Year -Month $date.Month -Day $date.Day -Hour 18 -Minute 20 -Second 0
    $timeToKeep = $endOfDay - $date
}
else {
    $timeToKeep = New-TimeSpan -Hours $Hours
}

ssh-add -D
ssh-add -t $timeToKeep.TotalSeconds


if(-not $Keep)
{
    $driveEject = New-Object -comObject Shell.Application
    $driveEject.Namespace(17).ParseName($currentDriveLetter + ":").InvokeVerb("Eject")
}
