import  socket
from conf import conf
import struct
import json
import hashlib
import sys
import time

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
        msg = self.sk.recv(4)
        print(msg)
        leng = struct.unpack('i',msg)[0]
        msg = self.sk.recv(leng)

        return msg

    def recevied(self,n):
        return self.sk.recv(n)

    def processBar(self, num, total):
        rate = num / total
        rate_num = int(rate * 100)
        if rate_num == 100:
            r = '\r%s>%d%%\n' % ('=' * rate_num, rate_num,)
        else:
            r = '\r%s>%d%%' % ('=' * rate_num, rate_num,)
        sys.stdout.write(r)
        sys.stdout.flush

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

    def upload(self):
        pass

    @classmethod
    def show(cls):
        cls = client()
        flag = 0
        while 1:
            print(['1:注册','2:登录','3:文件下载','5:退出'])

            try:
                num = int(input('请输入您的选择:').strip())

            except Exception as e:
                print('输入错误，请重新输入')
                continue


            if num == 5:
                cls.close()
                break

            elif num == 1:
                account ,password = cls.reg()
                print(account,password)
                cls.send('reg')
                cls.send(account)
                cls.send(password)
                msg = cls.receive()
                print(msg)

            elif num == 2:
                account ,password = cls.login()
                cls.send('login')
                cls.send(account)
                cls.send(password)
                msg = cls.receive().decode('utf--8')
                if msg == 'success':
                    flag = 1
                    print('登入成功')
                else:
                    print('账号或密码错误，请重试')

                print(msg)
            elif num == 3:
                # if flag == 0:
                #     print('请先登入')
                #     continue

                cls.send('upload')
                n = cls.recevied(4)
                n = struct.unpack('i',n)[0]

                msg = cls.recevied(n)
                file_json = json.loads(msg.decode('utf-8'))

                print(file_json)
                file_name = file_json['file_name']
                file_size =0
                file_total = file_json['file_size']

#add md5 check
                m = hashlib.md5(conf.salt)
                with open(file_name,'ab') as f:
                    while file_size < file_total:
                        print(file_size)
                        print(file_total)
                        content = cls.recevied(1024)
                        m.update(content)
                        f.write(content)
                        file_size += len(content)
                        time.sleep(0.1)
                        cls.processBar(file_size,file_total)

                md5_s = m.hexdigest()
                print(md5_s)
                cls.send(md5_s)


if __name__ == '__main__':
    client.show()



