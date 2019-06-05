from django.db import models


class Publisher(models.Model):
    # pid = models.AutoField(primary_key=True)  # pid 主键
    name = models.CharField(max_length=32)  # varchar(32)


class Book(models.Model):
    title = models.CharField(max_length=32)
    publisher = models.ForeignKey(Publisher, on_delete=models.CASCADE)
