from django.urls import path, re_path
from websites  import views
from django.conf.urls.static import static
from django.conf import settings
from django.views.generic.base import RedirectView

##from .views_chat import chat_response
##from .list_assistants import list_assistants
##from .testassistant import testAssistant


app_name = 'websites'

urlpatterns = [
path('', RedirectView.as_view(url='https://dentidelil-international.com/en/', permanent=True), name='home'),
path('masonry/', views.masonry_view, name='masonry'),
path('grid/', views.grid_view, name='grid'),
path('about/', views.about_view, name='about'),
path('blog/', views.blog_view, name='blog'),
path('single-post/', views.single_post_view, name='single-post'),
path('innovation/', views.innovation_view, name='innovation'),
path('whyturkey/', views.whyturkey_view, name='whyturkey'),
path('whybeyond/', views.whybeyond_view, name='whybeyond'),
path('dentaslan/', views.dentaslan_view, name='dentaslan'),
path('HT/', views.HT_view, name='HT'),
path('estetik/', views.estetik_view, name='estetik'),
path('comingsoon/', views.comingsoon_view, name='comingsoon'),
path('dashboard/', views.dashboard_view, name='dashboard'),
path('dentaslanFR/', views.dentaslanFR_view, name='dentaslanFR'),
path('tooth-model/', views.tooth_model_view, name='tooth_model'),


    #path('chat_response/', chat_response, name='chat_response'),
    #path('list_assistants/', list_assistants, name='list_assistants'),
    #path('testAssistant/', testAssistant , name='test_assistant_view'),
path('set_language/', views.set_language, name='set_language'),
    # Language switcher
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
    
