"""views"""
from django.shortcuts import render
from django.http import HttpResponse    # 引用HttpResponse类
from app.models import Test
# Create your views here
def index(request):
    """func函数说明"""
    return HttpResponse("Hello World!!")

def testdb(request):
    """func函数说明"""
    test1 = Test(name='runoob')
    test2 = Test(name='test1')
    test1.save()
    test2.save()
    return HttpResponse("<p>数据添加成功！</p>")


def getestdb(request):
    """func函数说明"""
    # 初始化
    response = ""
    response1 = ""

    # 通过objects这个模型管理器的all()获得所有数据行，相当于SQL中的SELECT * FROM
    list1 = Test.objects.all()

    # filter相当于SQL中的WHERE，可设置条件过滤结果
    # response2 = Test.objects.filter(id=1)

    # 获取单个对象
    # response3 = Test.objects.get(id=1)

    # 限制返回的数据 相当于 SQL 中的 OFFSET 0 LIMIT 2;
    # Test.objects.order_by('name')[0:2]

    #数据排序
    Test.objects.order_by("id")

    # 上面的方法可以连锁使用
    Test.objects.filter(name="runoob").order_by("id")

    # 输出所有数据
    for var in list1:
        response1 += var.name + " "
    response = response1
    return HttpResponse("<p>" + response + "</p>")


def update(request):
    """func函数说明"""
    test1 = Test.objects.get(id=1)
    test1.name = 'Google'
    test1.save()
    # 另外一种方式
    #Test.objects.filter(id=1).update(name='Google')
    # 修改所有的列
    # Test.objects.all().update(name='Google')
    return HttpResponse("<p>修改成功</p>")


def delete_test(request):
    """func函数说明"""
    # 删除id=1的数据
    test1 = Test.objects.get(name='test1')
    test1.delete()

    # 另外一种方式
    # Test.objects.filter(id=1).delete()

    # 删除所有数据
    # Test.objects.all().delete()

    return HttpResponse("<p>删除成功</p>")
# Create your views here.
