import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

ret = models.Person.objects.filter(id=5)
# id<5
ret = models.Person.objects.filter(id__lt=5)  # less then

ret = models.Person.objects.filter(id__gt=4)  # greater then

ret = models.Person.objects.filter(id__lte=5)  # less then equal

ret = models.Person.objects.filter(id__gte=4)  # greater then equal

ret = models.Person.objects.filter(id__in=[1, 3, 5])

ret = models.Person.objects.filter(id__range=[1, 5])

ret = models.Person.objects.filter(name__contains='alex')  # 包含  like

ret = models.Person.objects.filter(name__icontains='alex')  # 包含  like 忽略大小写


ret = models.Person.objects.filter(name__startswith='a')  # 以什么开头  like

ret = models.Person.objects.filter(name__istartswith='a')  # 以什么开头  like 忽略大小写

ret = models.Person.objects.filter(name__endswith='1')  # 以什么结尾  like

ret = models.Person.objects.filter(name__iendswith='a')  # 以什么结尾  like 忽略大小写

ret = models.Person.objects.filter(birth__year='2018')  # 年份


ret = models.Person.objects.filter(birth__contains='2019-05-19')  # 以什么开头  like 忽略大小写


ret = models.Person.objects.filter(age__isnull=True)

print(ret)
