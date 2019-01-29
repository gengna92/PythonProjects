import re
import urllib.request
import json

con_lst = []
#获取下载链接
def getlink():
    url = 'http://dytt8.net/'

    content = urllib.request.urlopen(url).read().decode('gbk')

    # obj =  re.compile('.*?最新电影下载</ a>]< a href=\'(.*?)\'',re.S)
    obj =  re.compile('.*?最新电影下载</a>]<a href=\'(?P<name>.*?)\'',re.S)

    urilst = obj.findall(content)

    # urilsts = obj.finditer(content)
    return urilst

#获取电影名字和下载链接
def getNameLink():
    urilst = getlink()
    movie_list = []
    for uri in urilst:
        url = "http://dytt8.net" + uri

        content = urllib.request.urlopen(url).read().decode('gbk')
        print(content)

        obj = re.compile('.*?◎译　　名　(?P<name>.*?)<br.*?磁力链下载点击这里.*?<a href="(?P<link>.*?)"', re.S)

        iters = obj.finditer(content)

        for el in iters:
            movie_dict = {}

            movie_dict ["name"] = el.group('name')
            movie_dict ["link"] = el.group('link')

            movie_list.append(movie_dict)

    json.dump(movie_list,open('movie.json',mode= 'w',encoding= 'utf-8'),ensure_ascii=False)
    return(movie_list)


#数据匹配并且不再已存在的列表中
def check(item):
    if item[1] in item[0]['name'] and (item[0] not in con_lst):
        return True







# if __name__ == "__main__":
    # getNameLink()
    # con = input("请输入您要检索的内容：").strip()
    # con = "一个人的"
    # content = json.load(open("movie.json",mode = 'r',encoding = 'utf-8'))
    # print(type(content))
    # print(content)

    # con_lst =[]
    # for i in range(len(con)):
        # s = con[0:(len(con)-i)]
        # ll = filter(lambda m: (s in m['name'] for m in content), content)
        # ll = filter(check, content) #函数不能接受多参数,生成一个列表组成一个元祖
        # ll = lambda m: (s in m['name'] for m in content)
        # ll = lambda m: for m in content
# -       print(ll)
        # for el in ll:
        #     if el not in con_lst:
        #         con_lst.append(el)
        #         # print(el)



# print(con_lst)

if __name__ == '__main__':
    con = input("请输入您要检索的内容：").strip()
        #检索内容
    content = json.load(open("movie.json",mode = 'r',encoding = 'utf-8'))

    for i in range(len(con)):
        s = con[0:(len(con)-i)]
        it = filter(check,[(el,s) for el in content])
        for elm in it:
            con_lst.append(elm[0])
            print(elm[0])

    print(con_lst)




