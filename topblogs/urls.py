# topblogs/urls.py

from django.urls import path
from . import views
from django.conf import settings

app_name = 'topblogs'


urlpatterns = [
    path('dashboard/', views.dashboard_view, name='dashboard'),
    path('estetik/', views.estetik_view, name='estetik'),
    path('ht/', views.ht_view, name='ht'),
    path('internalsurgeries/', views.internal_surgeries_view, name='internal_surgeries'),
    path('', views.tbindex_view, name='tbindex'),
    path('whybeyond/', views.whybeyond_view, name='whybeyond'),
    path('whyturkey/', views.whyturkey_view, name='whyturkey'),
    path('set_language/', views.set_language, name='set_language'),

]
