from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from .models import feedback
from rest_framework.decorators import APIView
from .serializer import FeedbackSerializer
import datetime
from dateutil import parser


# Create your views here.
class Review(APIView):
    def get(self, request):
        try:
            _spID = feedback.objects.filter(provider_id=request.query_params.get('spID'))

            serialiler = FeedbackSerializer(_spID, many=True)
            
            data = serialiler.data
            current_time = datetime.datetime.now(datetime.timezone.utc)

            time = []
            new = []
            response = {
                    "review":serialiler.data,
                    "time":new
                }
            
            for comment in data:
                created_time = parser.isoparse(comment["created"])
                time_since_creation = current_time - created_time
                time.append(time_since_creation)

                days = time_since_creation.days
                hours = time_since_creation.seconds // 3600
                minutes = (time_since_creation.seconds // 60) % 60
                seconds = time_since_creation.seconds % 60

                if days != 0:
                    new.append(f"{days} days")
                
                    print(f"_________ {new}")
                elif days==0 and hours!=0:
                    new.append(f"{hours} hrs")
                    print(f"_________ {new}")
                elif days==0 and hours == 0 and minutes!=0:
                    new.append(f"{minutes} min")
                    print(f"_________ {new}")
                elif days==0 and hours == 0 and minutes==0 and seconds!=0:
                    new.append(f"{seconds} sec")
                    print(f"_________ {new}")

            return Response(response, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error.'}, status=status.HTTP_400_BAD_REQUEST)
        
    
    def post(self, request, *args, **kwargs):
        try:
            print(request.data['uID'])
            feedback(
                user_id_id= str(request.data['uID']),
                provider_id_id = str(request.data['pID']),
                comment = request.data['comment'],
            ).save()
            return Response({'message': 'Thank you for the feedback.'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error.'}, status=status.HTTP_400_BAD_REQUEST)


