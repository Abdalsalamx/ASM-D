#!/bin/bash

# قتل Waybar إذا كان يعمل بالفعل
killall -q waybar

# انتظر حتى يتم إغلاقه بالكامل
while pgrep -x waybar >/dev/null; do sleep 0.1; done

# إعادة تشغيل Waybar
waybar &

# إشعار عند اكتمال العملية (اختياري)
notify-send "Waybar" "تم إعادة تشغيل Waybar بنجاح!"
