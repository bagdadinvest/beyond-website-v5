# Generated by Django 4.2.4 on 2024-07-21 17:13

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('apps', '0015_alter_referral_unique_together_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='contact',
            name='phone',
        ),
    ]
