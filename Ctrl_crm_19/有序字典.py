from collections import OrderedDict

# dict = OrderedDict()
# dict['k1'] = 'v1'
# dict['k4'] = 'v4'
# dict['k2'] = 'v2'
# dict['k3'] = 'v3'


dic = {
    1: {
        'title': '信息管理',
        'icon': 'fa-map-o',
        'weight': 1,
        'children': [{
            'url': '/department_list/',
            'title': '部门列表'
        }]
    },
    2: {
        'title': '用户管理',
        'icon': 'fa-map-o',
        'weight': 10,
        'children': [{
            'url': '/user_list/',
            'title': '用户列表'
        }]
    }
}

ret = sorted(dic,key=lambda x:dic[x]['weight'],reverse=True)
print(ret)