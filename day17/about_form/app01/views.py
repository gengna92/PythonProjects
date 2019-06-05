from django.shortcuts import render, HttpResponse


# Create your views here.
def reg(request):
    if request.method == 'POST':
        user = request.POST.get('user')
        pwd = request.POST.get('pwd')
        if len(pwd) < 6:
            pwd_error = '密码不能小于六位'
            return render(request, 'reg.html', {'pwd_error': pwd_error})
        
        return HttpResponse('注册成功')
    return render(request, 'reg.html')


from django import forms
from app01 import models

from django.core.validators import RegexValidator
from django.core.exceptions import ValidationError


def check_user(value):
    if 'alex' in value:
        raise ValidationError('含有非法字符')


class RegForm(forms.Form):
    user = forms.CharField(
        label='用户名',
        initial='张三',
        required=True,
        validators=[],
        # disabled=True,
        widget=forms.TextInput(attrs={'class': 'form-control'}),
        error_messages={'required': '该字段是必填的'},
    )
    
    pwd = forms.CharField(
        label='密码',
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        min_length=6,
        error_messages={'min_length': '该字段至少是6位'}, )
    
    re_pwd = forms.CharField(
        label='确认密码',
        widget=forms.PasswordInput(attrs={'class': 'form-control'}),
        min_length=6,
        error_messages={'min_length': '该字段至少是6位'}, )
    
    gender = forms.ChoiceField(
        choices=((1, '男'), (2, '女')),
        widget=forms.RadioSelect
    )
    hobby = forms.MultipleChoiceField(
        # choices=models.Hobby.objects.values_list('id', 'name'),
        label="爱好",
        initial=[1, 3],
        widget=forms.widgets.CheckboxSelectMultiple
    )
    
    phone = forms.CharField(
        min_length=11,
        max_length=11,
        validators=[RegexValidator(r'1[3-9]\d{9}', '手机号格式不正确')]
    )
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['hobby'].choices = models.Hobby.objects.values_list('id', 'name')
    
    def clean_user(self):
        # 局部钩子  对当前的字段的值进行校验
        # 通过校验  返回字段的值
        # 不通过校验  抛出异常
        value = self.cleaned_data.get('user')
        if 'alex' in value:
            raise ValidationError('含有非法字符')
        else:
            return value
    
    def clean(self):
        # 全局钩子
        pwd = self.cleaned_data.get('pwd', '')
        re_pwd = self.cleaned_data.get('re_pwd')
        if pwd == re_pwd:
            return self.cleaned_data
        else:
            self.add_error('re_pwd','两次密码不一致')
            raise ValidationError('两次密码不一致')

def reg2(request):
    if request.method == 'GET':
        form_obj = RegForm()
    elif request.method == 'POST':
        form_obj = RegForm(data=request.POST)  # 包含提交数据的form对象
        
        if form_obj.is_valid():  # 对数据进行校验
            print(form_obj.cleaned_data)
        else:
            print(form_obj.errors)
    
    return render(request, 'reg2.html', {'form_obj': form_obj})
