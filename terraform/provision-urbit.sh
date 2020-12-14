# Make sure all our base packages are up-to-date
sudo apt update

# Install all urbit dependencies
sudo apt install -y screen automake autoconf libtool cmake

# Download build, and install the urbit source package
cd ~
mkdir source
cd source
wget --content-disposition https://urbit.org/install/linux64/latest
tar zxvf ./linux64.tgz --strip=1
mv urbit* ../piers

# Add 2GB of swap so that we have enough memory to start up
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=2048
sudo /sbin/mkswap /var/swap.1
sudo chmod 600 /var/swap.1
sudo /sbin/swapon /var/swap.1
echo "/var/swap.1 none	swap    defaults        0   0" | sudo tee -a /etc/fstab

# Set up forwarding from port 80 (http) to 8080 and 443 (https) to 8443
#IPtables doesn't persist after rebooting; fix this.
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination :8080
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 443 -j DNAT --to-destination :8443

# Other packages that are nice to have on the server
sudo apt install -y expect git tmux iptables-persistent
