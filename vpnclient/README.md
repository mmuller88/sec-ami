# vpn client

* yarn cdkDeploy '*' --require-approval never --profile build
* yes cdkDestroy '*' --profile build

## Connect to VPC
* Connect to build VPC with VPN Client Connection:
* https://smartshift.com/guide-setting-up-an-aws-vpc-client-vpn/
git clone https://github.com/OpenVPN/easy-rsa.git
cd easy-rsa/easyrsa3
./easyrsa init-pki
./easyrsa build-ca nopass
./easyrsa build-server-full server nopass (This step will generate server certificate and key)
./easyrsa build-client-full client1.domain.tld nopass (This step will generate client certificate and the client private key)
Store/Copy the server and client certificates and keys in specified location as these are important
mkdir custom_folder
cp pki/ca.crt custom_folder
cp pki/issued/server.crt custom_folder
cp pki/private/server.key custom_folder
cp pki/issued/client1.domain.tld.crt custom_folder
cp pki/private/client1.domain.tld.key custom_folder

Notice! Make sure that you configure internet connection with the VPN Client.
* Download VPN Client Config

* insert as described at the end from the downloaded vpn client config
<cert>

-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----

</cert>

<key>

-----BEGIN PRIVATE KEY-----
...
-----END PRIVATE KEY-----

</key>

* sudo openvpn downloaded-client-config.ovpn