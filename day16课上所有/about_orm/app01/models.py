from django.db import models


class Person(models.Model):
    # pid = models.AutoField(primary_key=True)  # 自增字段
    name = models.CharField(max_length=32, db_column='username', unique=True, verbose_name='姓名')  # varchar(32)
    age = models.IntegerField(blank=True, null=True, verbose_name='年龄')  # 当前字段数据库中可不填
    # birth = models.DateTimeField(auto_now_add=True)  # 新增数据时自动保存当前的时间
    birth = models.DateTimeField(auto_now=True)  # 新增和修改数据时自动保存当前的时间
    gender = models.BooleanField(choices=[(0, '男'), (1, '女')])
    
    def __str__(self):
        return '< Person {} >'.format(self.name)
    
    class Meta:
        # 数据库中生成的表名称 默认 app名称 + 下划线 + 类名
        db_table = "person"
        
        # admin中显示的表名称
        # verbose_name = '个人信息'
        
        # verbose_name加s
        # verbose_name_plural = '所有用户信息'
        
        # # 联合索引
        # index_together = [
        #     ("pub_date", "deadline"),  # 应为两个存在的字段
        # ]
        #
        # # 联合唯一索引
        # unique_together = (("name", "age"),)  # 应为两个存在的字段


class Publisher(models.Model):
    name = models.CharField(max_length=32)
    
    def __str__(self):
        return '< Publisher {} >'.format(self.name)


class Book(models.Model):
    title = models.CharField(max_length=32)
    price = models.DecimalField(max_digits=5, decimal_places=2)  # 999.99
    sale = models.IntegerField()
    cukun = models.IntegerField()
    publisher = models.ForeignKey('Publisher', on_delete=models.CASCADE, related_name='books',
                                  related_query_name='book', null=True)
    
    # authors = models.ManyToManyField('Author')  # 自动生成第三张表
    def __str__(self):
        return '< Book {} >'.format(self.title)


class Author(models.Model):
    name = models.CharField(max_length=32)
    books = models.ManyToManyField('Book', related_name='authors')  # 自动生成第三张表
