from dal_select2_queryset_sequence.views import Select2QuerySetSequenceView

from queryset_sequence import QuerySetSequence

from it.models import MyUser, ArticleColumn
from django.db.models import Q
from django.shortcuts import HttpResponse



class UserAutocompleteView(Select2QuerySetSequenceView):
    """
    自定义 外键自动填充
    """

    #分页开关
    # mixup = True
    # AJAX 下来框 分页数量
    # paginate_by = 10


    def get_result_value(self, result):
        """Return the value of a result."""
        return str(result.pk)

    def get_queryset(self):
        users = MyUser.objects.all()

        #查询名字或者学工号
        if self.q:
            users = users.filter(Q(name__contains=self.q) | Q(number_id__contains=self.q))

        # Aggregate querysets
        qs = QuerySetSequence(users)

        if self.q:
            # This would apply the filter on all the querysets
            qs = qs.filter(name__icontains=self.q)

        # This will limit each queryset so that they show an equal number
        # of results.
        qs = self.mixup_querysets(qs)

        return qs


def get_cascade_list(request, column_id):
    """
    文章栏目二级联动
    """
    import json
    try:
        column = ArticleColumn.objects.get(pk=column_id)
        categories = column.category.all()
        return HttpResponse(json.dumps(list(categories.values('id', 'category_name'))), content_type='application/json')
    except:
        return HttpResponse(json.dumps([]), content_type='application/json')