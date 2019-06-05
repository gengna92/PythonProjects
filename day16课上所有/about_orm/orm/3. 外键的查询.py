import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

# 外键的查询
# 基于对象查询
# 正向查询  多  ——》 一

book_obj = models.Book.objects.get(id=1)
# print(book_obj.title)
# print(book_obj.publisher)  # 所关联的出版社
# print(book_obj.publisher_id)  # 所关联的出版社的id


# 反向查询  一  ——》 多
pub_obj = models.Publisher.objects.get(id=3)

# 外键中不指定related_name
# print(pub_obj.book_set)         # 关系管理对象
# print(pub_obj.book_set.all())   # 出版社出版的所有书籍

# 外键不指定related_name=’books‘
# print(pub_obj.books)         # 关系管理对象
# print(pub_obj.books.all())   # 出版社出版的所有书籍

# 基于字段的查询

ret = models.Book.objects.filter(publisher__name__contains='沙河')  # __ 跨表

# 不指定related_name  表名__字段名
# ret = models.Publisher.objects.filter(book__title='二狗子的美好生活1')


# 指定related_name  books__字段名
# ret = models.Publisher.objects.filter(books__title='二狗子的美好生活1')

# 指定related_query_name='book'  book__字段名
ret = models.Publisher.objects.filter(book__title='二狗子的美好生活1')

print(ret)
