from django.http import Http404
from django.shortcuts import render

def method_splitter(request, *args, **kwargs):
    get_view = kwargs.pop('GET', None)
    post_view = kwargs.pop('POST', None)
    if request.method == 'GET' and get_view is not None:
        return get_view(request, *args, **kwargs)
    elif request.method == 'POST' and post_view is not None:
        return post_view(request, *args, **kwargs)
    raise Http404


# 404错误
def page_not_found(request):
    return render(request,'it/errors/404.html',{})


# 500错误
def page_error(request):
    return render(request, 'it/errors/500.html', {})


# 403错误
def page_forbidden(request):
    return render(request, 'it/errors/403.html', {})