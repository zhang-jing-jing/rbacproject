"""views"""
from django.shortcuts import render,redirect
from django.http import HttpResponse    # 引用HttpResponse类
from django.http import QueryDict
# Create your views here.
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout
import json,datetime
from datetime import date
from app.models import user,role,permission,user_role,role_permission

#验证是否登录的装饰器
def check_user(func):
    def inner(*args, **kwargs):
        #判断是否登录
        isLogin = args[0].session.get('is_login', '')
        if isLogin != True:
            #保存当前的url到session中
            response = HttpResponse(json.dumps(
                {"message": "登录失效,请重新登录", "status": 600}))
            return response
        return func(*args, **kwargs)
    return inner

# 验证是否为POST请求
def post_only(func):
    def inner(*args, **kwargs):
        if args[0].method != "POST":
            response = HttpResponse(json.dumps(
                {"message": "请求方式错误", "status":403}))
            return response
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
        """
        用户登录
        """
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
        """
        用户退出
        """
        # del request.session["is_login"] # 删除session_data里的一组键值对
        reponse = {}
        if request.method == 'POST':
            request.session.flush()
            reponse['status'] = 0
            reponse['message'] = "退出成功"
        return HttpResponse(json.dumps(reponse, ensure_ascii=False))

@check_user
def getUserList(request):
    reponse = {
        'list':[]
    }
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
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

@check_user
def addUser(request):
    user_dto = user()
    user_dto.account = request.POST.get('account')
    user_dto.password = request.POST.get('password')
    user_dto.user_name = request.POST.get('user_name')
    user_dto.phone = request.POST.get('phone')
    user_dto.email = request.POST.get('email')
    user_dto.save()
    role_ids = request.POST.get('role')
    for i in role_ids:
        role_dto = role.objects.filter(role_id=1).first()
        user_role_dto = user_role()
        user_role_dto.save()
        user_role_dto.user_id.add(user_dto)
        user_role_dto.role_id.add(role_dto)
        user_role_dto.save()
    reponse = {}
    reponse['status'] = 0
    reponse['message'] = "添加成功"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

@check_user
def getRoleList(request):
    reponse = {
        'list': []
    }
    reponse['status'] = 0
    role_list = role.objects.all()
    if role_list.count() > 0:
        for t in role_list:
            per_dto = role_permission.objects.filter(role_id=t.role_id)
            per = []
            for item in per_dto:
                print(item.permission_id.all())
                temp_ids, temp_name = [(i.permission_id, i.permission_name) for i in item.permission_id.all()][0]
                per.append((temp_ids, temp_name))
            temp = {
                'role_id': t.role_id,
                'pid': t.pid,
                'role_name': t.role_name,
                'create_time': t.create_time,
                'role_dec': t.role_dec,
                'permission':per
            }
            reponse['list'].append(temp)
    else:
        reponse['list'] = []
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))


@check_user
@post_only
def addRole(request):
    role_dto = role(pid=0)
    role_dto.role_name = request.POST.get('role_name')
    role_dto.role_dec = request.POST.get('role_dec')
    role_dto.save()
    permission_ids = request.POST.get('permission').split(',')
    for i in permission_ids:
        permission_dto = permission.objects.filter(permission_id=i).first()
        role_permission_dto = role_permission(permission_type=0)
        role_permission_dto.save()
        role_permission_dto.role_id.add(role_dto)
        role_permission_dto.permission_id.add(permission_dto)
        role_permission_dto.save()
    reponse = {}
    reponse['status'] = 0
    reponse['message'] = "添加成功"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))
    
@check_user
@post_only
def updateRolePermission(request):
    role_id = request.POST.get('role_id')
    per_list = request.POST.get('permission_ids').split(',')
    role_permission.objects.filter(role_id=role_id).delete()
    role_dto = role.objects.filter(role_id=role_id).first()
    for t in per_list:
        role_per_dto = role_permission(permission_type=0)
        role_per_dto.save()
        permission_dto = permission.objects.filter(permission_id = t).first()
        role_per_dto.role_id.add(role_dto)
        role_per_dto.permission_id.add(permission_dto)
        role_per_dto.save()
    reponse = {}
    reponse['status'] = 0
    reponse['message'] = "添加成功"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

@check_user
def deleteRole(request):
    if request.method == 'DELETE':
        DELETE = QueryDict(request.body)
        d_id = DELETE.get('ids').split(',')
        reponse = {}
        try:
            for i in d_id:
                delete_role = role.objects.filter(role_id=i).first()
                if delete_role:
                    delete_role.delete()
        except:
            reponse['status'] = 300
            reponse['message'] = '删除异常'
        else:
            reponse['status'] = 0
            reponse['message'] = '删除成功'
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

@check_user
def getPermissionList(request):
    reponse = {
        'list': []
    }
    reponse['status'] = 0
    reponse['list'] = getPermissionById(0)
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))


@check_user
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


@check_user
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
