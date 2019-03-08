import logging

def conflog(filename,sysname):
    file_handler = logging.FileHandler(filename,encoding='utf-8')
    file_handler.setFormatter(logging.Formatter
                              (fmt="%(asctime)s - %(name)s - %(levelname)s -%(module)s: %(message)s"))

    loggers = logging.Logger(sysname,level=logging.INFO)

    loggers.addHandler(file_handler)
    return loggers

if __name__ == '__main__':
    # loggers = conflog('user.txt','sysname')
    # loggers.error("error ,,,,,,,,,,,,,,,,,,,,,,,")
    # loggers.error("error ,,,,,,,,,,,,,,,,,,,,,,,")
    # loggers.error("error ,,,,,,,,,,,,,,,,,,,,,,,")
    # loggers.error("error ,,,,,,,,,,,,,,,,,,,,,,,")
    pass



import sys,time
j = '#'
if __name__ == '__main__':
    for i in range(1,61):
        j += '#'
        sys.stdout.write(str(int((i/60)*100))+'%  ||'+j+'->'+"\r")
        sys.stdout.flush()
        time.sleep(0.5)


