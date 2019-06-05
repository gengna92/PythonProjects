from django.test import TestCase

# Create your tests here.
import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "line_manager.settings")
import django

django.setup()

from app01 import models
# ret = models.User.objects.exclude(id__in=[2,3])
ret = models.User.objects.values()
ret = models.User.objects.values_list()
ret = models.User.objects.all().order_by('uname').reverse()
# ret = models.Host.objects.all().distinct('hlid__user__uname')
ret = models.User.objects.count()
ret = models.User.objects.exists()

ret = models.User.objects.filter(uname__icontains='O')



#基于对象的查询
##host and line正向查询 子表----查询主表
host = models.Host.objects.first()
# print(host.hname)
# print(host.hlid)
# print(host.hlid.lname)
#
# print(models.Host.objects.values_list('hlid__lname'))

#查询line2对应的主机name 反向查询 主表-----查询子表

obj = models.Lobline.objects.get(lname='line2')
ret=obj.host_set.all()
# print(ret)


#基于字段的查询
#根据业务线查询主机
print(models.Host.objects.filter(hlid__lname__contains='line2'))
print(models.Host.objects.filter(hlid__lname='line2'))

#根据主机查询业务线
print(models.Lobline.objects.filter(host__hname='h1'))
