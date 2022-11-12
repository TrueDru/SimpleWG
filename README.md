# SimpleWG
2 bash scripts, that allow you to easy setup wireguard server and generate configs
# Server installation
```
git clone https://github.com/TrueDru/SimpleWG
cd SimpleWG
chmod +x setup-wg.sh
sudo ./setup-wg.sh
```
# Adding new client config
```
Usage: sudo addwguser -u username -i ip -d dns (optional)
-u Username (config name)
-i Ip address
-d Dns server (optional, default is 8.8.8.8)
-h Display this message 
```
Now you can find config file and qr code of new client in `/etc/wireguard/users/$username/`
