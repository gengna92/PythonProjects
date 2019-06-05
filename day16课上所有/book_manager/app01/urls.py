from django.conf.urls import url

from app01 import views

urlpatterns = [
    url(r'^login/$', views.login, name='login'),
    url(r'^logout/$', views.logout, name='logout'),
    
    url(r'^publisher_list/$', views.publisher, name='publisher'),  # /app01/publisher_list/
    # url(r'^publisher/add/$', views.add_publisher),
    url(r'^publisher/add/$', views.AddPublisher.as_view(), name='add_pub'),
    # url(r'^publisher/add/$', view,),
    url(r'^edit_publisher/(\d+)/$', views.edit_publisher, name='edit_publisher'),
    
    url(r'^book_list/$', views.book, name='book'),
    url(r'^book/add/$', views.AddBook.as_view(), name='add_book'),
    url(r'^book/edit/(?P<edit_id>\d+)/$', views.edit_book, name='edit_book'),
    
    url(r'^(?P<table>book|publisher)/delete/(?P<del_id>\d+)/$', views.delete, name='del'),

]
