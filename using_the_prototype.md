# Using the prototype stack

## Setup
1. Download the LG cert:
wget https://for-your-perusal.s3.amazonaws.com/ssl_certs/linuxguru.crt
2. On macs run "open linuxguru.crt". This will open your keychain apps and import the LG ca cert.
3. Double click the Linuxguru cert,select "|> Trust and select "Always Trust"
4. The cert will -not- work until you log out and back in
5. Tell knife to cut you a openvpn config

## Usage
1. Install an openvpn client. I personally use tunnelblick
2. Click the tunnelblick icon and select "vpn details"
3. Set  "Set DNS/WINS to  "Set nameserver"
4. Turn off "Route all IPv4 traffic through VPN" 
5. Find the openvpn conf I sent you and use finder to drag the openvpn conf onto the tunnelblick config
6. You should be able to connect now



