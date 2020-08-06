"""views"""
from django.shortcuts import render,redirect
from django.http import HttpResponse    # 引用HttpResponse类
# Create your views here.
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout
import json,datetime
from datetime import date
from app.models import user,role,permission

#验证是否登录的装饰器
def check_user(func):
    def inner(*args, **kwargs):
        #判断是否登录
        username = args[0].session.get("login_user", "")
        if username == "":
            #保存当前的url到session中
            args[0].session["path"] = args[0].path
            #重定向到登录页面
            return
        return func(*args, **kwargs)

    return inner


class CJsonEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        elif isinstance(obj, date):
            return obj.strftime("%Y-%m-%d")
        else:
            return json.JSONEncoder.default(self, obj)

class Users:
    def login(request):
        reponse = {}
        if request.method == 'POST':
            username = request.POST.get('username')                         
            password = request.POST.get('password')
            if username is not None and password is not None:
                users = user.objects.filter(account=username)
                if users.count() > 0:
                    userDto = users.first()
                    if userDto.password == password:
                        request.session["is_login"] = True
                        request.session["login_user"] = username
                        reponse['status'] = 0
                        reponse['message'] = "登录成功"
                        reponse['list'] = {
                            'account': userDto.account,
                            'user_name': userDto.user_name,
                            'phone': userDto.phone,
                            'email': userDto.email,
                            'create_time': userDto.create_time,
                            'login_time': userDto.login_time,
                            'last_login_time': userDto.last_login_time,
                            'login_count': userDto.login_count
                        }
                    else:
                        reponse['status'] = 10
                        reponse['message'] = "密码错误"
                else:
                    reponse['status'] = 20
                    reponse['message'] = '用户不存在'
            else:
                reponse['status'] = 400
                reponse['message'] = "参数错误"
        return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))
    
    def logout(request):
        # del request.session["is_login"] # 删除session_data里的一组键值对
        reponse = {}
        if request.method == 'POST':
            request.session.flush()
            reponse['status'] = 0
            reponse['message'] = "退出成功"
        return HttpResponse(json.dumps(reponse, ensure_ascii=False))
    
def getUserList(request):
    reponse = {
        'list':[]
    }
    isLogin = request.session['is_login']
    if isLogin:
        reponse['status'] = 0
        userList = user.objects.all()
        if userList.count() > 0:
            for t in userList:
                temp = {
                    'account':t.account,
                    'user_name':t.user_name,
                    'phone':t.phone,
                    'email':t.email,
                    'create_time': getattr(t, 'create_time'),
                    'login_time':t.login_time,
                    'last_login_time':t.last_login_time,
                    'login_count':t.login_count
                }
                reponse['list'].append(temp)
    else:
        reponse['status'] = 600
        reponse['message'] = "登录失效"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

def addUser(request):
    userDto = user()
    userDto.account = request.POST.get('account')
    userDto.password = request.POST.get('password')
    userDto.user_name = request.POST.get('user_name')
    userDto.phone = request.POST.get('phone')
    userDto.email = request.POST.get('email')
    print('_______________',request.POST.get('account'))
    print('userDto',userDto.account)
    userDto.save()
    print('++++++++++++++++',userDto.user_id)
    reponse={}
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

def getRoleList(request):
    reponse = {
        'list': []
    }
    isLogin = request.session['is_login']
    if isLogin:
        reponse['status'] = 0
        roleList = role.objects.all()
        if roleList.count() > 0:
            for t in roleList:
                temp = {
                    'role_id': t.role_id,
                    'pid': t.pid,
                    'role_name': t.role_name,
                    'create_time': t.create_time,
                    'role_dec': t.role_dec
                }
                reponse['list'].append(temp)
    else:
        reponse['status'] = 600
        reponse['message'] = "登录失效"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))


def getPermissionList(request):
    reponse = {
        'list': []
    }
    isLogin = request.session['is_login']
    if isLogin:
        reponse['status'] = 0
        permissionList = permission.objects.all()
        if permissionList.count() > 0:
            for t in permissionList:
                temp = {
                    'permission_id': t.permission_id,
                    'pid': t.pid,
                    'permission_name': t.permission_name,
                    'permission_dec': t.permission_dec
                }
                reponse['list'].append(temp)
    else:
        reponse['status'] = 600
        reponse['message'] = "登录失效"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))
