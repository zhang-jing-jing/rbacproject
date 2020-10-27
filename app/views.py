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
from django.core.paginator import Paginator
from django.contrib.auth.hashers import make_password, check_password
import datetime, time

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

@post_only
def login(request):
    """
    用户登录
    """
    reponse = {}
    username = request.POST.get('username')                         
    password = request.POST.get('password')
    if username is not None and password is not None:
        users = user.objects.filter(account=username)
        if users.count() > 0:
            userDto = users.first()
            userDto.login_count += 1 
            now = datetime.datetime.now()
            userDto.login_time = now.strptime(
                    now.strftime("%Y-%m-%d %H:%M:%S"), '%Y-%m-%d %H:%M:%S')
            userDto.save()
            if check_password(password, userDto.password):
                request.session["is_login"] = True
                request.session["login_user"] = username
                login_ur = user_role.objects.filter(user_id=userDto.user_id)
                role_temp = []
                for item in login_ur:
                    temp_ids = [i.role_id for i in item.role_id.all()][0]
                    role_temp.append(temp_ids)
                for role_id in role_temp:
                    login_rp = role_permission.objects.filter(role_id=role_id)
                    permission_temp = []
                    for rp_item in login_rp:
                        for i in rp_item.permission_id.all():
                            permission_temp.append(i.permission_id)
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
                    'login_count': userDto.login_count,
                    'permission': permission_temp
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

@post_only
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

def getNonRepeatList(data):
    return list(set(data))

def queryUserList(user_dto, pagesize, pindex):
    paginator = Paginator(user_dto, pagesize)
    current_list = paginator.page(pindex)
    templist = []
    if len(current_list) > 0:
        for t in current_list:
            ur = user_role.objects.filter(user_id=t.user_id)
            role_temp = []
            permission_temp = []
            for item in ur:
                temp_ids, temp_name = [(i.role_id, i.role_name)
                                       for i in item.role_id.all()][0]
                role_temp.append((temp_ids, temp_name))
                rp = role_permission.objects.filter(role_id=temp_ids)
                for _permiss in rp:
                    if _permiss.permission_id.all().count() > 0 :
                        temp_pids, temp_pname = [(i.permission_id, i.permission_name)
                                        for i in _permiss.permission_id.all()][0]
                        permission_temp.append((temp_pids, temp_pname))
            temp = {
                'account': t.account,
                'user_name': t.user_name,
                'phone': t.phone,
                'email': t.email,
                'create_time': getattr(t, 'create_time'),
                'login_time': t.login_time,
                'last_login_time': t.last_login_time,
                'login_count': t.login_count,
                'user_id': t.user_id,
                'role': role_temp,
                'permission':sorted(getNonRepeatList(permission_temp))
            }
            templist.append(temp)
    return templist

@check_user
@post_only
def getUserList(request):
    reponse = {
        'list': []
    }
    try:
        query_value = request.POST.get('queryValue', default="")
        query_content = request.POST.get('queryText',default="")
        pagesize = request.POST.get('pagesize', default=5)
        # 当前页数
        pindex = request.POST.get('index', default=1)
        if query_value != "" and query_content != "":
            if query_value == "user_name":
                user_list = user.objects.filter(
                    user_name__contains=query_content).order_by('user_id')
            elif query_value == "account":
                user_list = user.objects.filter(
                    account__contains=query_content).order_by('user_id')
            elif query_value == "phone":
                user_list = user.objects.filter(
                    phone__contains=query_content).order_by('user_id')
            elif query_value == "email":
                user_list = user.objects.filter(
                    email__contains=query_content).order_by('user_id')
            elif query_value == "role":
                role_dto = role.objects.filter(role_name__contains=query_content)
                for i in role_dto:
                    ur = user_role.objects.filter(role_id=i.role_id)
                    temp_list = []
                    for ii in ur:
                        for j in ii.user_id.all():
                            temp = user.objects.filter(
                                user_id=j.user_id).order_by('user_id')
                            temp_list.append(temp)
                    user_list = user.objects.none()
                    for j in temp_list:
                        user_list = user_list | j
            elif query_value == "permission":
                user_list = queryUserByPermission(query_content)
        else:
            print('111')
            user_list = user.objects.all().order_by('user_id')
        if user_list.count() > 0:
            reponse['list'] = queryUserList(user_list, pagesize, pindex)
        else:
            reponse['list'] = []
        reponse['total'] = user_list.count()
    except:
        reponse['status'] = 300
        reponse['message'] = "后台错误,请联系管理员。"
    else:
        reponse['status'] = 0
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

def queryUserByPermission(query):
    permission_dto = permission.objects.filter(permission_name__contains=query)
    temp_list = []
    for i in permission_dto:
        rp = role_permission.objects.filter(permission_id=i.permission_id)
        for ii in rp:
            for j in ii.role_id.all():
                ur = user_role.objects.filter(role_id=j.role_id)
                for ur_item in ur:
                    for u_item in ur_item.user_id.all():
                        temp = user.objects.filter(
                            user_id=u_item.user_id).order_by('user_id')
                        temp_list.append(temp)
    user_list = user.objects.none()
    for j in temp_list:
        user_list = user_list | j
    return user_list

@check_user
def addUser(request):
    reponse = {}
    update = False
    try:
        user_id = request.POST.get('user_id')
        if int(user_id) > -1:
            update = True
            user_dto = user.objects.filter(user_id=user_id).first()
            user_role.objects.filter(user_id=user_id).delete()
        else:
            user_dto = user()
        user_dto.account = request.POST.get('account')
        if update == False:
            user_dto.password = make_password(request.POST.get('password'))
        user_dto.user_name = request.POST.get('user_name')
        user_dto.phone = request.POST.get('phone', default="")
        user_dto.email = request.POST.get('email', default="")
        user_dto.save()
        role_ids = request.POST.get('role',default=[]).split(',')
        for i in role_ids:
            role_dto = role.objects.filter(role_id=i).first()
            user_role_dto = user_role()
            user_role_dto.save()
            user_role_dto.user_id.add(user_dto)
            user_role_dto.role_id.add(role_dto)
            user_role_dto.save()
    except:
        reponse['status'] = 300
        reponse['message'] = "添加失败"
    else:
        reponse['status'] = 0
        if update:
            message = "修改成功"
        else:
            message = "添加成功"
        reponse['message'] = message
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

@check_user
def deleteUser(request): 
    if request.method == 'DELETE':
        DELETE = QueryDict(request.body)
        d_id = DELETE.get('ids').split(',')
        reponse = {}
        try:
            for i in d_id:
                delete_user = user.objects.filter(user_id=i).first()
                if delete_user:
                    user_role.objects.filter(user_id=i).delete()
                    delete_user.delete()
        except:
            reponse['status'] = 300
            reponse['message'] = '删除异常'
        else:
            reponse['status'] = 0
            reponse['message'] = '删除成功'
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

@check_user
@post_only
def getRoleList(request):
    reponse = {
        'list': []
    }
    try:
        query_value = request.POST.get('queryValue', default="")
        query_content = request.POST.get('queryText',default="")
        pagesize = request.POST.get('pagesize', default=5)
        # 当前页数
        pindex = request.POST.get('index', default=1)
        if query_value != "" and query_content != "":
            if query_value == "role_name":
                role_list = role.objects.filter(
                    role_name__contains=query_content).order_by('role_id')
            elif query_value == "role_dec":
                role_list = role.objects.filter(
                    role_dec__contains=query_content).order_by('role_id')
            elif query_value == "permission":
                permission_dto = permission.objects.filter(permission_name__contains=query_content)
                role_list = role.objects.none()
                if permission_dto.count() > 0:
                    for i in permission_dto:
                        print('22',i.permission_id)
                        ur = role_permission.objects.filter(permission_id=i.permission_id)
                        temp_list = []
                        for ii in ur:
                            for j in ii.role_id.all():
                                temp = role.objects.filter(
                                    role_id=j.role_id).order_by('role_id')
                                temp_list.append(temp)
                        role_list = role.objects.none()
                        for j in temp_list:
                            role_list = role_list | j
        else:
            role_list = role.objects.all().order_by('role_id')
        reponse['list'] = queryRoleList(role_list, pagesize, pindex)
        reponse['status'] = 0
        reponse['total'] = role_list.count()
    except:
        reponse['status'] = 300
        reponse['list'] = '获取出错,请联系管理员'
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

def queryRoleList(role_dto, pagesize, pindex):
    paginator = Paginator(role_dto, pagesize)
    current_list = paginator.page(pindex)
    templist = []
    if len(current_list) > 0:
        for t in current_list:
                per_dto = role_permission.objects.filter(role_id=t.role_id)
                per = []
                for item in per_dto:
                    if item.permission_id.all().count() > 0:
                        temp_ids, temp_name = [(i.permission_id, i.permission_name) for i in item.permission_id.all()][0]
                        per.append((temp_ids, temp_name))
                temp = {
                    'role_id': t.role_id,
                    'role_name': t.role_name,
                    'create_time': t.create_time,
                    'role_dec': t.role_dec,
                    'permission':per
                }
                templist.append(temp)
    return templist

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
        role_permission_dto = role_permission()
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
def updateRole(request):
    reponse = {}
    try:
        role_id = request.POST.get('role_id')
        if role_id:
            print('0+++')
            role_dto = role.objects.filter(role_id=role_id).first()
            role_dto.role_name = request.POST.get('role_name')
            role_dto.role_dec = request.POST.get('role_dec')
            role_dto.save()
            print('1++')
            per_list = request.POST.get('permission').split(',')
            role_permission.objects.filter(role_id=role_id).delete()
            for t in per_list:
                role_per_dto = role_permission()
                role_per_dto.save()
                permission_dto = permission.objects.filter(permission_id=t).first()
                role_per_dto.role_id.add(role_dto)
                role_per_dto.permission_id.add(permission_dto)
                role_per_dto.save()
    except:
        reponse['status'] = 300
        reponse['message'] = "修改异常"
    else:
        reponse['status'] = 0
        reponse['message'] = "修改成功"
    return HttpResponse(json.dumps(reponse, ensure_ascii=False, cls=CJsonEncoder))

@check_user
def deleteRole(request):
    if request.method == 'DELETE':
        DELETE = QueryDict(request.body)
        d_id = DELETE.get('ids').split(',')
        reponse = {}
        try:
            for i in d_id:
                ur_dto = user_role.objects.filter(role_id=i)
                print('count++++',ur_dto.count())
                if ur_dto.count() == 0:
                    print('1')
                    delete_role = role.objects.filter(role_id=i).first()
                    if delete_role:
                        role_permission.objects.filter(role_id=i).delete()
                        delete_role.delete()
                    reponse['status'] = 0
                    reponse['message'] = '删除成功'
                else:
                    reponse['status'] = 300
                    reponse['message'] = '有关联的用户，请删除了相关用户后删除该角色'
        except:
            reponse['status'] = 300
            reponse['message'] = '删除异常'
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
@post_only
def addPermission(request):
    reponse = {}
    try:
        permission_id = request.POST.get('permission_id',-1)
        permission_name = request.POST.get('permission_name')
        permission_dec = request.POST.get('permission_dec')
        if int(permission_id) <= -1:
            pid = request.POST.get('pid')
            if permission_name != "":
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
            permissDto = permission.objects.filter(permission_id=permission_id).first()
            permissDto.permission_name = permission_name
            permissDto.permission_dec = permission_dec
            permissDto.save()
            reponse['status'] = 0
            reponse['message'] = '修改成功'
            reponse['list'] = {
                'permission_id': permissDto.permission_id,
                'permission_name': permissDto.permission_name,
                'permission_dec': permissDto.permission_dec,
                'leafCount':0,
                'children':[]
            }
    except:
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
