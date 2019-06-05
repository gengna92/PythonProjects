from django.db import models

# Create your models here.

class User(models.Model):
    id = models.AutoField(primary_key=True)
    uname = models.CharField(max_length=60)
    password = models.CharField(max_length=60)
    def __str__(self):
        return '< user {} >'.format(self.uname)

class Lobline(models.Model):
    id =models.AutoField(primary_key=True)
    lname = models.CharField(max_length=60)
    user = models.ManyToManyField('User')
    def __str__(self):
        return '< Lobline {} >'.format(self.lname)


class Host(models.Model):
    id = models.AutoField(primary_key=True)
    hname =models.CharField(max_length=60)
    password = models.CharField(max_length=60)
    hlid = models.ForeignKey('Lobline',on_delete= models.CASCADE)
    def __str__(self):
        return '< Host {} >'.format(self.hname)

