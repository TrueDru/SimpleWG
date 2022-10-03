# SimpleWG-cli
2 bash scripts, that allow you to easy setup wireguard server and generate configs
# Server installation
```
git clone https://github.com/TrueDru/SimpleWG-cli>
cd SimpleWG-cli
chmod +x setup-wg.sh
sudo ./setup-wg.sh
```
# Adding new client config
```
sudo addwguser
```
Now you can find config file and qr code of new client in `/etc/wireguard/users/$username/`
