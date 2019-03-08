from core.client.client import *
from log import logconf


if __name__ == '__main__':
    #启动客户端
    loggerc =  logconf.conflog('../log/client.txt', 'client')
    loggerc.info("客户端启动.......")
    client.show()


