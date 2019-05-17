from django.conf.urls import url

from app02 import views

urlpatterns = [
    url(r'^book/(?P<year>[0-9]{4})/(?P<month>\d{2})/$', views.book, name='book'),
    # url(r'^publisher_list/$', views.publisher, name='publisher'),  # /publisher_list/
    
    url(r'^data_json$', views.data_json),
    url(r'^template_test', views.template_test),

]
