#or 远程执行
#基于paramiko模块
import paramiko

if __name__ == '__main__':

    ssh  = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname='192.168.168.36', port=22, username='root', password='123456')

    stdin, stdout, stderr = ssh.exec_command('sh /usr/local/mydb/bin/main.py')
    print(stdout.read().decode('utf-8'))

    ssh.close()