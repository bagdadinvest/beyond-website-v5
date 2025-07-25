from django.db import models
import plotly.express as px
import plotly.graph_objs as go
from django.shortcuts import render
from apps.models import User, Appointment, TreatmentPlan, TreatmentProduct, Prescription, TreatmentPlanItem
from actstream.models import Action
from django.db.models import Count
from django.utils.translation import gettext_lazy as _
from django.utils.translation import gettext as translate  # To convert to string

def comprehensive_dashboard(request):
    # User Activity Section
    # 1. Count actions by verb (e.g., 'logged in', 'logged out', 'updated profile', etc.)
    action_counts = Action.objects.values('verb').annotate(count=Count('id')).order_by('-count')
    verbs = [entry['verb'] for entry in action_counts]
    counts = [entry['count'] for entry in action_counts]

    # Plot the actions by type (bar chart)
    fig1 = px.bar(x=verbs, y=counts, title=str(translate("User Actions by Type")))

    # 2. User logins and logouts over time
    login_actions = Action.objects.filter(verb=translate('logged in')).extra({'date': 'date(timestamp)'}).values('date').annotate(count=Count('id'))
    logout_actions = Action.objects.filter(verb=translate('logged out')).extra({'date': 'date(timestamp)'}).values('date').annotate(count=Count('id'))
    
    login_dates = [entry['date'] for entry in login_actions]
    login_counts = [entry['count'] for entry in login_actions]
    
    logout_dates = [entry['date'] for entry in logout_actions]
    logout_counts = [entry['count'] for entry in logout_actions]
    
    # Plot logins and logouts over time (line chart)
    fig2 = go.Figure()
    fig2.add_trace(go.Scatter(x=login_dates, y=login_counts, mode='lines+markers', name=str(translate('Logins'))))
    fig2.add_trace(go.Scatter(x=logout_dates, y=logout_counts, mode='lines+markers', name=str(translate('Logouts'))))
    fig2.update_layout(title=str(translate("User Logins and Logouts Over Time")))

    # 3. Actions by user group
    action_by_group = Action.objects.values('actor_content_type__model').annotate(count=Count('id')).order_by('-count')
    groups = [entry['actor_content_type__model'] for entry in action_by_group]
    group_counts = [entry['count'] for entry in action_by_group]
    
    # Plot actions by user group (pie chart)
    fig3 = px.pie(values=group_counts, names=groups, title=str(translate("User Actions by Group")))

    # Comprehensive Data Section
    # 1. Patient Distribution by Nationality
    patients = User.objects.filter(groups__name='Patient')
    nationality_counts = patients.values('nationality').annotate(count=models.Count('id'))
    nationality_labels = [item['nationality'] for item in nationality_counts]
    nationality_values = [item['count'] for item in nationality_counts]
    
    fig4 = px.pie(values=nationality_values, names=nationality_labels, title=str(translate("Patient Distribution by Nationality")))
    
    # 2. Appointments per Doctor
    appointments = Appointment.objects.all()
    doctor_names = [appt.doctor.get_full_name() for appt in appointments]
    fig5 = px.histogram(doctor_names, x=doctor_names, title=str(translate("Appointments per Doctor")))
    
    # 3. Active vs Inactive Users
    active_users_count = User.objects.filter(is_active=True).count()
    inactive_users_count = User.objects.filter(is_active=False).count()
    fig6 = go.Figure(data=[go.Pie(labels=[str(translate('Active')), str(translate('Inactive'))], values=[active_users_count, inactive_users_count])])
    fig6.update_layout(title_text=str(translate("Active vs Inactive Users")))
    
    # 4. Treatment Plans and Total Costs
    treatment_plans = TreatmentPlan.objects.all()
    patient_names = [plan.patient.get_full_name() for plan in treatment_plans]
    total_costs = [plan.total_price for plan in treatment_plans]
    fig7 = px.bar(x=patient_names, y=total_costs, title=str(translate("Total Costs of Treatment Plans per Patient")))
    
    # 5. Popular Treatment Products
    product_usage = TreatmentPlanItem.objects.values('product__name').annotate(count=models.Count('id')).order_by('-count')
    product_usage_names = [item['product__name'] for item in product_usage]
    product_usage_counts = [item['count'] for item in product_usage]
    fig8 = px.bar(x=product_usage_names, y=product_usage_counts, title=str(translate("Most Popular Treatment Products")))
    
    # 6. Prescription Distribution (Active vs Inactive)
    prescriptions = Prescription.objects.all()
    active_prescriptions = prescriptions.filter(active=True).count()
    inactive_prescriptions = prescriptions.filter(active=False).count()
    fig9 = go.Figure(data=[go.Pie(labels=[str(translate('Active')), str(translate('Inactive'))], values=[active_prescriptions, inactive_prescriptions])])
    fig9.update_layout(title_text=str(translate("Active vs Inactive Prescriptions")))

    # Convert all figures to HTML
    charts = {
        'chart1': fig1.to_html(full_html=False),
        'chart2': fig2.to_html(full_html=False),
        'chart3': fig3.to_html(full_html=False),
        'chart4': fig4.to_html(full_html=False),
        'chart5': fig5.to_html(full_html=False),
        'chart6': fig6.to_html(full_html=False),
        'chart7': fig7.to_html(full_html=False),
        'chart8': fig8.to_html(full_html=False),
        'chart9': fig9.to_html(full_html=False),
    }

    return render(request, 'comprehensive_dashboard.html', charts)
