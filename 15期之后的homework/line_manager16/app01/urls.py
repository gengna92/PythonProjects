"""lob_manager URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url,include
from django.contrib import admin
from app01 import views

urlpatterns = [
    url(r'^index/', views.login,name='login'),
    url(r'^user/userlist/', views.user_list,name='userlist'),
    url(r'^user/useradd/', views.Adduser.as_view(),name='useradd'),
    url(r'^user/useredit/(?P<id>\d+)/', views.Useredit.as_view(),name='useredit'),

#业务线管理
    url(r'^lobline/loblinelist/', views.lobline_list, name='loblinelist'),
    url(r'^lobline/loblineadd/', views.lineadd, name='loblineadd'),
    url(r'^lobline/loblineedit/(?P<id>\d+)/', views.lineedit, name='loblineedit'),

#主机管理
    url(r'^host/hostlist/', views.Hostlist.as_view(), name='hostlist'),
    url(r'^host/hostadd/', views.Hostadd.as_view(), name='hostadd'),
    url(r'^host/hostedit/(?P<id>\d+)/', views.Hostedit.as_view(), name='hostedit'),


    url(r'^(user|host|lobline)/del/(\d+)/', views.cancel,name='delete'),
    url(r'^logout/', views.logout,name='logout'),

]
