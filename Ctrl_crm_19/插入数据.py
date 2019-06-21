import os

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Ctrl_crm.settings")
import django

django.setup()
from crm import models

# for i in range(0, 305):
#     models.Department.objects.create(name="部门- {}".format(i))

obj_list = []

for i in range(0, 305):
    obj_list.append(models.Department(name="部门- {}".format(i)))

models.Department.objects.bulk_create(obj_list)
