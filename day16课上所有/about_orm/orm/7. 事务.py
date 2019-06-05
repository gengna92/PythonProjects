import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "about_orm.settings")
import django

django.setup()

from app01 import models

from django.db import transaction

try:
    with transaction.atomic():
        # 一系列的操作
        models.Publisher.objects.create(name='asdasdasd')
        models.Publisher.objects.create(name='23141654')


except Exception as  e:
    print(e)
