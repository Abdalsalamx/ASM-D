#!/bin/bash

# مسار ملف السجل
LOG_FILE="$HOME/.update-system.log"

# START MESSAGE
echo "
██    ██ ██████  ██████   █████  ████████ ███████ 
██    ██ ██   ██ ██   ██ ██   ██    ██    ██      
██    ██ ██████  ██   ██ ███████    ██    █████   
██    ██ ██      ██   ██ ██   ██    ██    ██      
 ██████  ██      ██████  ██   ██    ██    ███████
                                        
🚀 Starting Fedora system update...
"
# دالة لتسجيل النتائج فقط في الملف
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# بدء عملية التحديث
log "بدء تحديث النظام وحزم Flatpak"

# تحديث نظام Fedora
log "جاري تحديث حزم DNF..."
if ! sudo dnf upgrade --refresh -y; then
    log "فشل تحديث حزم DNF"
    exit 1
fi

# تنظيف الحزم غير الضرورية
log "جاري تنظيف حزم DNF..."
sudo dnf autoremove -y

# تحديث حزم Flatpak
log "جاري تحديث حزم Flatpak..."
if ! flatpak update -y; then
    log "فشل تحديث حزم Flatpak"
    exit 1
fi

# إعلام بانتهاء التحديث بنجاح
log "اكتمل تحديث النظام بنجاح"
notify-send -a "System Update" "System Update" "اكتمل تحديث النظام بنجاح"
