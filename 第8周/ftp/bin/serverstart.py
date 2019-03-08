from core.serpackage.server import *
from log import logconf


if __name__ == '__main__':
    # #启动服务端
    loggers = logconf.conflog('../log/server.txt', 'server')
    loggers.info("服务端启动.......")
    ser = socketserver.TCPServer((conf.ip, conf.port), MyServer)
    ser.serve_forever()


