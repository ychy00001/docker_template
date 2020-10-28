# nginx默认账号密码
username: root 
password: 123 

# 更改权限
```
chown -R 1000:root ./elastic/data1
chown -R 1000:root ./elastic/data2
chown -R 1000:root ./elastic/plugins
```

# 宿主机配置

## Linux

The vm.max_map_count setting should be set permanently in /etc/sysctl.conf:

```
grep vm.max_map_count /etc/sysctl.conf
vm.max_map_count=262144
```

To apply the setting on a live system, run:

```
sysctl -w vm.max_map_count=262144
```

## macOS with Docker for Mac

The vm.max_map_count setting must be set within the xhyve virtual machine:

a. From the command line, run:
```
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
```
b. Press enter and use`sysctl` to configure vm.max_map_count:
```
sysctl -w vm.max_map_count=262144
```
c. To exit the screen session, type Ctrl a d.


## Windows and macOS with Docker Desktop

The vm.max_map_count setting must be set via docker-machine:

```
docker-machine ssh
sudo sysctl -w vm.max_map_count=262144
Windows with Docker Desktop WSL 2 backend
```

The vm.max_map_count setting must be set in the docker-desktop container:

```
wsl -d docker-desktop
sysctl -w vm.max_map_count=262144
```


# 启动服务
```
docker-compose up -d
```

# es 初始化测试数据
数据文件在 elastic/resource中
```
docker-compose exec es0 bash
cd resource
curl -H "Content-Type: application/json" -XPOST "localhost:9200/bank/_bulk?pretty&refresh" --data-binary "@accounts.json"
curl "localhost:9200/_cat/indices?v"
```

# es ik分词自定义分词
可以直接在nginx/conf.d/my_dict.txt中 utf-8编码 \n 换行添加

# 备注
docker镜像为自己国内仓库的镜像基于elastic原生对应版本镜像，方便国内拉取

