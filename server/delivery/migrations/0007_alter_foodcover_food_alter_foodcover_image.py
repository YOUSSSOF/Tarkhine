# Generated by Django 4.2.4 on 2023-09-03 16:48

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('delivery', '0006_alter_foodcover_image'),
    ]

    operations = [
        migrations.AlterField(
            model_name='foodcover',
            name='food',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='covers', to='delivery.food'),
        ),
        migrations.AlterField(
            model_name='foodcover',
            name='image',
            field=models.ImageField(upload_to='pics'),
        ),
    ]
