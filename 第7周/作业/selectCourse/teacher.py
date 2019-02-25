from selectCourse.public import PUBLIC

class TEACHER(PUBLIC):
    def __init__(self,name):
        self.name = name

    def selectClass(self):
        try:
            with open('class_teacher.txt',mode = 'r',encoding='utf-8') as  f:
                for line in f:
                    acc,classname = line.strip().split(':')
                    if acc == self.name:
                        print(self.name + '所教班级为：'+classname)

        except FileNotFoundError as e:
            with open('class_teacher.txt', mode='w', encoding='utf-8') as  f:
                pass

    def selectStu(self,cls):
        try:
            with open('class_stu.txt', mode='r', encoding='utf-8') as  f:
                for line in f:
                    stu,classname = line.strip().split(':')
                    if cls == classname:
                        print(classname + '班级学生为：' + stu)

        except FileNotFoundError as e:
            with open('class_stu.txt', mode='w', encoding='utf-8') as  f:
                pass
