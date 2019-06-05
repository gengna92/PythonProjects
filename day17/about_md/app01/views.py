from django.shortcuts import render, HttpResponse
from django.template.response import TemplateResponse


# Create your views here.
def index(request):
    print('index')
    # print(222, id(request))
    
    # int('asasa')
    
    # ret = HttpResponse('ok')
    # print(1111,id(ret))
    return TemplateResponse(request, 'index.html', {'username': 'alex'})
