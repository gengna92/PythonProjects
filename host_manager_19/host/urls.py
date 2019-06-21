from django.conf.urls import url, include
from host import views

urlpatterns = [
    url(r'^host_list/$', views.host_list, name='host_list'),
    url(r'^host_add/$', views.host_change, name='host_add'),
    url(r'^host_edit/(\d+)$', views.host_change, name='host_edit'),
    url(r'^host_del/(\d+)$', views.host_del, name='host_del'),
    url(r'^login/$', views.login, name='login'),

]
