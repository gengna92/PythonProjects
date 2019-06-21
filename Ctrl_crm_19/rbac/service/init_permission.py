from django.conf import settings


def init_permission(request, obj):
    # 保存登录状态
    request.session['is_login'] = True
    # 查询出当前用户的权限
    # 去除权限为空的权限
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
    # 权限字典
    permission_dict = {}
    
    # 菜单
    menu_dict = {}
    for i in ret:
        # 权限
        permission_dict[i['permissions__name']] = {
            "url": i["permissions__url"],
            "title": i["permissions__title"],
            'id': i['permissions__id'],
            'pid': i['permissions__parent_id'],
            'pname': i['permissions__parent__name'],
        }
        
        menu_id = i.get('permissions__menu_id')
        
        if not menu_id:
            continue
        if menu_id not in menu_dict:
            menu_dict[menu_id] = {
                'title': i['permissions__menu__title'],
                'icon': i['permissions__menu__icon'],
                'weight': i['permissions__menu__weight'],
                'children': [
                    {
                        'url': i['permissions__url'],
                        'title': i['permissions__title'],
                        'id': i['permissions__id'],
                    }
                ]
            }
        else:
            menu_dict[menu_id]['children'].append({'url': i['permissions__url'], 'title': i['permissions__title']})
    
    # 保存权限信息 菜单信息
    request.session[settings.PERMISSION_SESSION_KEY] = permission_dict
    request.session[settings.MENU_SESSION_KEY] = menu_dict
