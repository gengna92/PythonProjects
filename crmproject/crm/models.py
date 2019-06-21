from django.db import models
from rabc.models import RbacUser

# Create your models here.
class Department(models.Model):
    name = models.CharField(max_length=64,verbose_name='部门名称')

    def __str__(self):
        return self.name


class User(RbacUser):
    name = models.CharField(max_length=32,verbose_name='用户名')
    pwd = models.CharField(max_length=32,verbose_name='密码')
    gender_choice =((1,'男'),(2,'女'))
    gender = models.IntegerField(choices=gender_choice,verbose_name='性别')
    dep = models.ForeignKey(to='Department',on_delete=models.CASCADE,verbose_name='部门')

    def __str__(self):
        return self.name
