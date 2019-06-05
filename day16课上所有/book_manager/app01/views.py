from django.shortcuts import render, redirect, reverse, HttpResponse
from app01 import models
from django.conf import global_settings

from django.contrib.sessions.backends import db


import time


def login_required(func):
    def inner(request, *args, **kwargs):
        # 获取普通的COOKIE
        # is_login = request.COOKIES.get('is_login')
        # 获取加密的COOKIE
        # is_login = request.get_signed_cookie('is_login', salt='s25', default='')
        
        # 获取session
        is_login = request.session.get('is_login')
        
        if is_login != '1':
            # 没有登录 跳转到登录页面
            
            url = request.path_info
            return_url = "{}?return_url={}".format(reverse('app01:login'), url)
            
            return redirect(return_url)
        ret = func(request, *args, **kwargs)
        return ret
    
    return inner


def login(request):
    request.session.clear_expired()
    error = ''
    if request.method == 'POST':
        user = request.POST.get('user')
        pwd = request.POST.get('pwd')
        if user == 'alex' and pwd == '123':
            
            # http://127.0.0.1:8000/app01/login/?return_url=/app01/book_list/
            # 登录成功
            
            # 获取要跳转的地址
            return_url = request.GET.get('return_url')  # '/app01/book_list/'
            
            # 保存登录状态
            if return_url:
                ret = redirect(return_url)
            else:
                ret = redirect(reverse('app01:publisher'))
            
            # 设置普通cookie
            # ret.set_cookie('is_login', '1')  # max_age 超时时间  path cookie生效的路径
            # 设置加密cookie
            # ret.set_signed_cookie('is_login', '1', 's25')
            
            # 设置session
            request.session['is_login'] = '1'

            request.session.set_expiry(0)
            
            
            return ret
        
        error = '用户名或密码错误'
    
    return render(request, 'login.html', {'error': error})


def logout(request):
    # request.session.delete()  # 删除session数据  不删除cookie
    request.session.flush()    # 删除session数据  删除cookie
    return redirect(reverse('app01:login'))

def timer(func):
    def inner(request, *args, **kwargs):
        print(func)
        print(args)
        start = time.time()
        ret = func(request, *args, **kwargs)
        end = time.time()
        print('执行时间是是：{}'.format(end - start))
        return ret
    
    return inner


# @timer
@login_required
def publisher(request):
    # 数据库查询所有的出版社
    all_publisher = models.Publisher.objects.all()  # 对象列表
    print(request.session.session_key)
    
    print(request.session.exists('k5x30wz6oiktgp7rninidbptlembbc6f'))
    return render(request, 'publisher.html', {'all_publisher': all_publisher})


def add_publisher(request):
    if request.method == 'POST':
        # 获取form表单中数据
        new_name = request.POST.get('new_name')
        # 保存到数据库中
        ret = models.Publisher.objects.create(name=new_name)
        # print(ret, type(ret))
        # print(ret.id, ret.name)
        return redirect(reverse('app01:publisher'))  # /app01/publisher_list/
    return render(request, 'add_publisher.html')


from django.views import View
from django.utils.decorators import method_decorator


# @method_decorator(timer, name='get')
# @method_decorator(timer, name='post')
# @method_decorator(timer, name='dispatch')
class AddPublisher(View):
    # http_method_names = ['post', 'put', 'patch', 'delete', 'head', 'options', 'trace']
    
    # @method_decorator(timer)
    # def dispatch(self, request, *args, **kwargs):
    #     ret = super().dispatch(request, *args, **kwargs)
    #     return ret
    
    @method_decorator(timer)
    def get(self, request):
        print('get')
        
        return render(request, 'add_publisher.html')
    
    def post(self, request):
        print(request.body)
        print('post')
        # 获取form表单中数据
        new_name = request.POST.get('new_name')
        # 保存到数据库中
        ret = models.Publisher.objects.create(name=new_name)
        return redirect(reverse('app01:publisher'))  # /app01/publisher_list/


def edit_publisher(request, pk):
    # pk = request.GET.get('pk')
    edit_obj = models.Publisher.objects.filter(pk=pk).first()
    if request.method == 'POST':
        new_name = request.POST.get('new_name')
        edit_obj.name = new_name  # 在内存中修改数据
        edit_obj.save()  # 提交到数据库中
        return redirect(reverse('app01:publisher'))  # /app01/publisher_list/
    return render(request, 'edit_publisher.html', {'edit_obj': edit_obj})


@login_required
def book(request):
    # 查询所有的书籍
    all_book = models.Book.objects.all()
    # for book in all_book:
    #     print(book,type(book))
    #     print(book.title)
    #     print(book.publisher,type(book.publisher))  # 所关联的出版社对象
    #     print(book.publisher.name)  # 所关联的出版社对象名称
    #     print(book.publisher_id)    # 所关联的出版社对象id
    
    return render(request, 'book.html', {'all_book': all_book})


class AddBook(View):
    def get(self, request):
        # 获取所有的出版社
        all_publisher = models.Publisher.objects.all()
        return render(request, 'add_book.html', {'all_publisher': all_publisher})
    
    def post(self, request):
        # 获取提交的数据
        book_name = request.POST.get('new_name')
        pub_id = request.POST.get('pub_id')
        # 插入到数据库中
        # models.Book.objects.create(title=book_name, publisher=models.Publisher.objects.get(pk=pub_id))
        models.Book.objects.create(title=book_name, publisher_id=pub_id)
        
        return redirect(reverse('app01:book'))


def edit_book(request, edit_id):
    book_obj = models.Book.objects.filter(pk=edit_id).first()
    
    if request.method == 'POST':
        # 获取提交的数据
        book_name = request.POST.get('new_name')
        pub_id = request.POST.get('pub_id')
        # 修改对象
        book_obj.title = book_name
        book_obj.publisher_id = pub_id
        # book_obj.publisher = models.Publisher.objects.get(pk=pub_id)
        book_obj.save()
        # 跳转到展示页面
        return redirect(reverse('app01:book'))
    
    all_publisher = models.Publisher.objects.all()
    return render(request, 'edit_book.html', {'book_obj': book_obj, 'all_publisher': all_publisher})


def delete(request, table, del_id):
    # print(table, del_id)
    # 获取表对应的类
    table_class = getattr(models, table.capitalize())
    # 查询出对象列表并删除
    table_class.objects.filter(pk=del_id).delete()
    # 跳转到指定页面
    return redirect(reverse('app01:{}'.format(table)))
