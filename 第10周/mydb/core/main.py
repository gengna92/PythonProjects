from core import managedb,manage

flag = 0
class main:
    def __init__(self):
        self.db = managedb.db()

#业务线操作相关
    def opBussiness(self):
        global flag
        if flag == 0:
            print('您还未登录，请先登录')
            return
            # continue
        manage.show(3)
        try:
            n = int(input('请输入您的选择：').strip())

        except Exception:
            print('格式错误')
            # continue

        opB_list = ['manage.addBussiness(self.db)', 'manage.deleteBussiness(self.db)',
                    'manage.updateBussiness(self.db)', 'manage.selectBussiness(self.db)']

        exec(opB_list[n - 1])

#主机操作相关
    def opHoster(self):
        global flag

        if flag == 0:
            print('您还未登录，请先登录')
            return

        manage.show(4)
        try:
            n = int(input('请输入您的选择：').strip())

        except Exception:
            print('格式错误')
            return

        opH_list = ['manage.addhoster(self.db)','manage.updatehoster(self.db)',
                    'manage.deletehoster(self.db)','manage.selecthoster(self.db)']

        exec(opH_list[n-1])

    def run(self):

        while 1:
            l =  ['注册','登录','业务线操作','主机操作','退出']
            for i in range(len(l)):
                print(i + 1, l[i])

            try:
                num = int(input('请输入您的选择：').strip())

            except Exception:
                print('格式错误')
                continue

            op_list = [
                'manage.reg(self.db)'
                ,'global flag\nif manage.login(self.db):flag = 1'
                ,'self.opBussiness()'
                ,'self.opHoster()'
            ]
            if num < 5:
                exec(op_list[num -1])
            if num == 5:
                global flag
                flag = 0
                self.db.close()
                print('login out')
                break

# '''
# Traceback (most recent call last):
#   File "F:/coding/mydb/core/main.py", line 82, in <module>
#     a.run()
#   File "F:/coding/mydb/core/main.py", line 70, in run
#     exec(op_list[num -1])
#   File "<string>", line 4
# SyntaxError: 'break' outside loop
#
# # 用exec执行exec(op_list[4])  会报错这个是为什么？
#
#****************exec 不能执行break语句
# '''

if __name__ == '__main__':
    a = main()
    a.run()



