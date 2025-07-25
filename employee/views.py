# Standard library imports
import os
from datetime import datetime
import json
import time
import ast

# Django imports
from django.conf import settings
from django.shortcuts import redirect, render, get_object_or_404
from django.contrib import messages
from .forms import WorkForm, MakeRequestForm , EmployeeProfileForm, EmployeeFileUploadForm
from employee.models import Employee, Attendance, Notice, WorkAssignment, Request, SalaryDetails, WorkSchedule, flattened_designations, EmployeeFile
from django.contrib.auth.decorators import login_required
from django.utils.translation import get_language, activate
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.models import Group
from django_countries.fields import CountryField
from django.utils.http import url_has_allowed_host_and_scheme

 
def set_language(request):
    next_url = request.POST.get('next', request.GET.get('next'))
    if not next_url or not url_has_allowed_host_and_scheme(url=next_url, allowed_hosts={request.get_host()}):
        next_url = request.META.get('HTTP_REFERER', '/')

    response = redirect(next_url)
    lang_code = request.POST.get('language', request.GET.get('language'))
    if lang_code and lang_code in dict(settings.LANGUAGES).keys():
        if hasattr(request, 'session'):
            request.session['django_language'] = lang_code
        response.set_cookie(settings.LANGUAGE_COOKIE_NAME, lang_code)
        activate(lang_code)  # Activate the language immediately for the current request

    # Debugging output
    print(f"Session language: {request.session.get('django_language')}")
    print(f"Cookie language: {request.COOKIES.get(settings.LANGUAGE_COOKIE_NAME)}")
    print(f"Current language: {get_language()}")

    return response

# Dashboard view
@login_required(login_url='/')
def dashboard(request):
    # Use username or email to filter employees
    employee = Employee.objects.filter(username=request.user.username).first()
    return render(request, "employee/index.html", {'employee': employee})

# Attendance view
@login_required(login_url='/')
def attendance(request):
    # Fetch Attendance for the current employee by filtering with the 'username'
    employee = Employee.objects.get(username=request.user.username)
    attendance = Attendance.objects.filter(employee=employee)
    return render(request, "employee/attendance.html", {"attendance": attendance})

# Notice view
@login_required(login_url='/')
def notice(request):
    notices = Notice.objects.all()
    return render(request, "employee/notice.html", {"notices": notices})

# Notice detail view
@login_required(login_url='/')
def noticedetail(request, id):
    # Fetch the notice by its ID
    noticedetail = get_object_or_404(Notice, noticeId=id)
    return render(request, "employee/noticedetail.html", {"noticedetail": noticedetail})

# Assign work view
@login_required(login_url='/')
def assignWork(request):
    context = {}
    employee = Employee.objects.get(username=request.user.username)
    initialData = {
        "assignerId": employee.id,
    }
    flag = ""
    form = WorkForm(request.POST or None, initial=initialData)
    if form.is_valid():
        currentTaskerId = form.cleaned_data["taskerId"]
        if currentTaskerId == employee.id:
            flag = "Invalid ID Selected..."
        else:
            flag = "Work Assigned Successfully!!"
            form.save()
    context['form'] = form
    context['flag'] = flag
    return render(request, "employee/workassign.html", context)

# View my work
@login_required(login_url='/')
def mywork(request):
    # Fetch the employee and their assigned work
    employee = Employee.objects.get(username=request.user.username)
    work = WorkAssignment.objects.filter(taskerId=employee)
    return render(request, "employee/mywork.html", {"work": work})

# Work details view
@login_required(login_url='/')
def workdetails(request, wid):
    # Fetch work assignment details by ID
    workdetails = get_object_or_404(WorkAssignment, id=wid)
    return render(request, "employee/workdetails.html", {"workdetails": workdetails})

# Make request view
@login_required(login_url='/')
def makeRequest(request):
    context = {}
    employee = Employee.objects.get(username=request.user.username)
    initialData = {
        "requesterId": employee.id,
    }
    flag = ""
    requestForm = MakeRequestForm(request.POST or None, initial=initialData)
    if request.method == 'POST' and requestForm.is_valid():
        currentRequesterId = requestForm.cleaned_data["destinationEmployeeId"]
        if currentRequesterId == employee.id:
            flag = "Invalid ID Selected..."
        else:
            flag = "Request Submitted"
            requestForm.save()

    context['requestForm'] = requestForm
    context['flag'] = flag
    return render(request, "employee/request.html", context)

# View requests made to the employee
@login_required(login_url='/')
def viewRequest(request):
    # Fetch employee's incoming requests
    employee = Employee.objects.get(username=request.user.username)
    requests = Request.objects.filter(destinationEmployeeId=employee)
    return render(request, "employee/viewRequest.html", {"requests": requests})

# Request details view
@login_required(login_url='/')
def requestdetails(request, rid):
    # Fetch specific request details by ID
    requestdetail = get_object_or_404(Request, id=rid)
    return render(request, "employee/requestdetails.html", {"requestdetail": requestdetail})

# List of assigned works by the employee
@login_required(login_url='/')
def assignedworklist(request):
    # Fetch works assigned by the logged-in user
    employee = Employee.objects.get(username=request.user.username)
    works = WorkAssignment.objects.filter(assignerId=employee)
    return render(request, "employee/assignedworklist.html", {"works": works})

# Delete work assignment
@login_required(login_url='/')
def deletework(request, wid):
    # Delete the work assignment
    obj = get_object_or_404(WorkAssignment, id=wid)
    obj.delete()
    return redirect('assignedworklist')

# Update work assignment
@login_required(login_url='/')
def updatework(request, wid):
    # Fetch and update a specific work assignment
    work = get_object_or_404(WorkAssignment, id=wid)
    form = WorkForm(request.POST or None, instance=work)
    flag = ""
    if form.is_valid():
        currentTaskerId = form.cleaned_data["taskerId"]
        employee = Employee.objects.get(username=request.user.username)
        if currentTaskerId == employee.id:
            flag = "Invalid ID Selected..."
        else:
            flag = "Work Updated Successfully!!"
            form.save()
    return render(request, "employee/updatework.html", {'currentWork': work, "filledForm": form, "flag": flag})


@login_required
def virtual_reality(request):
   return render(request, 'virtual-reality.html')

@login_required
def profile(request):
    user = request.user  # Get the logged-in user
    
    if request.method == 'POST':
        profile_form = EmployeeProfileForm(request.POST, request.FILES, instance=user)
        file_form = EmployeeFileUploadForm(request.POST, request.FILES)

        if profile_form.is_valid():
            profile_form.save()  # Update employee's profile

        if file_form.is_valid():
            employee_file = file_form.save(commit=False)  # Don't commit the save yet
            employee_file.employee = user  # Associate the file with the current employee
            employee_file.save()  # Save it to the database
            messages.success(request, 'Profile updated and file uploaded successfully.')
            return redirect('profile')  # Redirect to the profile page after successful update
        else:
            messages.error(request, 'There was an error uploading the file.')

    else:
        profile_form = EmployeeProfileForm(instance=user)
        file_form = EmployeeFileUploadForm()

    # Query the files (e.g., profile picture, CV, etc.)
    profile_picture = EmployeeFile.objects.filter(employee=user, file_type='profile_picture').first()
    cv = EmployeeFile.objects.filter(employee=user, file_type='cv').first()
    
    context = {
        'profile_form': profile_form,
        'file_form': file_form,
        'profile_picture': profile_picture,
        'cv': cv,
        'uploaded_files': EmployeeFile.objects.filter(employee=user),
    }

    return render(request, 'profile (2).html', context)

#@login_required
#def messages(request, error=None):
 #   
  #  return render(request, 'messages.html', context)


@login_required
def upload_employee_file(request):
    if request.method == 'POST':
        file_form = EmployeeFileUploadForm(request.POST, request.FILES)
        
        if file_form.is_valid():
            # Create the instance but don't save it yet
            employee_file = file_form.save(commit=False)
            
            # Set the employee field to the current logged-in user
            employee_file.employee = request.user
            
            # Save the instance to the database
            employee_file.save()
            
            # Provide success message
            messages.success(request, 'File uploaded successfully.')
            return redirect('employee:profile')  # Redirect to the appropriate page

        else:
            messages.error(request, 'There was an error uploading the file.')
    
    else:
        file_form = EmployeeFileUploadForm()

    return render(request, 'upload_file.html', {'file_form': file_form})
