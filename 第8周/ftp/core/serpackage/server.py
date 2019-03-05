from socket import *
import socketserver
import hashlib
from core.serpackage import secrect_md5
from conf import conf
class MyServer(socketserver.BaseRequestHandler):
    def handle(self):

        co = self.request.recv(1024)
        self.request.send(b'recv')
        print(co)

    

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

    server  = socketserver.TCPServer((conf.ip,conf.port),MyServer)
    server.serve_forever()



