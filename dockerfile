FROM debian:bookworm
RUN echo -e 'deb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\ndeb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\ndeb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\ndeb http://mirrors4.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware' >> /etc/apt/sources.list
RUN rm /etc/apt/sources.list.d/debian.sources
RUN apt update -y
RUN apt install vim xfce4 xfce4-terminal tightvncserver tightvnc-java dbus-x11 -y
vncserver :0
vncserver -kill :0
rm /tmp/.X* -r
sed -i 's$x-window-manager$xfce4-session$' ~/.vnc/xstartup
vncserver :0
EXPOSE 5900
RUN apt install firefox-esr xfonts-intl-chinese xfonts-wqy scim scim-pinyin -y 