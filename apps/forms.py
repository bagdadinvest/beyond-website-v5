from django import forms
from .models import User, TreatmentPlan, TreatmentPlanItem, TreatmentProduct

class ProfilePictureForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['thumbnail']

class TreatmentProductForm(forms.ModelForm):
    class Meta:
        model = TreatmentProduct
        fields = ['name', 'category', 'price', 'description', 'image', 'max_discount_percentage']

class TreatmentPlanForm(forms.ModelForm):
    class Meta:
        model = TreatmentPlan
        fields = ['final_discount_percentage']
        labels = {
            'final_discount_percentage': 'Final Discount Percentage (%)',
        }
        widgets = {
            'final_discount_percentage': forms.NumberInput(attrs={
                'class': 'form-control',
                'min': '0',
                'max': '100',
                'step': '0.01',
                'placeholder': '0.00'
            })
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['final_discount_percentage'].help_text = 'Enter discount percentage (0-100%)'

class TreatmentPlanItemForm(forms.ModelForm):
    class Meta:
        model = TreatmentPlanItem
        fields = ['product', 'quantity', 'discount_percentage']
        labels = {
            'product': 'Product',
            'quantity': 'Quantity',
            'discount_percentage': 'Item Discount (%)'
        }
        widgets = {
            'product': forms.Select(attrs={'class': 'form-control'}),
            'quantity': forms.NumberInput(attrs={
                'class': 'form-control',
                'min': '1',
                'placeholder': '1'
            }),
            'discount_percentage': forms.NumberInput(attrs={
                'class': 'form-control',
                'min': '0',
                'max': '100',
                'step': '0.01',
                'placeholder': '0.00'
            })
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['product'].queryset = TreatmentProduct.objects.filter(is_active=True)
        self.fields['product'].empty_label = "Select a product..."

# Formset for TreatmentPlanItem
TreatmentPlanItemFormSet = forms.inlineformset_factory(
    TreatmentPlan,
    TreatmentPlanItem,
    form=TreatmentPlanItemForm,
    extra=1,
    can_delete=True
)
