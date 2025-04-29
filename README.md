# usb-firewall-authentication
A USB authentication layer (2 Factor Authentication) for mounting storage, similar to how a system uses passwords for user login. It demonstrates how important it is to protect your system from malware executed via USB. It's a simple but yet effective to protect you property.

How The Hash Authentication Will Work
✅ Every allowed USB must contain a secret key file inside it, for example:
/mk-mahwete/2025-05u/.auth_key
✅ When you insert the USB:

    The script checks if .auth_key exists

    If the hash inside matches the system's expected hash, the USB is usable

    If not, the system immediately unmounts the USB!

🔐 This is like your Linux asking for a "password" before allowing the USB.

Generate a secret hash
Run this in your terminal:

     openssl rand -hex 32
It will generate a random 64-character hexadecimal string.
(This is your secret key — DO NOT lose it!)

Open the script you copied and Find the line:

      TRUSTED_HASH="put_your_generated_hash_here"

# MOve the Hash Script to a folder of your choice but i recommand this folder:

    TRUSTED_HASH="your_hashed_value"
Replace put_your_generated_hash_here with your generated key!


Prepare your USB drive
Now:
Mount your USB drive
Inside it, create a hidden file called .auth_key

    echo "your_generated_hash" > /media/mk-mahwete/2052-05u/.auth_key

