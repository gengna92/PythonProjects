from functools import wraps
import time

lis = ['请登录', '请注册', '文章页面', '日记页面', '评论页面', '收藏页面', '注销', '退出程序']
loginFlag = False
currentUser = ""
#日志装饰器
def logWrapper(fn):
    #装饰函数名
    @wraps(fn)
    def inner(*args,**kwargs):
        struct_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
        s='用户:'+ currentUser + '在'+ struct_time+ '执行了'+fn.__name__+'函数\n'

        with open('log.txt',mode= 'a',encoding= 'utf-8') as f:
            f.write(s)

        ret = fn(*args,**kwargs)
        return ret
    return inner

#登录装饰器
def loginWrapper(fn):
    @wraps(fn)
    def inner(*args, **kwargs):
        if loginFlag :
#判断用户是否登录
            ret = fn(*args, **kwargs)
            return ret
        else:
            print('您还未登录，请先登录！')
    return inner

def firstPageShow():
    print('欢迎来到博客园首页')
    for i in range(len(lis)):
        print('%s:%s'%(i+1,lis[i]))


def login(username,password):
    global currentUser,loginFlag
    with open('register.txt',mode='r',encoding='utf-8') as f:
        for line in f:
            account,pas = line.strip().split(':')
            if username == account and password == pas:
                currentUser = username
                loginFlag = True
                print('登入成功')
                return True
    print('账号或密码错误')


def checkAccount(username):

    try:
        with open('register.txt', mode='r', encoding='utf-8') as f:
            for line in f:
                account, pas = line.strip().split(':')
                if username == account:
                    return True

    except FileNotFoundError:
        return False


#注册
def regis(username,password):
    if checkAccount(username):
        print("该账号已注册")

    else:
        with open('register.txt', mode='a', encoding='utf-8') as f:
            streams = ':'.join([username,password])
            f.write(streams)
            f.write('\n')
            print('注册成功')
            #注册后登录
        login(username,password)
            # firstPageShow()

@logWrapper
@loginWrapper
def showPage(num):
    print('欢迎%s用户访问%s'%(currentUser,lis[num-1]))


def logout():
    global loginFlag
    print('注销成功')
    loginFlag = False


if __name__ == '__main__':
    while 1:
        firstPageShow()
        num = int(input("请输入您的选择：").strip())
        if num < 1 or num > 8:
            print("请输入正确的选择")
            continue

        elif num ==  7:
            loginFlag = False
            currentUser = ""
            print('注销成功')

        elif num ==  8:
            print('退出程序')
            break

        elif num == 2:
            username = input('请输入注册用户名：').strip()
            password = input('请输入注册密码：').strip()

            regis(username,password)
            continue

        elif num == 1:
            i = 0
            while loginFlag == False and i < 3:
                username = input('请输入登录用户名：').strip()
                password = input('请输入登录密码：').strip()
                if login(username,password):
                    break
                i += 1
            print(loginFlag)
            if loginFlag:
                continue

            else:
                break

        else:
            showPage(num)










