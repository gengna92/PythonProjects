import  socket
from conf import conf
import struct

class client:

    def __init__(self):
        self.sk = socket.socket()
        self.sk.connect((conf.ip,conf.port))

    def send(self,msg):
        s = struct.pack('i',len(msg))
        print(s)
        self.sk.send(s)
        self.sk.send(msg.encode('utf-8'))


    def receive(self):
        leng = struct.unpack('i',self.sk.recv(4))[0]
        msg = self.sk.recv(1024)

        return msg


    # @staticmethod
    def reg(self):
        account = input('请输入注册账号:').strip()
        password = input('请输入注册账号密码:').strip()
        return account,password

    def login(self):
        account = input('请输入登录账号:').strip()
        password = input('请输入登录账号密码:').strip()
        return account, password


    def close(self):
        self.sk.close()

    @staticmethod
    def show():
        cls = client()
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
                print(account,password)
                cls.send('reg')
                cls.send(account)
                cls.send(password)
                # msg = cls.receive()
                # print(msg)

            elif num == 2:
                account ,password = cls.login()
                cls.send(str(2))
                cls.send(account)
                # cls.send(password)
                # cls.receive()



if __name__ == '__main__':
    # # cl = client()
    # cl.show()
    # print(cl)
    # cl.send('hello')
    # msg = cl.receive()
    # print(msg)
    # sk = socket.socket()
    # sk.connect((conf.ip, conf.port))
    # sk.send(b'hello')
    # msg = sk.recv(1024)
    # print(msg)
    client.show()



