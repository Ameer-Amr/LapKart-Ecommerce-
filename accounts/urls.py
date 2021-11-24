from django.urls import path
from.import views


urlpatterns = [

    path('userlogin',views.userlogin,name='userlogin'),
    path('usersignup',views.usersignup,name='usersignup'),
    path('userlogout',views.userlogout,name='userlogout'),
    path('signinotp',views.signinotp,name='signinotp'),   
    path('otpcheck',views.otpcheck,name='otpcheck'),
    path('confirm_signup',views.confirm_signup,name='confirm_signup'),
    path('resent_otp',views.resent_otp,name='resent_otp'),
    path('userdashboard',views.userdashboard,name='userdashboard')

]