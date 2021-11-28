from django.urls import path
from.import views


urlpatterns = [

    path('userlogin', views.userlogin, name='userlogin'),
    path('usersignup', views.usersignup, name='usersignup'),
    path('userlogout', views.userlogout, name='userlogout'),
    path('signinotp', views.signinotp, name='signinotp'),
    path('otpcheck', views.otpcheck, name='otpcheck'),
    path('confirm_signup', views.confirm_signup, name='confirm_signup'),
    path('resent_otp', views.resent_otp, name='resent_otp'),
    path('userdashboard/', views.userdashboard, name='userdashboard'),
    path('my_orders/',views.my_orders,name='my_orders'),
    path('edit_profile/', views.edit_profile, name='edit_profile'),
    path('change_password/', views.change_password, name='change_password'),
    path('order_detail/<int:order_id>/',views.order_detail,name='order_detail'),
    path('cancel_order/<int:pk>/',views.cancel_order,name='cancel_order'),
    path('add_address', views.add_address, name='add_address'),
    path('edit-address/<int:pk>/', views.edit_address, name='edit-address'),
    path('delete-address/<int:pk>/', views.delete_address, name='delete-address'),
    path('set-default-address/<int:pk>/', views.set_default_address, name='set-default-address'),
    

]
