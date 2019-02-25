from selectCourse.public import PUBLIC

class ADMIN(PUBLIC):
    def __init__(self,name):
        self.name = name

#添加新的课程
    def createCourse(self,coursename):
        if self.sigleCheck('course.txt',coursename):
            print('该课程已存在')

        else:
            with open('course.txt', mode='a',encoding= 'utf-8') as f:
                f.write(coursename + "\n")
                print(coursename, "课程添加成功")



#添加new course
    # def createCourse(self,coursename):
    #     with open("course.txt",mode = 'r+',encoding = "utf-8") as f:
    #
    #         try:
    #             con = json.loads(f.read(),encoding= 'utf-8')
    #
    #         except json.decoder.JSONDecodeError:
    #             con = []
    #
    #         if coursename not in con:
    #             con.append(coursename)
    #             data = json.dumps(con,ensure_ascii = False)
    #             f.seek(0)
    #             f.write(data)
    #             print(coursename,'课程创建成功')
    #
    #         else:
    #             print("不能重复添加")

#添加班级
    def createClass(self, classname):
        if self.sigleCheck('class.txt', classname):
            print('该班级已存在')

        else:
            with open('class.txt', mode='a',encoding= 'utf-8') as f:
                f.write(classname + "\n")
                print(classname, "班级添加成功")

    #添加管理员
    def createAdmin(self, name, password):
        if self.accountCheck('admin.txt',name):
            print('该管理员已添加')

        else:

            with open('admin.txt', mode='a',encoding= 'utf-8') as f:
                f.write(name + ":" + password + '\n')
                print(name,"管理员添加成功")

#添加学生
    def createUser(self,name,password):
        if self.accountCheck('stu.txt', name):
            print('该学生已添加')

        else:

            with open('stu.txt', mode='a',encoding= 'utf-8') as f:
                f.write(name + ":" + password + '\n')
                print(name, "学生添加成功")

#添加老师
    def createTeacher(self, name, password):
        if self.accountCheck('teacher.txt', name):
            print('该讲师已添加')

        else:

            with open('teacher.txt', mode='a',encoding= 'utf-8') as f:
                f.write(name + ":" + password + '\n')
                print(name, "讲师添加成功")

#查询全部学生
    def selectUser(self):
        with open("stu.txt",mode = "r",encoding = "utf-8") as f :
            for line in f:
                name,password = line.strip().split(":")
                print(name)

#查询学生以及所选课程:
    def selectStuCourser(self):
        try:
            with open("course_stu.txt", mode="r", encoding="utf-8") as f:
                for line in f:
                    print(line)
        except FileNotFoundError as e:
            print('暂无学生选课信息')
            with open("course_stu.txt", mode="w", encoding="utf-8") as f:
                pass

#为讲师指定班级
    def bindTeacher(self,name,classname):

        # print(self.accountCheck('teacher.txt',name))
        # print(self.sigleCheck('class.txt',classname))

        if self.fileCheck('class_teacher.txt',name,classname):
            print('班级已经指定过')

        elif not (self.accountCheck('teacher.txt',name) and self.sigleCheck('class.txt',classname)):
            print('讲师或班级信息错误')

        else:

            with open('class_teacher.txt',mode = 'a',encoding= 'utf-8') as f:

                f.write(name+':'+classname + "\n")
                print('指定成功')


#为学生指定班级
    def bindStu(self,name,classname):

        if self.fileCheck('class_stu.txt',name,classname):
            print('班级已经指定过')

        elif not (self.accountCheck('stu.txt',name) and self.sigleCheck('class.txt',classname)):
            print('学生或班级信息错误')

        else:

            with open('class_stu.txt',mode = 'a',encoding= 'utf-8') as f:

                f.write(name+':'+classname + "\n")
                print('指定成功')



if __name__ == '__main__':
    admin = ADMIN('admin')
    # teacherName = input("请输入您要指定的讲师账号：").strip()
    # classname = input("请输入您要指定的班级：").strip()
    admin.bindStu('tom','6ban')