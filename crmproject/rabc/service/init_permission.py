from django.conf import  settings

def init_permissions(request,obj):
    #保存登录状态
    request.session['is_login'] = True
    #查询出当前用户的权限，并去除权限为空的权限
    ret = obj.roles.filter(permissions__url__isnull=False).values(
        'permissions__id',
        'permissions__url',
        'permissions__title',
        'permissions__name',
        'permissions__menu_id',
        'permissions__menu__title',
        'permissions__menu__icon',
        'permissions__menu__weight',
        'permissions__parent_id',
        'permissions__parent__name',
        ).distinct()
    print(ret)