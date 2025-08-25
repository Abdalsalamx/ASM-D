#!/bin/bash

# تعريف المجلد المخصص للصور
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# دالة لالتقاط لقطة الشاشة الكاملة
full_screenshot() {
    # إنشاء اسم الملف مع التاريخ
    filename="full_$(date +'%Y-%m-%d_%H-%M-%S').png"
    
    # التقاط وحفظ الصورة
    grim "$SCREENSHOT_DIR/$filename"
    wl-copy < "$SCREENSHOT_DIR/$filename"
    
    # إظهار إشعار مع الصورة
    notify-send -i "$SCREENSHOT_DIR/$filename" "تم التقاط لقطة شاشة كاملة"
}

# دالة لالتقاط منطقة محددة
area_screenshot() {
    # إنشاء اسم الملف مع التاريخ
    filename="area_$(date +'%Y-%m-%d_%H-%M-%S').png"
    
    # التقاط وحفظ الصورة
    grim -g "$(slurp)" "$SCREENSHOT_DIR/$filename"
    wl-copy < "$SCREENSHOT_DIR/$filename"
    
    # إظهار إشعار مع الصورة
    notify-send -i "$SCREENSHOT_DIR/$filename" "تم التقاط لقطة شاشة محدده"
}

# تنفيذ الوظائف حسب الوسيط المقدم
if [ "$1" = "--full" ]; then
    full_screenshot
elif [ "$1" = "--area" ]; then
    area_screenshot
else
    echo "خطأ: يجب تحديد نوع اللقطة"
    echo "استخدام: $0 --full أو $0 --area"
    exit 1
fi