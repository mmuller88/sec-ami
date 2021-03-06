# sec-ami
Repo for converting a Dockerfile to an AMI. The AMI is based on [cdk-prowler](https://github.com/mmuller88/cdk-prowler).

# Docker Related
For orchestrating those containers we are use **Docker Compose**. How to install Docker and Docker Compose you can see in the Useful Resources section above.

## Deploy
In den jeweiligen course Ordner wechseln und:

```
docker-compose build --no-cache
docker-compose up -d --build
```
## Destroy
No worries! The destroy command only destroys the container. No important data will be lost as those are usually saved as volumes e.g.: ./wordpress_files:/var/www/html or ./db_data:/var/lib/mysql

```
docker-compose down
```
## Log into container
Am besten einfach VS Code mit der Docker extension verwenden um dich in den jeweiligen Container einzuloggen. Alternativ:
```bash
docker exec -it <container name> /bin/bash
docker exec msf /useExploit.sh
docker-compose up -d --build && docker exec msf /useExploit.sh
```

# AWS AMI
Benutze https://github.com/ake-persson/docker-build-ami

## Pre
* Install python 2.7
which pip2.7
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
sudo python2.7 get-pip.py
which pip2.7

* install docker-build-ami
python2.7 -m pip install docker-build-ami

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

* insert as described
<cert>
...
</cert>
<key>
...
</key>

* sudo openvpn downloaded-client-config.ovpn

## Run AMI script
* be sure deploying to us-east-1 as that is the region for the marketplace!
* run:
```
../createAmi.sh
```

Check the docker-build-ami.log after the script completed successfully.

## Steps in Marketplace:
That are the steps after you created the AMI.

* https://aws.amazon.com/marketplace/management/manage-products
* Add AMI and choose AMI. Check to use the right SSH user like **ubuntu**

# Prowler CFN

aws cloudformation deploy --template-file https://raw.githubusercontent.com/toniblyx/prowler/master/util/codebuild/codebuild-prowler-audit-account-cfn.yaml --stack-name sec-stack

# Misc

publishing AMI:

https://docs.aws.amazon.com/marketplace/latest/userguide/ami-single-ami-products.html

aws sts get-session-token --serial-number arn:aws:iam::981237193288:mfa/damadden88 --token-code code-from-token

# Thanks To
* the maintainer of https://github.com/ake-persson/docker-build-ami
