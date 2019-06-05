import  json
from selectCourse.public import PUBLIC
from selectCourse.teacher import TEACHER
from selectCourse.stu import STU
from selectCourse.admin import ADMIN

#管理员初始化账号为admin admin
if __name__ == "__main__":
    #0表示未登录  1表示学生登录  2表示管理员登录   3表示讲师登录
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

        elif PUBLIC.checkLogin("teacher.txt", name, password):
            flag = 3
            print(name, '讲师登入成功')
        else:
            print('账号或密码错误，请重新登入')


    if flag == 1:
        stu = STU(name)

        while flag == 1:
            PUBLIC.showMenu(1)
            try:
                num = int(input("请输入您的选择：").strip())

            except ValueError as e:
                print("格式输入错误")
                continue

            if num == 1:
                stu.show()
            elif num ==2:
                coursename = input("请输入您要选择的课程：").strip()
                stu.makeCourse(coursename)
            elif num ==3:
                stu.haveChoose()
            elif num ==4:
                print('退出登入')
                flag = 0


    if flag == 2:
        admin = ADMIN(name)

        while flag == 2:
            admin.showMenu(2)
            try:
                num = int(input("请输入您的选择：").strip())

            except ValueError as e:
                print("格式输入错误")
                continue

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
                teacherName = input("请输入您要创建讲师账号：").strip()
                teacherPassword = input("请输入您要创建的讲师账号密码：").strip()
                admin.createTeacher(teacherName,teacherPassword)

            elif num ==7:
                teacherName = input("请输入您要指定的讲师账号：").strip()
                classname = input("请输入您要指定的班级：").strip()
                admin.bindTeacher(teacherName,classname)
            elif num ==8:
                classname = input("请输入您要创建的班级：").strip()
                admin.createClass(classname)
            elif num ==9:
                stuName = input("请输入您要指定的学生账号：").strip()
                classname = input("请输入您要指定的班级：").strip()
                admin.bindStu(stuName,classname)
            elif num ==10:
                print("退出登入")
                flag = 0

    if flag == 3:
        teacher = TEACHER(name)

        while flag == 3:
            teacher.showMenu(3)
            try:
                num = int(input("请输入您的选择：").strip())

            except ValueError as e:
                print("格式输入错误")
                continue

            if num == 1:
               teacher.show()

            elif num ==2:
               teacher.selectClass()
            elif num ==3:
                clsname = input("请输入您要查找的班级：").strip()
                teacher.selectStu(clsname)

            elif num ==4:
                print("退出登入")
                flag = 0
