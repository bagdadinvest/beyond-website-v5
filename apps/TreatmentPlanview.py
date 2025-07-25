from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
from django.forms import inlineformset_factory
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import TreatmentPlan, TreatmentPlanItem, TreatmentProduct, User
from .forms import TreatmentPlanForm, TreatmentPlanItemFormSet, TreatmentProductForm
from django.views.generic import DetailView
from django.contrib.auth.mixins import UserPassesTestMixin

@login_required
@user_passes_test(lambda u: u.is_staff)
def create_treatment_product(request):
    if request.method == 'POST':
        form = TreatmentProductForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('treatment_product_list')
    else:
        form = TreatmentProductForm()

    return render(request, 'treatment_product_form.html', {'form': form})

@login_required
@user_passes_test(lambda u: u.is_staff)
def treatment_product_list(request):
    products = TreatmentProduct.objects.all()
    return render(request, 'treatment_product_list.html', {'products': products})

class TreatmentPlanDetailView(UserPassesTestMixin, DetailView):
    model = TreatmentPlan
    template_name = 'treatment_plan_detail.html'
    context_object_name = 'treatment_plan'

    def test_func(self):
        return self.request.user.is_staff

@login_required
@user_passes_test(lambda u: u.is_staff)
def create_treatment_plan(request, patient_id):
    patient = get_object_or_404(User, pk=patient_id)
    TreatmentPlanItemFormSet = inlineformset_factory(TreatmentPlan, TreatmentPlanItem, form=TreatmentPlanItemFormSet, extra=1)

    if request.method == 'POST':
        form = TreatmentPlanForm(request.POST)
        formset = TreatmentPlanItemFormSet(request.POST)

        if form.is_valid() and formset.is_valid():
            treatment_plan = form.save(commit=False)
            treatment_plan.patient = patient
            treatment_plan.doctor = request.user
            treatment_plan.save()

            formset.instance = treatment_plan
            formset.save()

            treatment_plan.calculate_total_price()
            treatment_plan.save()

            return redirect('treatment_plan_detail', treatment_plan_id=treatment_plan.pk)
    else:
        form = TreatmentPlanForm()
        formset = TreatmentPlanItemFormSet()

    return render(request, 'treatment_plan_form.html', {'form': form, 'formset': formset, 'patient': patient})

@login_required
@user_passes_test(lambda u: u.is_staff)
def edit_treatment_plan(request, pk):
    treatment_plan = get_object_or_404(TreatmentPlan, pk=pk)
    TreatmentPlanItemFormSet = inlineformset_factory(TreatmentPlan, TreatmentPlanItem, form=TreatmentPlanItemFormSet, extra=1)

    if request.method == 'POST':
        form = TreatmentPlanForm(request.POST, instance=treatment_plan)
        formset = TreatmentPlanItemFormSet(request.POST, instance=treatment_plan)

        if form.is_valid() and formset.is_valid():
            form.save()
            formset.save()

            treatment_plan.calculate_total_price()
            treatment_plan.save()

            return redirect('treatment_plan_detail', pk=treatment_plan.pk)
    else:
        form = TreatmentPlanForm(instance=treatment_plan)
        formset = TreatmentPlanItemFormSet(instance=treatment_plan)

    return render(request, 'treatment_plan_form.html', {'form': form, 'formset': formset})

@login_required
@csrf_exempt
def treatment_plan_form(request, treatment_plan_id=None):
    """
    Handles treatment plan form for both creating and editing.
    """
    if request.method == 'POST':
        treatment_plan = get_object_or_404(TreatmentPlan, pk=treatment_plan_id)
        form = TreatmentPlanForm(request.POST, instance=treatment_plan)
        formset = TreatmentPlanItemFormSet(request.POST, instance=treatment_plan)

        if form.is_valid() and formset.is_valid():
            form.save()
            formset.save()
            return redirect('treatment_plan_detail', pk=treatment_plan.pk)

        return JsonResponse({'errors': form.errors})

    else:
        treatment_plan = TreatmentPlan.objects.get(pk=treatment_plan_id)
        return render(request, 'treatment_plan_form.html',
                      {'form': TreatmentPlanForm(instance=treatment_plan)})
