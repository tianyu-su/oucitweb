"""oucit URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
import it.urls
import DjangoUeditor.urls


# Uncomment the next two lines to enable the admin:
from django.contrib.auth.decorators import login_required
admin.autodiscover()
admin.site.login = login_required(admin.site.login) # 设置admin登录的页面,永久重定向到自定义的URL，settings.LOGIN_URL


urlpatterns = [
    url(r'^', include(it.urls)),
    url(r'^ueditor/', include(DjangoUeditor.urls)),
    url(r'^admin/', admin.site.urls, name='admin'),

]

handler404 = "it.views.common.page_not_found"

handler500 = "it.views.common.page_error"

handler403 = "it.views.common.page_forbidden"



# 调试模式下，处理 upload 文件访问权限
# 部署模式不需要这个，直接配置 Nginx 等静态目录

from django.conf import settings
if settings.DEBUG:
    from django.conf.urls.static import static
    urlpatterns += static(
        settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
