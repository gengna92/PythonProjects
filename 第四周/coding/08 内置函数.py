# python直接给你的. 直接拿来用的.
# print()
# input()
# len()
# range()
# min()
# max()
# list()
# str()
# tuple()

# lst = ["宅", "上班", "加班", "坐地铁", "睡觉"]
#
# # it1 = lst.__iter__() # 类的特殊成员,  特定的场景固定的调用方式
# # print(it1)
#
# it2 = iter(lst) # 内部执行的就是__iter__()
# print(it2)
#
# it2.__next__()
# next(it2)

# print(hash("哈哈哈")) # 哈希值就是一个数字



# import os
# mokuai = input("请输入你要导入的模块")
# __import__(mokuai)

# print(help(str))


# # callable 判断你给的参数是否可以被调用
# def func(fn):
#     if callable(fn): # 判断你传进来的这个东西能不能+()
#         print("哈哈哈哈哈")
#         fn()
#         print("哇哈哈哈哈哈")
#     else:
#         print("不可以被调用")
#
# def chi():
#     print("吃自助餐了")
#
# func(chi)

# eval # 有返回值 = > 侧重结果
# exce # 没有返回值 => 侧重过程
# compile # 编译   python是一门解释型编程语言.
# 意义:可以执行动态的代码, 执行字符串代码

# s = "5+9 + 13"
# ret = eval(s)
# print(ret)

# s = input("请输入一段代码:")
# ret = eval(s) # "[1,2,3,4]"  => 列表
# print(ret)

# exec
# s = input("请输入一段代码:")
# exec(s)

# s = "name='周杰伦'"
# exec(s) # name='周杰伦'
# print(name) # pycharm的错误不一定真的错误

# compile可以预加载(编译)一些代码.
# compile(代码, 文件, 执行模式)

# s = """
# lst = []
# for i in range(10):
#     lst.append(i)
# print(lst)
#
# """
#
# c = compile(s, "", "exec")
#
# # 运行代码
# exec(c)


# c = compile("5+9", "", "eval")
# ret = eval(c)
# print(ret)

# c = compile("name = input('请输入你的名字')", "", "single") # single:当程序出现交互了
# exec(c)
# print(name)

#
# a = 0b101 # 二进制
# print(a)

# a = 0o11 # 八进制
# print(a)

# a = 0x12 # 十六进制
# print(a)
#
# print(bin(5)) # 0b101
# print(oct(9)) # 0o11
# print(hex(18)) # 0x12

# s = {1,2,3} # 不可哈希. 因为可变
#
# s.add(4)
# s.add("刘老根")
#
# print(s)

# s = frozenset({1,2,3})
# print(hash(s)) # 不可变
# list => tuple
# set => fronzenset

# lst = ["刘老根", "药匣子", "马大帅", "西游记"]
#
# for i in range(len(lst)):
#     print(i, lst[i])
#
# for i, el in enumerate(lst, 100):
#     print(i, el)


# # all
# print(all([0, 1, "哈哈哈", '呵呵呵'])) # and
# # any
# print(any([0, None, True, []])) # or

# if any([5>8, 3 > 5, 1 < 0]):
#     pass
# if 5 > 8 or 3 > 5 or  1 < 0:
#     pass


# s = "你好啊, 我叫周杰伦"
# ss = "巴拉巴拉巴拉巴拉巴拉"
# sss = "哈哈进口红酒客户"
# s1 = slice(2, 9)
#
# print(s[s1])
# print(ss[s1])
# print(sss[s1])

# print(ord("中")) # 20013
# print(chr(20013))

# for i in range(65536):
#     print(chr(i), end=" ")
#
# s = "金角大王吧"
# print(ascii(s)) # 判断你的文字是否是ascii范畴得 内容









# repr
# s = "哈哈哈哈" # => 变成C里面的字符串
# print(s)
# print(repr(s)) # 把字符串还原回最应该显示的样子

# s = "哈\哈哈" # \ 转义  \n  \t  \\   \"   \'
# print(s)
# print(repr(s))
# s = "胡辣汤\\n蝙蝠侠"
# print(s)
# print(repr(s))

# print(r"") # 原样输出 => 和repr没关系
# print(r"哈\n\\\n\]\\\\\\\\n哈\t哈") # 正则表达式


# 很重要
# 1. str 普通字符串
# 2. repr 还原最官方的字符串
# 3. r"" 原样输出

# print(format("test", "<20"))  # 拉长成20位, 左对齐
# print(format("test", ">20"))  # 拉长成20位, 右对齐
# print(format("test", "^20"))  # 拉长成20位, 右对齐
#
# print(format(11))
# print(format(11, "b")) # 1011
# print(format(11, "d")) # 11
# print(format(11, "o")) # 13
# print(format(11, "x")) # b
# print(format(11, "X")) # B
#
# bin()
# hex()
# oct()

# print(format(123456789, "e")) # 科学计数法 ,  默认保留小数点后6位
# print(format(123456789, ".1e")) # 科学计数法 ,  默认保留小数点后1位
# print(format(123456789, ".1E")) # 科学计数法 ,  默认保留小数点后1位

# # 重要
# print(format(1.23456789, ".2f")) # 保留小数点2位
# print(format(10.000000000000000005, ".3"))
# print(10/3)

# # zip 拉链
# lst1 = ["赵本山", "范伟", "于月仙"]
# # lst2 = ["相亲", "卖拐"]
# # lst3 = [28, 60, 50]
# #
# # z  = zip(lst1, lst2, lst3) # 水桶效应
# #
# # print(z) # <zip object at 0x00000000029632C8>
# #
# # for el in z:
# #     print(el)


