from django.urls import path
from . import views
from . import scheduleview
from django.conf import settings


app_name = 'employee'

urlpatterns = [
    
    path('set_language/', views.set_language, name='set_language'),

    
    path('dashboard/', views.dashboard, name="dashboard"),
    path('attendance/', views.attendance, name="attendance"),
    path('notice/', views.notice, name="notice"),
    path('noticedetail/<str:id>/', views.noticedetail, name="noticedetail"),
    path('assignwork/', views.assignWork, name="assignwork"),
    path('mywork/', views.mywork, name="mywork"),
    path('workdetails/<str:wid>/', views.workdetails, name="workdetails"),
    path('editAW/', views.assignedworklist, name="assignedworklist"),
    path('deletework/<str:wid>/', views.deletework, name="deletework"),
    path('updatework/<str:wid>/', views.updatework, name="updatework"),
    path('makeRequest/', views.makeRequest, name="makeRequest"),
    path('viewRequest/', views.viewRequest, name="viewRequest"),
    path('requestdetails/<str:rid>/', views.requestdetails, name="requestdetails"),
    path('virtual-reality/', views.virtual_reality, name='virtual-reality'),
    path('profile/', views.profile, name='profile'),
   # path('messages/', views.messages, name='messages'),
    path('upload/', views.upload_employee_file, name='employee_file_upload'),


    
    # Employee Schedule Views
    path('my-schedule/', scheduleview.employee_schedule_view, name='employee-schedule'),

    # Admin Schedule Views
    path('admin/schedules/', scheduleview.admin_manage_schedules, name='admin-manage-schedules'),
    path('admin/schedules/edit/<int:schedule_id>/', scheduleview.edit_schedule, name='edit-schedule'),
    path('admin/schedules/delete/<int:schedule_id>/', scheduleview.delete_schedule, name='delete-schedule'),
]

