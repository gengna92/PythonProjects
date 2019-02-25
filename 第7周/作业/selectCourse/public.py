import json

class PUBLIC:
    #查看已开设的课程
    def show(self):
        try:
            with open("course.txt",mode = 'r',encoding = "utf-8") as f:
               for line in f:
                   print(line)

        except FileNotFoundError as e:
            print("未设置任何课程")
            with open("course.txt", mode='w', encoding="utf-8") as f:
                pass


    #校验用户账号、密码
    @staticmethod
    def checkLogin(file_name,account,password):
        try:
            with open(file_name,mode = 'r',encoding = "utf-8") as f:
                for line in f:
                    name ,word = line.strip().split(":")
                    if name == account and word == password:

                        return True

        except FileNotFoundError as e:
            with open(file_name, mode='w', encoding="utf-8") as f:
                pass



    @staticmethod
    def showMenu(type):
        stu_menu = ['查看所有课程','选择课程','查看所选课程','退出程序']
        admin_menu = ['创建课程','创建学生账号','查看所有课程','查看所有学生','查看所有学生的选课情况','创建讲师','为讲师指定班级','创建班级','为学生指定班级','退出程序']
        teacher_menu = ['查看所有课程','查看所教班级','查看班级中的学生','退出程序']

        if type == 1:
            for i in range(len(stu_menu)):
                print(i+1,stu_menu[i])
        elif type == 2:
            for i in range(len(admin_menu)):
                print(i+1,admin_menu[i])

        elif type == 3:
            for i in range(len(teacher_menu)):
                print(i + 1, teacher_menu[i])

#检查单个数据存在
    def sigleCheck(self,file,name):
        try:
            with open(file,mode = 'r',encoding= 'utf-8') as f:
                for line in f:
                    if line.strip() == name:
                        return True

        except FileNotFoundError as e:
            with open(file, mode='w', encoding='utf-8') as f:
                pass



#校验账户类
    def accountCheck(self,file,name):
        try:
            with open(file,mode = 'r',encoding= 'utf-8') as f:
                for line in f:
                    acc, word = line.strip().split(":")
                    if name == acc:
                        return True

        except FileNotFoundError as e:
            with open(file, mode='w', encoding='utf-8') as f:
                pass




#查询数据是否存在
    def fileCheck(self,file,name,classname):
        try:
            with open(file, mode='r', encoding='utf-8') as f:
                for line in f:
                    a,b =  line.strip().split(':')
                    if a == name and b == classname:
                        return True

        except FileNotFoundError as e:
            with open(file, mode='w', encoding='utf-8') as f:
                pass



