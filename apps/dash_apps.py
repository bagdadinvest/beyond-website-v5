# apps/dash_apps.py
import dash
from dash import html, dcc
import plotly.express as px
from django_plotly_dash import DjangoDash
from apps.models import User, TreatmentPlan, TreatmentPlanItem

# Initialize the Dash app
app = DjangoDash('patient_appointment_overview')

# Get data from Django models
active_patients = User.objects.filter(groups__name='Patient', is_active=True)
appointments = TreatmentPlan.objects.all()

# Create data for the charts
# Number of active patients
num_active_patients = active_patients.count()

# Total number of appointments
num_appointments = appointments.count()

# Group data for appointments per doctor
doctor_names = [plan.doctor.get_full_name() for plan in appointments]
doctor_fig = px.histogram(doctor_names, x=doctor_names, title="Appointments Per Doctor")

# Set up the layout for the dashboard
app.layout = html.Div([
    html.H1("Patient and Appointment Overview"),
    html.Div(f"Number of Active Patients: {num_active_patients}"),
    html.Div(f"Total Appointments: {num_appointments}"),
    dcc.Graph(figure=doctor_fig),
])
