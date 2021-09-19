param($network, $server)
for ($i =0; $i -lt 255; $i++)
{

$ip = "$network" + "." +  "$i"
Resolve-DnsName -DnsOnly $ip -Server $server -ErrorAction Ignore | Select-Object -Property Name, NameHost
}  
