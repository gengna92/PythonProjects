import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

# 基于对象的查询
author_obj = models.Author.objects.get(id=1)  # 二狗子
# print(author_obj.books,type(author_obj.books))
# print(author_obj.books.all())


book_obj = models.Book.objects.get(title='二狗的悲惨人生')
# print(book_obj)
# print(book_obj.author_set.all())   #  author_set  没有指定
# print(book_obj.authors.all())  # related_name='authors'


# all   查询所有的书籍

# add  添加多对多的关系
# author_obj.books.add(3)  # 添加多对多的关系
# author_obj.books.add(3,4)  # 添加多对多的关系
# author_obj.books.add(models.Book.objects.get(id=4))  # 添加多对多的关系

# remove  删除多对多的关系

# book_obj.authors.remove(1)
# book_obj.authors.remove(models.Author.objects.get(id=2))

# set  设置多对多的关系
# author_obj.books.set([1])
# author_obj.books.set(models.Book.objects.filter(id__in=[3,4]))


# clear 清除所有的多对多的关系

# author_obj.books.clear()

# create
# author_obj.books.create(title='xxxx',publisher_id='1')  # 二狗子
book_obj.authors.create(name='小二狗')






