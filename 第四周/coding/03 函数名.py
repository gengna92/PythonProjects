# def play():
#     print("最近喜欢跑跑卡丁车")
#
# play() # () 调用 callable()
# print(play) # <function play at 0x00000000003D1E18>

# 函数名就是一个变量名
# # 1. 赋值
# def an():
#     print("昨天下载的游戏")
#
# bn = an
# an = 3
#
# bn()
# print(an)

# # 2. 函数可以作为参数进行传递
# def func(fn): # fn可以接收任意的函数
#     print("我是func")
#     fn() # 收到的函数什么都没干. 直接执行
#     print("你执行完了")
#
# def shuijiao():
#     print("我特别喜欢睡觉")
#     # return None
# def chi():
#     print("我还特别喜欢吃")
#
# # func(shuijiao()) # 'NoneType' object is not callable
# func(shuijiao)
# func(chi)

# # 3,. 函数名可以作为返回值返回
# def outer():
#     def inner():
#         print("我是内部函数")
#
#     print("我是外部函数")
#     a = 123
#     return inner
#
# ret = outer()
# print(ret)
# ret() # 执行的是inner => 在函数外面访问到了内部函数
# # ret = "呵呵呵"
#

# #. 4.函数名可以作为集合类的元素
# def f1():
#     print("今天中午吃1个包子")
#
# def f2():
#     print("今天中午吃2个包子")
# def f3():
#     print("今天中午吃3个包子")
# def f4():
#     print("今天中午吃4个包子")
#
# # lst1 = [f1(),f2(),f3(),f4()]
# lst2 = [f1,f2,f3,f4]
# for el in lst2:
#     el()
# # print(lst1)

