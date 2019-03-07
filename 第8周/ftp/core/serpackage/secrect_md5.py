import hashlib
from conf import conf
def smd5(message):
    m = hashlib.md5(conf.salt)
    m.update(message.encode())
    sec = m.hexdigest()
    return sec

