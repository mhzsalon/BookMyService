# from django.shortcuts import render
# from rest_framework.decorators import APIView
# from rest_framework.permissions import IsAuthenticated
# from rest_framework.response import Response
# from rest_framework import status
# from .models import Booking

# # Create your views here.
# class BookRoom(APIView):
#     permission_classes = (IsAuthenticated,)

#     def post(self, request, *args, **kwargs):
#         try:
            
#             Booking(
#                 user_id=request.user,
#                 serviceDate = request.data['serviceDate'],
#                 location = request.data['location'],
#                 price = request.data['price'],
#                 time = request.data['time']
#                 booking_status = True,
#             ).save()

#             return Response({'message': 'Your room has been booked successfully'}, status=status.HTTP_200_OK)
#         except:
#             return Response({'message': 'Something went wrong!'}, status=status.HTTP_400_BAD_REQUEST)