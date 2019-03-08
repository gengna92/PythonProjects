from core.client.client import *
from core.serpackage.server import *
from log import logconf


if __name__ == '__main__':
    #启动服务端
    ser = socketserver.TCPServer((conf.ip, conf.port), MyServer)
    print(ser)
    ser.serve_forever()
    loggers =  logconf.conflog('../log/server.txt', 'server')
    loggers.info("服务端启动.......")

    time.sleep(1)

    #启动客户端
    client.show()
    loggerc =  logconf.conflog('../log/client.txt', 'client')
    loggers.info("客户端启动.......")

