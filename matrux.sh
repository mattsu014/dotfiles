#!/bin/bash

basics_packages() {
    sudo pacman -S --noconfirm ttf-dejavu noto-fonts noto-fonts-emoji ttf-liberation
    sudo pacman -S --noconfirm ttf-font-awesome
    sudo pacman -S --noconfirm gst-libav gst-plugins-bad gst-plugins-good gst-plugins-ugly ffmpeg gstreamer
    sudo pacman -S --noconfirm hyprland kitty
    sudo pacman -S --noconfirm xdg-desktop-portal xdg-desktop-portal-hyprland
    sudo pacman -S --noconfirm cargo
    cp -f ~/dotfiles/SystemStyle/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
    cp -r ~/dotfiles/SystemStyle/kitty ~/.config/
}

nvidia_packages() {
    sudo pacman -S --noconfirm nvidia nvidia-utils lib32-nvidia-utils
    sudo pacman -S --noconfirm vulkan-icd-loader lib32-vulkan-icd-loader
    sudo pacman -S --noconfirm vulkan-tools
    sudo pacman -S --noconfirm mesa-utils
}

yay_packages() {
    sudo pacman -S --noconfirm --needed git base-devel
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin || exit
    makepkg -si --noconfirm
    cd ..
}

dark_theme_config() {
    sudo pacman -S --noconfirm gtk3 gtk4 gnome-themes-extra
    mkdir -p ~/.config/gtk-3.0
    cat > ~/.config/gtk-3.0/settings.ini << 'EOF'
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=Sans 10
EOF

    mkdir -p ~/.config/gtk-4.0
    cat > ~/.config/gtk-4.0/settings.ini << 'EOF'
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Adwaita
gtk-font-name=Sans 10
EOF
}

folder_manager() {
    sudo pacman -S --noconfirm thunar thunar-archive-plugin tumbler ffmpegthumbnailer
    xdg-mime default thunar.desktop inode/directory
    mkdir -p ~/Desktop
    mkdir -p ~/Downloads
    mkdir -p ~/Documents
    mkdir -p ~/Images
    mkdir -p ~/Videos
}

rofi_config() {
    sudo pacman -S --noconfirm rofi
    mkdir -p ~/.config/rofi
    cat > ~/.config/rofi/config.rasi << 'EOF'
* {
    font: "Figtree 13";
    g-spacing: 10px;
    g-margin: 0;
    b-color: #000000FF;
    fg-color: #FFFFFFFF;
    fgp-color: #888888FF;
    b-radius: 8px;
    g-padding: 8px;
    hl-color: #FFFFFFFF;
    hlt-color: #000000FF;
    alt-color: #111111FF;
    wbg-color: #000000CC;
    w-border: 2px solid;
    w-border-color: #FFFFFFFF;
    w-padding: 12px;
}

configuration {
    modi: "drun";
    show-icons: true;
    display-drun: "";
}

listview {
    columns: 1;
    lines: 7;
    fixed-height: true;
    fixed-columns: true;
    cycle: false;
    scrollbar: false;
    border: 0px solid;
}

window {
    transparency: "real";
    width: 450px;
    border-radius: @b-radius;
    background-color: @wbg-color;
    border: @w-border;
    border-color: @w-border-color;
    padding: @w-padding;
}

prompt {
    text-color: @fg-color;
}

inputbar {
    children: ["prompt", "entry"];
    spacing: @g-spacing;
}

entry {
    placeholder: "Search Apps";
    text-color: @fg-color;
    placeholder-color: @fgp-color;
}

mainbox {
    spacing: @g-spacing;
    margin: @g-margin;
    padding: @g-padding;
    children: ["inputbar", "listview", "message"];
}

element {
    spacing: @g-spacing;
    margin: @g-margin;
    padding: @g-padding;
    border: 0px solid;
    border-radius: @b-radius;
    border-color: @b-color;
    background-color: transparent;
    text-color: @fg-color;
}

element normal.normal {
    background-color: transparent;
    text-color: @fg-color;
}

element alternate.normal {
    background-color: @alt-color;
    text-color: @fg-color;
}

element selected.active {
    background-color: @hl-color;
    text-color: @hlt-color;
}

element selected.normal {
    background-color: @hl-color;
    text-color: @hlt-color;
}

message {
    background-color: red;
    border: 0px solid;
}
EOF
}

waybar_style() {
    sudo pacman -S --noconfirm waybar
    mkdir -p ~/.config/waybar
    cp -r ~/dotfiles/SystemStyle/waybar ~/.config/
}

hyprpaper_config() {
    sudo pacman -S --noconfirm hyprpaper
    mkdir -p ~/.config/hypr
    cat > ~/.config/hypr/hyprpaper.conf << 'EOF'
preload = ~/dotfiles/SystemStyle/wallpaper.jpg
wallpaper = ,~/dotfiles/SystemStyle/wallpaper.jpg
EOF
}

extra_programs() {
    sudo pacman -S --noconfirm discord
    sudo pacman -S --noconfirm flatpak
    sudo pacman -S --noconfirm udisks2
    sudo pacman -S --noconfirm pavucontrol
    sudo pacman -S --noconfirm tlp tlp-rdw
}



echo "Hi, Welcome to Matrux install"

echo "Install Basics Packages?"
select option in "Yes" "No"; do
    case $option in
        "Yes") basics_packages; break ;;
        "No") break ;;
    esac
done

echo "Install Nvidia Packages?"
select option in "Yes" "No"; do
    case $option in
        "Yes") nvidia_packages; break ;;
        "No") break ;;
    esac
done

echo "Install yay Packages?"
select option in "Yes" "No"; do
    case $option in
        "Yes") 
            yay_packages
            echo "Install Brave Browser?"
            select brave_option in "Yes" "No"; do
                case $brave_option in
                    "Yes") yay -S --noconfirm brave-bin; break ;;
                    "No") break ;;
                esac
            done
            break ;;
        "No") break ;;
    esac
done

echo "Install Dark Theme Packages?"
select option in "Yes" "No"; do
    case $option in
        "Yes") dark_theme_config; break ;;
        "No") break ;;
    esac
done

echo "Install Folder Manager?"
select option in "Yes" "No"; do
    case $option in
        "Yes") folder_manager; break ;;
        "No") break ;;
    esac
done

echo "Install Rofi?"
select option in "Yes" "No"; do
    case $option in
        "Yes") rofi_config; break ;;
        "No") break ;;
    esac
done

echo "Install Waybar Style?"
select option in "Yes" "No"; do
    case $option in
        "Yes") waybar_style; break ;;
        "No") break ;;
    esac
done

echo "Install Hyprpaper Style?"
select option in "Yes" "No"; do
    case $option in
        "Yes") hyprpaper_config; break ;;
        "No") break ;;
    esac
done

echo "Install extra programs (discord, flatpak, udisks2, pavucontrol tlp tlp-rdw)?"
select option in "Yes" "No"; do
    case $option in
        "Yes") extra_programs; break ;;
        "No") break ;;
    esac
done

echo "Installation complete!"