# Generated by Django 4.2.4 on 2024-07-26 16:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apps', '0016_remove_contact_phone'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='thread_id',
            field=models.CharField(blank=True, max_length=255, null=True),
        ),
    ]
