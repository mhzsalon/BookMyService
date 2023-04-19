from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from .models import feedback
from rest_framework.decorators import APIView
from .serializer import FeedbackSerializer


# Create your views here.
class Review(APIView):
    def get(self, request):
        try:
            _spID = feedback.objects.filter(provider_id=request.query_params.get('spID'))

            serialiler = FeedbackSerializer(_spID, many=True)
         
            return Response(serialiler.data, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error.'}, status=status.HTTP_400_BAD_REQUEST)
        
    
    def post(self, request, *args, **kwargs):
        try:
            print(request.data['uID'])
            feedback(
                user_id_id= request.data['uID'],
                provider_id_id = request.data['pID'],
                comment = request.data['comment'],
            ).save()
            return Response({'message': 'Thank you for the feedback.'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error.'}, status=status.HTTP_400_BAD_REQUEST)


