"""数据库表"""
from django.db import models

# Create your models here.


class role(models.Model):
    role_id = models.BigIntegerField(primary_key=True)
    pid = models.BigIntegerField()
    role_name = models.CharField(max_length=64)
    create_time = models.DateField()
    role_dec = models.CharField(max_length=200,default='', blank=True)


class user(models.Model):
    user_id = models.BigIntegerField(primary_key=True)
    account = models.CharField(max_length=64)
    password = models.CharField(max_length=64)
    user_name = models.CharField(max_length=64)
    phone = models.CharField(max_length=20, blank=True)
    email = models.CharField(max_length=64, blank=True)
    create_time = models.DateField()
    login_time = models.DateField(blank=True)
    last_login_time = models.DateField(blank=True)
    login_count = models.BigIntegerField()

class permission(models.Model):
    permission_id = models.BigIntegerField(primary_key=True)
    pid = models.BigIntegerField()
    permission_name = models.CharField(max_length=64)
    permission_dec = models.CharField(max_length=200, default='', blank=True)

class user_role(models.Model):
    id = models.BigIntegerField(primary_key=True)
    user_id = models.ManyToManyField(user)
    role_id = models.ManyToManyField(role)

class user_permission(models.Model):
    id = models.BigIntegerField(primary_key=True)
    user_id = models.ManyToManyField(user)
    permission_id = models.ManyToManyField(permission)
    permission_type = models.IntegerField()

class role_permission(models.Model):
    id = models.BigIntegerField(primary_key=True)
    role_id = models.ManyToManyField(role)
    permission_id = models.ManyToManyField(permission)
    permission_type = models.IntegerField()
