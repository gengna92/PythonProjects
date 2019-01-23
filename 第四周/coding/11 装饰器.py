# 开闭原则
#  开: 增加功能
#  闭: 对修改源代码封闭

# def yue():
#     print("打开手机")
#     print("打开陌陌")
#     print("找一个合适的")
#     print("找一个不合适的")
#     print("现女友也不错....")


# 装饰器的目的: 在不改变原来代码的基础上. 给代码添加新功能
#
# def zaoren():
#     print("女娲. 捏泥人. 吹口气")
#
# # 三年大旱
# def water(fn): # 代理了原来的zaren
#     def inner():
#         print("浇水")
#         fn() # zaoren()
#     return inner
#
# zaoren = water(zaoren) # 依然执行了造人和water
#
#
#
# zaoren()
# zaoren()
# zaoren()

    
# 装饰器的基本雏形
# def wrapper(fn): # fn:目标函数.
#     def inner():
#         '''执行函数之前'''
#         fn() # 执行被装饰的函数
#         '''执行函数之后'''
#     return inner

# 第二个故事
# 约

# from functools import wraps # 导入wraps模块
# # 约之前问问alex. 最近时长行情怎么样
# def wrapper(fn):
#     @wraps(fn) # inner在看起来就像是fn函数
#     def inner():
#         print("问问alex. 行情如何")
#         fn()
#         print("alex骗我")
#     return inner
#
# # 语法糖
# @wrapper  # yue = wrapper(yue)
# def yue():
#     print("约一约")
#
# @wrapper
# def play():
#     print("一起打游戏")
#
# print(yue) # 外面看到的都是inner函数
# print(play)
# yue()
# play()

# 在不改变函数源代码的基础上给函数添加新功能



# def wrapper(fn):
#         # 无敌传参
#     def inner(*args, **kwargs): # args = > 元组 **kwargs => 字典
#         print("哈哈")
#         ret = fn(*args, **kwargs) # 把接收到的数据打散发出去
#         print("呵呵")
#         return ret
#     return inner
#
# @wrapper
# def play(username, password):
#     print("用%s" % username)
#     print("用%s" % password)
#     return 1000
#
# ret = play("alex", 123) # 调用的是inner
# print(ret)




#
# @wrapper
# def yue(tools):
#     print("用%s约" % tools)
# yue("探探")
#
# # inner() takes 0 positional arguments but 2 were given
# # 由于装饰器的存在. play -> inner
# play("alex", 123)


# # 装饰器雏形(2版)
# from functools import wraps
#
# # 动态代理
# # 思想:AOP, 面向切面编程
# def wrapper(fn): # fn: 目标函数, 被装饰的函数
#     @wraps(fn) # 改变inner的名字
#     def inner(*args, **kwargs): # *args, **kwargs: 接收参数
#         """之前"""
#         ret = fn(*args, **kwargs) # 调用目标函数.
#         """之后"""
#         return ret # 返回结果
#     return inner
#
# @wrapper
# def func():
#     pass


# # 应用
# # 在执行以下操作之前., 要进行登录校验
# flag = False # 没登录
#
# def login():
#     username = input("请输入用户名:")
#     password = input("请输入密码:")
#     if username == "alex" and password == "123":
#         print("登录成功")
#         global flag # 导入全局变量
#         flag = True
#     else:
#         print("登录失败")
#
# # 登录验证的装饰器
# def login_verify_wrapper(fn):
#     def inner(*args, **kwargs):
#         while 1:
#             if flag:
#                 ret = fn(*args, **kwargs)
#                 return ret
#             else:
#                 login()
#     return inner
#
#
# @login_verify_wrapper
# def add():
#     pass
#
# @login_verify_wrapper
# def upd():
#     pass
#
# @login_verify_wrapper
# def dele():
#     pass
#
# @login_verify_wrapper
# def info():
#     pass
#
#
# add()
# upd()
# dele()
# info()


# # 带有参数的装饰器
# def wrapper_out(flag): # 装饰器的参数
#     def wrapper(fn):
#         def inner(*args, **kwargs):
#             if flag == True: # 判断是否要问alex
#                 print("问一下alex")
#             ret = fn(*args, **kwargs)
#             return ret
#         return inner
#     return wrapper
#
# @wrapper_out(False) # 执行流程: 先执行wrapper_out(True)  返回装饰器 再和@拼接起来. @wrapper
# def yue():
#     print("我要约")
#
# yue()

# 多个装饰器装饰同一个函数
#
# def wrapper1(fn):
#     def inner(*args, **kwargs):
#         print("第一个装饰器开始")
#         ret = fn(*args, **kwargs)
#         print("第一个装饰器结束")
#         return ret
#     return inner
#
# def wrapper2(fn):
#     def inner(*args, **kwargs):
#         print("第二个装饰器开始")
#         ret = fn(*args, **kwargs)
#         print("第二个装饰器结束")
#         return ret
#     return inner
#
# def wrapper3(fn):
#     def inner(*args, **kwargs):
#         print("第三个装饰器开始")
#         ret = fn(*args, **kwargs)
#         print("第三个装饰器结束")
#         return ret
#     return inner
#
# @wrapper1
# @wrapper2
# @wrapper3
# def func():
#     print("瞬间来三")
#
# func()

# # wrapper1
# # wrapper2
# # wrapper3
# # func
# # wrapper3
# # wrapper2
# # wrapper1
