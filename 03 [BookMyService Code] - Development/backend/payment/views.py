from django.shortcuts import render
from .models import Payment
from rest_framework import status

from rest_framework.decorators import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from userModel.serializer import SpSerializer, ServiceProvider
from .serializer import PaymentSerializer

# Create your views here.
class servicePayment(APIView):
    # permission_classes= [IsAuthenticated]
    def get(self, request):
        spID = ServiceProvider.objects.get(service_provider= request.query_params.get('id'))
        serial = SpSerializer(spID, many=False)
        return Response(serial.data,status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        try:
            b_id = str(request.data['booking_id'])
            uID = str(request.data['uID'])
            payment_type = str(request.data['payment_mode'])
            print(request.data['amount'])

            amt =  request.data['amount']
            paid= True

            if payment_type == 'Cash':
                paid = False

            Payment(
                user_id_id=uID,
                booking_id_id= b_id,
                payment_mode = payment_type,
                is_paid = paid,
                amount = amt
                ).save()
                
            return Response({'message': 'Payment Successfull'},status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error'},status=status.HTTP_400_BAD_REQUEST)
        
    def put(self, request, *args, **kwargs):
        try:
            bID = request.query_params.get('id')

            cashPayment=Payment.objects.get(booking_id= bID)
            cashPayment.is_paid=True
            cashPayment.save()

            return Response({'message': 'Payment Successfull'},status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error'},status=status.HTTP_400_BAD_REQUEST)

        