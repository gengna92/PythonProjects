from conf import conf
import pymysql
# import paramiko
# #基于paramiko模块
# ssh  = paramiko.SSHClient()
# ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# ssh.connect(hostname='192.168.168.36', port=22, username='root', password='time.9818')
#
# stdin, stdout, stderr = ssh.exec_command('ls')
# print(stdout.read().decode('utf-8'))

# ssh.close()

class db:
    def __init__(self):
        self.conn =pymysql.Connect(host=conf.host, user=conf.username, password=conf.password,
                 database=conf.db, port=conf.port)

        self.cursor = self.conn.cursor()

#增删改
    def add(self,sql):
        try:
            self.cursor.execute(sql)
            self.conn.commit()
            return True

        except pymysql.err.IntegrityError:
            print('数据重复~')
            return False

#查询
    def select(self,sql):

        self.cursor.execute(sql)
        res = self.cursor.fetchall()
        print(res)
        # self.cursor.scroll()
        return res

    def close(self):
        self.cursor.close()
        self.conn.close()



if __name__ == '__main__':
    db =db()
    sql = "insert into managers values ('1','1','3','6')"
    db.add(sql)


