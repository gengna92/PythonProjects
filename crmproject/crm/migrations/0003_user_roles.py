# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-06-21 08:42
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rabc', '0003_role'),
        ('crm', '0002_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='roles',
            field=models.ManyToManyField(blank=True, to='rabc.Role', verbose_name='用户所拥有的角色'),
        ),
    ]