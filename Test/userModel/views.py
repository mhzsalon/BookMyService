
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from rest_framework.authtoken.models import Token
from django.db.models.query_utils import Q

from rest_framework.response import Response
from rest_framework import status
from .models import CustomUser, ServiceProvider, Service
from rest_framework.decorators import APIView
from .serializer import UserSerializer, LoginSerializer
from django.contrib.auth import authenticate, login, logout
from rest_framework_simplejwt.tokens import RefreshToken

# Create your views here.
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
                # refresh = RefreshToken.for_user(user)
                login(request, user)
                print("login")

                userDetail = CustomUser.objects.get(email=email)
                serializer = LoginSerializer(userDetail, many=False)
            
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response({"message": "User doesnot exist", }, status=status.HTTP_400_BAD_REQUEST)
            
            # return Response({"message": "Login Successful", }, status=status.HTTP_200_OK)

        except:
            return Response({"message": "Email or password doesn't match!", }, status=status.HTTP_400_BAD_REQUEST)


class UserRegistration(APIView):
    
    def post(self, request, *args, **kwargs):
        phone =  request.data['phone']
        email= request.data['email']
        password= request.data['password']
        name= request.data['name']
        location= request.data['location']
        gender = request.data['gender']
        user_type= request.data['user_type']

        print(password)
        print(request.data['user_type'])

        # user_type = request.data['user_type']

        # print(user_type)
        # if user_type=='2':
        #             print("hello Service)))))))))))))))0")  
        # print(request.data['service'])
        # ser = Service.objects.get(service_id = request.data['service'])
        # print(ser)


        try:
            if CustomUser.objects.filter(email=email).exists():
                return Response({'message': 'Email already taken!'}, status=status.HTTP_400_BAD_REQUEST)
            elif CustomUser.objects.filter(phone=phone).exists():
                return Response({'message': 'Phone number already taken!'}, status=status.HTTP_400_BAD_REQUEST)
            else:
               
                if user_type == 'Clients':
                      user = CustomUser.objects.create_user(
                        email= email,
                        password= password,
                        name= name,
                        gender = gender,
                        phone =  phone,
                        location= location, 
                        user_type= user_type
                    ) 
                     
                elif user_type == 'Service Provider':
                    user = CustomUser.objects.create_user(
                        email= email,
                        password= password,
                        name= name,
                        gender = gender,
                        phone =  phone,
                        location= location, 
                        user_type= user_type
                    )  
                    sp_id =CustomUser.objects.latest("id")
                    

                    ServiceProvider.objects.create(
                        service = request.data['service'] ,
                        service_provider = sp_id,
                        price = request.data['price'],
                    )
                     
                #  UserActivation.post(request, user, email)
                serialzer= UserSerializer(user, many=False)
                print(serialzer.data)

            # refresh = tokenGenerator(user)
            
            
            return Response("User created", status=status.HTTP_200_OK)    
           
        except Exception as e:
            print(e)
            return Response({'message': 'Error.'}, status=status.HTTP_400_BAD_REQUEST)

