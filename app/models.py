"""数据库表"""
from django.db import models

# Create your models here.

class Test(models.Model):
    """test表结构"""
    name = models.CharField(max_length=20)
