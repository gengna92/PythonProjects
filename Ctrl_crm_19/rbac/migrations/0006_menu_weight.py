# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-06-16 06:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rbac', '0005_auto_20190616_1137'),
    ]

    operations = [
        migrations.AddField(
            model_name='menu',
            name='weight',
            field=models.IntegerField(default=1),
        ),
    ]
