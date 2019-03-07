from socket import *
import socketserver
import hashlib
from core.serpackage import secrect_md5
from conf import conf
import struct
import  os

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

    def pack(self,msg):
        s = struct.pack('i',len(msg))
        print(s)
        return s

    def unpacks(self,msg):
        s = struct.unpack('i',msg)[0]
        print(s)
        return s

    def handle(self):
        n = self.request.recv(4)
        n = self.unpacks(n)
        types = self.request.recv(n)
        type = types.decode('utf-8')
        print(types)
        # 注册
        if type == 'reg':

            n = self.request.recv(4)
            n = self.unpacks(n)
            print(n)
            account = self.request.recv(n)
            print(account)
            account = account.decode('utf-8')
            print(account)

            n = self.request.recv(4)
            n = self.unpacks(n)
            print(n)
            password = self.request.recv(n)
            print(password)
            password = password.decode('utf-8')
            print(password)

            msg = self.reg(account,password)
            print(msg)


        if type == 'login':
            pass

        if type == 'upload':
            filename  = os.path.basename(conf.filepath)
            size  = os.path.getsize(conf.filepath)
            m = hashlib.md5(conf.salt)
            with open(conf.filepath,mode = 'rb') as f:
                content = f.read(1024)
                m.update(content.encode())
                self.request.send(content)

            s = m.hexdigest()
            headers ={}
            headers['filename'] = filename
            headers['md5'] = s










            # self.request.send(self.pack(msg))
            # self.request.send(msg.encode('utf-8'))











    def reg(self,account,password):
        print(account,password)
        try:
            with open('../../db/use.txt',mode = 'r+' ,encoding = 'utf-8') as f:
                print(f)
                f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                msg = '注册成功'
                print(msg)

                # for line in f:
                #     if line.strip().split(':')[0] == account:
                #         msg = '账号已注册'
                #         print(msg)
                #         return msg
                #     else:
                #         print('fffffff')
                #         f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                #         msg = '注册成功'
                #         print(msg)
                #
                #         return msg


        except Exception as e:
            print('*************')
            with open('../../db/use.txt', mode='w', encoding='utf-8'):
                f.write(account + ':' + secrect_md5.smd5(password) + '\n')
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
    ser  = socketserver.TCPServer((conf.ip,conf.port),MyServer)
    print(ser)
    ser.serve_forever()


    # s = '审核通过了了'
    # for i in range(0,49):
    #     s =s + '审核通过了了'
    #
    # print(s)
    # print(len(s))





