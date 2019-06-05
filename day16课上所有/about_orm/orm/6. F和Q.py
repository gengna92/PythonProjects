import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

# F
ret = models.Book.objects.filter(price__gt=50)

from django.db.models import F, Q

ret = models.Book.objects.filter(sale__gte=F('cukun'))  # 两个字段进行对比

#
# ret = models.Book.objects.all().update(sale=F('sale')*2+5)


# Q

ret = models.Book.objects.exclude(id__gte=2, id__lte=3)  # 大于3 后者 小于2     1 4 5
ret = models.Book.objects.filter(~Q(Q(id__gt=3) | Q(id__lt=2)))  # 大于3 后者 小于2

"""
Q(条件)
~  非
& 与
| 或
"""

print(ret)
