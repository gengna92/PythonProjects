from django.shortcuts import render,redirect,HttpResponse

# Create your views here.
import hashlib
from  templates import *

def sec(data):
    m = hashlib.md5('abcd123')
    m.update(data.encode())
    return m.hexdigest()

def userList(request):
    return render(request,'userList.html')
    # return HttpResponse('200')
