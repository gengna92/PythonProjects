from django.shortcuts import render, redirect, reverse
from crm import models
from crm.forms import UserForm
from utils.pagination import Pagination


def user_list(request):
    all_user = models.User.objects.all()  # 查询所有的用户
    page_obj = Pagination(request.GET.get('page'), all_user.count())

    
    return render(request, 'user_list.html', {
        'all_user': all_user[page_obj.start:page_obj.end],
        'page_html':page_obj.page_html
    })


# 添加用户
def user_add(request):
    if request.method == 'GET':
        form_obj = UserForm()
    elif request.method == 'POST':
        form_obj = UserForm(request.POST)
        if form_obj.is_valid():
            # 保存数据
            form_obj.save()
            return redirect(reverse('crm:user_list'))
    
    return render(request, 'form.html', {'form_obj': form_obj})


# 编辑用户
def user_edit(request, edit_id):
    obj = models.User.objects.filter(pk=edit_id).first()
    form_obj = UserForm(instance=obj)
    
    if request.method == 'POST':
        form_obj = UserForm(data=request.POST,instance=obj)
        if form_obj.is_valid():
            form_obj.save()
            return redirect(reverse('crm:user_list'))
    
    return render(request, 'form.html', {'form_obj': form_obj})
