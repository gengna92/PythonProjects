from django import template
from django.conf import settings
import re
from django.conf import settings
from django.shortcuts import reverse
from collections import OrderedDict

register = template.Library()


@register.inclusion_tag('menu.html')
def menu(request):
    menu_dict = request.session.get(settings.MENU_SESSION_KEY)
    ordered_dic = OrderedDict()
    
    for key in sorted(menu_dict, key=lambda x: menu_dict[x]['weight'], reverse=True):
        i = menu_dict[key]
        ordered_dic[key] = i
        
        # 一级菜单
        i['class'] = 'hide'
        for child in i['children']:
            if request.current_menu_id == child['id']:
                child['class'] = 'active'
                i['class'] = ''
    
    return {'menu_list': ordered_dic.values()}  # 字典要交给模板进行渲染


@register.filter
def has_permission(request, name):
    if name in request.session.get(settings.PERMISSION_SESSION_KEY):
        return True


@register.inclusion_tag('breadcrumb.html')
def breadcrumb(request):
    breadcrumb_list = request.breadcrumb_list
    return {'breadcrumb_list': breadcrumb_list}


