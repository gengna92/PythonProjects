from django.db import models


class Department(models.Model):
    name = models.CharField(max_length=32,verbose_name='部门名称')
    des = models.TextField(null=True, blank=True,verbose_name='部门描述')
