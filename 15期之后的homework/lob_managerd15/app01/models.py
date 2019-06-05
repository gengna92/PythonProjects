from django.db import models

# Create your models here.

class User(models.Model):
    id = models.AutoField(primary_key=True)
    uname = models.CharField(max_length=60)
    password = models.CharField(max_length=60)

class Lobline(models.Model):
    id =models.AutoField(primary_key=True)
    lname = models.CharField(max_length=60)


class Host(models.Model):
    id = models.AutoField(primary_key=True)
    hname =models.CharField(max_length=60)
    password = models.CharField(max_length=60)
    hlid = models.ForeignKey('Lobline',on_delete= models.CASCADE)

