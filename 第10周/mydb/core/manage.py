import hashlib


buList = ['添加业务线','删除业务线','修改业务线','查看业务线']
hostlist = ['添加主机','删除主机','修改主机','查看主机']


#密码加密
def secrect(arg):
    salt = b'secrecttopassword'
    md5_s = hashlib.md5(salt)
    md5_s.update(arg.encode('utf-8'))
    res = md5_s.hexdigest()
    return res


def show(type):
    if type == 3:
        l = buList

    else:
        l = hostlist

    for i in range(len(l)):
        print(i+1,l[i])


def reg(db):
    uname = input('请输入您的注册用户名：').strip()
    password = input('请输入您的注册密码：').strip()
    email = input('请输入您的注册邮箱：').strip()
    uword = secrect(password)
    sql = "insert into managers (`uname`, `uword`, `email`)  values ('%s','%s','%s');"%(uname,uword,email)
    if db.add(sql):

        print('注册成功')

    else:
        print('用户已注册')


def login(db):
    uname = input('请输入您的登录用户名：').strip()
    password = input('请输入您的登录密码：').strip()
    uword = secrect(password)
    sql = "select * from  managers where uname = '%s' and uword = '%s';"%(uname,uword)
    if db.select(sql):
        print('登录成功')
        return True
    else:
        print('账号密码错误')
        return False





def addBussiness(db):
    bname = input('请输入您要添加的业务线名字：').strip()
    sql = "insert into bussiness (bname) value ('%s');"%(bname)
    if db.add(sql):

        print('业务线添加成功')

    else:
        print('该业务线已添加')


def updateBussiness(db):
    bname1 = input('请输入您要更新的业务线原始名字：').strip()
    bname2 = input('请输入您要更新的业务线名字：').strip()
    sql = "update bussiness  set bname = '%s'  where bname = '%s';"%(bname2,bname1)
    if db.add(sql):

        print('业务线修改成功')

    else:
        print('要修改的业务线不存在')


def deleteBussiness(db):
    bname = input('请输入您要删除的业务线名字：').strip()
    sql = "delete from  bussiness   where bname = '%s';"%(bname)
    if db.add(sql):

        print('业务线删除成功')

    else:
        print('要删除的业务线不存在')


def selectBussiness(db):
    sql = "select * from  bussiness ;"
    res = db.select(sql)
    if res:
        print('业务线查询成功,当前业务线如下')
        for i in range (len(res)):
            print(res[i][1])

    else:
        print('暂无数据')





def addhoster(db):
    hname = input('请输入您要添加的主机名字：').strip()
    hword = input('请输入您要添加的主机密码：').strip()
    bname = input('请输入该主机所在的业务线：').strip()
    sql = "select id from  bussiness  where bname ='%s';"%(bname)
    res = db.select(sql)
    if res:
        id = res[0][0]
    else:
        print('业务线不存在')
        return

    sql = "insert into hoster (hname,hword,b_id) value ('%s','%s','%s');"%(hname,hword,id)
    if db.add(sql):

        print('主机添加成功')

    else:
        print('该主机已添加')


def updatehoster(db):
    hname1 = input('请输入您要更新的主机原始名字：').strip()
    hname2 = input('请输入您要更新的主机名字：').strip()
    sql = "update hoster  set hname = '%s'  where hname ='%s';"%(hname2,hname1)
    if db.add(sql):

        print('主机修改成功')

    else:
        print('要修改的主机不存在')



def deletehoster(db):
    hname = input('请输入您要删除的主机名字：').strip()
    sql = "delete from  hoster   where hname = '%s';"%(hname)
    if db.add(sql):

        print('删除主机成功')

    else:
        print('要删除的主机不存在')


def selecthoster(db):
    sql = "select * from  hoster ;"
    res = db.select(sql)
    if res:
        print('主机查询成功,当前主机如下')
        for i in  range(len(res)):
            print(res[i][1])
    else:
        print('暂无数据')
