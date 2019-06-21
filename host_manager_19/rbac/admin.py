from django.contrib import admin
from rbac import models


# Register your models here.
class PermissionConfig(admin.ModelAdmin):
    list_display = ['url', 'title', 'name']
    list_editable = ['name']


admin.site.register(models.Permission, PermissionConfig)
admin.site.register(models.Role)
admin.site.register(models.Menu)
