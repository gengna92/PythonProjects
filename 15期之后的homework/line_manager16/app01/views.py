from django.shortcuts import render,redirect,HttpResponse,reverse
from app01 import models
from django.views import View
from django.utils.decorators import method_decorator
from functools import wraps


# Create your views here.
logname = ''

#装饰器函数
def wrapper(fun):
    @wraps(fun)
    def inner(request,*args,**kwargs):
        global logname
        if not request.session.get('linemanage'):
            to_url=request.path_info
            print(to_url)
            url='{}?to_url={}'.format(reverse('login'),to_url)
            return redirect(url)
        else:
            ret=fun(request,*args,**kwargs)
            return ret
    return inner
#登录首页
def login(request):
    error =''
    if request.method == 'POST':
        uname = request.POST.get('username')
        password = request.POST.get('password')
        if models.User.objects.filter(uname=uname,password=password):
            global logname
            logname=uname
            request.session['linemanage'] ='linemanage'
            print(logname)
            if request.GET.get('to_url'):
                return redirect(request.GET.get('to_url'))
            else:
                return redirect(reverse('userlist'))

        elif uname == '' or password =='':
            error = '用户名或者密码不能为空'
        else:
            error = '账号或密码错误'

    return render(request,'index.html',{'error':error})




@wrapper
def user_list(request):
    userlist = models.User.objects.all()
    return render(request, 'userlist.html', {'username':logname, 'userlist':userlist})

@method_decorator(wrapper,name='dispatch')
class Adduser(View):
    def get(self,request):
        return render(request,'adduser.html',{'username':logname})
    def post(self,request):
        uname = request.POST.get('name')
        password = request.POST.get('password')
        if uname=='' or password=='':
            error='用户名或密码不能为空'
        elif models.User.objects.filter(uname=uname):
            error = '该用户已存在'

        else:
            models.User.objects.create(uname=uname,password=password)
            return redirect(reverse('userlist'))

        return render(request,'adduser.html',{'username':logname,'error':error})

@method_decorator(wrapper,name='dispatch')
class Useredit(View):

    def get(self,request,id):
        obj = models.User.objects.filter(id=id).first()

        error=''
        return render(request,'edituser.html',{'username':logname,'error':error,'user_obj':obj})

    def post(self, request,id):
        obj = models.User.objects.filter(id=id).first()
        #   = models.Book.objects.filter(pk=edit_id).first()

        uname = request.POST.get('name')
        password = request.POST.get('password')
        if uname == '' or password == '':
            error = '用户名或密码不能为空'
        elif models.User.objects.filter(uname=uname):
            error = '该用户已存在'

        else:
            obj.uname=uname
            obj.password=password
            obj.save()
            return redirect(reverse('userlist'))

        return render(request, 'edituser.html', {'username': logname, 'error': error, 'user_obj': obj})

@wrapper
def cancel(request,tname,id):
    cancel_class = getattr(models,tname.capitalize())
    cancel_class.objects.filter(id=id).delete()
    return redirect(reverse('%slist'%(tname)))


@wrapper
def lobline_list(request):
    linelist = models.Lobline.objects.all()
    manas = {}
    # manas = []
    for lobline in linelist:
        print(lobline)
        manas[lobline.id] = lobline.user.all().first()
        # manas.append( lobline.user.all().first())

    print(manas)
    return render(request,'loblinelist.html',{'username': logname,'linelist':linelist,'manas':manas})

@wrapper
def lineadd(request):
    error =  ''
    user_obj = models.User.objects.all()
    if request.method == 'POST':
        name = request.POST.get('name')
        if models.Lobline.objects.filter(lname=name):
            error ='该业务线已存在'
        elif name=='':
            error ='业务线不能为空'

        else:
            uid = request.POST.get('uid')
            models.Lobline.objects.create(lname=name).user.add(uid)
            return redirect(reverse('loblinelist'))
    return render(request,'addline.html',{'username': logname,'error':error,'user_obj':user_obj})

@wrapper
def lineedit(request,id):
    error =  ''
    obj = models.Lobline.objects.filter(id=id).first()
    user_obj = models.User.objects.all()
    print(obj)
    if request.method == 'POST':
        name = request.POST.get('name')
        uid =request.POST.get('uid')
        if models.Lobline.objects.filter(lname=name):
            error ='该业务线已存在'
        elif name=='':
            error ='业务线不能为空'

        else:
            obj.lname=name
            obj.user.set(uid)
            obj.save()
            return redirect(reverse('loblinelist'))
    return render(request,'editline.html',{'username': logname,'error':error, 'obj':obj,'user_obj':user_obj})

@method_decorator(wrapper,name='dispatch')
class Hostlist(View):
    def get(self,request):
        hosts = models.Host.objects.all()
        return render(request,'host.html',{'username': logname,'hosts':hosts})



@method_decorator(wrapper,name='dispatch')
class Hostadd(View):
    def get(self,request):
        error=''
        line_obj=models.Lobline.objects.all()
        return render(request,'addhost.html',{'username': logname,'line_obj':line_obj,'error':error})

    def post(self,request):
        hname = request.POST.get('name')
        password = request.POST.get('password')
        hlid = request.POST.get('hlid')
        if models.Host.objects.filter(hname=hname):
            error ='该主机已存在'
        elif hname=='':
            error ='主机不能为空'

        else:
            models.Host.objects.create(hname=hname,password=password,hlid_id=hlid)
            return redirect(reverse('hostlist'))

@method_decorator(wrapper,name='dispatch')
class Hostedit(View):
    def get(self,request,id):
        error=''
        line_obj=models.Lobline.objects.all()
        obj=models.Host.objects.filter(id=id).first()
        return render(request,'edithost.html',{'username': logname,'line_obj':line_obj,'obj':obj,'error':error,})

    def post(self,request,id):
        line_obj=models.Lobline.objects.all()
        obj=models.Host.objects.filter(id=id).first()
        hname = request.POST.get('name')
        password = request.POST.get('password')
        hlid = request.POST.get('hlid')
        if models.Host.objects.filter(hname=hname):
            error = '该主机已存在'
        elif hname == '':
            error = '主机不能为空'

        else:
            obj.hname=hname
            obj.password=password
            obj.hlid_id=hlid
            obj.save()
            return redirect(reverse('hostlist'))
        return render(request,'edithost.html',{'username': logname,'line_obj':line_obj,'obj':obj,'error':error,})

@wrapper
def logout(request):
    global logname
    logname=''
    request.session.delete()
    return redirect(reverse('login'))



