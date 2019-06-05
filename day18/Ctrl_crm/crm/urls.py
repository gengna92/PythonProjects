from django.conf.urls import url
from crm.views import department, user, classlist,auth

urlpatterns = [
    url(r'^index/', auth.index, name='index'),
    url(r'^login/', auth.login, name='login'),
    url(r'^department_list/', department.department_list, name='department_list'),
    url(r'^department_add/', department.add_department, name='add_department'),
    url(r'^department_edit/(\d+)/', department.edit_department, name='edit_department'),
    url(r'^department_del/(\d+)/', department.del_department, name='del_department'),
    
    url(r'^user_list/', user.user_list, name='user_list'),
    url(r'^user_add/', user.user_add, name='user_add'),
    url(r'^user_edit/(\d+)/', user.user_edit, name='user_edit'),
    
    url(r'^class_list/', classlist.class_list, name='class_list'),
    url(r'^class_add/', classlist.class_change, name='class_add'),
    url(r'^class_edit/(\d+)/', classlist.class_change, name='class_edit'),

]
