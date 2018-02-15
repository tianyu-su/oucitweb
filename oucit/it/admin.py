from django.contrib import admin
from it.models import MyUser, Profile, Group, Connection, Carousel, IPRecord, News, Introduce, \
    Teach_Plan, HZBX, Teach_Course, XSBG, \
    ArticleCategory, ArticleColumn, BaseArticle
from it.forms.admin_plugin import ConnectionForm

from django.utils.html import format_html
from django.shortcuts import get_object_or_404, redirect
from django.contrib import messages

# 定义后台名字，书签名字

admin.site.site_header = "信院网站管理系统"
admin.site.site_title = "信院"


# Register your models here.


class ProfileAdmin(admin.StackedInline):
    model = Profile


@admin.register(BaseArticle)
class BaseArticleAdmin(admin.ModelAdmin):
    """
       进行相关文章编辑，保存时需要进行的操作
    """
    # 继承admin自带页面，实现二级联动
    change_form_template = "it/admin/cascade_list.html"

    fieldsets = (
        ("基本信息", {'fields': ['heading', 'subheading', ('column', 'category',), 'author', 'source',
                             ('open_jmp_url', 'jmp_url',), ]}),
        ("正文", {'fields': ['content', 'index_img', ]}),
        ("属性", {'fields': [('article_top', 'article_hot',), ]}),
    )

    date_hierarchy = 'c_time'
    list_per_page = 20
    list_filter = ['column__column_name']
    search_fields = ['heading']

    def get_list_display(self, request):
        if request.user.is_superuser:
            return ['heading', 'c_time', 'publisher', 'column', 'category']
        return ['heading', 'c_time', 'column', 'category']

    # 保存模型的时候进行发表者绑定，图片提取等操作
    def save_model(self, request, obj, form, change):
        try:
            if not change:  # 如果是新增那么绑定当前账号为作者，修改的时候不改变作者
                obj.publisher = request.user
            if obj.open_jmp_url and obj.jmp_url.strip() == '':
                self.message_user(request, '请输入转向链接！', messages.ERROR)
            else:
                # 提取正文的图片 URL
                def get_img_url(str):
                    index = str.find(r'<img')
                    if index == -1:
                        return ''
                    else:
                        try:
                            img_html = str[index:str.find(r'/>', index) + 2]
                            pattern = r'src=\"[^\"]+\"'
                            import re
                            res = re.search(pattern, img_html, re.M)
                            begin, end = res.span()
                            return img_html[begin + 5:end - 1]
                        except:
                            return ''

                img_url = get_img_url(obj.content)
                if img_url == '' or img_url.find('dialogs/attachment') != -1:   #防止把富文本编辑器里面子到的icon识别为首页图片
                    obj.index_img = False
                elif obj.index_img:
                    obj.index_img = True
                    obj.index_img_url = img_url
        except:
            self.message_user(request, '录入失败，请重试！', messages.ERROR)

        super(BaseArticleAdmin, self).save_model(request, obj, form, change)

    # 过滤文章显示列表，非超级用户只显示自己自己发表的
    def get_queryset(self, request):
        qs = super(BaseArticleAdmin, self).get_queryset(request)
        if not request.user.is_superuser:
            return qs.filter(publisher=request.user)
        else:
            return qs


    #由于一些特殊的外加，例如学院新闻，学术报告这种的，不应该出现在这个文章的栏目中，因此需要过滤
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "column":
            kwargs['queryset'] = ArticleColumn.objects.all().exclude(column_name='学术报告').exclude(column_name='学院新闻')
        # if db_field.name == "category":
        #     qs0 = ArticleColumn.objects.get(column_name='学院新闻').category.all()
        #     qs1 = ArticleColumn.objects.get(column_name='学术报告').category.all()
        #     qs = ArticleCategory.objects.all()
        #     kwargs['queryset'] = qs - qs0 - qs1
        return super(BaseArticleAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)

    # 本方法和 change_view 一起实现，修改文章不可以修改文章所属类别
    def get_readonly_fields(self, request, change=False, obj=None):
        if request.user.is_superuser:
            return []
        if change:
            return ['column', 'category']
        return []

    def change_view(self, request, object_id, form_url='', extra_context=None):
        change_obj = BaseArticle.objects.get(pk=object_id)
        self.get_readonly_fields(request, change=True, obj=change_obj)
        return super(BaseArticleAdmin, self).change_view(request, object_id, form_url, extra_context=extra_context)


@admin.register(MyUser)
class UserAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        if not change:  # 如果是新增，设置默认密码, 修改密码只能通过页面右上角修改密码进行
            from oucit.settings import USER_DEFAULT_PWD
            obj.set_password(USER_DEFAULT_PWD)
            obj.save()

    def reset_password_tag(self, obj):
        """
        定义一个 a  标签，指向重置密码功能
        """
        dest = "{obj_id}/reset_pwd/".format(obj_id=obj.pk)
        return format_html('<a href="%s">重置密码</a>' % dest)

    reset_password_tag.short_description = "重置密码"
    reset_password_tag.allow_tags = True

    def get_urls(self):
        """
        添加一个指向上面重置密码功能的路由
        """
        from django.conf.urls import url
        urls = [
            url(r"^(\d+)/reset_pwd/$", self.admin_site.admin_view(self.reset_password)),
        ]
        return urls + super(UserAdmin, self).get_urls()

    def reset_password(self, request, *args):
        """
        实现密码重置功能
        """
        try:
            row_obj = get_object_or_404(MyUser, pk=args[0])
            from oucit.settings import USER_DEFAULT_PWD
            row_obj.set_password(USER_DEFAULT_PWD)
            row_obj.save()
            self.message_user(request, "%s 密码重置为: %s " % (row_obj.name, USER_DEFAULT_PWD))
        except:
            self.message_user(request, "密码重置失败，请刷新重试！", level=messages.ERROR)
        return redirect('/'.join(request.path.split('/')[:-3]))

    # 实现外键表链接到本页面一起编辑
    inlines = [ProfileAdmin, ]
    list_display = ('name', 'number_id', 'reset_password_tag',)
    readonly_fields = ['last_login']
    filter_horizontal = ('groups', 'user_permissions',)

    def get_fieldsets(self, request, obj=None):
        if request.user.is_superuser:
            return (
                ('基本信息', {'fields': ['number_id', 'name', 'last_login', 'groups', 'is_superuser']}),
            )
        else:
            return (
                ('基本信息', {'fields': ['number_id', 'name']}),
            )

    # 非超级管理员只显示自己信息
    def get_queryset(self, request):
        qs = super(UserAdmin, self).get_queryset(request)
        if request.user.is_superuser:
            return qs
        else:
            return qs.filter(pk=request.user.id)


class ConnectionIndline(admin.TabularInline):
    model = Connection
    form = ConnectionForm
    extra = 2


@admin.register(Group)
class GroupAdmin(admin.ModelAdmin):
    inlines = [ConnectionIndline, ]
    search_fields = ('name',)


@admin.register(Connection)
class ConnectionAdmin(admin.ModelAdmin):

    def get_list_display(self, request):
        if request.user.is_superuser:
            return ['group_fk', 'users_fk', 'display_level']
        else:
            return ['group_fk', 'display_level']

    # 过滤组织关系显示列表，非超级用户只显示自己自己组织的
    def get_queryset(self, request):
        qs = super(ConnectionAdmin, self).get_queryset(request)
        if not request.user.is_superuser:
            return request.user.connection.all()
        else:
            return qs


    def get_exclude(self, request, obj=None):
        if request.user.is_superuser:
            return []
        else:
            return ['group_fk', 'users_fk',]


@admin.register(Carousel)
class CarouselAdmin(admin.ModelAdmin):
    # list_display = ['headline', 'display_level']
    list_display = ['img_tag', 'headline', 'display_level']
    list_editable = ['headline', 'display_level']
    pass


@admin.register(IPRecord)
class IPRecordAdmin(admin.ModelAdmin):
    list_display = ['user_fk', 'ip_addr', 'time']
    search_fields = ['user_fk__name']


@admin.register(News)
class NewsAdmin(BaseArticleAdmin):
    fieldsets = (
        ("基本信息", {'fields': ['heading', 'subheading', ('column', 'category', 'is_official',), 'author', 'source',
                             ('open_jmp_url', 'jmp_url',), ]}),
        ("正文", {'fields': ['content', 'index_img', ]}),
        ("属性", {'fields': ['article_top', 'article_hot']}),
    )
    list_filter = ['is_official']

    # 过滤add,change 页面的外键下拉框
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "column":
            kwargs['queryset'] = ArticleColumn.objects.filter(column_name='学院新闻')
        return super(BaseArticleAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)

    def get_list_display(self, request):
        if request.user.is_superuser:
            return ['heading', 'c_time', 'publisher', 'category', 'is_official', ]
        return ['heading', 'c_time', 'category', 'is_official', ]

        # 本方法和 change_view 一起实现，修改文章不可以修改文章所属类别

    def get_readonly_fields(self, request, change=False, obj=None):
        if request.user.is_superuser:
            return []
        if change:
            return ['category', 'is_official']
        return []

    def change_view(self, request, object_id, form_url='', extra_context=None):
        change_obj = BaseArticle.objects.get(pk=object_id)
        self.get_readonly_fields(request, change=True, obj=change_obj)
        return super(BaseArticleAdmin, self).change_view(request, object_id, form_url, extra_context=extra_context)


@admin.register(Introduce)
class IntroduceAdmin(admin.ModelAdmin):

    def save_model(self, request, obj, form, change):
        if not change:
            try:
                Introduce.objects.get(department=obj.department)
                self.message_user(request, '不能重复添加！', messages.ERROR)
            except Introduce.DoesNotExist:
                obj.save()


@admin.register(Teach_Plan)
class Teach_PlanAdmin(admin.ModelAdmin):
    list_display = ['major', 'u_time']

    def save_model(self, request, obj, form, change):
        if not change:
            try:
                Teach_Plan.objects.get(major=obj.major)
                self.message_user(request, '不能重复添加！', messages.ERROR)
            except Teach_Plan.DoesNotExist:
                obj.save()


@admin.register(HZBX)
class HZBXAdmin(admin.ModelAdmin):
    def get_list_display(self, request):
        if request.user.is_superuser:
            return ['heading', 'c_time', 'publisher', ]
        return ['heading', 'c_time', ]

    # 保存模型的时候进行发表者绑定，图片提取等操作
    def save_model(self, request, obj, form, change):
        try:
            if not change:  # 如果是新增那么绑定当前账号为作者，修改的时候不改变作者
                obj.publisher = request.user
        except:
            self.message_user(request, '录入失败，请重试！', messages.ERROR)

        super(HZBXAdmin, self).save_model(request, obj, form, change)

    # 过滤文章显示列表，非超级用户只显示自己自己发表的
    def get_queryset(self, request):
        qs = super(HZBXAdmin, self).get_queryset(request)
        if not request.user.is_superuser:
            return qs.filter(publisher=request.user)
        else:
            return qs

    exclude = ('publisher', )


@admin.register(Teach_Course)
class Teach_CourseAdmin(admin.ModelAdmin):
    list_filter = ['department']
    list_display = ['course_name', 'major', 'course_id']


@admin.register(XSBG)
class XSBGAdmin(BaseArticleAdmin):
    fieldsets = (
        ("基本信息", {'fields': ['heading', 'subheading', ('column', 'category',), 'author', 'source', 'meeting_place',
                             'meeting_time',
                             ('open_jmp_url', 'jmp_url',), ]}),
        ("正文", {'fields': ['content', 'index_img', ]}),
        ("属性", {'fields': ['article_top', 'article_hot']}),
    )
    list_filter = []

    # 过滤add,change 页面的外键下拉框
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == "column":
            kwargs['queryset'] = ArticleColumn.objects.filter(column_name='学术报告')
        if db_field.name == "category":
            kwargs['queryset'] = ArticleCategory.objects.filter(category_name='学术报告')
        return super(BaseArticleAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)

    def get_list_display(self, request):
        if request.user.is_superuser:
            return ['heading', 'meeting_time', 'meeting_place', 'publisher', 'c_time', ]
        return ['heading', 'meeting_time', 'meeting_place', 'c_time', ]

    def get_readonly_fields(self, request, change=False, obj=None):
        if request.user.is_superuser:
            return []
        if change:
            return ['category', 'column']
        return []

    def change_view(self, request, object_id, form_url='', extra_context=None):
        change_obj = BaseArticle.objects.get(pk=object_id)
        self.get_readonly_fields(request, change=True, obj=change_obj)
        return super(BaseArticleAdmin, self).change_view(request, object_id, form_url, extra_context=extra_context)


class ArticleCategoryInline(admin.TabularInline):
    model = ArticleCategory
    extra = 3


@admin.register(ArticleColumn)
class ArticleColumnAdmin(admin.ModelAdmin):
    inlines = [ArticleCategoryInline]
