from socket import *
import socketserver
import hashlib
from core.serpackage import secrect_md5
from conf import conf
import struct

# class mysturct:
#     def pack(self,msg):
#         s = struct.pack('i',len(msg))
#         print(s)
#         return s
#
#     def unpacks(self,msg):
#         s = struct.unpack('i',msg)[0]
#         print(s)
#         return s




class MyServer(socketserver.BaseRequestHandler):
    def handle(self):
        num = self.request.recv(4)
        num = self.unpacks(num)
        if num == 1:
            n = self.request.recv(4)
            n = self.unpacks(num)
            account = self.request.recv(n)

            n = self.request.recv(4)
            n = self.unpacks(n)
            password = self.request.recv(n)

            msg = self.reg(account,password)

            self.request.send(self.pack(msg))
            self.request.send(msg.encode('utf-8'))




    def pack(self,msg):
        s = struct.pack('i',len(msg))
        print(s)
        return s

    def unpacks(self,msg):
        s = struct.unpack('i',msg)[0]
        print(s)
        return s







    

    def reg(self,account,password):
        try:
            with open('../../db/use.txt',mode = 'w+' ,encoding = 'utf-8') as f:
                for line in f:
                    if line.strip().split(':')[0] == account:
                        msg = '账号已注册'
                        return msg


        except Exception as e:
            with open('../../db/use.txt', mode='w', encoding='utf-8'):
                pass

        f.write(account+':'+secrect_md5.smd5(password)+'\n')
        msg = '注册成功'
        return msg

    def login(self, account, password):
        try:
            with open('../../db/use.txt', mode='r', encoding='utf-8') as f:
                for line in f:
                    if line.strip().split(':')[0] == account and line.strip().split(':')[1] == secrect_md5.smd5(password):

                        return True


        except Exception as e:
            pass




if __name__ == '__main__':

    # ser  = socketserver.TCPServer((conf.ip,conf.port),MyServer)
    # print(ser)
    # ser.serve_forever()







