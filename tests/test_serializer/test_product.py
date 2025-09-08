import pytest
from product.models import Product, Category

@pytest.mark.django_db
def test_product_creation_and_category_link():
    category = Category.objects.create(title="Aventura", slug="aventura", description="Livros de aventura")
    product = Product.objects.create(title="Livro Teste", description="Desc", price=10.0, active=True)
    product.categories.add(category)
    assert product.id is not None
    assert product.categories.filter(title="Aventura").exists()
