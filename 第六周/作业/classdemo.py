
class PUBLIC:
    #查看已开设的课程
    def show(self):
        with open("course.txt",mode = 'r',encoding = "utf-8") as f:
            self.con = f.read()
            return self.con

    #校验用户账号、密码
    @staticmethod
    def checkLogin(file_name,account,password):

        with open(file_name,mode = 'r',encoding = "utf-8") as f:
            for line in f:
                name ,word = line.strip().split()
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
                account ,lst = line.strip().split(":")
                if self.name == account:
                    return lst

                else:
                    print('该用户未选择任何课程')

  #选课
    def makeCourse(self,coursename):
        with open('course_stu.txt',mode = 'r+',encoding = 'utf-8') as f:
            for line in f:
                account ,lst = line.strip().split(":")
                if self.name == account:
                    if coursename in lst:
                        print("该课程您已选课")

                else:
                    lst.append(coursename)
                    f.write(lst)
                    print("选课成功")


class ADMIN(PUBLIC):
    def __init__(self,name):
        self.name = name

#添加new course
    def createCourse(self,coursename):
        with open("course.txt",mode = 'r+',encoding = "utf-8") as f:
            con = f.read()
            if coursename not in con:
                con.append(coursename)
                f.write(con)

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

            f.write(name + ":" + password)
            print("添加成功")

#添加用户
    def createUser(self,name,password):
        with open('stu.txt',mode = 'w+') as f:
            for line in f :
                acc,word =  line.strip().split(":")
                if name == acc:
                    print('该学生已添加')
                    return

            f.write(name + ":" + password)
            print("添加成功")

#查询全部学生
    def selectUser(self):
        with open("stu.txt",mode = "r",encoding = "utf-8") as f :
            for line in f:
                name,password = line.strip().split(":")
                print(name)
#查询学生以及所选课程
    def selectStuCourder(self):
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

        elif PUBLIC.checkLogin("admin.txt",name,password):
            flag = 2


    if flag == 1:
        while flag == 1:
            stu = STU(name)
            PUBLIC.showMenu(1)
            num = int(input("请输入您的选择：").strip())

            if num == 1:
                PUBLIC.show()
            elif num ==2:
                coursename = input("请输入您要选择的课程：").strip()
                stu.makeCourse(coursename)
            elif num ==3:
                stu.haveChoose()
            elif num ==4:
                flag == 0


    if flag == 2:
        while flag == 2:
            admin = ADMIN(name)
            PUBLIC.showMenu(2)
            num = int(input("请输入您的选择：").strip())

            if num == 1:
                coursename = input("请输入您要创建的课程：").strip()
                admin.createCourse(coursename)

            elif num ==2:
                stuName = input("请输入您要创建学生账号：").strip()
                stuPassword = input("请输入您要创建的学生账号密码：").strip()
                admin.createUser(stuName,stuPassword)
            elif num ==3:
                PUBLIC.show()
            elif num ==4:
                admin.selectUser()
            elif num ==5:
                admin.selectStuCourder()
            elif num ==6:
                flag == 0









