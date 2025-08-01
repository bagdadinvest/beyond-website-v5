# Generated by Django 5.0.7 on 2024-08-18 03:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('apps', '0019_emailtemplate'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_online',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='user',
            name='last_login_time',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='user',
            name='last_logout_time',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
