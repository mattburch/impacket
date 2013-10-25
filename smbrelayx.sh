#!/bin/bash

IMPACKET_SMBRELAY=/opt/impacket/examples/smbrelayx

cd /tmp
echo "[+] Downloading impacket python zip archieve"
wget "http://corelabs.coresecurity.com/index.php?module=Wiki&action=attachment&type=tool&page=Impacket&file=impacket-0.9.9.9.zip" -O impacket-0.9.9.9.zip

echo "[+] Unzipping impacket archieve"
unzip -q impacket-0.9.9.9.zip -d /opt/

cd /opt/impacket/examples/smbrelayx
echo "[+] Building symlinks"
ln -s /opt/impacket/impacket/dcerpc/ .
ln -s /opt/impacket/impacket/ .
ln -s /opt/impacket/impacket/nmb.py .
ln -s /opt/impacket/impacket/ntlm.py .
ln -s /opt/impacket/impacket/smb.py .
ln -s /opt/impacket/impacket/smbserver.py .
ln -s /opt/impacket/impacket/structure.py .

echo "[+] Building execution wrapper"
cat > /usr/local/bin/smbrelayx <<EOF
#!/bin/bash

cd $IMPACKET_SMBRELAY
python smbrelayx.py \$@
EOF
chmod 755 /usr/local/bin/smbrelayx

echo "[+] Cleaning up"
rm /tmp/impacket-0.9.9.9.zip

cat <<EOF
 ========================================================
                  Done!
   To run smbrelayx.py you must perform the following:
   
 smbrelayx [options]
 
   Happy hacking!
 ========================================================
EOF