#!/bin/bash
echo Welcome to SimpleWG-cli setup script by https://github.com/TrueDru!
if (( $EUID != 0 )); then
    echo "Please run as root"
    sleep 1
    clear
    exit
fi

echo -ne Updating apt...
apt-get update > /dev/null
echo -ne "\rUpdating apt...done!\nInstalling wireguard..."
apt-get install wireguard > /dev/null
echo -ne "\rInstalling wireguard...done!\nGenerating server private key..."
mkdir /etc/wireguard/server/
wg genkey > /etc/wireguard/server/private.key
chmod go= /etc/wireguard/server/private.key
echo -ne "\rGenerating server private key...done!\nGenerating server public key..."
cat /etc/wireguard/server/private.key | wg pubkey > /etc/wireguard/server/public.key 2>&1
echo -ne "\rGenerating server public key...done!\nCreating wg0.conf file...\n"
read -p "Please, enter wireguard local ip like ip/subnet_prefix (10.10.10.1/24): " ip
read -p "Please, specify wireguard port (443): " port
echo "
Address = ${ip:-10.10.10.1/24}
PostUp = iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
PreDown = iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
ListenPort = ${port:-443}
Privatekey = $(cat /etc/wireguard/server/private.key)" > /etc/wireguard/wg0.conf
echo -ne "...done!\nEnabling port forwarding..."
sed -i '/net.ipv4.ip_forward=1/s/^#//g' /etc/sysctl.conf
echo -ne "\rEnabling port forwarding...done!\nEnabling wireguard daemon..."
systemctl enable wg-quick@wg0.service --now
echo -ne "\rEnabling wireguard daemon...done!\nSending addwguser to /usr/bin..."
chmod +x addwguser
mv addwguser /usr/bin/
echo -e "\rSending addwguser to /usr/bin...done!"
echo "All done, now type 'sudo addwguser' and create a client!"




