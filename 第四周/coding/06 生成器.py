# 生成器的本质:迭代器

# def chi():
#     print("第一顿")
#     return "饺子"  # 函数一运行到return. 结束函数的调用和执行
#
#
# ret = chi()
# print(ret)


# def chi():
#     print("第一顿")
#     yield "饺子"  # yield 也代表返回,  函数中如果有了yield, 函数是一个生成器函数
#     print("第二顿")
#     yield "包子"
#
# # 生成器函数运行的时候. 不会执行你的函数. 获取到一个生成器
# ret = chi() # <generator object chi at 0x0000000001DFD888> 生成器
# print(ret)
#
# # 生成器的运行: __next__()
# r1 = ret.__next__() # 此时函数才真正的开始运行. 运行到第一个yield
# print(r1)
#
# r2 = ret.__next__()
# print(r2)
#
# r3 = ret.__next__() # 生成器已经执行完毕. 不可以继续运行. StopIteration
# print(r3)
#
# # yield:
# #   1. 把一个普通的函数变成生成器函数
# #   2. 可以分段的把一个函数去裕兴


# 作用
# def order():
#     lst = []
#     for i in range(10000):
#         lst.append("衣服%s" % i)
#     return lst
#
# lst = order() # 数据量很大. 存储是一个大问题
# print(lst)


# # 生成器函数
# # 大量的节省内存. 生成器内部保存的是代码. 不是数据
# def order():
#     for i in range(10000):
#         yield "衣服%s" % i
#
# gen = order()
#
# print(gen.__next__()) # 让生成器向下执行一次
# print(gen.__next__())
# print(gen.__next__())
# print(gen.__next__())
# print(gen.__next__())


# # send() 也可以像__next__()一样执行生成器中的代码, 都是执行到下一个yield
# # send可以给上一个yield位置传值
#
# def chi():
#     print("我要开始吃饭了")
#     a = yield "大米饭"
#     print(a)
#     print("我不吃主食了")
#     b = yield "锅包肉"
#     print(b)
#     print("我最喜欢吃素的")
#     c = yield "汉堡包"
#     print(c)
#     d = yield "吃饱"
#     print(d)
#
# gen = chi() # 创建生成器
# print(gen.__next__())  # 第一次运行. 没有上一个yield
# # print(gen.__next__())
# print(gen.send("大龙虾"))
# print(gen.send("火腿肠"))
# print(gen.send("芝士")) # 吃饱
# print(gen.send("哈哈哈哈哈哈")) # 最后一个yield位置是不能传值的. 最后一个yield后面不会再有yield了


