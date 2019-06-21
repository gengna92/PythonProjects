from django import forms
from host import models


class BSForm(forms.ModelForm):
    
    def __init__(self,*args,**kwargs):
        super().__init__(*args,**kwargs)
        for field in self.fields.values():
            field.widget.attrs['class'] = 'form-control'

class HostForm(BSForm):
    class Meta:
        model = models.Host
        fields = '__all__'
