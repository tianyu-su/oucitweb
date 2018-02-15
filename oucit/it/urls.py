from django.conf.urls import url,include
from .views.common import method_splitter
from .views import user,admin_plugin
from oucit import settings

urlpatterns =[
    url(r'^login/$', method_splitter, {'GET': user.get_login, 'POST': user.post_login}, name='login'),
    url(r'^get_cascade/(\d+)', admin_plugin.get_cascade_list),  #实现文章栏目二级联动
    url(r'^user-autocomplete/$',  admin_plugin.UserAutocompleteView.as_view(), name='user_autocomplete'),  #admin connection 自定义外键自动填充
    # url(r'^user-autocomplete/$',  autocomplete.Select2QuerySetView.as_view(model=MyUser), name='user_autocomplete'),  #admin connection 外键自动填充
    url(r'^captcha', include('captcha.urls')),  # 增加这一行
]