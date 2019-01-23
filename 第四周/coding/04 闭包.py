# 闭包: 在内部函数中访问外部函数的变量.
#   1. 可以保护你的变量不受侵害. 变量是一个局部变量
#   2. 可以让一个变量常驻内存. 被内部函数访问的变量会常驻内存.


# def outer():
#     a = "哇哈哈哈"
#     def inner(): # 闭包函数
#         print(a) # 内层函数对外层函数中变量的引用
#
#     inner()
#
# outer()

# a = "白蛇" # 不安全
# def f1():
#     global a
#     a = "胡辣汤"
#     print(a)
#
# def f2():
#     print(a)
#
# f1()
# f2()


# def f1():
#     a = "白蛇" # 局部变量
#     def inner():
#         print(a)
#
#     def f2():
#         nonlocal a
#     return inner
#
#
#
# ret = f1()
# ret()
#
# # 改变a?????
# def f2():
#     nonlocal a
#

# def outer():
#     a = 10 # 可不可以回收
#     def inner():
#         return a
#     return inner
#
# ret = outer() # ret就是inner
# r = ret()
# print(r)
#
# print(ret()) # ret_inner 可以在任意的时段执行
# print(ret()) # 为了保证inner可以正常运行. a必须常驻内存.
# print(ret())
# print(ret())
# print("约一下")
# print("约一下")
# print("约一下")
# print("约一下")
# print(ret())

# 闭包应用
# low版爬虫
# 导入可以发送请求的一个包
from urllib.request import urlopen

# content = urlopen("https://www.dytt8.net/").read().decode("gbk")
# print(content) # 网页源代码
# 后面的就是爬取数据了......

# 上面的网页内容: 1. 不能被随意的改动. 2. 内容每次都去网络请求 很慢

def outer():
    content = urlopen("https://www.dytt8.net/").read().decode("gbk")
    def inner():
        return content # 闭包
    return inner
 
print("开始爬取")
o = outer() # 比较慢   o 就是innner
print("爬取完毕")

print("第一次")
print(o())
print("第二次")
print(o())
print("第三次")
print(o())





