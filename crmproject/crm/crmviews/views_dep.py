from django.shortcuts import render,redirect,reverse,HttpResponse
from crm import  models
from crm.forms import Dep
from django.http import JsonResponse
from utils import pagination

# Create your views here.
def dep_list(request):
    dep_all = models.Department.objects.all()
    pagination_obj = pagination.Pagination(request.GET.get('page'),dep_all.count(),per_num=5)
    return render(request,'dep_list.html',{'dep_all':dep_all[pagination_obj.start:pagination_obj.end],
                                           'page_html':pagination_obj.page_html

                                        })


def dep_add(request):
    dep_form = Dep()
    if request.method == 'POST':
        dep_form = Dep(request.POST)
        if dep_form.is_valid():
            dep_form.save()
            return redirect(reverse('crm:dep_list'))
        else:
            print(dep_form.errors.as_data)
    return render(request,'dep_add.html',{'dep_form':dep_form})



def dep_edit(request,id):
    dep_obj = models.Department.objects.filter(pk=id).first()
    dep_form = Dep(instance=dep_obj)

    if request.method == 'POST':
        dep_form = Dep(request.POST,instance=dep_obj)
        if dep_form.is_valid():
            dep_form.save()
            return redirect(reverse('crm:dep_list'))

    return render(request, 'dep_edit.html', {'dep_form': dep_form})




def dep_del(request,id):
    models.Department.objects.get(pk=id).delete()
    return JsonResponse({'status':200,'message':'del success!'})
    models.User.objects.bulk_create()