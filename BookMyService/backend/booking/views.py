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

import datetime
from dateutil import parser, tz

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
                requirement=request.data['requirements'],
                # ServiceProvider_id_booking_count =+1
            ).save()

            count = ServiceProvider.objects.get(id=spID)
            count.booking_count += 1
            count.save()


            return Response({'message': 'Your service has been booked successfully'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Something went wrong!'}, status=status.HTTP_400_BAD_REQUEST)
        

class BookingHistory(APIView):
    def get(self, request):
        try:
            data = []
            pData = []
            p_detail = Payment.objects.all()
            pSerializer = PaymentSerializer(p_detail, many=True)
            pData = pSerializer.data
            
                
            if request.query_params.get('user') == "Clients":
                b_details = Booking.objects.filter(user_id= request.query_params.get('uid'))
                serailizer = BookingHistorySerializer(b_details, many=True)
                data = serailizer.data

            else:    
                b_details = Booking.objects.filter(serviceProvider_id= request.query_params.get('sp'))
                serailizer = BookingHistorySerializer(b_details, many=True)
                data = serailizer.data
                # return Response(serailizer.data, status=status.HTTP_200_OK)
            
            previous = []
            # payment = []
            current_time = datetime.datetime.now(datetime.timezone.utc)
            for booking in data:
                # Parse the service date and end time
                service_date = parser.isoparse(booking["serviceDate"]).date()
                end_time = datetime.datetime.strptime(booking["end_time"], "%H:%M:%S").time()

                # Combine the service date and end time into a datetime object
                service_end_datetime = datetime.datetime.combine(service_date, end_time)

                # Convert the service end datetime to an offset-aware datetime in UTC
                service_end_datetime_utc = datetime.datetime.combine(service_date, end_time, tzinfo=tz.UTC)

                # Check if the service end datetime in UTC is in the past compared to the current time
                if request.query_params.get('time') == "previous":

                    if service_end_datetime_utc < current_time:
                        previous.append(booking)
                else:
                     if service_end_datetime_utc > current_time:
                        previous.append(booking)
                        # for p in pData:
                        #     if p['booking_id'] == booking['id']:
                        #         payment.append(p)
                
            response = {
                'booking': previous,
                'payment':pData
            }
            return Response(response, status=status.HTTP_200_OK)




        except Exception as e:
            print (e)
            return Response({'message': 'Something went wrong!'}, status=status.HTTP_400_BAD_REQUEST)