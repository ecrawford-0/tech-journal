echo "checking for users without a password set, this shouldn't return anything"

awk -F : '( $2 == "") { print } ' /etc/shadow

echo "checking user with a uid of 0, this should only be the root user"
awk -F : '( $3 == "0") { print } ' /etc/shadow

echo "checking the services which are currently running"
systemctl list-unit-files --type=service | grep enabled 

echo "checking open network sockets"
ss -tulpn

