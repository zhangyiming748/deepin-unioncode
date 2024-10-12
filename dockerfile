FROM debian:bookworm

# 添加源
RUN printf 'deb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\ndeb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\ndeb http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\ndeb http://mirrors4.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware\ndeb-src http://mirrors4.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware' >> /etc/apt/sources.list

# 更新并安装必要的软件
RUN apt update -y && apt install -y vim xfce4 xfce4-terminal tightvncserver tightvnc-java dbus-x11

# 暴露 VNC 端口
EXPOSE 5900

# 安装其他软件
RUN apt install -y firefox-esr xfonts-intl-chinese xfonts-wqy scim scim-pinyin git build-essential
# docker build -t vnc:1 .
# docker run -dit --name vnc -p 5900:5900 -v /C/Users/zen/Github/deepin-unioncode/swap:/root/swap vnc:1 bash
# docker exec -it vnc bash