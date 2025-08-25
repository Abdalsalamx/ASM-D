#!/bin/bash

while true; do
    # عدد الأجهزة القابلة للإزالة (removable) مثل USB
    HAS_DEVICES=$(lsblk -o RM,NAME,TRAN | grep -E '^ 1 ' | grep -vE 'loop|sr|rom' | wc -l)

    if [ "$HAS_DEVICES" -gt 0 ]; then
        # إذا لم تكن udiskie تعمل، شغلها
        pgrep -f "udiskie -t -n" > /dev/null || udiskie -t -n &
    else
        # إذا لا يوجد أجهزة، أوقف udiskie
        pkill -f "udiskie -t -n"
    fi

    sleep 5  # تحقق كل 10 ثوانٍ
done

