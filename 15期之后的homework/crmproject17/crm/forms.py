from django import forms
from crm import models
from django.core.exceptions import ValidationError

class Dep(forms.ModelForm):
    class Meta:
        model = models.Department
        fields = '__all__'

        widgets = {
            'name':forms.TextInput(attrs={
                'class':'form-control'
            })
        }

        error_messages ={
            'name':{
                'required':'不能为空'
            }
        }

    def clean_name(self):
        dname = self.cleaned_data.get('name')
        print(dname)
        print(dname)
        if models.Department.objects.filter(name=dname):
            raise ValidationError('该部门已存在')
        else:
            return dname



class UserForm(forms.ModelForm):
    class Meta:
        model = models.User
        fields = '__all__'

        widgets = {
            'name':forms.TextInput(attrs={'class':'form-control'}),
            'pwd':forms.PasswordInput(attrs={'class':'form-control'}),
            # 'gender':forms.TextInput(attrs={'class':'form-control'}),
        #     'dep':forms.TextInput(attrs={'class':'form-control'}),
        }


    def clean_name(self):
        uname = self.cleaned_data.get('name')
        if models.User.objects.filter(name=uname):
            raise ValidationError('该用户已存在')
        else:
            return  uname











































