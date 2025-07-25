from django import forms
from .models import Employee, WorkAssignment, Request, WorkSchedule, DaySchedule, EmployeeFile

# Form for WorkAssignment
class WorkForm(forms.ModelForm):
    class Meta:
        model = WorkAssignment
        widgets = {
            "assignDate": forms.DateInput(attrs={'type': 'datetime-local'}),
            "dueDate": forms.DateInput(attrs={'type': 'datetime-local'}),
        }
        labels = {"assignerId": "Select Your ID"}
        fields = [
            "assignerId",
            "work",
            "assignDate",
            "dueDate",
            "taskerId",
        ]

# Form for Request
class MakeRequestForm(forms.ModelForm):
    class Meta:
        model = Request
        widgets = {
            "requestDate": forms.DateInput(attrs={'type': 'datetime-local'}),
        }
        labels = {"requesterId": "Select Your ID"}
        fields = [
            "requesterId",
            "requestMessage",
            "requestDate",
            "destinationEmployeeId",
        ]

# Form for managing individual day schedules
class DayScheduleForm(forms.ModelForm):
    class Meta:
        model = DaySchedule
        fields = ['day_of_week', 'active', 'start_time', 'end_time', 'work_type']

# WorkSchedule form doesn't need individual days anymore
class WorkScheduleForm(forms.ModelForm):
    class Meta:
        model = WorkSchedule
        fields = ['employee']  # Only the employee field


class EmployeeProfileForm(forms.ModelForm):
    class Meta:
        model = Employee
        fields = ['name', 'nationality', 'email', 'phone_number', 'bank_account', 'account_holder', 'address', 'notes']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control form-control-lg'}),
            'nationality': forms.Select(attrs={'class': 'form-control form-control-lg'}),
            'email': forms.EmailInput(attrs={'class': 'form-control form-control-lg'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control form-control-lg'}),
            'bank_account': forms.TextInput(attrs={'class': 'form-control form-control-lg'}),
            'account_holder': forms.TextInput(attrs={'class': 'form-control form-control-lg'}),
            'address': forms.Textarea(attrs={'class': 'form-control form-control-lg', 'rows': 3}),
            'notes': forms.Textarea(attrs={'class': 'form-control form-control-lg', 'rows': 5}),
        }


class EmployeeFileUploadForm(forms.ModelForm):
    class Meta:
        model = EmployeeFile
        fields = ['file_type', 'file']
        widgets = {
            'file_type': forms.Select(attrs={'class': 'form-control form-control-lg'}),
            'file': forms.ClearableFileInput(attrs={'class': 'form-control form-control-lg'}),
        }
