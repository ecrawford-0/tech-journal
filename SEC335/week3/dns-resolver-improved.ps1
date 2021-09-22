param($network, $server)
for ($i = 0; $i -lt 255; $i++)
{
$ip = "$network" + "." +  "$i"


$result = Resolve-DnsName -DnsOnly $ip -Server $server -ErrorAction Ignore | Select-Object -Property NameHost

if ($result  -like "*")
{
    echo "ip:"$ip 
    echo "server" $result
    echo ""
}
 
}
