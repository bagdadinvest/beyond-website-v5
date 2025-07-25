from django.db import migrations, transaction

def item_total(item):
    """Calculate the total for an individual treatment plan item."""
    return item.product.price * item.quantity * (1 - (item.discount_percentage / 100))

def calculate_subtotal(plan):
    """Calculate the subtotal from all items in the treatment plan."""
    return sum(item_total(item) for item in plan.treatmentplanitem_set.all())

def calculate_discount_amount(plan):
    """Calculate the discount amount based on the subtotal and final discount percentage."""
    return (calculate_subtotal(plan) * plan.final_discount_percentage) / 100

def calculate_total_price(plan):
    """Calculate the total price after applying the final discount."""
    return calculate_subtotal(plan) - calculate_discount_amount(plan)

def update_treatment_plans(apps, schema_editor):
    TreatmentPlan = apps.get_model('apps', 'TreatmentPlan')
    TreatmentPlanItem = apps.get_model('apps', 'TreatmentPlanItem')

    with transaction.atomic():
        for plan in TreatmentPlan.objects.all():
            plan.subtotal = calculate_subtotal(plan)
            plan.discount_amount = calculate_discount_amount(plan)
            plan.total_price = calculate_total_price(plan)
            plan.save(update_fields=['subtotal', 'discount_amount', 'total_price'])

class Migration(migrations.Migration):
    dependencies = [
        ('apps', '0034_treatmentplan_discount_amount'),  # Adjust to your actual dependency
    ]

    operations = [
        migrations.RunPython(update_treatment_plans),
    ]
