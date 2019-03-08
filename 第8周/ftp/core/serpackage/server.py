from socket import *
import socketserver
import hashlib
from core.serpackage import secrect_md5
from conf import conf
import struct
import  os
import sys
import json
from log import logconf


class MyServer(socketserver.BaseRequestHandler):

#进度条
    def processBar(self,num, total):
        rate = num / total
        rate_num = int(rate * 100)
        if rate_num == 100:
            r = '\r%s>%d%%\n' % ('=' * rate_num, rate_num,)
        else:
            r = '\r%s>%d%%' % ('=' * rate_num, rate_num,)
        sys.stdout.write(r)
        sys.stdout.flush

    def handle(self):
        loggers = logconf.conflog('../../log/server.txt', 'server')

        while 1:
            n = self.request.recv(4)
            n = struct.unpack('i',n)[0]
            types = self.request.recv(n).decode('utf-8')

            loggers.info("接收到客户端请求%s"%types)

            #t退出
            if types == 'quit':
                loggers.info("用户断开连接")

                break


            # 注册
            if types == 'reg':

                loggers.info("开始注册.....")

                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                account = self.request.recv(n)
                account = account.decode('utf-8')

                loggers.info("接收到客户端注册用户名：", account)

                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                password = self.request.recv(n)
                password = password.decode('utf-8')

                loggers.info("接收到客户端注册密码：", password)


                msg = self.reg(account,password)
                print(msg)
                len_msg = struct.pack('i',len(msg))
                self.request.send(len_msg)
                self.request.send(msg.encode('utf-8'))





            #登陆
            if types == 'login':
                #接受客户端登陆用户名
                loggers.info("开始等入.....")

                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                account = self.request.recv(n)
                account = account.decode('utf-8')
                loggers.info("接收到客户端等入用户名：", account)

                #接受客户端登陆密码
                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                password = self.request.recv(n)
                password = password.decode('utf-8')
                loggers.info("接收到客户端等入密码：", password)


                #调用登陆函数，成功返回success 失败返回fail
                msg = self.login(account, password)
                len_msg = struct.pack('i',len(msg))
                self.request.send(len_msg)
                self.request.send(msg.encode('utf-8'))


            #下载文件
            if types == 'upload':
                #获取文件名以及文件size
                file_name  = os.path.basename(conf.filepath)
                file_size  = os.path.getsize(conf.filepath)
                file_total  = os.path.getsize(conf.filepath)

                info_dic = {'file_name': file_name, 'file_size': file_size}
                info_json = json.dumps(info_dic).encode('utf-8')  # str.encode('utf-8') bytes
                send_len = struct.pack('i',len(info_json))

               #将文件名以及文件按大小发送到客户端
                self.request.send(send_len)
                self.request.send(info_json)

                m = hashlib.md5(conf.salt)

                loggers.info("开始下载文件.....")

                with open(conf.filepath,mode = 'rb') as f:
                    while file_size > 0:

                        content = f.read(1024)
                        m.update(content)
                        self.request.send(content)
                        file_size -= len(content)
                        #调用进度条
                        self.processBar((file_total - file_size),file_total)

                loggers.info("文件下载完成.....")
                #获取md5值
                s = m.hexdigest()
                #接受客户端的MD5值，并校验是否一致
                n = self.request.recv(4)
                n = struct.unpack('i',n)[0]
                s_md5 = self.request.recv(n).decode('utf-8')

                loggers.info("原始文件的md5值是：%s，目标文件的md5值是：%s"%(s,s_md5))

                if s_md5 == s:
                    print('md5值校验成功')
                    loggers.info("文件md5值校验成功.....")

    #注册
    def reg(self,account,password):
        loggers = logconf.conflog('../../log/server.txt', 'server')

        try:

            with open('../../db/use.txt', mode='r+', encoding='utf-8') as f:

                if os.path.getsize('../../db/use.txt') == 0:
                    f.write(account + ':' + secrect_md5.smd5(password) + '\n')

                    loggers.info("%s用户注册成功"%account)
                    msg = '注册成功'
                    print(msg)

                else:
                    for line in f:
                        if line.strip().split(':')[0] == account:
                            # msg = '账号已注册'
                            msg = 'fail'
                            loggers.info("%s用户已经注册过该系统" % account)
                            print(msg)
                            return msg

                    f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                    # msg = '注册成功'
                    msg = 'success'
                    loggers.info("%s用户注册成功"%account)

                    print(msg)
                    return msg



        except Exception as e:
            with open('../../db/use.txt', mode='w', encoding='utf-8'):
                f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                # msg = '注册成功'
                loggers.info("%s用户注册成功" % account)
                msg = 'success'
                return msg

#登陆
    def login(self, account, password):
        loggers = logconf.conflog('../../log/server.txt', 'server')

        try:
            with open('../../db/use.txt', mode='r', encoding='utf-8') as f:
                for line in f:
                    if line.strip().split(':')[0] == account and \
                            line.strip().split(':')[1] == secrect_md5.smd5(password):
                        print('登入成功~')
                        loggers.info("%s用户登入成功" % account)

                        msg = 'success'
                        return msg

            print('账号或密码错误')
            loggers.info("%s用户登入失败，账号或密码错误" % account)

            msg = 'fail'
            return msg



        except Exception as e:
            msg = 'fail'
            return msg












if __name__ == '__main__':
    ser  = socketserver.TCPServer((conf.ip,conf.port),MyServer)
    ser.serve_forever()









