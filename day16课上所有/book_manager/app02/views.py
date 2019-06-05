from django.shortcuts import render, HttpResponse
from django.http import JsonResponse


def book(request, year, month, **kwargs):
    print(year, type(year))
    print(kwargs)
    return HttpResponse('app02 book')


import json


def data_json(request):
    # data = {'user': 'alex', 'pwd': 123}
    data = [1, 23, 4, 5, 5]
    # ret = HttpResponse(json.dumps(data))  # Content-Type: text/html; charset=utf-8
    # ret['Content-Type'] = 'application/json'  # 加响应头
    # return ret
    return JsonResponse(data, safe=False)  # Content-Type: application/json

import datetime

def template_test(request):
    l = [11, 22, 33]
    d = {"name": "alex",'keys':'xxxx'}
    
    class Person(object):
        def __init__(self, name, age):
            self.name = name
            self.age = age
        
        def dream(self):
            return "{} is dream...".format(self.name)
    
    Alex = Person(name="Alex", age=34)
    Egon = Person(name="Egon", age=9000)
    Eva_J = Person(name="Eva_J", age=18)
    
    person_list = [Alex, Egon, Eva_J]
    # person_list = []
    return render(request,
                  "template_test.html",
                  {"l": l,
                   "d": d,
                   "person_list": person_list,
                   "file_size": 1*1024*1024*1024*1024*1024*1024,
                   'long_str':"""Django的模板中会对HTML标签和JS等语法标签进行自动转义，原因显而易见，这样是为了安全。但是有的时候我们可能不希望这些HTML元素被转义，比如我们做一个内容管理系统，后台添加的文章中是经过修饰的，这些修饰可能是通过一个类似于FCKeditor编辑加注了HTML修饰符的文本，如果自动转义的话显示的就是保护HTML标签的源文件。为了在Django中关闭HTML的自动转义有两种方式，如果是一个单独的变量我们可以通过过滤器“|safe”的方式告诉Django这段代码是安全的不必转义。
                   """,
                   'now': datetime.datetime.now(),
                   'a_str':'<a href="http://www.baidu.com">点击</a>',
                   'js':"""
                   <script>
                    
                        for (var i = 0; i < 5; i++) {
                            alert('11111')
                        }
                    
                    </script>""",
                   
                   'p_list':[person_list,person_list],
                   })
