from django import template
from django.shortcuts import reverse
from django.http.request import QueryDict

register = template.Library()


@register.simple_tag
def reverse_url(request, name, *args, **kwargs):
    qd = QueryDict(mutable=True)
    next = request.get_full_path()
    qd['next'] = next
    
    url = reverse(name, args=args, kwargs=kwargs)
    
    return_url = "{}?{}".format(url, qd.urlencode())
    return return_url
