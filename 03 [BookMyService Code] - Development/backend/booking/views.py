from django.utils import timezone
from django.shortcuts import render
from rest_framework.decorators import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import Booking
from userModel.models import ServiceProvider, CustomUser
from .serializer import BookingSerializer, BookingHistorySerializer
from payment.models import Payment
from payment.serializer import PaymentSerializer

# # Create your views here.
class BookService(APIView):
    # permission_classes = (IsAuthenticated,)
    def get(self,request):
        bID = Booking.objects.latest('id')
        serailizer = BookingSerializer(bID, many=False)

        return Response(serailizer.data, status=status.HTTP_200_OK)


    def post(self, request, *args, **kwargs):
        try:
            spID = request.data['sp_id']
            count = ServiceProvider.objects.get(id=spID)
            uID = CustomUser.objects.get(id=request.data['id'])
            print(spID)

            serviceDate = request.data['serviceDate']
            startTime = request.data['start_time']
            endTime = request.data['end_time']

            conflicting_bookings = Booking.objects.filter(
                    serviceProvider_id_id=spID,
                    serviceDate=serviceDate,
                    start_time=startTime,
                    end_time=endTime,
                )
            
            if conflicting_bookings.exists():
                return Response({'message': 'This service provider is already booked at the given time.'}, status=status.HTTP_306_RESERVED)
            
            Booking(
                user_id_id=request.data['id'],
                serviceProvider_id_id = spID,
                serviceDate = request.data['serviceDate'],
                location = request.data['location'],
                price = request.data['price'],
                start_time = request.data['start_time'],
                end_time = request.data['end_time'],
                booking_status = True,
                requirement=request.data['requirements']
                # ServiceProvider_id_booking_count =+1
            ).save()

            count = ServiceProvider.objects.get(id=spID)
            count.booking_count += 1
            count.save()


            return Response({'message': 'Your room has been booked successfully'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Something went wrong!'}, status=status.HTTP_400_BAD_REQUEST)
        

class BookingHistory(APIView):
    def get(self, request):
        try:
            if request.query_params.get('user') == "Clients":
                b_details = Booking.objects.filter(user_id= request.query_params.get('uid'))
                serailizer = BookingHistorySerializer(b_details, many=True)
                p_detail = Payment.objects.filter(user_id=request.query_params.get('uid'))
            
                pSerializer = PaymentSerializer(p_detail, many=True)

                response = {
                    'booking': serailizer.data,
                    'payment': pSerializer.data
            }
                return Response(response, status=status.HTTP_200_OK)
            else:         
                b_details = Booking.objects.filter(serviceProvider_id= request.query_params.get('sp'))
                serailizer = BookingHistorySerializer(b_details, many=True)
                return Response(serailizer.data, status=status.HTTP_200_OK)


        except Exception as e:
            print (e)
            return Response({'message': 'Something went wrong!'}, status=status.HTTP_400_BAD_REQUEST)