from django.shortcuts import render, redirect, reverse
from crm import models
from crm.forms import DepartmentForm
from django.http import JsonResponse
from utils.pagination import Pagination
import hashlib
from django.conf import settings


def department_list(request):
    all_departs = models.Department.objects.all()
    
    page_obj = Pagination(request.GET.get('page'), all_departs.count())
    return render(request, 'department_list.html', {
        'all_departs': all_departs[page_obj.start:page_obj.end],
        'page_html': page_obj.page_html
        
    })


def add_department(request):
    form_obj = DepartmentForm()  # 空的form对象
    if request.method == 'POST':
        form_obj = DepartmentForm(request.POST)  # 包含提交数据的form对象
        if form_obj.is_valid():  # 对提交数据进行校验
            # 校验成功
            # models.Department.objects.create(**form_obj.cleaned_data)
            form_obj.save()  # 新增数据
            # 跳转到展示页面
            return redirect(reverse('crm:department_list'))
    return render(request, 'add_department.html', {'form_obj': form_obj})


def edit_department(request, edit_id):
    edit_obj = models.Department.objects.filter(pk=edit_id).first()
    form_obj = DepartmentForm(instance=edit_obj)  # 包含了原始数据
    if request.method == 'POST':
        form_obj = DepartmentForm(request.POST, instance=edit_obj)  # 包含了原始数据  新提交的数据
        if form_obj.is_valid():  # 对提交数据进行校验
            # 数据校验成功
            form_obj.save()  # 编辑数据
            return redirect(reverse('crm:department_list'))
    return render(request, 'edit_department.html', {'form_obj': form_obj})


def del_department(request, pk):
    models.Department.objects.filter(pk=pk).delete()
    return JsonResponse({'status': 0, 'msg': '删除成功'})
