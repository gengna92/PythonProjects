from django.shortcuts import render,redirect,reverse,HttpResponse
from crm import  models
from crm.forms import Dep,UserForm
from django.http import JsonResponse
from utils.pagination import Pagination

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