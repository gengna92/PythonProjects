from django.shortcuts import render, redirect, reverse
from crm import models

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
        # 认证成功
        # 保存登录状态
        request.session['is_login'] = True
        # 查询出当前用户的权限
        # 去除权限为空的权限
        ret = obj.roles.filter(permissions__url__isnull=False).values(
            'permissions__url',
            'permissions__title',
            'permissions__name',
            'permissions__is_menu',
        ).distinct()
        # 权限字典
        permission_dict = {}
        
        # 菜单
        menu_list = []
        for i in ret:
            # 权限
            permission_dict[i['permissions__name']] = {"url":i["permissions__url"]}
            
            # 菜单信息
            if i['permissions__is_menu']:
                menu_list.append({'url': i['permissions__url'], 'title': i['permissions__title']})
        
        # 保存权限信息 菜单信息
        request.session[settings.PERMISSION_SESSION_KEY] = permission_dict
        request.session[settings.MENU_SESSION_KEY] = menu_list
        
        print(permission_dict)
        
        return redirect(reverse('crm:index'))
    return render(request, 'login.html')

