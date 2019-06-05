# from django.middleware.csrf import CsrfViewMiddleware

from django.utils.deprecation import MiddlewareMixin
from django.shortcuts import HttpResponse


class MD1(MiddlewareMixin):
    
    def process_request(self, request):
        # print(111, id(request))
        print('MD1 process_request')
        
        # return HttpResponse('o98k')
    
    def process_response(self, request, response):
        # print(22,id(response))
        print('MD1 process_response')
        return response
    
    def process_view(self, request, view_func, view_args, view_kwargs):
        print('MD1 process_view')
        # print(view_func)
        # print(view_args)
        # print(view_kwargs)
        # return HttpResponse('o98k!!!')


    def process_exception(self, request, exception):
        print('MD1 process_exception')
        
        # return HttpResponse('错误处理完成了')
    def process_template_response(self,request,response):
        print('MD1 process_template_response')
        response.context_data['username'] = 'alexdsb'
        return response
        
        
class MD2(MiddlewareMixin):
    
    def process_request(self, request):
        print('MD2 process_request')
    
    def process_response(self, request, response):
        print('MD2 process_response')
        return response
    
    def process_view(self, request, view_func, view_args, view_kwargs):
        print('MD2 process_view')

    def process_exception(self, request, exception):
        print('MD2 process_exception')
    
        # return HttpResponse('错误处理完成了')

    def process_template_response(self, request, response):
        print('MD2 process_template_response')
    
        return response