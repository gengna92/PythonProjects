from django.db import models


class Menu(models.Model):
    """
    一级菜单
    """
    title = models.CharField(max_length=32)
    icon = models.CharField(max_length=64)
    weight = models.IntegerField(default=1)


class Permission(models.Model):
    """
    权限表
    有menu_id   ——》 权限是二级菜单
    没有menu_id   ——》 权限是普通的权限
    """
    url = models.CharField(max_length=64, verbose_name='权限')
    title = models.CharField(max_length=32, verbose_name='标题')
    name = models.CharField(max_length=32, verbose_name='URL别名', unique=True)
    menu = models.ForeignKey(Menu, blank=True, null=True)
    parent = models.ForeignKey('Permission', blank=True, null=True)
    
    def __str__(self):
        return self.title


class Role(models.Model):
    """
    角色表
    """
    name = models.CharField(max_length=32, verbose_name='名称')
    permissions = models.ManyToManyField('Permission', verbose_name='角色所拥有的权限', blank=True)
    
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
