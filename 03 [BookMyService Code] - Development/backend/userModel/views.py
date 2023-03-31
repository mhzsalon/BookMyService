
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response


from rest_framework.response import Response
from rest_framework import status
from .models import CustomUser, ServiceProvider

from rest_framework.decorators import APIView
from .serializer import UserSerializer, LoginSerializer, SpSerializer, StatusSerializer
from django.contrib.auth import authenticate, login, logout

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


class getSP(APIView):
    def get(self,request):
        try:
            # print(request.query_params.get('service'))
            sp_details = ServiceProvider.objects.filter(service=request.query_params.get('service'))
            # sp_details = ServiceProvider.objects.all()


            print(request.query_params.get('service'))
           

            serializer = SpSerializer(sp_details, many=True)
            print(serializer.data)


            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({'message': 'Error!'}, status=status.HTTP_404_NOT_FOUND)

def delete(request):
        try:
            delete_user= CustomUser.objects.get(id=request.query_params.get('id'));
            print(delete_user)
            delete_user.delete()
        except:
            return Response({'message': 'User not found.'}, status=status.HTTP_404_NOT_FOUND)
 

class activateUser(APIView):
    def get(self, request):
        activate = ServiceProvider.objects.get(service_provider__email=request.query_params.get('email'))
        serializer = StatusSerializer(activate, many=False)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def put(self,request):
        try:
            # uID = request.user
            activate = ServiceProvider.objects.get(service_provider__email=request.query_params.get('email'))
            print(activate)
            activate.active_status=True
            activate.save()
            serializer = StatusSerializer(activate, many=False)

            return Response({'message': 'User activated'}, status=status.HTTP_200_OK)

        except Exception as e:
                print(e)
                return Response({'message': 'Error'}, status=status.HTTP_400_BAD_REQUEST)


class deactivateUser(APIView):
    def put(self,request):
        try:
            # uID = request.user
            activate = ServiceProvider.objects.get(service_provider__email=request.query_params.get('email'))
            print(activate)
            activate.active_status=False
            activate.save()

            return Response({'message': 'User de-activated'}, status=status.HTTP_200_OK)

        except Exception as e:
                print(e)
                return Response({'message': 'Error'}, status=status.HTTP_400_BAD_REQUEST)

class changePw(APIView):
     def put(self, request, *args, **kwargs):
        try:
            uID =request.data['id']
            newpw = request.data['password']
            repw = request.data['repassword']
            print(newpw)
            print(repw)
            if newpw == repw:
                userdata = CustomUser.objects.get(id=uID)
                userdata.set_password(newpw)
                userdata.save()
                return Response({"message": "The password has been reset!", }, status=status.HTTP_200_OK, )
            else:
                return Response({"message": "Password does not match", }, status=status.HTTP_406_NOT_ACCEPTABLE, )
        except Exception as e:
            print(e)
            return Response({'message': 'Error'}, status=status.HTTP_400_BAD_REQUEST)

class updateUser(APIView):
    def put(self, request, *args, **kwargs):
        try:
            user_detail = CustomUser.objects.get(id=request.query_params.get('id'))
            if request.data['name'] is not None and request.data['name'] != '':
                user_detail.name = request.data['name']
            if request.data['email'] is not None and request.data['email'] != '':
                user_detail.email = request.data['email']
            if request.data['phone'] is not None and request.data['phone'] != '':
                user_detail.phone = request.data['phone']
            if request.data['location'] is not None and request.data['location'] != '':
                user_detail.location = request.data['location']
            user_detail.save()
            return Response({"message": "The details has been updated!" }, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response({
                "message": "Error!",
            },
                status=status.HTTP_400_BAD_REQUEST, )

    def get(self, request, *args, **kwargs):
        userData = CustomUser.objects.get(id=request.query_params.get('id'))
        if userData.user_type == 'Service Provider':
            spData= ServiceProvider.objects.get(service_provider=request.query_params.get('id'))
            serializer = SpSerializer(spData, many=False)
            return Response(serializer.data, status=status.HTTP_200_OK)

        else:
            serializer = UserSerializer(userData, many=False)
            return Response(serializer.data, status=status.HTTP_200_OK)
        