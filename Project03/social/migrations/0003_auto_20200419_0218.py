# Generated by Django 3.0.3 on 2020-04-19 02:18

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('social', '0002_auto_20200417_0600'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userinfo',
            name='birthday',
            field=models.DateField(blank=True, null=True),
        ),
    ]