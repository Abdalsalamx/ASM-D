#!/bin/bash

set -e
echo "🚀 بدء إعداد نظام Fedora..."

# ✳️ طلب صلاحية sudo مرة واحدة فقط
sudo -v
# تحديث صلاحية sudo كل 60 ثانية حتى انتهاء السكربت
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# --- System Setup ---
echo "⚙️ إعداد DNF..."
sudo bash -c 'echo -e "\nmax_parallel_downloads=10\nfastestmirror=True\ninstall_weak_deps=False" >> /etc/dnf/dnf.conf'

# --- Repositories ---
echo "📦 إضافة المستودعات..."
sudo dnf install -y dnf-plugins-core flatpak
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf copr enable -y solopasha/hyprland
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf --refresh upgrade -y

# --- Core Components ---
echo "🧱 تثبيت مكونات Hyprland..."
sudo dnf install -y hyprland hyprlock hypridle hyprland-qtutils hyprpicker hyprpolkitagent xdg-desktop-portal-hyprland waybar waypaper rofi-wayland mako libnotify grim slurp swww wl-clipboard xhost

# --- System Tools ---
echo "🛠️ تثبيت أدوات النظام..."
sudo dnf install -y kitty git vim htop fastfetch cronie network-manager-applet blueman unrar p7zip p7zip-plugins gvfs gvfs-mtp jmtpfs

# --- Media ---
echo "🎵 تثبيت أدوات الميديا..."
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
sudo dnf5 group install -y multimedia
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf install -y vlc mpv gthumb imv playerctl pavucontrol

# --- Applications ---
echo "📱 تثبيت التطبيقات..."
sudo dnf install -y chromium firefox brave-browser nautilus gedit copyq

# --- Fonts ---
echo "🔤 تثبيت الخطوط..."
sudo dnf install -y \
  dejavu-sans-fonts fira-code-fonts fontawesome-fonts jetbrains-mono-fonts \
  google-noto-cjk-fonts google-noto-emoji-fonts google-noto-fonts-common \
  google-croscore-tinos-fonts google-croscore-cousine-fonts google-croscore-arimo-fonts \
  google-noto-sans-arabic-fonts cascadia-code-nf-fonts fontawesome-6-brands-fonts fontawesome-6-free-fonts

fc-cache -fv
sudo fc-cache -fv

# --- Appearance ---
echo "🎨 تثبيت الثيمات والمظهر..."
sudo dnf install -y adw-gtk3-theme papirus-icon-theme kvantum qt5ct qt6ct nwg-look
git clone https://github.com/vinceliuice/Vimix-cursors.git && cd Vimix-cursors && sudo ./install.sh && cd .. && rm -rf Vimix-cursors

# --- Dotfiles ---
echo "📂 تطبيق ملفات الإعداد الشخصية..."
cd ~
git clone https://github.com/Abdalsalamx/ASM-D.git
mkdir -p ~/.config/
cp -r ASM-D/.config/* ~/.config/
[ -f ASM-D/.bashrc ] && cp ASM-D/.bashrc ~/
[ -f ASM-D/.vimrc ] && cp ASM-D/.vimrc ~/
rm -rf ASM-D
find ~/.config/Scripts/ -type f -name "*.sh" -exec chmod +x {} \;

# --- Power Management ---
echo "🔋 تثبيت أدوات إدارة الطاقة..."
sudo dnf install -y tlp tlp-rdw acpid brightnessctl udiskie udisks2
sudo systemctl enable --now tlp
sudo systemctl enable --now acpid

# --- SDDM Setup ---
echo "🔐 تثبيت SDDM وإعداده..."
sudo dnf install -y sddm qt6-qtsvg qt6-qtvirtualkeyboard qt6-qtmultimedia
sudo systemctl enable sddm --force
sudo systemctl set-default graphical.target
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && sudo ./install.sh && cd .. && rm -rf SilentSDDM

# --- DONE ---
echo "✅ تم الانتهاء من إعداد النظام. سيتم إعادة التشغيل الآن..."
reboot

