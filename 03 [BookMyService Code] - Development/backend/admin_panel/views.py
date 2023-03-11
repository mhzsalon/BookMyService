from django.shortcuts import render, redirect
from django.http import HttpResponse

from userModel.models import CustomUser, ServiceProvider
from django.contrib import messages
from .forms import CustomUserForm, ServiceProviderForm
from django.contrib.auth. models import auth
from django.contrib.auth.decorators import login_required


def loginPage(request):
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



@login_required(login_url='login')
def dashboard(request):
    userCount = CustomUser.objects.filter(user_type='Clients').count()
    spCount = CustomUser.objects.filter(user_type='Service Provider').count()

    response = {
        'userCount': userCount,
        'spCount': spCount,
               'title': 'Dashboard'

    }

    return render(request, 'dashboard.html', response)

def logoutUser(request):
    auth.logout(request)
    return redirect('/')

@login_required(login_url='login')
def addUser(request):
    form = CustomUserForm

    if request.method == 'POST':
        pw = request.POST['password']
        confirm_pw = request.POST['confirm_password']
        if pw == confirm_pw:
            form = CustomUserForm(request.POST)
            if form.is_valid():
                user_instance=form.save(commit=False)
                user_instance.password = pw
                user_instance.user_type = 'Clients'
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


@login_required(login_url='login')
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
                print("--------------------")
                new_sp = ServiceProvider.objects.latest('id')
                print(new_sp)

                if sp_form.is_valid():
                    instance = sp_form.save(commit=False)
                    instance.service_provider = new_sp
                    instance.save()
                    return redirect('../service-provider')
        else:
            messages.info(request, 'Your password does not match.')

    userData = CustomUser.objects.filter(user_type='Service Provider')
    spData = ServiceProvider.objects.all()
    for i in spData:
        print(i.service_provider.email)
    context = {
               'form': form,
               'sp_form': sp_form,
               'userData': userData,
               'spData': spData,
               'title': 'Service Providers'


               }
    return render(request, 'service_provider.html', context)

