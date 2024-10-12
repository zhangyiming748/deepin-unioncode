# docker build -t ubuntu-vnc-novnc .
# docker run -d -p 5901:5901 -p 5900:5900 -p 8080:8080 --name my-vnc-container ubuntu-vnc-novnc
# 使用 Ubuntu 作为基础镜像
FROM ubuntu:noble

# 特色代码
RUN rm /etc/apt/sources.list.d/ubuntu.sources
COPY noble.sources /etc/apt/sources.list.d
COPY install-retry.sh /usr/local/bin
RUN chmod +x /usr/local/bin/install-retry.sh
# 更新包列表并安装必要的包
RUN apt-get update
RUN /usr/local/bin/install-retry.sh xfce4 xfce4-goodies tightvncserver websockify novnc dbus-x11 language-pack-zh-hans
RUN apt-get clean

# 设置 VNC 密码
ENV USER=$(whoami)
RUN mkdir -p /root/.vnc
RUN echo "yourpassword" | vncpasswd -f > /root/.vnc/passwd
RUN chmod 600 /root/.vnc/passwd

RUN echo -e '#!/bin/sh\n\n# 启动 xfce4\nstartxfce4 &\n# 启动 xfce4 面板\nxfce4-panel &\n' > ~/.vnc/xstartup
RUN chmod a+x ~/.vnc/xstartup
# 设置中文界面
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8

# 启动 VNC 服务器
CMD ["sh", "-c", "vncserver :0 -geometry 1280x800 -depth 24 && tail -f /root/.vnc/*.log"]
