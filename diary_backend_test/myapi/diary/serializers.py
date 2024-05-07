from rest_framework import serializers
from .models import Question, Answer, Quote

class DiarySerializer(serializers.ModelSerializer):
	class Meta:
		model = Quote
		fields = ('content',)
