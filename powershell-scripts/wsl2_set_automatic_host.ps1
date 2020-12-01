# WSL2 localhost Script
# Automatically update your Windows hosts file with the WSL2 VM IP address with multiple domains
# Add IP address to wsl host on windows hosts file "172.20.20.69 wsl"
# @ref https://abdus.dev/posts/fixing-wsl2-localhost-access-issue/

# Set domains
$hostnameArray = "wsl", "local"

# Configure vars
$newHostString = ""
$hostnameString = $hostnameArray -join "|"
$paternHostWsl = "((\d+\.?){4})\s+(.*\.)?($hostnameString)"

# find ip of eth0
$ifconfig = (wsl -- ip -4 addr show eth0)
$ipPattern = "((\d+\.?){4})"
$wslPattern = "(.*\.)?"
$ip = ([regex]"inet $ipPattern").Match($ifconfig).Groups[1].Value
if (-not $ip) {
    exit
}

#get hostsFile
$hostsPath = "$env:windir/system32/drivers/etc/hosts"

$hosts = (Get-Content -Path $hostsPath -Raw -ErrorAction Ignore)
if ($null -eq $hosts) {
    $hosts = ""
}

#convert host to array lines and string
$hostsString = $hosts.Trim()
$hostsArray = $hosts.Trim().Split([Environment]::NewLine)

#check host to update
foreach ($h in $hostsArray)
{
     if ($h -match $paternHostWsl) {
         $newHostString += ($h -replace $ipPattern, $ip) + [Environment]::NewLine
     }elseif($h -notmatch "^(\s*)$"){
        $newHostString += ("$h ") + [Environment]::NewLine
     }
}

#add host if not exist
foreach ($ho in $hostnameArray)
{
    # wsl ip
    $find = "$ipPattern\s+$ho"
    $entry = "$ip $ho"

    if ($hostsString -notmatch $find) {
        $newHostString += $entry
    }
}

# Write new file
try {
    $temp = "$hostsPath.new"
    New-Item -Path $temp -ItemType File -Force | Out-Null
    Set-Content -Path $temp $newHostString

    Move-Item -Path $temp -Destination $hostsPath -Force
}
catch {
    Write-Error "cannot update wsl ip"
}

exit
