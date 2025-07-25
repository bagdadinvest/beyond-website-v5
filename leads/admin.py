from django.contrib import admin
from import_export.admin import ImportExportModelAdmin
from .models import Lead, LeadHistory, Note


# Tabular inlines for related models
class LeadHistoryInline(admin.TabularInline):
    model = LeadHistory
    extra = 0
    fields = ('action', 'timestamp', 'user')
    readonly_fields = ('timestamp',)


class NoteInline(admin.TabularInline):
    model = Note
    extra = 0
    fields = ('content', 'user', 'created_at')
    readonly_fields = ('created_at',)


# Register Lead with import/export and inline related models
@admin.register(Lead)
class LeadAdmin(ImportExportModelAdmin):
    list_display = (
        'name', 'email', 'phone', 'source', 'status', 'country', 
        'created_at', 'last_updated'
    )
    search_fields = ('name', 'email', 'phone', 'country')
    list_filter = ('source', 'status', 'country', 'created_at')
    inlines = [LeadHistoryInline, NoteInline]
    ordering = ('-created_at',)


# Register LeadHistory with import/export
@admin.register(LeadHistory)
class LeadHistoryAdmin(ImportExportModelAdmin):
    list_display = ('lead', 'action', 'timestamp', 'user')
    search_fields = ('lead__name', 'action', 'user__username')
    list_filter = ('timestamp',)
    ordering = ('-timestamp',)


# Register Note with import/export
@admin.register(Note)
class NoteAdmin(ImportExportModelAdmin):
    list_display = ('lead', 'user', 'created_at')
    search_fields = ('lead__name', 'user__username', 'content')
    list_filter = ('created_at',)
    ordering = ('-created_at',)
