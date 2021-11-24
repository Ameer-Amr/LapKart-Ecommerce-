from django.urls import path
from.import views


urlpatterns = [ 
    path('adminlogin',views.adminlogin,name='adminlogin'),
    path('signout',views.signout,name='signout'),
    path('dashboard',views.dashboard,name='dashboard'),
    path('productlists',views.productlists,name='productlists'),
    path('varientlists',views.varientlists,name='varientlists'),
    path('addproduct',views.addproduct,name='addproduct'),
    path('addvarient',views.addvarient,name='addvarient'),
    path('brandlists',views.brandlists,name='brandlists'),
    path('activeusers',views.activeusers,name='activeusers'),
    path('categorylists',views.categorylists,name='categorylists'),
    path('addbrand',views.addbrand,name='addbrand'),
    path('addcategory',views.addcategory,name='addcategory'),
    path('deleteproduct/<product_id>',views.deleteproduct,name='deleteproduct'),
    path('editproduct/<product_id>',views.editProduct,name='editproduct'),
    path('editbrand/<brand_id>',views.editbrand,name='editbrand'),
    path('deletebrand/<brand_id>',views.deletebrand,name='deletebrand'),
    path('editcategory/<category_id>',views.editcategory,name='editcategory'),
    path('deletecategory/<category_id>',views.deletecategory,name='deletecategory'),
    path('blockuser/<user_id>',views.blockuser,name='blockuser'),
    path('unblockuser/<user_id>',views.unblockuser,name='unblockuser'),
    path('deleteuser/<user_id>',views.deleteuser,name='deleteuser'),
    path('editvarient/<varient_id>',views.editvarient,name='editvarient'),
    path('deletevarient/<varient_id>',views.deletevarient,name='deletevarient'),
    path('blockvarient/<varient_id>',views.blockvarient,name='blockvarient'),
    path('unblockvarient/<varient_id>',views.unblockvarient,name='unblockvarient'),


]