from django.conf.urls import url
from crm import views

urlpatterns = [
    url(r'^index/', views.index),
    url(r'^department_list/', views.department_list, name='department_list'),
    url(r'^department_add/', views.add_department, name='add_department'),
    url(r'^department_edit/(\d+)/', views.edit_department, name='edit_department'),
    url(r'^department_del/(\d+)/', views.del_department, name='del_department'),

]
