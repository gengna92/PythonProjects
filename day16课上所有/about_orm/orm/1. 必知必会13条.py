import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

# 1. all() 查询所有数据  QuerySet  对象列表
ret = models.Person.objects.all()

# 2. get  获取一个对象  对象  如果没有数据或者是多条数据报错
ret = models.Person.objects.get(name='alex')


# 3. filter 查询所有满足条件的对象  QuerySet  对象列表
ret = models.Person.objects.filter(gender=0)

# 4. exclude 查询所有不满足条件的对象  QuerySet  对象列表
ret = models.Person.objects.exclude(gender=1)


# 5. values 查询字段名称和值  QuerySet  对象列表   【 {} 】
# 没有参数  所有字段名称和值
# 有参数    指定字段名称和值
ret = models.Person.objects.values('id','name')


# 6. values_list 查询数据的值  QuerySet  对象列表   【 () 】
# 没有参数  所有字段值
# 有参数    指定字段值
ret = models.Person.objects.values_list('name','gender','id')

# 7. order_by 排序   QuerySet  对象列表  默认升序

ret = models.Person.objects.all().order_by('-age','-id')

# 8. reverse 倒叙排序  前提 已经排序
ret = models.Person.objects.all().order_by('-age','-id').reverse()

# 9. distinct  去重

ret = models.Person.objects.values('age','gender').distinct()


# 10. count 计数
ret = models.Person.objects.filter(age=12).count()


# 11. first 查询第一个结果  没有就是none

ret = models.Person.objects.filter(name='xxxxx').first()

# 12. last 查询最后一个结果  没有就是none

ret = models.Person.objects.all().last()

# 13. exists 判断数据是否存在
ret = models.Person.objects.filter(name='alex').exists()

print(ret)