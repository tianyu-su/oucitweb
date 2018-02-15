'''
Django模板引擎的自定义过滤器，需要在模板中引用
{% load forum_extras %}
'''
from django import template
register = template.Library()


@register.filter(name='dump_errors')
def dump_errors(errors): # 显示错误信息
    t = template.Template('''
        {% if errors %}
        <ul class="errors alert alert-error">
            {% for v in errors.values %}
                <li>{{ v | join:'，' }}</li>
            {% endfor %}
        </ul>
        {% endif %}
        ''')
    c = template.Context(dict(errors = errors))

    return t.render(c)