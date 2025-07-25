from django.contrib import admin
from import_export import resources
from import_export.admin import ImportExportModelAdmin
from .models import Employee, WorkSchedule, DaySchedule, SalaryDetails, SalaryDelivery, AdvancePayment, Attendance, Notice, WorkAssignment, Request, EmployeeFile

# Resource classes for import/export functionality
class EmployeeResource(resources.ModelResource):
    class Meta:
        model = Employee

class EmployeeFileResource(resources.ModelResource):
    class Meta:
        model = EmployeeFile

class WorkScheduleResource(resources.ModelResource):
    class Meta:
        model = WorkSchedule

class DayScheduleResource(resources.ModelResource):
    class Meta:
        model = DaySchedule

class SalaryDetailsResource(resources.ModelResource):
    class Meta:
        model = SalaryDetails

class SalaryDeliveryResource(resources.ModelResource):
    class Meta:
        model = SalaryDelivery

class AdvancePaymentResource(resources.ModelResource):
    class Meta:
        model = AdvancePayment

class AttendanceResource(resources.ModelResource):
    class Meta:
        model = Attendance

class NoticeResource(resources.ModelResource):
    class Meta:
        model = Notice

class WorkAssignmentResource(resources.ModelResource):
    class Meta:
        model = WorkAssignment

class RequestResource(resources.ModelResource):
    class Meta:
        model = Request 

# Inline for DaySchedule in WorkScheduleAdmin
class DayScheduleInline(admin.TabularInline):
    model = DaySchedule
    extra = 1  # Allow adding extra schedules in the form
    fields = ('day_of_week', 'active', 'start_time', 'end_time', 'work_type')  # Fields to display
    can_delete = True  # Allow deletion of individual DaySchedule entries

# Admin for WorkSchedule, with DayScheduleInline
@admin.register(WorkSchedule)
class WorkScheduleAdmin(admin.ModelAdmin):
    list_display = ['employee', 'get_active_schedules']
    inlines = [DayScheduleInline]  # Add DaySchedule as inline

    def get_active_schedules(self, obj):
        # List active schedules for each day
        return ", ".join([f"{schedule.day_of_week}: {schedule.start_time} - {schedule.end_time} ({schedule.work_type})"
                          for schedule in obj.schedules.all() if schedule.active])
    get_active_schedules.short_description = 'Active Day Schedules'

# Admin for Employee
@admin.register(Employee)
class EmployeeAdmin(ImportExportModelAdmin):
    resource_class = EmployeeResource
    list_display = ['name', 'job_number', 'email', 'nationality']  # Added nationality for more info
    search_fields = ('name', 'job_number', 'email', 'nationality')

# Admin for EmployeeFile
@admin.register(EmployeeFile)
class EmployeeFileAdmin(ImportExportModelAdmin):
    resource_class = EmployeeFileResource
    list_display = ['employee', 'file_type', 'get_file_name']
    search_fields = ('employee__first_name', 'employee__last_name', 'file_type')
    list_filter = ('file_type',)  # Add filtering by file type

    def get_file_name(self, obj):
        # Display renamed file with its extension
        return os.path.basename(obj.file.name)
    get_file_name.short_description = 'File Name'

# Admin for SalaryDetails
@admin.register(SalaryDetails)
class SalaryDetailsAdmin(ImportExportModelAdmin):
    resource_class = SalaryDetailsResource
    list_display = ('employee', 'base_salary', 'bonuses', 'deductions', 'overtime_hours', 'overtime_pay', 'total_salary')
    search_fields = ('employee__name',)

# Admin for SalaryDelivery
@admin.register(SalaryDelivery)
class SalaryDeliveryAdmin(ImportExportModelAdmin):
    resource_class = SalaryDeliveryResource
    list_display = ('employee', 'payment_date', 'payment_method', 'status')
    search_fields = ('employee__name',)

# Admin for AdvancePayment
@admin.register(AdvancePayment)
class AdvancePaymentAdmin(ImportExportModelAdmin):
    resource_class = AdvancePaymentResource
    list_display = ('employee', 'request_date', 'amount', 'status')
    search_fields = ('employee__name',)

# Admin for Attendance
@admin.register(Attendance)
class AttendanceAdmin(ImportExportModelAdmin):
    resource_class = AttendanceResource
    list_display = ('employee', 'workdays', 'overtime_hours', 'absence_days', 'deductions')
    search_fields = ('employee__name',)

# Admin for Notice
@admin.register(Notice)
class NoticeAdmin(ImportExportModelAdmin):
    resource_class = NoticeResource
    list_display = ('noticeId', 'title', 'description', 'publishDate')
    search_fields = ('title',)

# Admin for WorkAssignment
@admin.register(WorkAssignment)
class WorkAssignmentAdmin(ImportExportModelAdmin):
    resource_class = WorkAssignmentResource
    list_display = ('assignmentId', 'assignerId', 'work', 'assignDate', 'dueDate', 'taskerId')
    search_fields = ('assignerId__name', 'taskerId__name')

# Admin for Request
@admin.register(Request)
class RequestAdmin(ImportExportModelAdmin):
    resource_class = RequestResource
    list_display = ('requestId', 'requesterId', 'requestMessage', 'requestDate', 'destinationEmployeeId')
    search_fields = ('requesterId__name', 'destinationEmployeeId__name')
