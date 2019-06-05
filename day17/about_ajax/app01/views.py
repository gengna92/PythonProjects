from django.shortcuts import render, HttpResponse
from django.views.decorators.csrf import csrf_exempt,csrf_protect,ensure_csrf_cookie


# Create your views here.
@csrf_exempt   # 不在进行csrf校验
# @csrf_protect  # 进行csrf校验
@ensure_csrf_cookie
def index(request):
    if request.method == 'POST':
        i1 = request.POST.get('i1')
        i2 = request.POST.get('i2')
        i3 = int(i1) + int(i2)
        return render(request, 'index.html', locals())
    return render(request, 'index.html')


import time


def calc(request):
    if request.method == 'POST':
        time.sleep(3)
        i1 = request.POST.get('v1')
        i2 = request.POST.get('v2')
        i3 = int(i1) + int(i2)
        return HttpResponse(i3)


def calc2(request):
    if request.method == 'POST':
        i1 = request.POST.get('v1')
        i2 = request.POST.get('v2')
        i3 = int(i1) + int(i2)
        return HttpResponse(i3)


import json


def test(request):
    print(request.POST)
    ret = request.POST.get('hobby')
    print(ret, type(ret))
    ret = json.loads(ret)
    print(ret, type(ret))
    return HttpResponse('ok')
