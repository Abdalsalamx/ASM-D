# Arabic Fonts Setup on Linux

This guide explains how to install and configure high-quality Arabic and Latin fonts on your Linux system, especially for use in UI, terminal, or development environments.

---

## 1️⃣ Download Fonts

Download the following fonts manually from Google Fonts:

- **Noto Sans Arabic**  
  https://fonts.google.com/noto/specimen/Noto+Sans+Arabic

- **Arimo**  
  https://fonts.google.com/specimen/Arimo

- **Cousine**  
  https://fonts.google.com/specimen/Cousine

- **Tinos**  
  https://fonts.google.com/specimen/Tinos

---

## 2️⃣ Extract Fonts

If the fonts are downloaded in `.zip` format, use the following command to extract them each into their own folder:

```bash
find . -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
```

---

## 3️⃣ Copy Fonts to System Directory

To install fonts system-wide:

```bash
sudo cp -r <font-folder-path> /usr/share/fonts/
```

(Replace `<font-folder-path>` with the folder containing the `.ttf` files)

---

## 4️⃣ Create Fontconfig Configuration

Create a configuration directory if it doesn't exist:

```bash
mkdir -p ~/.config/fontconfig
```

---

## 5️⃣ Create or Edit `fonts.conf`

Edit `~/.config/fontconfig/fonts.conf` and add the following XML content:

```xml
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
  <!-- Set preferred serif, sans serif, and monospace fonts. -->
  <alias>
   <family>sans-serif</family>
   <prefer>
    <family>Arimo</family>
    <family>Noto Sans Arabic</family>
   </prefer>
  </alias>

  <alias>
   <family>serif</family>
   <prefer>
    <family>Tinos</family>
    <family>Noto Sans Arabic</family>
   </prefer>
  </alias>

  <alias>
   <family>Sans</family>
   <prefer>
    <family>Arimo</family>
    <family>Noto Sans Arabic</family>
   </prefer>
  </alias>

  <alias>
   <family>monospace</family>
   <prefer>
    <family>Cousine</family>
    <family>Noto Sans Arabic</family>
   </prefer>
  </alias>
  <!-- Aliases for commonly used MS fonts. -->
  <match>
    <test name="family"><string>Arial</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Arimo</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>Helvetica</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Arimo</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>Verdana</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Arimo</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>Tahoma</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Arimo</string>
    </edit>
  </match>
  <match>
    <!-- Insert joke here -->
    <test name="family"><string>Comic Sans MS</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Arimo</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>Times New Roman</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Tinos</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>Times</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Tinos</string>
    </edit>
  </match>
  <match>
    <test name="family"><string>Courier New</string></test>
    <edit name="family" mode="assign" binding="strong">
      <string>Cousine</string>
    </edit>
  </match>
</fontconfig>
```

---

## ✅ Final Step

Update the font cache:

```bash
fc-cache -fv
```

Done! Your system should now use the configured fonts.
