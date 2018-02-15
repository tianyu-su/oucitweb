from django import forms
from django.contrib.auth import authenticate
#Django 验证码插件
from captcha.fields import CaptchaField

class LoginForm(forms.Form):
    number_id = forms.CharField(max_length=15, error_messages={
        'required': u'必须输入学工号',
        'min_length': u'请检查学工号长度',
        'max_length': u'请检查学工号长度',
        'invalid': u'请检查学工号长度'
    })

    pwd = forms.CharField(min_length=5, max_length=128, error_messages={
            'required': u'必须填写密码',
            'min_length': u'密码长度过短（5-64个字符）',
            'max_length': u'密码长度过长（5-64个字符）'
        }
    )

    validate = CaptchaField(label='验证码')

    def clean(self):
        number_id = self.cleaned_data.get('number_id', None)
        pwd = self.cleaned_data.get('pwd', None)

        def __init__(self, *args, **kwargs):
            self.user_cache = None
            super(LoginForm, self).__init__(*args, **kwargs)

        if number_id and pwd:
            self.user_cache = authenticate(username=number_id, password=pwd)
            if self.user_cache is None:
                raise forms.ValidationError('学工号或者密码不正确！请重新输入！')
            elif not self.user_cache.is_active:
                raise forms.ValidationError('你的账号被冻结！请联系管理员！')
            return self.cleaned_data


    def get_user(self):
        return self.user_cache
