# 검색 기능 추가 
from django.contrib import admin
from .models import Question

class QuestionAdmin(admin.ModelAdmin):
    search_fields = ['subject']
    
admin.site.register(Question,QuestionAdmin)


# Register your models here.
