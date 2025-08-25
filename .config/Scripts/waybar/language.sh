#!/bin/bash
# سكربت Waybar لعرض اللغة الحالية بناءً على hyprctl

if command -v hyprctl &> /dev/null; then
    # إذا وُجد أي سطر فيه Arabic اعتبر اللغة عربية، وإلا اعتبرها إنجليزية
    if hyprctl devices | grep -q 'active keymap: Arabic'; then
        echo "AR"
    else
        echo "EN"
    fi
    exit 0
fi

echo "    EN"