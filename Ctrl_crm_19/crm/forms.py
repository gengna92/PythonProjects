from django import forms
from crm import models
from django.core.exceptions import ValidationError
import hashlib


class BSForm(forms.ModelForm):
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'


class DepartmentForm(BSForm):
    class Meta:
        model = models.Department
        fields = '__all__'  # ['name']
        exclude = ['des']
        
        labels = {
            # 'name': '部门名称'
        }
        
        widgets = {
            # 'name': forms.TextInput(attrs={'class': 'form-control'})
            
        }
        
        error_messages = {
            'name': {
                'required': '必填项'
            }
        }


class UserForm(BSForm):
    re_password = forms.CharField(label='确认密码', widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    
    class Meta:
        model = models.User
        fields = ['username', 'password', 're_password', 'gender', 'depart']
        # exclude = []  # 排除
        
        labels = {
            'username': '用户名',
            # 're_password': '确认密码'
        }
        
        widgets = {
            
            'username': forms.TextInput(attrs={'class': 'form-control'}),
            'password': forms.PasswordInput(attrs={'class': 'form-control'})
        }
        
        error_messages = {
            'password': {
                'required': '密码必填'
            }
        }
    
    def clean(self):
        pwd = self.cleaned_data.get('password', '')
        re_pwd = self.cleaned_data.get('re_password')
        if pwd == re_pwd:
            md5 = hashlib.md5()
            md5.update(pwd.encode('utf-8'))
            self.cleaned_data['password'] = md5.hexdigest()
            return self.cleaned_data
        self.add_error('re_password', '两次密码不一致!!!')
        raise ValidationError('两次密码不一致')


class ClassListForm(BSForm):
    class Meta:
        model = models.ClassList
        fields = "__all__"
