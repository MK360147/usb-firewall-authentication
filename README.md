# USB Firewall Authentication
A USB authentication layer (2 Factor Authentication) for mounting storage, similar to how a system uses passwords for user login. It demonstrates how important it is to protect your system from malware executed via USB. It's a simple but yet effective to protect you property.

<br/>

**How The Hash Authentication Works**<br/>
Every allowed USB must contain a secret key file inside it, for example:
/mk-mahwete/2025-05u/.auth_key

When you insert the USB:

* The script checks if .auth_key exists
* If the hash inside matches the system's expected hash, the USB is usable
* If not, the system immediately unmounts the USB!
  
> 🔐 This is like your Linux asking for a "password" before allowing the USB.

<br/>

***

1. Generate a secret hash<br/>
Get your srip ready or open then run this in your terminal to get our key:
```
     openssl rand -hex 32
```

> [!IMPORTANT]
> It will generate a random 64-character hexadecimal string (This is your secret key — DO NOT lose it!)

<br/>

***

2. Open your script and Find this line and past you genarated key:
```
      TRUSTED_HASH="your_hashed_value"
```
> [!WARNING]
> Replace "your_hashed_value" with your generated key!

<br/>

***

3. Move the Hash Script to a folder of your choice but i recommand this folder:
```
    /usr/local/bin/usb_hash_check.sh
```
> [!NOTE]
> Make this scrip to be executable by using the chmod command `chmod +x usb_hash_check.sh` 

<br/>

* Prepare your USB drive and add/mount your USB drive inside it, create a hidden file called .auth_key
```
    echo "your_generated_hash" > /media/mk-mahwete/2052-05u/.auth_key
```

<br/>

***

4. Auto-run Hash Check When USB is Inserted\
You need to make sure that every time a USB is plugged in your usb_hash_check.sh script automatically runs to check it!. We'll use a simple Linux system: udev rules.

Create a new udev rule

     sudo vim /etc/udev/rules.d/99-usbguard-hashcheck.rules
Paste this into the file:
     
     ACTION=="add", SUBSYSTEMS=="usb", RUN+="/usr/local/bin/usb_hash_check.sh"

Reload udev rules
Now tell Linux to reload the rules:
```     
     sudo udevadm control --reload-rules
```

<br/>

***

> [!CAUTION] 
> This is a prototype-level security enhancement and should not be considered a complete USB defense system. Use it as a learning tool or layer within a broader security strategy.
