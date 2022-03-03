#!/bin/bash
# secure-ssh.sh
# author emily crawford
# creates a new ssh user using the $user parameter
# adds a public key from the local repo or curled from the remote repo
# removes root's ability to ssh in
echo "welcome to secure secure-ssh script, this script will only allow users to ssh into a machine with a public/private key pair, rather than a password"
echo "First a new user needs to be created, what do you want to call the new use:"
read user # get the name for the user

# add the user  
sudo useradd -m -d /home/$user -s /bin/bash $user
 
# create the home directory for the new user
sudo mkdir /home/$user/.ssh

#download a public key and place it in user's folder
sudo cp id_rsa.pub /home/$user/.ssh/authorized_keys

# change permissions of .ssh file to read,write,and execute to owner of file, only
sudo chmod 700 /home/$user/.ssh

# change the permissions of the authorized keys to be read and write for the owner only
sudo chmod 600 /home/$user/.ssh/authorized_keys

# change the owner to be for the user created
sudo chown -R $user:$user /home/$user/.ssh
