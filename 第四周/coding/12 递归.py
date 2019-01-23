# # 函数自己调用自己
# def func():
#     print("哈哈哈哈")
#     func()
#
# func()

# python的最大递归深度. 1000.永远到不了1000
# windows最大你能看到998
# mac 能看到的997

# 递归的一个应用: 遍历文件夹


import os
def read_dir(s, n):
    # 1. 打开这个文件夹
    lst = os.listdir(s) # 打开文件夹. 拿到文件
    for el in lst: # 拿到的都是文件的名字
        # 2. 拼接出文件的路径
        real_path = os.path.join(s, el) # D:\25期周末班\a\b
        print("----"*n, el)  # 打印文件名字
        # 3. 判断是否是文件夹
        if os.path.isdir(real_path):
            read_dir(real_path, n + 1) # 递归的入口
        else:
            pass
            # open(real_path, mode="w", encoding="utf-8").write(1)

read_dir(r"c:\\", 0)


