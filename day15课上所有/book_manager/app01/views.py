from django.shortcuts import render, redirect, reverse, HttpResponse
from app01 import models

import time


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
def publisher(request):
    # 数据库查询所有的出版社
    all_publisher = models.Publisher.objects.all()  # 对象列表
    # 返回一个页面
    # ret = reverse('publisher')
    # print(ret, type(ret))
    # ret = reverse('edit_publisher',args=('2',))
    # print(ret, type(ret))
    #
    # ret = reverse('book', args=('2019','06'))
    # print(ret, type(ret))
    # ret = reverse('book', kwargs={'year':'2017','month':'05'})
    # print(ret, type(ret))
    
    print(request.path_info, type(request.path_info))
    print(request.get_full_path(), type(request.get_full_path()))
    # print(request.scheme,type(request.scheme))
    # print(request.META)
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
    table_class = getattr(models,table.capitalize())
    # 查询出对象列表并删除
    table_class.objects.filter(pk=del_id).delete()
    # 跳转到指定页面
    return redirect(reverse('app01:{}'.format(table)))
