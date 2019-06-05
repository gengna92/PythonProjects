"""Ctrl_crm URL Configuration

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
from crm.crmviews import views_dep,views_user
urlpatterns = [
    # url(r'^admin/', admin.site.urls),
    url(r'^dep_list/', views_dep.dep_list,name='dep_list'),
    url(r'^dep_add/', views_dep.dep_add,name='dep_add'),
    url(r'^dep_edit/(\d+)/', views_dep.dep_edit,name='dep_edit'),
    url(r'^dep_del/(\d+)/', views_dep.dep_del,name='dep_del'),

    url(r'^user_list/', views_user.user_list, name='user_list'),
    url(r'^user_add/', views_user.user_add, name='user_add'),
    url(r'^user_edit/(\d+)/', views_user.user_edit, name='user_edit'),
    url(r'^user_del/(\d+)/', views_user.user_del, name='user_del'),


]
