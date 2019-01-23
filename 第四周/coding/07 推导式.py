# 创建一个列表. 里面放10000件衣服

# # lst = []
# # for i in range(10000):
# #     lst.append("衣服%s" % i)
#
# lst = ["衣服%s" % i for i in range(10000)]
#
# #列表推导式: [添加的内容 for循环 if条件]
#
# print(lst)

# 生成一个列表. 元素是1, 4, 9, 16, 25
#                   1, 2, 3, 4,  5

# lst = [i ** 2 for i in range(1, 10) if i % 2 == 0]
# print(lst)

# # 字典推导式 {k:v for循环 if条件}
# lst = ["莫丽清", "莫厉害", "魔力红", "魔力瘦"]
#
# dic = {i:lst[i] for i in range(len(lst))}
# print(dic)

# 集合推导式 {k for循环 if条件}
# dic = {} # key必须可哈希
# dic[1] = "张无忌"
# dic[1] = "赵敏"
# print(dic)
#
# # 集合  {}  # 其实就是不存value的字典
# s = set()
# s.add("胡辣汤")
# s.add("胡辣汤")

# s = {i for i in range(1,5,2)}
# print(s)


# # 没有元组推导式  (结果 for if)  生成器表达式
# gen = (i for i in range(100))
# print(gen)  # <generator object <genexpr> at 0x0000000001DFD990>
#
# print(gen.__next__())
# print(gen.__next__())
#
# # 完全是一次性的

# 看一个面试题

# def func(): # 生成器函数
#     print(111)
#     yield 222
#
# g = func() # 创建生成器
# g1 = (i for i in g) #  生成器表达式, 没有人拿过数据. g1和g都是新的
# g2 = (i for i in g1) # 生成器表达式, 没有人拿过数据. g1和g2, g都是新的
#
# print(list(g2))
# print(list(g)) # list => for => __iter__() => __next__()
# print(list(g1))

# 惰性机制
# 只能向前. 不能反复
# 生成器里保存的是代码. 不是数据


# # yield from
# def chi():
#     yield from ["疙瘩汤", "烧烤", "烤鱼", "烤面筋"]
#     yield from ["呵呵", "哈哈", "嘿嘿", "嘻嘻"]
#
# gen = chi()
# print(gen)
#
# print(gen.__next__())
# print(gen.__next__())
# print(gen.__next__())
# print(gen.__next__())
# print(gen.__next__())



