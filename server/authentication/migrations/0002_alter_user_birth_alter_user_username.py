# Generated by Django 4.2.4 on 2023-08-24 07:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('authentication', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='birth',
            field=models.DateField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='user',
            name='username',
            field=models.CharField(default='کاربر ترخینه', max_length=255),
        ),
    ]
