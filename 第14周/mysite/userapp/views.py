from django.shortcuts import render,redirect,HttpResponse
from userapp import models
# Create your views here.
import hashlib

def sec(data):
    m = hashlib.md5(b'abcd123')
    m.update(data.encode())
    return m.hexdigest()

def userList(request):
    data = models.user.objects.all()
    return render(request,'userList.html',{'data':data})

def addUser(request):
    error = ''
    if request.method == 'POST':
        print(request.POST)
        username = request.POST.get('username')
        password = request.POST.get('password')
        if username == '' or password == '':
            error = '用户名或者密码不能为空'

        elif models.user.objects.filter(username=username):
            error = username+'用户已存在'

        else:
            models.user.objects.create(username=username,password=sec(password))
            return redirect('/user-list/')


    return render(request,'addUser.html',{'error':error})


def delUser(request):
    id = request.GET.get('id')
    models.user.objects.filter(id=id).delete()
    return redirect('/user-list/')


def modifyUser(request):
    error = ''
    id = request.GET.get('id')
    obj =models.user.objects.get(id=id)

    if request.method == 'POST':
        print(request.POST)
        username = request.POST.get('username')
        password = request.POST.get('password')
        if username == '' or password == '':
            error = '用户名或者密码不能为空'

        elif models.user.objects.filter(username=username):
            error = username + '用户已存在'

        else:
            obj.username = username
            obj.password = sec(password)
            obj.save()
            return redirect('/user-list/')
    return render(request, 'modifyUser.html', {'error': error,'data':obj})

def login(request):
    error = ''
    if request.method == 'POST':
        print(request.POST)
        username = request.POST.get('username')
        password = request.POST.get('password')
        if username == '' or password == '':
            error = '用户名或者密码不能为空'

        elif not  models.user.objects.filter(username=username,password=sec(password)):
            error = '账号或密码错误'

        else:
            return redirect('/user-list/')

    return render(request, 'login.html', {'error': error})




