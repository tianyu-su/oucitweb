from django.db import models
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager, User
from django.contrib.auth.validators import ASCIIUsernameValidator, UnicodeUsernameValidator
from django.utils import six
from django.utils.html import format_html
from oucit.settings import MEDIA_URL
from DjangoUeditor.models import UEditorField


# Create your models here.


class NormalTextField(models.TextField):
    """
    派生一个 NormalTextField ，因为原生 TextField 在 Mysql 数据库中字段为， 
    LongText 浪费空间， 直接通过返回 text 来告知 ORM 创建表的时候为 Text
    """
    def db_type(self, connection):
        return 'text'


class MyUserManager(BaseUserManager):
    """
    配合自定义User使用
    """

    def create_superuser(self, name, number_id, password):
        if not name:
            raise ValueError('The given username must be set')
        name = self.model.normalize_username(name)
        user = self.model(name=name, number_id=number_id)
        user.set_password(password)
        user.is_superuser = True
        user.save(using=self._db)
        return user


class MyUser(AbstractBaseUser, PermissionsMixin):
    """
    继承抽象基本用户为了使用其用户认证，permissionsMixin 使用权限系统
    """

    number_id_validator = UnicodeUsernameValidator() if six.PY3 else ASCIIUsernameValidator()

    number_id = models.CharField('学工号',
                                 max_length=15,
                                 unique=True,
                                 validators=[number_id_validator, ],
                                 help_text='请输入正确的学工号用于系统登录',
                                 error_messages={
                                     'unique': "该学工号已经注册！请检查！",
                                 },
                                 )
    name = models.CharField('姓名', max_length=50)

    # 必须写，在 Manager 中有使用
    USERNAME_FIELD = 'number_id'
    REQUIRED_FIELDS = ['name']

    # 自定义必须实现 Manager
    objects = MyUserManager()

    def get_short_name(self):
        return self.name

    def get_full_name(self):
        return self.get_short_name()

    def __str__(self):
        return "%s %s" % (self.name, self.number_id)

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return True

    def has_group(self, group):
        if not self.is_active:
            return False
        if self.is_superuser:
            return True
        if not hasattr(self, '_group_cache'):
            self._group_cache = set([g.name for g in self.groups.all()])
        return group in self._group_cache

    class Meta:
        verbose_name = '用户'
        verbose_name_plural = '用户'
        ordering = ['number_id']


class Profile(models.Model):
    """
    用户详细信息
    """
    CHOICE_JOB_TITLE = (
        ('0', '教授'),
        ('1', '副教授'),
        ('2', '高级工程师'),
        ('3', '高级实验师'),
        ('4', '讲师'),
        ('5', '助理工程师'),
        ('6', '助理实验师'),
        ('7', '其他'),
    )

    CHOICE_JOB = (
        ('0', '院长'),
        ('1', '副院长'),
        ('2', '系主任'),
        ('3', '副系主任'),
        ('4', '其他'),
    )

    CHOICE_TUTOR = (
        ('0', '博士生导师'),
        ('1', '硕士生导师'),
        ('2', '其他'),
    )

    CHOICE_DEPARTMENT = (
        ('0', '物理系'),
        ('1', '电子工程系'),
        ('2', '计算机科学与技术系'),
        ('3', '海洋技术系'),
        ('4', '信息工程中心'),
        ('5', '行政人员'),
    )

    user_fk = models.OneToOneField(MyUser, verbose_name='用户')
    pic = models.ImageField('上传照片', upload_to='user-head', blank=True)
    birthday = models.DateField('生日')
    politics_status = models.CharField('政治面貌', blank=True, max_length=20, default='')
    education = models.CharField('学历', max_length=50, blank=True, default='')
    mobile_phone = models.CharField('移动电话', max_length=15, blank=True, default='')
    office_phone = models.CharField('办公电话', max_length=15, blank=True, default='')
    email = models.EmailField('Email', blank=True, default='')
    workplace = models.CharField('办公室', max_length=50, blank=True, default='')
    address = models.CharField('通信地址', max_length=80, blank=True, default='')

    job_title = models.CharField('职称', max_length=10, choices=CHOICE_JOB_TITLE, default=0)
    job = models.CharField('职务', max_length=10, choices=CHOICE_JOB, default=0)
    tutor = models.CharField('导师', max_length=10, choices=CHOICE_TUTOR, default=0)
    department = models.CharField('单位', max_length=15, choices=CHOICE_DEPARTMENT, default=0)

    course = NormalTextField('教授课程', blank=True, default='')
    experience = NormalTextField('教育及工作经历', blank=True, default='')
    research_direction = NormalTextField('研究方向', blank=True, default='')
    research_project = NormalTextField('科研项目', blank=True, default='')
    achievements = NormalTextField('学术成果', blank=True, default='')
    paper = NormalTextField('论文专利', blank=True, default='')
    enrolment = NormalTextField('研究生招生条件', blank=True, default='')
    remark = NormalTextField('备注', blank=True, default='')

    def __str__(self):
        return self.user_fk.name

    class Meta:
        verbose_name_plural = '用户详细信息'
        verbose_name = '用户详细信息'


class Group(models.Model):
    """
    社团组织
    """
    CHOICE_TYPE = (
        ('0', '组织'),
        ('1', '社团'),
        ('2', '实验室'),
        ('3', '其他'),
    )

    name = models.CharField('组织名字', max_length=20, unique=True)
    type = models.CharField('组织类型', max_length=10, choices=CHOICE_TYPE, default=0)
    pic = models.ImageField('组织图片', upload_to='org-img', blank=True)
    link_url = models.URLField('组织网址', blank=True, default='')

    def __str__(self):
        return self.name

    class Meta:
        verbose_name_plural = '组织'
        verbose_name = '组织'


class Connection(models.Model):
    """
    社团组织的具体联系表
    """
    group_fk = models.ForeignKey(Group, verbose_name='组织')
    users_fk = models.ForeignKey(MyUser, verbose_name='组员', related_name='connection')
    display_level = models.IntegerField('显示等级')
    job_tile = models.CharField('职务', max_length=100, blank=True, default='')
    job = models.CharField('职责', max_length=100, blank=True, default='')
    phone = models.CharField('电话', max_length=100, blank=True, default='')
    email = models.EmailField('Email', blank=True, default='')

    def __str__(self):
        # return "<Connection:> %s -- %s" % (self.group_fk.name, self.users_fk.name)
        return ""

    class Meta:
        verbose_name_plural = '职责关系'
        verbose_name = '职责关系'
        ordering = ['group_fk', 'display_level']
        unique_together = ('group_fk', 'users_fk')


class Carousel(models.Model):
    """
    首页轮播图
    """
    pic = models.ImageField('图片(规格: 1190*398)', upload_to='index-img')
    headline = models.CharField('标题', max_length=80, blank=True, default='')
    display_level = models.IntegerField('显示顺序', default=1)

    def img_tag(self):
        img_html = ''
        try:
            img_html = format_html('<img src="%s" width="150px" height="150px" />' % (MEDIA_URL + self.pic.path))
        except Exception:
            pass
        return img_html

    img_tag.short_description = '照片'
    img_tag.allow_tags = True

    def __str__(self):
        return self.headline

    class Meta:
        verbose_name_plural = '首页轮播图'
        verbose_name = '首页轮播图'
        ordering = ['display_level']


class IPRecord(models.Model):
    """
    管理员记录 IP 
    """
    user_fk = models.ForeignKey(MyUser, verbose_name='管理员', null=True, on_delete=models.SET_NULL)
    ip_addr = models.GenericIPAddressField('IP地址')
    time = models.DateTimeField('登录时间', auto_now=True)

    def __str__(self):
        return self.user_fk.name

    class Meta:
        verbose_name = '登录记录'
        verbose_name_plural = '登录记录'
        ordering = ['-time']


class Introduce(models.Model):
    """
    学院、专业概况
    """
    CHOICE_DEPARTMENT = (
        ('0', '学院'),
        ('1', '物理系'),
        ('2', '电子工程系'),
        ('3', '计算机科学与技术系'),
        ('4', '海洋技术系'),
        ('5', '信息工程系'),

        ('6', '物理学'),
        ('7', '光信息科学与技术'),

        ('8', '电子信息科学与技术'),
        ('9', '电子信息工程'),
        ('10', '通信工程'),

        ('11', '计算机科学与技术'),

        ('12', '海洋技术'),
    )

    department = models.CharField('院系专业', max_length=20, choices=CHOICE_DEPARTMENT, default='0',
                                  help_text='院系介绍选择结尾为系，专业介绍结尾无系')
    content = UEditorField(height=300, width=1000,
                           imagePath="uploads/images/", toolbars='besttome', filePath='uploads/files/',
                           default='', blank=True, verbose_name='正文')

    def __str__(self):
        return self.get_department_display()

    class Meta:
        verbose_name = '院系、专业介绍'
        verbose_name_plural = '院系、专业介绍'
        ordering = ['department']


class Teach_Plan(models.Model):
    """
    教育教学--教学计划
    """
    CHOICE_MAJOR = (
        ('0', '物理学'),
        ('1', '光信息科学与技术'),

        ('2', '电子信息科学与技术'),
        ('3', '电子信息工程'),
        ('4', '电子信息工程中法卓越班'),

        ('5', '通信工程'),

        ('6', '计算机科学与技术'),

        ('7', '海洋技术'),
    )

    major = models.CharField('专业', max_length=20, choices=CHOICE_MAJOR, default='0')
    u_time = models.DateField('上传时间', auto_now=True)
    file = models.FileField('替换上传', upload_to='teach-plan', blank=True)

    def __str__(self):
        return self.get_major_display()

    class Meta:
        verbose_name = '培养计划'
        verbose_name_plural = '培养计划'
        ordering = ['major']


class HZBX(models.Model):
    """
    教育教学--合作办学
    """
    publisher = models.ForeignKey(MyUser, verbose_name='发表人')
    heading = models.CharField('标题', max_length=50)
    content = UEditorField(height=300, width=1000,
                           imagePath="uploads/images/", toolbars='besttome', filePath='uploads/files/',
                           default='', blank=True, verbose_name='正文')
    c_time = models.DateTimeField('录入时间', auto_now_add=True)

    def __str__(self):
        return self.heading

    class Meta:
        verbose_name_plural = '合作办学'
        verbose_name = '合作办学'


class Teach_Course(models.Model):
    """
    教育教学--本科生教育--课程介绍
    """
    CHOICE_DEPARTMENT = (
        ('0', '物理系'),
        ('1', '电子工程系'),
        ('2', '计算机科学与技术系'),
        ('3', '海洋技术系'),
    )

    CHOICE_MAJOR = (
        ('0', '物理学'),
        ('1', '光信息科学与技术'),

        ('2', '电子信息科学与技术'),
        ('3', '电子信息工程'),
        ('4', '通信工程'),

        ('5', '计算机科学与技术'),

        ('6', '海洋技术'),
    )

    CHOICE_TYPE = (
        ('0', '无实验理论课或纯试验课程'),
        ('1', '含实验理论课'),
        ('2', '课程设计(或以周为教学单位的试验课)'),
    )

    course_name = models.CharField('课程名称', max_length=50)
    department = models.CharField('开课院系', max_length=20, choices=CHOICE_DEPARTMENT, default=0)
    major = models.CharField('所属专业', max_length=20, choices=CHOICE_MAJOR, default=0)
    course_type = models.CharField('课程类型', max_length=30, choices=CHOICE_TYPE, default=0)
    course_id = models.CharField('课程编号', max_length=30)
    course_name_english = models.CharField('课程英文名称', max_length=100)
    course_hours = models.SmallIntegerField('课程总学时')
    course_credit = models.FloatField('课程总学分')
    experiment_hours = models.SmallIntegerField('含实验或实践学时')
    experiment_credit = models.FloatField('含实验或实践学分')
    recommend_book = models.CharField('推荐使用教材', blank=True, max_length=200, default='')
    recommend_book_author = models.CharField('推荐使用教材编者', blank=True, max_length=200, default='')
    recommend_book_publisher = models.CharField('推荐使用教材出版社', blank=True, max_length=200, default='')
    recommend_book_time_version = models.CharField('推荐使用教材出版时间及版次', blank=True, max_length=200, default='')
    course_object = NormalTextField('课程教学目标与基本要求', blank=True, default='')
    quiz_type = models.CharField('考试形式', max_length=20)
    referance_book = NormalTextField('学习参考书', blank=True, default='')
    additional_file = models.FileField('上传更多信息', upload_to='course-file', blank=True)

    def __str__(self):
        return self.course_name

    class Meta:
        verbose_name_plural = '课程列表'
        verbose_name = '课程列表'


class ArticleColumn(models.Model):
    """
    存储文章的大栏目
    """
    column_name = models.CharField('栏目名称', max_length=50)

    def __str__(self):
        return self.column_name

    class Meta:
        verbose_name_plural = '文章栏目'
        verbose_name = '文章栏目'


class ArticleCategory(models.Model):
    """
    栏目二级分类
    """
    category_name = models.CharField('栏目二级分类名称', max_length=50)
    belong_column = models.ForeignKey(ArticleColumn, related_name='category')

    def __str__(self):
        return self.category_name

    class Meta:
        verbose_name = '栏目二级分类'
        verbose_name_plural = '栏目二级分类'


class BaseArticle(models.Model):
    """
    无特别文章的模板类
    """
    CHOICE_AUTHOR = (
        ('0', '我自己'),
        ('1', '匿名'),
        ('2', '未知'),
    )

    CHOICE_SOURCE = (
        ('0', '本站原创'),
        ('1', '转载'),
        ('2', '未知'),
        ('3', '来自网络'),
    )

    publisher = models.ForeignKey(MyUser, verbose_name='发表人')
    heading = models.CharField('标题', max_length=50)
    subheading = models.CharField('副标题', max_length=50, blank=True, default='')
    column = models.ForeignKey(ArticleColumn, verbose_name='文章发表栏目')
    category = models.ForeignKey(ArticleCategory, verbose_name='栏目分类')
    author = models.CharField('作者', max_length=15, choices=CHOICE_AUTHOR, default='0')
    source = models.CharField('来源', max_length=15, choices=CHOICE_SOURCE, default='0')
    open_jmp_url = models.BooleanField('启用转向链接', default=False)
    jmp_url = models.URLField('转向链接', blank=True, default='')
    content = UEditorField(height=300, width=1000,
                           imagePath="uploads/images/", toolbars='besttome', filePath='uploads/files/',
                           default='', blank=True, verbose_name='正文')
    # content = models.TextField('正文', blank=True, default='')
    index_img = models.BooleanField('从本文获取首页图片', default=True)
    index_img_url = models.CharField('首页图片地址', blank=True, max_length=200, default='')
    article_top = models.BooleanField('置顶文章', default=False)
    article_hot = models.BooleanField('热门文章', default=False)
    c_time = models.DateField('录入时间', auto_now_add=True)

    def __str__(self):
        return self.heading

    class Meta:
        verbose_name_plural = '文章'
        verbose_name = '文章'
        ordering = ['-c_time', 'article_top', 'article_hot']


class News(BaseArticle):
    """
    文章--学院新闻
    """

    is_official = models.BooleanField('学院官方', default=True)

    class Meta:
        verbose_name_plural = '学院新闻'
        verbose_name = '学院新闻'


class XSBG(BaseArticle):
    """
    学术报告
    """
    meeting_place = models.CharField('举办地点', max_length=100)
    meeting_time = models.DateTimeField('举办时间')

    class Meta:
        verbose_name_plural = '学术报告'
        verbose_name = '学术报告'
