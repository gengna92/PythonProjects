# 迭代和for有关系
# 可以for循环: str, list, tuple, dict, set, range, open,
# 不可以for循环:int, bool

# dir() 函数,  可以帮我们查看xxx数据类型中可以执行哪些操作
# print(dir(list)) # 我们看到了__iter__
# print(dir(str)) # 我们看到了__iter__
# print(dir(range)) # 我们看到了__iter__
# f = open("扑了儿子", mode="w")
# print(dir(f)) # 我们看到了__iter__
# print(dir(bool)) # # 没有__iter__
# print(dir(int)) # 没有__iter__

# 迭代:iter
# 可迭代的里面有__iter__
# 不可迭代的里面没有__iter__

# lst = ["一个包子", "一碗粥", "一盘咸菜", "一同泡面"]
#
# it = lst.__iter__() # iterator 迭代器
# # print(it) # <list_iterator object at 0x0000000001E8C6D8>
# #
# # print(dir(it)) # __iter__ # 迭代器本身也是可以被迭代的
# # # __next__ 下一个
# #
# # for i in it:
# #     print(i)
#
# print(it.__next__())
# print(it.__next__())
# print(it.__next__())
# print(it.__next__())
# print(it.__next__()) # StopIteration # 停止迭代. 迭代器里没有元素了

# 不管数据类型 -> 跨过数据类型的屏障. 完成所有数据类型的迭代工作

# 可迭代对象: __iter__()可以拿到迭代器
# 迭代器: __iter__() , __next__() 迭代器一定是可迭代的

# for循环到底做了些什么?
# 1,获取迭代器
# 2,获取元素
# 3,处理异常

# 模拟for循环(重点)
# lst = ["白蛇", "密室逃生", "来电狂响", "天气预爆"]
#
# it = lst.__iter__()  # 拿到迭代器
# while 1:
#     try:
#         el = it.__next__()
#         print(el)
#     except StopIteration: # 处理这个异常
#         break


# lst = list("张柏芝") # list()函数内部是要进行迭代的 list => for => 迭代器
# print(lst)


# 迭代器的特点:
# 1. 省内存(生成器)
# 2. 惰性机制 不执行__next__()不拿数据
# 3. 只能向前, 不能反复

# lst = ["王宝强", "马蓉", "宋喆", "杨xx"]
# it = lst.__iter__()
# print(it.__next__())
# print(it.__next__())
# print(it.__next__())
# print(it.__next__()) # 拿光数据之后. 迭代器就废了
#
# it = lst.__iter__() # 重新拿到迭代器
# print(it.__next__())

# 一般不这么用迭代器
# 迭代器给for循环用的.


# # 用官方的办法来判断xxx数据是否是可迭代对象, 迭代器
# # Iterable: 可迭代的
# # Iterator: 迭代器
from collections import Iterable, Iterator
# lst = [1,2,3]
# print(isinstance(lst, Iterable))  # 判断xxx数据是否是xxx类型的
# print(isinstance(lst, Iterator))  # 判断xxx数据是否是xxx类型的
#
# it = lst.__iter__()
# print(isinstance(it, Iterable))  # 判断xxx数据是否是xxx类型的
# print(isinstance(it, Iterator))  # 判断xxx数据是否是xxx类型的

# 生成器, 推导式, 生成器表达式, 内置函数(部分), 装饰器

f = open("扑了儿子", mode="r")
print(isinstance(f, Iterator))
print(isinstance(f, Iterable))
