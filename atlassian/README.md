#jira/confluence docker容器

#启动项目
```
docker-compose up -d
```

#获取授权
#####jira破解授权（替换对应的位置）
```
#-n 企业名称 随便起 
#-p 固定 conf
#-o 访问地址 写confluence地址
#-s 授权码写启动时候的授权码
java -jar atlassian-agent.jar -d -m vshu0121@gmail.com -n DaShu -p jira -o http://59.110.230.30 -s B4PT-BX8P-NKEP-XHHL
```
#####confluence破解授权（替换对应的位置 ）
```
#-n 企业名称 随便起 
#-p 固定 conf
#-o 访问地址 写confluence地址
#-s 授权码写启动时候的授权码
java -jar atlassian-agent.jar -d -m vshu0121@gmail.com -n DaShu -p conf -o http://59.110.230.30 -s BAQG-T6MQ-2R2R-50VU
```


#优化confluence/jira-mysql
1.停掉服务
cd /usr/local/var/atlassian
docker-compose stop
service mysql stop
vim /etc/my.conf
2.在msyqld后添加confluence/jira setter
innodb_log_file_size=2GB
max_allowed_packet=512M
cd /mnt/data/mysql/
3.删除所有的ib_logfile
rm -rf ib_logfile0
4.开启服务
service mysql start
cd /usr/local/var/atlassian
docker-compose start
