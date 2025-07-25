from django import forms
from .models import TreatmentPlan, TreatmentPlanItem

class TreatmentPlanForm(forms.ModelForm):
    class Meta:
        model = TreatmentPlan
        fields = ['discount_percentage']

class TreatmentPlanItemForm(forms.ModelForm):
    class Meta:
        model = TreatmentPlanItem
        fields = ['product', 'quantity']

TreatmentPlanItemFormSet = forms.inlineformset_factory(
    TreatmentPlan,
    TreatmentPlanItem,
    form=TreatmentPlanItemForm,
    extra=1,
    can_delete=True
)