from django.template.loader import render_to_string
from django.http import HttpResponse
from weasyprint import HTML, CSS
from django.templatetags.static import static
from io import BytesIO

@login_required
def download_treatment_plan_pdf(request, plan_id):
    # Fetch the treatment plan
    treatment_plan = get_object_or_404(TreatmentPlan, id=plan_id, patient=request.user)

    # Render the HTML template with context data
    html_string = render_to_string('pdf/treatment_plan.html', {
        'treatment_plan': treatment_plan,
        'user': request.user,
    })

    # Create a BytesIO buffer to hold the PDF
    pdf_file = BytesIO()

    # Load the centralized CSS file
    css_path = static('assets/css/argon-dashboard.css')
    pdf_css = CSS(filename=css_path)

    # Generate the PDF with the CSS
    HTML(string=html_string).write_pdf(target=pdf_file, stylesheets=[pdf_css])

    # Return the PDF as a response
    response = HttpResponse(pdf_file.getvalue(), content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="treatment_plan_{treatment_plan.id}.pdf"'

    return response
