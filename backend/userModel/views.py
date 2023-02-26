

from rest_framework.response import Response

from django.db.models.query_utils import Q
from rest_framework.permissions import IsAuthenticated


from rest_framework.response import Response
from rest_framework import status
from .models import CustomUser
from rest_framework.decorators import APIView
from .serializers import UserSerializer, UserVerifySerializer
from django.contrib.auth import authenticate, login, logout
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.sites.shortcuts import get_current_site
from django.utils.http import urlsafe_base64_encode, urlsafe_base64_decode
from django.utils.encoding import force_bytes, force_str
from django.core.mail import EmailMessage
from django.contrib import messages
from django.template.loader import render_to_string
from django.contrib.auth import get_user_model

#user registration
class UserRegistration(APIView):
    
    def post(self, request, *args, **kwargs):
        name = request.data['name']
        gender = request.data['gender']
        phone =  request.data['phone']
        location = request.data['location']
        email= request.data['email']


        try:
            if CustomUser.objects.filter(email=email).exists():
                return Response({'message': 'Email already taken!'}, status=status.HTTP_400_BAD_REQUEST)
            elif CustomUser.objects.filter(phone=phone).exists():
                return Response({'message': 'Phone number already taken!'}, status=status.HTTP_400_BAD_REQUEST)
            else:
                 user = CustomUser.objects.create_user(
                    email= request.data['email'],
                    password= request.data['password'],
                    name= name,
                    gender = gender,
                    phone  =phone,
                    location= location,    
                    # is_staff = False,
                    # is_active = False,
                    # is_verified = False,           
                )                 
            

            return Response({'message': 'User Created.'}, status=status.HTTP_200_OK)    
           
        except:
            return Response({'message': 'Error.'}, status=status.HTTP_400_BAD_REQUEST)


# user login
class UserLogin(APIView):
    def get(self, request):
        userDetail = CustomUser.objects.all()
        serializer = UserSerializer(userDetail, many=True)
        return Response(serializer.data)
    
    def post(self, request, *args, **kwargs):
        if request.method == 'POST':
            print("working")
            email = request.data['email']
            password = request.data['password']
            
        try:
            print(email)
            print(password)
            user = authenticate(
                username=email, 
                password=password
                )
            print(user)
            if user is not None:
                login(request, user)
                print("login")

                userDetail = CustomUser.objects.get(email=email)
                serializer = UserSerializer(userDetail, many=False)

                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response({"message": "User doesnot exist", }, status=status.HTTP_400_BAD_REQUEST)
            
            # return Response({"message": "Login Successful", }, status=status.HTTP_200_OK)

        except:
            return Response({"message": "Email or password doesn't match!", }, status=status.HTTP_400_BAD_REQUEST)


#change password
class ChangePW(APIView):
    # permission_classes = (IsAuthenticated)

    def put(self, request, *args, **kwargs):
        data = request.data
        try:
            newpw = data['password']
            repw = data['repassword']
            if newpw == repw:
                userdata = CustomUser.objects.get(email=request.user)
                userdata.set_password(newpw)
                userdata.save()
                return Response({"message": "The password has been reset!", }, status=status.HTTP_200_OK, )
            else:
                return Response({"message": "Password does not match", }, status=status.HTTP_406_NOT_ACCEPTABLE, )
        except:
            return Response({
                "message": "Error!",
            },
                status=status.HTTP_400_BAD_REQUEST, )
        
def logout(request):
    try:
        logout(request)
        return Response({
                "message": "User logged out.",
            },
                status=status.HTTP_200_OK, )
    except:
        return Response({
                "message": "Error!",
            },
                status=status.HTTP_502_BAD_GATEWAY )

class UpdateDetails(APIView):
    permission_classes = (IsAuthenticated)

    def put(self, request, *args, **kwargs):
        try:
            user_detail = CustomUser.objects.get(email=request.user)
            if request.data['name'] is not None and request.data['name'] != '':
                user_detail.name = request.data['name']
            if request.data['gender'] is not None and request.data['gender'] != '':
                user_detail.gender = request.date['gender']
            if request.data['phone'] is not None and request.data['phone'] != '':
                user_detail.phone = request.date['phone']
            if request.date['location'] is not None and request.date['location'] != '':
                user_detail.address = request.date['location']
            user_detail.save()
            return Response({"message": "The details has been updated!", }, status=status.HTTP_200_OK, )
        except:
            return Response({
                "message": "Error!",
            },
                status=status.HTTP_400_BAD_REQUEST, )

    def get(self, request, *args, **kwargs):
        userData = CustomUser.objects.get(email=request.user)
        serializer = UserSerializer(userData, many=False)
        return Response(serializer.data, status=status.HTTP_200_OK)