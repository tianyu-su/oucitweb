from it.models import Connection
from django import forms
from dal import autocomplete


class ConnectionForm(forms.ModelForm):
    """
    在组织关系中，外键自动填充，
    """
    class Meta:
        model = Connection
        fields = ('group_fk', 'users_fk', 'display_level', 'job_tile', 'job', 'phone', 'email')
        widgets = {
            'users_fk': autocomplete.ModelSelect2(url='user_autocomplete')
        }
