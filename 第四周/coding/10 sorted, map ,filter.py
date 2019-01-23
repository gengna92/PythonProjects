# # sorted: sort排序
# lst = [1,2,1,1,1,12,23,34,4,3,3,2]
# # lst.sort()
# lst2 = sorted(lst, reverse=True)
# print(lst2)

# # 可以自己给出排序规则
# #       2       4            3        3         3           7
# lst = ["盖伦", "快乐风男", "儿童节", "喜之郎", "托儿所", "奥斯特洛夫斯基"]
# #根据名字的长度排序
# def func(x): # x就是列表中每一项
#     return len(x)
#
# lst2 = sorted(lst, key=func, reverse=True) # key必须是一个函数
# # 把可迭代对象中的每一项拿出来传递给函数key, 根据函数执行的结果进行排序
# print(lst2)

# # 根据给的人的年龄进行排序
# lst = [{"name":"alex", "age":34, "hobby":"吹牛"},
#        {"name": "wusir", "age": 14, "hobby": "吹牛牛"},
#        {"name": "taibai", "age": 31, "hobby": "吹牛牛牛"},
#        {"name": "taihei", "age": 12, "hobby": "吹牛牛牛牛"},
#        {"name": "tailv", "age": 48, "hobby": "吹牛牛牛牛牛"},]
#
#
# # print(sorted(lst, key=lambda dic: dic['age']))
# # print(sorted(lst, key=lambda dic: dic['hobby'].count("牛")))

# # filter 筛选
# lst = ["张无忌", "张三丰", "张子萱", "李老虎", "李易峰"]
#
# f = filter(lambda x: x[0] == "张", lst)
# for el in f:
#     print(el)
# # filter 把可迭代对象进行迭代. 把每一项数据传递给前面的函数. 根据函数返回的true和false来决定该元素是否保留


# lst = [3, 4, 1, 2, 3, 4, 5]
#
# m = map(lambda x: x + 1, lst) # 把可迭代对象中每一项传递给前面的函数. 函数执行的结果作为整个运算的结果
# for el in m:
#     print(el)

# hadoop
