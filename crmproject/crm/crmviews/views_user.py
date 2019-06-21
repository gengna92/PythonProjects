from django.shortcuts import render,redirect,reverse,HttpResponse
from crm import  models
from crm.forms import Dep,UserForm
from django.http import JsonResponse
from utils.pagination import Pagination
from rabc.service.init_permission import init_permissions

# Create your views here.
def user_list(request):
    user_all = models.User.objects.all()
    p_obj = Pagination(request.GET.get('page'),user_all.count() )
    return render(request,'user_list.html',{'user_all':user_all[p_obj.start:p_obj.end],
                                            'page_html':p_obj.page_html
                                            })


def user_add(request):
    user_form = UserForm()
    if request.method == 'POST':
        user_form = UserForm(request.POST)
        if user_form.is_valid():
            user_form.save()
            return redirect(reverse('crm:user_list'))
    else:
        print(user_form.errors.as_data)
    return render(request,'user_add.html',{'form_obj':user_form})




def user_edit(request,id):
    user_obj = models.User.objects.filter(pk=id).first()
    user_form = UserForm(instance=user_obj)
    if request.method == 'POST':
        user_form = UserForm(request.POST,instance=user_obj)
        if user_form.is_valid():
            user_form.save()
            return redirect(reverse('crm:user_list'))

    return render(request,'user_edit.html',{'form_obj':user_form})

def user_del(request,id):
    models.User.objects.get(pk=id).delete()
    return JsonResponse({'status':200,'message':'del success!'})



def login(request):
    error = ''
    if request.method == 'POST':
        username = request.POST.get('username')
        pwd = request.POST.get('password')
        obj =  models.User.objects.filter(name=username,pwd=pwd).first()
        if obj:
            init_permissions(request,obj)
            return redirect(reverse('crm:dep_list'))
        else:
            print(username)
            print(pwd)
            error = '用户名或密码错误'


    return render(request,'login.html',{'error':error})