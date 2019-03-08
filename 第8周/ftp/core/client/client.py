import  socket
from conf import conf
import struct
import json
import hashlib
import sys
import time
from log import logconf
import os


class client:
    def __init__(self):
        self.sk = socket.socket()
        self.sk.connect((conf.ip,conf.port))

#用struct pack 发送message
    def send(self,msg):
        s = struct.pack('i',len(msg))
        self.sk.send(s)
        self.sk.send(msg.encode('utf-8'))

#用struct unpack 解码收到的message
    def receive(self):
        msg = self.sk.recv(4)
        leng = struct.unpack('i',msg)[0]
        msg = self.sk.recv(leng)

        return msg

#接受n个字节的数据
    def recevied(self,n):
        return self.sk.recv(n)

#发送n个字节的数据
    def sends(self, msg):
        return self.sk.send(msg)
#进度条
    def processBar(self, num, total):
        rate = num / total
        rate_num = int(rate * 100)
        if rate_num == 100:
            r = '\r%s>%d%%\n' % ('=' * rate_num, rate_num,)
        else:
            r = '\r%s>%d%%' % ('=' * rate_num, rate_num,)
        sys.stdout.write(r)
        sys.stdout.flush

#登陆
    def reg(self):
        account = input('请输入注册账号:').strip()
        password = input('请输入注册账号密码:').strip()
        return account,password

#注册
    def login(self):
        account = input('请输入登录账号:').strip()
        password = input('请输入登录账号密码:').strip()
        return account, password

#关闭连接
    def close(self):
        self.sk.close()


    def upload(self):
        pass

    @classmethod
    def show(cls):
        loggerc = logconf.conflog('../../log/client.txt', 'client')

        cls = client()
        flag = 0
        while 1:
            print(['1:注册','2:登录','3:文件下载','4:文件上传','5:退出'])

            try:
                num = int(input('请输入您的选择:').strip())
                loggerc.info("用户输入的选择是:%d"%(num))

            except Exception as e:
                print('输入错误，请重新输入')
                loggerc.error("用户输入格式错误！！！")
                continue

            #退出
            if num == 5:
                cls.send('quit')
                loggerc.info("用户退出连接")
                cls.close()


                break

            elif num == 1:
                account ,password = cls.reg()
                print(account,password)

                loggerc.info("%s用户尝试注册系统"%(account))

                cls.send('reg')
                cls.send(account)
                cls.send(password)
                msg = cls.receive().decode('utf-8')
                print(msg)
                if msg == 'success':
                    print('注册成功')
                    loggerc.info('%s用户注册成功'%(account))
                else:
                    print('该用户已注册')
                    loggerc.info('%s该用户已经注册，不可重复注册'%(account))



            elif num == 2:
                account ,password = cls.login()
                loggerc.info("%s用户尝试等入系统"%(account))

                cls.send('login')
                cls.send(account)
                cls.send(password)
                msg = cls.receive().decode('utf-8')
                if msg == 'success':
                    flag = 1
                    print('登入成功')
                    loggerc.info('%s用户登入成功'%(account))

                else:
                    print('账号或密码错误，请重试')
                    loggerc.info('%s账号或密码错误，请重试'%(account))


            elif num == 3:
                #判断用户是否登入
                if flag == 0:
                    print('请先登入')
                    continue

                #发送请求的操作
                cls.send('download')
                #接受服务端传过来filename以及size
                n = cls.recevied(4)
                n = struct.unpack('i',n)[0]

                msg = cls.recevied(n)
                file_json = json.loads(msg.decode('utf-8'))

                print(file_json)
                file_name = file_json['file_name']
                file_size =0
                file_total = file_json['file_size']

                loggerc.info('准备开始下载文件.......文件名字是：%s，文件大小是：%s'%(file_name,file_size))




#add md5 check
                m = hashlib.md5(conf.salt)

                #接受文件并写入
                loggerc.info('开始下载文件.......')

                with open(file_name,'ab') as f:
                    while file_size < file_total:

                        content = cls.recevied(1024)
                        m.update(content)
                        f.write(content)
                        file_size += len(content)
                        time.sleep(0.1)
                        cls.processBar(file_size,file_total)

                loggerc.info('文件下载完成.......')

            #将MD5值传给服务端进行校验
                md5_s = m.hexdigest()
                loggerc.info('文件的MD5值是%s'%md5_s)
                cls.send(md5_s)


            elif num == 4:
                # 判断用户是否登入
                if flag == 0:
                    print('请先登入')
                    continue

                # 发送请求的操作
                cls.send('upload')
                # 接受服务端传过来filename以及size
                con = cls.recevied(7).decode('utf-8')
                if con == 'connect':
                    file_name = os.path.basename(conf.filepath)
                    file_size = os.path.getsize(conf.filepath)
                    file_total = os.path.getsize(conf.filepath)

                    info_dic = {'file_name': file_name, 'file_size': file_size}
                    info_json = json.dumps(info_dic).encode('utf-8')  # str.encode('utf-8') bytes
                    send_len = struct.pack('i', len(info_json))

                    # 将文件名以及文件按大小发送到服务端
                    cls.sends(send_len)
                    cls.sends(info_json)

                    m = hashlib.md5(conf.salt)

                    loggerc.info("开始上传文件.....")

                    with open(conf.filepath, mode='rb') as f:
                        while file_size > 0:
                            content = f.read(1024)
                            m.update(content)
                            cls.sends(content)
                            file_size -= len(content)
                            # 调用进度条
                            cls.processBar((file_total - file_size), file_total)

                    loggerc.info("文件上传完成.....")
                    # 获取md5值
                    s = m.hexdigest()
                    # 接受服务端的MD5值，并校验是否一
                    n = cls.recevied(4)
                    n = struct.unpack('i',n)[0]
                    s_md5 = cls.recevied(n).decode('utf-8')

                    loggerc.info("原始文件的md5值是：%s，目标文件的md5值是：%s" % (s, s_md5))

                    if s_md5 == s:
                        print('md5值校验成功')
                        loggerc.info("上传文件md5值校验成功.....")


if __name__ == '__main__':
    client.show()



