from django.shortcuts import render, redirect
from django.http import HttpResponse

from userModel.models import CustomUser, ServiceProvider
from django.contrib import messages
from .forms import CustomUserForm, ServiceProviderForm
from django.contrib.auth. models import auth
from django.contrib.auth.decorators import login_required
from booking.models import Booking
from payment.models import Payment


def loginPage(request):
    try:
        if request.user.is_authenticated:
                return redirect('dashboard/')
        else:
            if request.method == 'POST':
                username = request.POST['username']
                password = request.POST['password']

                admin = CustomUser.objects.get(email=username)

                if admin.user_type == 'Admin':
                    users = auth.authenticate(username=username, password=password)

                    if users is not None:
                        auth.login(request, users)
                        return redirect('dashboard/')
                    else:
                        messages.error(request, "Invalid user or password!")
                        return redirect('/')
                else:
                    return HttpResponse("You are not authorized to this page.")
            else:
                return render(request, 'login.html')
    except:
        messages.error(request, "Invalid user or password!")
        return redirect('/')


@login_required(login_url='/')
def dashboard(request):
    userCount = CustomUser.objects.filter(user_type='Clients').count()
    spCount = CustomUser.objects.filter(user_type='Service Provider').count()
    bkCount = Booking.objects.all().count()


    response = {
        'userCount': userCount,
        'spCount': spCount,
               'title': 'Dashboard',
               'bkCount': bkCount,

    }

    return render(request, 'dashboard.html', response)

def logoutUser(request):
    auth.logout(request)
    return redirect('/')

@login_required(login_url='/')
def addUser(request):
    form = CustomUserForm

    if request.method == 'POST':
        pw = request.POST['password']
        confirm_pw = request.POST['confirm_password']

        if pw == confirm_pw:
            form = CustomUserForm(request.POST)
            email = form['email'].value
            print(email)
            if CustomUser.objects.filter(email=email).exists():
                messages.error(request, 'Email already exists!')
                return redirect('../user/') 
            else: 
                if form.is_valid():
                        user_instance=form.save(commit=False)
                        user_instance.password = pw
                        user_instance.user_type = 'Clients'
                        user_instance.is_active=True
                        user_instance.save()
                        return redirect('../user/')    
                    
        else:
            messages.info(request, 'Your password does not match.')


    userData = CustomUser.objects.filter(user_type='Clients')
    context = {'form': form,
               'userData': userData,
               'title': 'Users'
               }
    return render(request, 'user.html', context)


@login_required(login_url='/')
def addSp(request):
    form = CustomUserForm
    sp_form = ServiceProviderForm

    if request.method == 'POST':
        pw = request.POST['password']
        confirm_pw = request.POST['confirm_password']
        if pw == confirm_pw:
            form = CustomUserForm(request.POST)
            sp_form = ServiceProviderForm(request.POST)

            if form.is_valid():
                user_instance=form.save(commit=False)
                user_instance.user_type = 'Service Provider'
                user_instance.password = pw
                user_instance.is_active=True
                user_instance.save()

                new_sp = ServiceProvider.objects.latest('id')
                print(new_sp)

            if sp_form.is_valid():
                instance = sp_form.save(commit=False)
                instance.service_provider = new_sp.id
                instance.save()
            return redirect('../service-provider')
        else:
            messages.info(request, 'Your password does not match.')

    userData = CustomUser.objects.filter(user_type='Service Provider')
    spData = ServiceProvider.objects.all()
   
    context = {
               'form': form,
               'sp_form': sp_form,
               'userData': userData,
               'spData': spData,
               'title': 'Service Providers'
               }
    return render(request, 'service_provider.html', context)

@login_required(login_url='/')
def deleteUser(request, pk):
    uid = CustomUser.objects.get(id=pk)
    uid.delete()
    return redirect('user/')    

@login_required(login_url='/')
def getBooking(request):
    booking_detail=Booking.objects.all()
    print(booking_detail)
    context = {
               'booking_detail': booking_detail,
         
               'title': 'Booking Details'
               }
    return render(request, 'booking.html', context)

@login_required(login_url='/')
def getPayment(request):
    payment=Payment.objects.all()
    context = {
               'payment': payment,
         
               'title': 'Payment Details'
               }
    return render(request, 'payment.html', context)

