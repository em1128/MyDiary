from django.db import models

# Create your models here.
class Question(models.Model):
    qID = models.IntegerField()
    title = models.CharField(max_length=200)
    body = models.TextField()
    rating = models.BooleanField()

class Answer(models.Model):
    qID = models.IntegerField()
    ansCand = models.IntegerField()
    ansStr = models.CharField(max_length=1200)

class Quote(models.Model):
    content = models.CharField(max_length=200)
