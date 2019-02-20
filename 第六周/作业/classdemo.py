import json

class PUBLIC:
    #查看已开设的课程
    def show(self):
        with open("course.txt",mode = 'r',encoding = "utf-8") as f:
            self.con = f.read()
            print('课程列表为：')
            try:
                con = json.loads(self.con, encoding='utf-8')
                for item in con:
                    print(item)

            except json.decoder.JSONDecodeError:
                print('暂无课程安排')


            return con

    #校验用户账号、密码
    @staticmethod
    def checkLogin(file_name,account,password):

        with open(file_name,mode = 'r',encoding = "utf-8") as f:
            for line in f:
                name ,word = line.strip().split(":")
                if name == account and word == password:

                    return True

    @staticmethod
    def showMenu(type):
        stu_menu = ['查看所有课程','选择课程','查看所选课程','退出程序']
        admin_menu = ['创建课程','创建学生账号','查看所有课程','查看所有学生','查看所有学生的选课情况','退出程序']

        if type == 1:
            for i in range(len(stu_menu)):
                print(i+1,stu_menu[i])
        elif type == 2:
            for i in range(len(admin_menu)):
                print(i+1,admin_menu[i])



class STU(PUBLIC):
    def __init__(self,name):
        self.name = name

#查看某学生所选课程
    def haveChoose(self):
        with open('course_stu.txt',mode = 'r',encoding = 'utf-8') as f:
            for line in f:
                account ,coursename = line.strip().split(":")
                if self.name == account:
                    print(self.name+"选择的课程是：",coursename)


  #选课
    def makeCourse(self,coursename):

        with open('course_stu.txt',mode = 'r+',encoding = 'utf-8') as f:
            for line in f:
                print(line)
                account ,course = line.strip().split(":")

                if self.name == account  and course == coursename:
                    print("该课程您已选课")
                    return


            f.write(self.name + ':' + coursename + "\n")
            print("选课成功")



class ADMIN(PUBLIC):
    def __init__(self,name):
        self.name = name

#添加new course
    def createCourse(self,coursename):
        with open("course.txt",mode = 'r+',encoding = "utf-8") as f:

            try:
                con = json.loads(f.read(),encoding= 'utf-8')

            except json.decoder.JSONDecodeError:
                con = []

            if coursename not in con:
                con.append(coursename)
                data = json.dumps(con,ensure_ascii = False)
                f.seek(0)
                f.write(data)
                print(coursename,'课程创建成功')

            else:
                print("不能重复添加")

    #添加管理员
    def createAdmin(self, name, password):
        with open('admin.txt', mode='w+') as f:
            for line in f:
                acc, word = line.strip().split(":")
                if name == acc:
                    print('该管理员已添加')
                    return

            f.write(name + ":" + password + '\n')
            print(name,"管理员添加成功")

#添加用户
    def createUser(self,name,password):
        with open('stu.txt',mode = 'a+') as f:
            for line in f :
                acc,word =  line.strip().split(":")
                if name == acc:
                    print('该学生已添加')
                    return

            f.write(name + ":" + password+ "\n")

            print(name,"学生添加成功")

#查询全部学生
    def selectUser(self):
        with open("stu.txt",mode = "r",encoding = "utf-8") as f :
            for line in f:
                name,password = line.strip().split(":")
                print(name)

#查询学生以及所选课程:
    def selectStuCourser(self):

        with open("course_stu.txt", mode="r", encoding="utf-8") as f:
            for line in f:
                print(line)



if __name__ == "__main__":
    #0表示未登录  1表示学生登录  2表示管理员登录
    flag = 0
    while flag == 0:

        name = input("请输入您的用户名：").strip()
        password = input("请输入您的登录密码：").strip()

        if PUBLIC.checkLogin("stu.txt",name,password):
            flag = 1
            print(name,'学生登入成功')


        elif PUBLIC.checkLogin("admin.txt",name,password):
            flag = 2
            print(name,'管理员登入成功')
        else:
            print('账号或密码错误，请重新登入')


    if flag == 1:
        while flag == 1:
            stu = STU(name)
            PUBLIC.showMenu(1)
            num = int(input("请输入您的选择：").strip())

            if num == 1:
                stu.show()
            elif num ==2:
                coursename = input("请输入您要选择的课程：").strip()
                if coursename in stu.show():
                    stu.makeCourse(coursename)
                else:
                    print('课程名字输入有误')
            elif num ==3:
                stu.haveChoose()
            elif num ==4:
                print('退出登入')
                flag = 0


    if flag == 2:
        while flag == 2:
            print(flag)
            admin = ADMIN(name)
            admin.showMenu(2)
            num = int(input("请输入您的选择：").strip())

            if num == 1:
                coursename = input("请输入您要创建的课程：").strip()
                admin.createCourse(coursename)

            elif num ==2:
                stuName = input("请输入您要创建学生账号：").strip()
                stuPassword = input("请输入您要创建的学生账号密码：").strip()
                admin.createUser(stuName,stuPassword)
            elif num ==3:
                admin.show()
            elif num ==4:
                admin.selectUser()
            elif num ==5:
                admin.selectStuCourser()
            elif num ==6:
                print("退出登入")
                flag = 0










