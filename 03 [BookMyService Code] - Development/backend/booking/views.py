from django.shortcuts import render
from rest_framework.decorators import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import Booking
from userModel.models import ServiceProvider, CustomUser

# # Create your views here.
class BookService(APIView):
    # permission_classes = (IsAuthenticated,)
    def get(self,request):
        return Response({'message': 'Your room has been booked successfully'}, status=status.HTTP_200_OK)


    def post(self, request, *args, **kwargs):
        try:
            spID = request.data['sp_id']
            count = ServiceProvider.objects.get(id=spID)
            uID = CustomUser.objects.get(id=request.query_params.get('id'))


            Booking(
                user_id_id=uID,
                serviceProvider_id_id = spID,
                serviceDate = request.data['serviceDate'],
                location = request.data['location'],
                price = request.data['price'],
                start_time = request.data['start_time'],
                end_time = request.data['end_time'],
                booking_status = True,
                # ServiceProvider_id_booking_count =+1
            ).save()

            count = ServiceProvider.objects.get(id=spID)
            count.booking_count =+ 1
            count.save()


            return Response({'message': 'Your room has been booked successfully'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Something went wrong!'}, status=status.HTTP_400_BAD_REQUEST)