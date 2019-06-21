from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import HttpResponse, redirect, reverse
from django.conf import settings
import re
from rbac import models


class RbacMiddleware(MiddlewareMixin):
    
    def process_request(self, request):
        # 获取当前访问url地址
        url = request.path_info
        request.current_menu_id = None
        request.breadcrumb_list = [{'title': '首页', 'url': '/index/'}, ]
        # 白名单
        for i in settings.WHITE_LIST:
            if re.match(i, url):
                return
        # 没有登录 跳转登录页面
        is_login = request.session.get('is_login', False)
        if not is_login:
            return redirect(reverse('host:login'))
        
        # 已经登录 可以访问不需要权限校验的URL
        for i in settings.NO_PERMISSION_LIST:
            if re.match(i, url):
                return
        
        # 真正需要进行权限校验的地址
        permission = request.session.get(settings.PERMISSION_SESSION_KEY)
        
        for i in permission.values():
            if re.match(r'^{}$'.format(i['url']), url):
                # {'url': '/department_list/', 'id': 1, 'pid': None}   二级菜单  父权限
                # {'url': '/department_add/', 'id': 2, 'pid': 1}     子权限
                id = i['id']
                pid = i['pid']
                pname = i['pname']
                if pid:
                    # 有PID 当前访问的是子权限
                    request.current_menu_id = pid
                    # 添加父权限的信息
                    
                    # parent = models.Permission.objects.get(pk=pid)
                    # request.breadcrumb_list.append({'title': parent.title, 'url': parent.url})
                    
                    request.breadcrumb_list.append(
                        {'title': permission[pname]['title'], 'url': permission[pname]['url']})
                    request.breadcrumb_list.append({'title': i['title'], 'url': i['url']})
                else:
                    # 没有PID 当前访问的是父权限
                    request.current_menu_id = id
                    request.breadcrumb_list.append({'title': i['title'], 'url': i['url']})
                
                return
        
        return HttpResponse('没有权限，请联系管理员')
