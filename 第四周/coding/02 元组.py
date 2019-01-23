# def func():
#     return 1, 2, 3
#
# a = func()
# print(a)


def func():
    global name # 在局部可以创建全局变量
    name = "dsb"
    
# print(name) # alex
func()
print(name) # dsb