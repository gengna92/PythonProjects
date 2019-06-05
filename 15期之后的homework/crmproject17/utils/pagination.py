from django.utils.safestring import mark_safe

"""
分页使用文档：
from utils.pagination import Pagination


视图：

page_obj = Pagination(request.GET.get('page'), all_departs.count())

return render(request, 'user_list.html', {
    'all_user': all_user[page_obj.start:page_obj.end],
    'page_html':page_obj.page_html
})


模板：
    基于booststrap css
    <nav aria-label="Page navigation">
        <ul class="pagination">
            {{ page_html }}
        </ul>
    </nav>

"""


class Pagination:
    
    def __init__(self, page, all_count, per_num=10  , max_show=11):
        """
        
        :param page: 当前页码数
        :param all_count:  总数据条数
        :param per_num:  每页数据量
        :param max_show:  最多显示页码数
        """
        
        # 获取页码数
        try:
            self.page = int(page)
            
            if self.page <= 0:
                self.page = 1
        except Exception:
            self.page = 1
        
        # 数据总条数
        all_count = all_count
        
        # 每页显示的数据条数
        self.per_num = per_num
        
        # 最多显示页码数  max_show 传入的值
        half_show = max_show // 2
        
        # 总页码数
        self.page_count, more = divmod(all_count, per_num)
        if more:
            self.page_count += 1
        
        # 最多显示页码数 小于 最大显示页码数  显示所有页码
        if self.page_count < max_show:
            self.page_start = 1
            self.page_end = self.page_count
        
        else:
            # 处理左边的极值
            if self.page - half_show <= 0:
                self.page_start = 1
                self.page_end = max_show
            # 处理右边的极值
            elif self.page + half_show >= self.page_count:
                self.page_start = self.page_count - max_show + 1
                self.page_end = self.page_count
            # 正常情况
            else:
                self.page_start = self.page - half_show
                self.page_end = self.page + half_show
    
    @property
    def start(self):
        return (self.page - 1) * self.per_num
    
    @property
    def end(self):
        return self.page * self.per_num
    
    @property
    def page_html(self):
        # 存放li标签的字符串
        page_list = []
        
        if self.page == 1:
            page_list.append('<li class="disabled"><a>&laquo;</a></li>')
        else:
            page_list.append('<li><a href="?page={}">&laquo;</a></li>'.format(self.page - 1))
        
        for i in range(self.page_start, self.page_end + 1):
            if self.page == i:
                page_list.append('<li class="active"><a href="?page={}">{}</a></li>'.format(i, i))
            else:
                page_list.append('<li><a href="?page={}">{}</a></li>'.format(i, i))
        
        if self.page == self.page_count:
            page_list.append('<li class="disabled"><a>&raquo;</a></li>')
        else:
            page_list.append('<li><a href="?page={}">&raquo;</a></li>'.format(self.page + 1))
        
        return mark_safe(''.join(page_list))
