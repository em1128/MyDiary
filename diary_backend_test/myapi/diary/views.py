from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Question, Quote
from .serializers import DiarySerializer
import random

# Create your views here.
@api_view(['GET'])
def helloAPI(request):
    return Response("Hello world!")

@api_view(['GET'])
def randomQuote(request, id):
    totalQuotes = Quote.objects.all()
    randomQuotes = random.sample(list(totalQuotes), id)
    serializer = DiarySerializer(randomQuotes, many=True) # many=True로 해야 다량의 데이터도 처리 가능
    return Response(serializer.data)