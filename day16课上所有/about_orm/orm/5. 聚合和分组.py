import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

from django.db.models import Avg, Sum, Max, Min, Count

# 聚合   ——》 字典   终止子句
ret = models.Book.objects.all().aggregate(Avg('price'))  # {'price__avg': 100.0}
ret = models.Book.objects.all().aggregate(avg=Avg('price'))  # {'avg': 72.0}

ret = models.Book.objects.all().aggregate(max=Max('price'))  # {'avg': 72.0}

# 分组
# 统计每一本书的作者个数


ret = models.Book.objects.all().annotate(Count('authors'))

# 统计出每个出版社买的最便宜的书的价格

ret = models.Publisher.objects.annotate(min=Min('book__price')).values()

ret = models.Book.objects.values('publisher__name').annotate(min=Min('price')).values('publisher__name', 'min')


# 统计不止一个作者的图书
ret = models.Book.objects.all().annotate(count=Count('authors')).filter(count__gte=2)

# 查询各个作者出的书的总价格

ret = models.Author.objects.annotate(Sum('books__price')).values()

for i in ret:
    print(i)