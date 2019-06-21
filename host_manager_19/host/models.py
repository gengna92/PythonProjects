from django.db import models
from rbac.models import RbacUser

class BusinessUnit(models.Model):
    name = models.CharField(max_length=32, verbose_name='业务线名称')
    
    def __str__(self):
        return self.name


class Host(models.Model):
    name = models.CharField(max_length=32, unique=True, verbose_name='主机名')
    ip = models.GenericIPAddressField(verbose_name='IP')
    bus_unit = models.ForeignKey('BusinessUnit', on_delete=models.CASCADE, verbose_name='业务线')


class User(RbacUser):
    username = models.CharField(max_length=32, verbose_name='用户名')
    password = models.CharField(max_length=32, verbose_name='密码')