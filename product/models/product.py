from django.db import models


class Product(models.Model):
    title = models.CharField(max_length=100)
    description = models.TextField(max_length=500, blank=True, null=True)
    price = models.DecimalField(decimal_places=2, max_digits=10, null=True)
    active = models.BooleanField(default=True)
    categories = models.ManyToManyField("Category", blank=True)

    def __str__(self):
        return self.title
