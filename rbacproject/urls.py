"""rbacproject URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from app import views as myViews

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login', myViews.Users.login),
    path('logout', myViews.Users.logout),
    path('getUserList', myViews.getUserList),
    path('getRoleList', myViews.getRoleList),
    path('getPermissionList', myViews.getPermissionList),
    path('addPermission',myViews.addPermission),
    path('deletePermission', myViews.deletePermission),
    path('user/addUser',myViews.addUser),
    path('role/updateRolePermission', myViews.updateRolePermission),
    path('role/addRole', myViews.addRole)
]
