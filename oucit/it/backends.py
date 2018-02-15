from django.contrib.auth.backends import ModelBackend # 继承这个为了使用admin的权限控制
from it.models import MyUser


class NumberIDAuthBackend(ModelBackend):

    def authenticate(self, request, username=None, password=None, **kwargs):
        try:
            user = MyUser.objects.get(number_id = username)
            if user.check_password(password):
                return user
            return None
        except MyUser.DoesNotExist:
            return None

    def get_user(self, user_id):
        try:
            return MyUser.objects.get(pk=user_id)
        except MyUser.DoesNotExist:
            return None
