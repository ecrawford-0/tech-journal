#!/bin/bash
# get user input
hostfile=$1
portfile=$2

# the following regex string to look for ips was found on this website: https://www.shellhacks.com/regex-find-ip-addresses-file-grep/
regex="(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"

echo "sanitizing target file, any invalid inputs will be filtered"

# create a temp file to store the sanitized ip addresses in
sanitized_target_file=$(touch sanitized_target_file.txt)

# code for reading each line of a text file found here https://linuxhint.com/read_file_line_by_line_bash/
# look through each line of the file, if ip address is valid, place it in the sanitized ip address file.
while read line; do
  if [[ $line =~ $regex ]] && [[ ${#line} -le 15 ]] ; then
   echo $line >> sanitized_target_file.txt 
  fi
done < $hostfile;

sanitized_port_file=$(touch sanitized_port_file.txt) 
echo "sanitizing port list file, any invalid inputs will be filtered"
while read line; do
# code to check for numbers from this website: https://www.golinuxcloud.com/check-if-string-contains-numbers-shell-script/
 if [[ $line =~ ^[0-65353]+$ ]]; then
  echo $line >> sanitized_port_file.txt
 fi
done < $portfile
echo "--------------------------"
echo "---ip addresses to scan---"
cat sanitized_target_file.txt
echo "--------------------------"

echo "----ports to scan---------"
cat sanitized_port_file.txt
echo "--------------------------"

result=$(touch result.txt)
for host in $(cat sanitized_target_file.txt); do
  for port in $(cat sanitized_port_file.txt); do
    timeout .1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null &&
      echo "$host,$port" >> result.txt
   done
done
echo "------Results--------------"
if [[ -s result.txt ]]; then
 cat result.txt
else
echo "no results"
fi

# delete the files so when running the script again previous runs won't affet it 
rm -rf sanitized_target_file.txt
rm -rf sanitized_port_file.txt
rm -rf result.txt

# other websites which were referenced 
# https://www.shellhacks.com/regex-find-ip-addresses-file-grep/
# https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/
# https://linuxhint.com/read_file_line_by_line_bash/
# https://acloudguru.com/blog/engineering/conditions-in-bash-scripting-if-statements
# https://linuxhint.com/length_of_string_bash/
# https://www.golinuxcloud.com/check-if-string-contains-numbers-shell-script/
