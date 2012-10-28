#!/bin/bash
#文件名：cut-nginx-log.sh
#脚本支持http://www.zhanggang.net/y2012/41057.html

 
#先把日期赋值到变量，因为是在第二天0点后执行，所以日期应该获取前一天的，如20120903
todaydate=`date --date='yesterday' "+%Y%m%d"`
 
#把网站的子目录日志枚举一下
for site in `ls -l /home/log/ | grep -v "^d" |awk '{print $NF}'`
 
#移动昨天的日志到新的位置，重命名中增加日期标识
do
  mv /home/log/$site /home/logbak/${site}_$todaydate
done
 
#找到nginx的master进程，向它发USR1指令，让它生成新的日志
kill -USR1 `ps aux | grep nginx | grep master | awk '{print $2}'`
