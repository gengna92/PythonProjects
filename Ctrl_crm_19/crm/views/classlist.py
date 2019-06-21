from django.shortcuts import render, redirect, reverse
from crm import models
from crm.forms import ClassListForm


def class_list(request):
    all_class = models.ClassList.objects.all()
    return render(request, 'class_list.html', {'all_class': all_class})


def class_change(request, edit_id=None):
    obj = models.ClassList.objects.filter(pk=edit_id).first()
    form_obj = ClassListForm(instance=obj)
    if request.method == 'POST':
        form_obj = ClassListForm(request.POST, instance=obj)
        if form_obj.is_valid():
            form_obj.save()
            return redirect(reverse('crm:class_list'))
    return render(request, 'form.html', {'form_obj': form_obj})
