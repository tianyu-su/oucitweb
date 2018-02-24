# 操作手册

 - 搭建虚拟环境并且进入虚拟环境
 - 解压 static 压缩包
 - pip install -r requirements.txt
 - 本机打开 Mysql 服务，新建数据库 **oucit**
 - 导入数据： mysql -u root -p oucit < init.sql
 - 自行修改 setting.py 中的数据库连接字符串
 - 执行 python manage.py createsuperuser
 - 进入后台: 127.0.0.1:8000/admin
