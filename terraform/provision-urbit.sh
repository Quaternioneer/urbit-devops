# Make sure all our base packages are up-to-date
sudo apt update

# Install all urbit dependencies
sudo apt install -y screen automake autoconf libtool cmake

# Download build, and install the urbit source package
cd ~
mkdir source piers
cd source
wget --content-disposition https://urbit.org/install/linux64/latest
tar zxvf ./linux64.tgz --strip=1
mv urbit* ../piers

#ToDo: The following line does not seem to write to fstab. Also, the above does not persist after rebooting; test and fix this.
#sudo echo "swap        /var/swap.1 swap    defaults        0   0" >> /etc/fstab

# Set up forwarding from port 80 (http) to 8080 and 443 (https) to 8443
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination :8080
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to-destination :8443

# Other packages that are nice to have on the server
sudo apt install -y expect git tmux
