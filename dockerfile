FROM debian:bookworm

# 设置中国镜像源
RUN echo -e 'deb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\n\
deb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\n\
deb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
deb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
deb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
deb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
deb http://mirrors4.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware\n\
deb-src http://mirrors4.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware' > /etc/apt/sources.list && \
    apt update -y && \
    apt install -y vim xfce4 xfce4-terminal tightvncserver tightvnc-java dbus-x11 firefox-esr xfonts-intl-chinese xfonts-wqy scim scim-pinyin && \
    rm -rf /var/lib/apt/lists/*

# 配置 VNC
RUN vncserver :0 && \
    vncserver -kill :0 && \
    rm -rf /tmp/.X* && \
    sed -i 's$x-window-manager$xfce4-session$' ~/.vnc/xstartup

EXPOSE 5900

# 启动 VNC 服务器
CMD ["vncserver", ":0"]
