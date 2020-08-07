"""views"""
from django.shortcuts import render,redirect
from django.http import HttpResponse    # 引用HttpResponse类
from django.http import QueryDict
# Create your views here.
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout
import json,datetime
from datetime import date
from app.models import user,role,permission,user_role

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
    userDto.save()
    roleIds = request.POST.get('role')
    for  i in roleIds:
        RoleDto = role.objects.filter(role_id=1).first()
        userRoleDto = user_role()
        userRoleDto.save()
        userRoleDto.user_id.add(userDto)
        userRoleDto.role_id.add(RoleDto)
        userRoleDto.save()
    reponse={}
    reponse['status'] = 0
    reponse['message'] = "添加成功"
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

def getPermissionById(pid):
    permissionList = permission.objects.filter(pid=pid)
    if permissionList.count() > 0:
        tempList = []
        for t in permissionList:
            children = permission.objects.filter(pid=t.permission_id)
            childrenList = []
            if children.count() > 0:
                childrenList = getPermissionById(t.permission_id)
            temp = {
                'permission_id': t.permission_id,
                'pid': t.pid,
                'permission_name': t.permission_name,
                'permission_dec': t.permission_dec,
                'leafCount': children.count(),
                'children': childrenList
            }
            tempList.append(temp)
        return tempList

def getPermissionList(request):
    reponse = {
        'list': []
    }
    isLogin = request.session['is_login']
    if isLogin:
        reponse['status'] = 0
        reponse['list'] = getPermissionById(0)
    else:
        reponse['status'] = 600
        reponse['message'] = "登录失效"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

def addPermission(request):
    if request.method == 'POST':
        permission_name = request.POST.get('permission_name')
        permission_dec = request.POST.get('permission_dec')
        pid = request.POST.get('pid')
        if permission_name is not "":
            permissDto = permission(permission_name=permission_name, permission_dec=permission_dec, pid=pid)
            permissDto.save()
            reponse = {}
            if permissDto.permission_id:
                reponse['status'] = 0
                reponse['message'] = '添加成功'
                reponse['list'] = {
                    'permission_id': permissDto.permission_id,
                    'permission_name': permissDto.permission_name,
                    'permission_dec': permissDto.permission_dec,
                    'leafCount':0,
                    'children':[]
                }
            else:
                reponse['status'] = 600
                reponse['message'] = '添加失败'
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

def deletePermission(request):
    if request.method == 'DELETE':
        DELETE = QueryDict(request.body)
        d_id = DELETE.get('permission_id')
        delete_dto = permission.objects.filter(permission_id=d_id).first()
        reponse = {}
        if delete_dto:
            delete_dto.delete()
            reponse['status'] = 0
            reponse['message'] = '删除成功'
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))
