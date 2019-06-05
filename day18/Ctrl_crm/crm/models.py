from django.db import models
from django.utils.safestring import mark_safe
from rbac.models import RbacUser

class Department(models.Model):
    name = models.CharField(max_length=32, verbose_name='部门名称')
    des = models.TextField(null=True, blank=True, verbose_name='部门描述')
    
    def __str__(self):
        return self.name


class User(RbacUser):
    username = models.CharField('用户名', max_length=32, )
    password = models.CharField(max_length=32, verbose_name='密码')
    gender_choice = ((1, '男'), (2, '女'))
    gender = models.IntegerField(choices=gender_choice, verbose_name='性别')
    depart = models.ForeignKey(to='Department', on_delete=models.CASCADE, verbose_name='部门')
    
    def __str__(self):
        return self.username


class Course(models.Model):
    """
    课程表
    如：
        Linux基础
        Linux架构师
        Python自动化
        Python全栈
    """
    name = models.CharField(verbose_name='课程名称', max_length=32)
    
    def __str__(self):
        return self.name


class School(models.Model):
    """
    校区表
    如：
        北京昌平校区
        上海浦东校区
        深圳南山校区
    """
    title = models.CharField(verbose_name='校区名称', max_length=32)
    
    def __str__(self):
        return self.title


class ClassList(models.Model):
    """
    班级表
    如：
        Python全栈  面授班  5期  10000  2017-11-11  2018-5-11
    """
    school = models.ForeignKey(verbose_name='校区', to='School')
    course = models.ForeignKey(verbose_name='课程名称', to='Course')
    semester = models.IntegerField(verbose_name="班级(期)")  # 11
    price = models.IntegerField(verbose_name="学费")
    start_date = models.DateField(verbose_name="开班日期")
    graduate_date = models.DateField(verbose_name="结业日期", null=True, blank=True)
    
    tutor = models.ForeignKey(verbose_name='班主任', to='User', related_name='classes')
    teachers = models.ManyToManyField(verbose_name='任课老师', to='User', related_name='teach_classes')
    
    memo = models.CharField(verbose_name='说明', max_length=255, blank=True, null=True)
    
    class Meta:
        unique_together = ('school', 'course', 'semester')
    
    def show_teachers(self):
        return ' | '.join([teacher.username for teacher in self.teachers.all()])
    
    def get_teacher(self):
        return mark_safe('<a href="https://www.cnblogs.com/#p5"> {} </a>'.format(self.tutor.username))
