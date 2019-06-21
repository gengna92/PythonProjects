from django.utils.deprecation import MiddlewareMixin
from django.conf import settings
import re
from django.shortcuts import redirect,reverse
class RbacMiddleware(MiddlewareMixin):

    def process_request(self,request):
        url = request.path_info  #获取当前访问的url
        request.current_menu_id = None
        request.breadCrumb_list = [{'title': '首页', 'url': '/index/'},]

        for i in settings.WHITE_LIST: #过滤白名单的数据
            if re.match(i,url):
                return


        is_login = request.session.get('is_login',False)  #没有登录跳转到登录页面
        if not is_login:
            return redirect(reverse('crm:login'))


        for i in settings.NO_PERMISSION_LIST: #判断是否有权限
            if re.match(i,url):
                return

