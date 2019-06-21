from django.db import models

# Create your models here.
class Menu(models.Model):
    title = models.CharField(max_length=32)
    weight = models.IntegerField(default=1)
    icon = models.CharField(max_length=64)

    def __str__(self):
        return self.title


class Permission(models.Model):
    url = models.CharField(max_length=64, verbose_name='权限')
    title = models.CharField(max_length=32, verbose_name='标题')
    name = models.CharField(max_length=32, verbose_name='URL别名', unique=True)
    menu = models.ForeignKey(Menu, blank=True, null=True)
    parent = models.ForeignKey('Permission', blank=True, null=True)

    def __str__(self):
        return self.title

class Role(models.Model):
    name = models.CharField(max_length=64, verbose_name='名称')
    permissions = models.ManyToManyField('Permission',verbose_name='角色所拥有的权限',blank=True)

    def __str__(self):
        return self.name



class RbacUser(models.Model):
    """
    用户表
    """
    # username = models.CharField(max_length=32, verbose_name='用户名')
    # password = models.CharField(max_length=32, verbose_name='密码')
    roles = models.ManyToManyField(Role, verbose_name='用户所拥有的角色', blank=True)

    class Meta:
        abstract = True  # 数据库迁移的时候不生成表  作为基类 继承使用