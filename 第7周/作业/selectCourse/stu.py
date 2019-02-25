import  json
from selectCourse.public import PUBLIC
class STU(PUBLIC):
    def __init__(self,name):
        self.name = name

#查看某学生所选课程
    def haveChoose(self):
        try:
            with open('course_stu.txt',mode = 'r',encoding = 'utf-8') as f:
                for line in f:
                    account ,coursename = line.strip().split(":")
                    if self.name == account:
                        print(self.name+"选择的课程是：",coursename)

        except FileNotFoundError as e:
            with open('course_stu.txt', mode='r', encoding='utf-8') as f:
                print("还未选择课程")
                pass


  #选课
    def makeCourse(self,coursename):
        if self.fileCheck('course_stu.txt',self.name,coursename):
            print("该课程您已选课")

        else:

            with open('course_stu.txt',mode = 'a',encoding = 'utf-8') as f:
                f.write(self.name + ':' + coursename + "\n")
                print("选课成功")


if __name__ == '__main__':
    stu =STU('tom')
    stu.haveChoose()