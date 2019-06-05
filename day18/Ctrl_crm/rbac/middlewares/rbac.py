from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import HttpResponse, redirect, reverse
from django.conf import settings
import re


class RbacMiddleware(MiddlewareMixin):
    
    def process_request(self, request):
        # 获取当前访问url地址
        url = request.path_info
        # 白名单
        for i in settings.WHITE_LIST:
            if re.match(i, url):
                return
        # 没有登录 跳转登录页面
        is_login = request.session.get('is_login', False)
        if not is_login:
            return redirect(reverse('crm:login'))
        
        # 已经登录 可以访问不需要权限校验的URL
        for i in settings.NO_PERMISSION_LIST:
            if re.match(i, url):
                return
        
        # 真正需要进行权限校验的地址
        permission = request.session.get(settings.PERMISSION_SESSION_KEY)
        
        for i in permission.values():
            if re.match(i['url'], url):
                return
        
        return HttpResponse('没有权限，请联系管理员')
