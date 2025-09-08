import pytest
from django.contrib.auth.models import User
from product.models import Product, Category
from order.models import Order

@pytest.mark.django_db
def test_order_creation_and_product_link():
    user = User.objects.create_user(username="testuser", password="testpass")
    category = Category.objects.create(title="Romance", slug="romance", description="Livros de romance")
    product = Product.objects.create(title="Livro Romance", description="Desc", price=20.0, active=True)
    product.categories.add(category)
    order = Order.objects.create(user=user)
    order.product.add(product)
    assert order.id is not None
    assert order.product.filter(title="Livro Romance").exists()
    assert order.user.username == "testuser"