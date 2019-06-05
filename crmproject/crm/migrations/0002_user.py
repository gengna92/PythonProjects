# -*- coding: utf-8 -*-
# Generated by Django 1.11.20 on 2019-06-04 09:16
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('crm', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, verbose_name='用户名')),
                ('pwd', models.CharField(max_length=32, verbose_name='密码')),
                ('gender', models.IntegerField(choices=[(1, '男'), (2, '女')], verbose_name='性别')),
                ('dep', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='crm.Department', verbose_name='部门')),
            ],
        ),
    ]
