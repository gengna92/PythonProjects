from socket import *
import socketserver
import hashlib
from core.serpackage import secrect_md5
from conf import conf
import struct
import  os
import sys
import json

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
        while 1:
            n = self.request.recv(4)
            n = struct.unpack('i',n)[0]
            types = self.request.recv(n)
            type = types.decode('utf-8')
            print(types)

            # 注册
            if type == 'reg':

                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                account = self.request.recv(n)
                account = account.decode('utf-8')

                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                password = self.request.recv(n)
                password = password.decode('utf-8')

                msg = self.reg(account,password)
                print(msg)
                len_msg = struct.pack('i',len(msg))
                self.request.send(len_msg)
                self.request.send(msg.encode('utf-8'))

                # try:
                #
                #     with open('../../db/use.txt', mode='r+', encoding='utf-8') as f:
                #         print('************************')
                #
                #         if os.path.getsize('../../db/use.txt') == 0:
                #             f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                #             msg = '注册成功'
                #             print(msg)
                #
                #         else:
                #             for line in f:
                #                 print(line)
                #                 if line.strip().split(':')[0] == account:
                #                     print(account)
                #                     msg = '账号已注册'
                #                     print(msg)
                #                 else:
                #                     print(account)
                #                     f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                #                     msg = '注册成功'
                #                     print(msg)
                #
                # except Exception as e:
                #     with open('../../db/use.txt', mode='w', encoding='utf-8'):
                #         f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                #         msg = '注册成功'
                #         print(msg)





            if type == 'login':
                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                account = self.request.recv(n)
                account = account.decode('utf-8')

                n = self.request.recv(4)
                n = struct.unpack('i', n)[0]
                password = self.request.recv(n)
                password = password.decode('utf-8')

                msg = self.login(account, password)
                print(msg)
                len_msg = struct.pack('i',len(msg))
                self.request.send(len_msg)
                self.request.send(msg.encode('utf-8'))



            if type == 'upload':
                file_name  = os.path.basename(conf.filepath)
                file_size  = os.path.getsize(conf.filepath)
                file_total  = os.path.getsize(conf.filepath)

                info_dic = {'file_name': file_name, 'file_size': file_size}
                info_json = json.dumps(info_dic).encode('utf-8')  # str.encode('utf-8') bytes
                send_len = struct.pack('i',len(info_json))

                self.request.send(send_len)
                self.request.send(info_json)

                m = hashlib.md5(conf.salt)
                with open(conf.filepath,mode = 'rb') as f:
                    while file_size > 0:

                        content = f.read(1024)
                        m.update(content)
                        self.request.send(content)
                        file_size -= len(content)
                        self.processBar(file_size,file_total)


                s = m.hexdigest()
                print(s)
                n = self.request.recv(4)
                n = struct.unpack('i',n)[0]
                s_md5 = self.request.recv(n).decode('utf-8')
                if s_md5 == s:
                    print('md5值校验成功')







    def reg(self,account,password):
        try:

            with open('../../db/use.txt', mode='r+', encoding='utf-8') as f:
                print('************************')

                if os.path.getsize('../../db/use.txt') == 0:
                    f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                    msg = '注册成功'
                    print(msg)

                else:
                    for line in f:
                        print(line)
                        if line.strip().split(':')[0] == account:
                            print(account)
                            msg = '账号已注册'
                            print(msg)
                        else:
                            print(account)
                            f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                            msg = '注册成功'
                            print(msg)

        except Exception as e:
            with open('../../db/use.txt', mode='w', encoding='utf-8'):
                f.write(account + ':' + secrect_md5.smd5(password) + '\n')
                msg = '注册成功'

        return msg


    def login(self, account, password):
        try:
            with open('../../db/use.txt', mode='r', encoding='utf-8') as f:
                for line in f:
                    if line.strip().split(':')[0] == account and \
                            line.strip().split(':')[1] == secrect_md5.smd5(password):
                        print('登入成功~')
                        msg = 'success'
                        return msg

                    else:
                        print('账号或密码错误')
                        msg = 'fail'
                        return msg



        except Exception as e:
            msg = 'fail'
            return msg












if __name__ == '__main__':
    ser  = socketserver.TCPServer((conf.ip,conf.port),MyServer)
    print(ser)
    ser.serve_forever()









