# docker build -t ubuntu-vnc-novnc .
# docker run -d -p 5900:5900 -v C:\Users\zen\Github\deepin-unioncode\swap:/root/swap --name my-vnc-container ubuntu-vnc-novnc
# docker exec -it my-vnc-container bash
# 使用 Ubuntu 作为基础镜像
FROM ubuntu:noble

# 特色代码
RUN rm /etc/apt/sources.list.d/ubuntu.sources
COPY noble.sources /etc/apt/sources.list.d
COPY install-retry.sh /usr/local/bin
RUN chmod +x /usr/local/bin/install-retry.sh
# 更新包列表并安装必要的包
RUN apt-get update
RUN /usr/local/bin/install-retry.sh xfce4 xfce4-goodies tightvncserver websockify novnc dbus-x11 language-pack-zh-hans build-essential git
RUN apt-get clean

# 设置 VNC 密码
ENV USER=$(whoami)
RUN mkdir -p /root/.vnc
RUN echo "yourpassword" | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd

RUN echo -e '#!/bin/sh\n\n# 启动 xfce4\nstartxfce4 &\n' > ~/.vnc/xstartup
RUN chmod a+x ~/.vnc/xstartup
# 设置中文界面
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8

# 启动 VNC 服务器
CMD ["sh", "-c", "vncserver :0 -geometry 1920x1080 -depth 24 && tail -f /root/.vnc/*.log"]
