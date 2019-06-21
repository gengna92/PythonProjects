from django.shortcuts import render, redirect, reverse
from host import models
from host.forms import HostForm
from utils.pagination import Pagination
from rbac.service.init_permission import init_permission


# Create your views here.
def host_list(request):
    all_hosts = models.Host.objects.all()
    page = Pagination(request.GET.get('page'), all_hosts.count(), request.GET.copy(), 1)
    return render(request, 'host_list.html', {
        'all_hosts': all_hosts[page.start:page.end],
        'page_html': page.page_html
    })


def host_change(request, pk=None):
    obj = models.Host.objects.filter(pk=pk).first()
    form_obj = HostForm(instance=obj)
    if request.method == 'POST':
        form_obj = HostForm(request.POST, instance=obj)
        if form_obj.is_valid():
            form_obj.save()
            
            next = request.GET.get('next')
            return redirect(next)
    
    return render(request, 'form.html', {'form_obj': form_obj})


def host_del(request, pk):
    models.Host.objects.filter(pk=pk).delete()
    return redirect('host:host_list')


def login(request):
    if request.method == 'POST':
        user = request.POST.get('username')
        pwd = request.POST.get('password')
        
        obj = models.User.objects.filter(username=user, password=pwd).first()
        if not obj:
            return render(request, 'login.html', {'error': '用户名或密码错误'})
        # 登录成功
        # 权限信息的初始化
        init_permission(request, obj)
        # 跳转到指定页面
        return redirect('host:host_list')
    return render(request, 'login.html')
