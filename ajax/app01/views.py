from django.shortcuts import render,HttpResponse

# Create your views here.

def index(request):
    if request.method == 'POST':
        a = request.POST.get('i1')
        b = request.POST.get('i2')
        c = int(a)+int(b)
        print(locals())

    return render(request,'index.html',{'locals':locals()})

def calc(request):
    if request.method == 'POST':
        a = request.POST.get('v1')
        b = request.POST.get('v2')
        c = int(a)+int(b)
        return HttpResponse(c)
    return render(request,'index.html')



from django import forms
from django.core.validators import RegexValidator


class Reg(forms.Form):
    name = forms.CharField(label='用户名',
                           # initial='zhang',
                           widget=forms.TextInput(attrs={'class':'from-control'}))
    pwd = forms.CharField(label='密码',
        min_length=6,
                          widget=forms.PasswordInput(attrs={'class':'from-control'}),
                          error_messages={'required':'lalalala'},

                          validators=RegexValidator(r'\d++')

                          )

    gender = forms.ChoiceField(choices=((1,'M'),(2,'F')))
    hobby = forms.MultipleChoiceField(choices=((1,'football'),(2,'baskerball'),
                                               (3, 'table')))



def test(request):
    reg_obj = Reg()
    if request.method == 'POST':
        return HttpResponse('ok')

    return render(request,'test.html',{'reg_obj':reg_obj})

