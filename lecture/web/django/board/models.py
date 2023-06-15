from django.db import models

class Question(models.Model):
    subject = models.CharField(max_length=200)
    content = models.TextField()
    created_at = models.DateTimeField()
    
    def __str__(self):
        return self.subject
    
    
class Answer(models.Model):
    Question = models.ForeignKey(Question,on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField()

# Create your models here.
