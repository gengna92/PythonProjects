from django import template
from django.conf import settings

register = template.Library()


@register.inclusion_tag('menu.html')
def menu(request):
    menu_list = request.session.get(settings.MENU_SESSION_KEY)
    return {'menu_list': menu_list}  # 字典要交给模板进行渲染
