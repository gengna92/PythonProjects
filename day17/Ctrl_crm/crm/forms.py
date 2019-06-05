from django import forms
from crm import models


class DepartmentForm(forms.ModelForm):
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
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'
    