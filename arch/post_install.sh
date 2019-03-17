
#!/bin/bash
#
#   My post install arch
#
#  This script assumes that standard linux installation is finised with the following packages
#  base base-devel networkmanager git
#  Relevant aspects:
#  
#  -----

INST="pacman -Sy"

do_pause () {
    printf "Pause: $1 ... press Ctrl+C to cancel"
    read -n 1 c
}

do_yn() {

    printf "Question: $1 [Y/n]?"
    read -n 1 c
    if [ "$c" = "n" -o "$c" = "N"  ] ; then
        return 1
    else
        return 0
    fi

}

echo "Arch linux post install...."
echo "==========================="
do_pause "abort script?"

printf "Enabling NetworkManager and configure wifi..."
systemctl enable NetworkManager.service
systemctl start NetworkManager.service
sleep 1
nmtui
nmcli con
echo "!"

do_yn "Create user ldiaz"
if [ $? -eq 0 ] ; then
    useradd -m -g wheel -G rfkill,uucp ldiaz
    passwd ldiaz
    #sed -i
    #echo "Defaults !tty_tickets" >> /etc/sudoers
fi

d_yn "Basic software audio,htop,ranger..."
if [ $? -eq 0 ] ; then
    $INST htop alsa-utils htop ranger screen screenfetch
fi


#    git clone https://aur.archlinux.org/yay.git
#    cd yay
#    makepkg -si

d_yn "X11+i3+fonts"
if [ $? -eq 0 ] ; then
    $INST xorg-server xorg-xinit i3-gaps i3status rxvt-unicode dmenu \
          rofi ttf-linux-libertine ttf-incosolata ttf-hack xclip autocutsel \
          nitrogen feh
    d_yn "X11 intel driver"
    if [ $? -eq 0 ] ; then
        $INST xf86-video-intel
    fi
    d_yn "XFCE4"
        if [ $? -eq 0 ] ; then
        $INST xfce4
    fi
fi



echo "done!"
exit 0


