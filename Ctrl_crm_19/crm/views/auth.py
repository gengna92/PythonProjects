from django.shortcuts import render, redirect, reverse
from crm import models
from rbac.service.init_permission import init_permission
import hashlib
from django.conf import settings


def index(request):
    return render(request, 'index.html')


def login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        md5 = hashlib.md5()
        md5.update(password.encode('utf-8'))
        
        obj = models.User.objects.filter(username=username, password=md5.hexdigest()).first()
        
        if not obj:
            # 认证失败
            return render(request, 'login.html', {'error': '用户名或密码错误'})
        # 认证成功 权限信息的初识化
        init_permission(request,obj)
        
 
        return redirect(reverse('crm:index'))
    return render(request, 'login.html')
