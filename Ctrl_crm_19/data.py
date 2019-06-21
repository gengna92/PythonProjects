data = [{
    'permissions__url': '/department_list/',
    'permissions__title': '部门列表',
    'permissions__name': 'department_list',
    'permissions__menu_id': 1,
    'permissions__menu__title': '信息管理',
    'permissions__menu__icon': 'fa-map-o'
}, {
    'permissions__url': '/order_list/',
    'permissions__title': '账单列表',
    'permissions__name': 'department_list',
    'permissions__menu_id': 1,
    'permissions__menu__title': '信息管理',
    'permissions__menu__icon': 'fa-map-o'
}, {
    'permissions__url': '/department_add/',
    'permissions__title': '添加部门',
    'permissions__name': 'add_department',
    'permissions__menu_id': None,
    'permissions__menu__title': None,
    'permissions__menu__icon': None
}, {
    'permissions__url': '/department_edit/(\\d+)/',
    'permissions__title': '编辑部门',
    'permissions__name': 'edit_department',
    'permissions__menu_id': None,
    'permissions__menu__title': None,
    'permissions__menu__icon': None
}, {
    'permissions__url': '/department_del/(\\d+)/',
    'permissions__title': '删除部门',
    'permissions__name': 'del_department',
    'permissions__menu_id': None,
    'permissions__menu__title': None,
    'permissions__menu__icon': None
}, {
    'permissions__url': '/user_list/',
    'permissions__title': '用户列表',
    'permissions__name': 'user_list',
    'permissions__menu_id': 2,
    'permissions__menu__title': '用户管理',
    'permissions__menu__icon': 'fa-map-o'
}, {
    'permissions__url': '/user_add/',
    'permissions__title': '添加用户',
    'permissions__name': 'user_add',
    'permissions__menu_id': None,
    'permissions__menu__title': None,
    'permissions__menu__icon': None
}, {
    'permissions__url': '/user_edit/(\\d+)/',
    'permissions__title': '编辑用户',
    'permissions__name': 'user_edit',
    'permissions__menu_id': None,
    'permissions__menu__title': None,
    'permissions__menu__icon': None
}, {
    'permissions__url': '/user_del/(\\d+)/',
    'permissions__title': '删除用户',
    'permissions__name': 'user_del',
    'permissions__menu_id': None,
    'permissions__menu__title': None,
    'permissions__menu__icon': None
}]

"""
{
   1：{
		'title':'信息管理',
		'icon':'fa-map-o',
		'children': [
		{'url': '/department_list/', 'title':'部门列表'    },
		{'url': '/order_list/',       'title''账单列表',  }
		]
   },
   2：{
		'title':'用户管理',
		'icon':'fa-map-o',
		'children': [
		{'url': '/user_list/', 'title':'用户列表' },
		
		]
   }	   

}
"""
ret = {}

for i in data:
    menu_id = i.get('permissions__menu_id')
    
    if not menu_id:
        continue
    if menu_id not in ret:
        ret[menu_id] = {
            'title': i['permissions__menu__title'],
            'icon': i['permissions__menu__icon'],
            'children': [
                {'url': i['permissions__url'], 'title': i['permissions__title']}
            ]
        }
    else:
        ret[menu_id]['children'].append({'url': i['permissions__url'], 'title': i['permissions__title']})
print(ret)
