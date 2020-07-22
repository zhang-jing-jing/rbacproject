from django.shortcuts import render
from django.http import HttpResponse    # 引用HttpResponse类
# Create your views here. 
def index(request):
    return HttpResponse("Hello World!!")
# Create your views here.
