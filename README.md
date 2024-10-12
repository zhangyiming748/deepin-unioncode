# deepin-unioncode
容器化运行deepin-ide

# 开启vnc服务

```bash
export USER=$(whoami)
vncserver :0
vncserver -kill :0
rm /tmp/.X* -r
sed -i 's$x-window-manager$xfce4-session$' ~/.vnc/xstartup
vncserver :0
```

# ide源码

1. 确保已经安装所有依赖库。

```bash
git clone https://github.com/linuxdeepin/deepin-unioncode.git
cd deepin-unioncode
git tag
git checkout 1.3.8
apt build-dep ./
```

2. 构建:

```shell
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

3. 安装:

```shell
cmake --build build --target install
```

可执行程序为 `/usr/bin/deepin-unioncode`

----

docker 容器安装 Ubuntu:novel 系统后 安装 vnc和novnc服务