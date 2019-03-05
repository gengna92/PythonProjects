import  socket
from conf import conf
import struct

class client:

    def __init__(self):
        self.sk = socket.socket()
        self.sk.connect((conf.ip,conf.port))

    def send(self,msg):
        leng = struct.pack('i',len(msg))
        self.sk.send(leng)
        self.sk.send(msg.encode('utf-8'))


    def receive(self):
        leng = struct.unpack('i',self.sk.recv(4).decode('utf-8'))
        msg = self.sk.recv(leng)

        return msg


    # @staticmethod
    def reg(self,account,password):
        account = input('注册账号').strip()
        password = input('注册账号密码').strip()
        return account,password

    def login(self):
        account = input('登录账号').strip()
        password = input('登录账号密码').strip()
        return account, password


    def close(self):
        self.sk.close()

    @classmethod
    def show(cls):
        flag = 0
        while 1:
            print(['1:注册\n','2:登录\n','3:文件下载\n','4：文件上传\n','5:退出\n'])

            try:
                num = int(input('请输入您的选择:').strip())

            except Exception as e:
                print('输入错误，请重新输入')
                continue


            if num == 5:
                cls.close()

            elif num == 1:
                account ,password = cls.reg()
                cls.send(1)
                cls.send(account)
                cls.send(password)
                cls.receive()

            elif num == 2:
                account ,password = cls.login()
                cls.send(2)
                cls.send(account)
                cls.send(password)
                cls.receive()



if __name__ == '__main__':
    cl = client()
    print(cl)
    cl.send('hello')
    # msg = cl.receive()
    # print(msg)
    # sk = socket.socket()
    # sk.connect((conf.ip, conf.port))
    # sk.send(b'hello')
    # msg = sk.recv(1024)
    # print(msg)



