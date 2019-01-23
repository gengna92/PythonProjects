# lst = [{"name":"电脑", "price":1999}, {"name":"鼠标", "price":10}, {"name":"波多老师", "price":99999}, {"name":"七天", "price":123456}]
#
# f = open("商品.txt", mode="a", encoding="utf-8")
# for el in lst:
#     f.write(str(el)+"\n")
#
# f.flush()
# f.close()

# # 读取
# f = open("商品.txt", mode="r", encoding="utf-8")
# for line in f: # {'name': '电脑', 'price': 1999}
#     s = line.strip()
#     d = eval(s) # {'name': '电脑', 'price': 1999} => 字典
#     print(d['name'])