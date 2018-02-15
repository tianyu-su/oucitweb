from django.contrib import auth
from django.shortcuts import render, redirect
from it.forms.user import LoginForm
from it.models import IPRecord
#Django 验证码相关
from captcha.models import CaptchaStore
from captcha.helpers import captcha_image_url


def get_login(request, **kwargs):

    auth.logout(request)
    img_hashKey = CaptchaStore.generate_key()
    img_url = captcha_image_url(img_hashKey)
    kwargs['img_url'] = img_url
    kwargs['img_hashKey'] = img_hashKey
    return render(request, 'it/Login.html', kwargs)


def get_client_ip(request):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip


def post_login(request):
    form = LoginForm(request.POST)
    if not form.is_valid():
        return get_login(request, errors=form.errors)
    user = form.get_user()
    auth.login(request, user)

    #记录登录IP
    record = IPRecord()
    record.user_fk = user
    record.ip_addr = get_client_ip(request)
    record.save()
    return redirect('/admin/')




