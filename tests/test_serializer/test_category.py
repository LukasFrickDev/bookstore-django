import pytest
from product.models import Category


@pytest.mark.django_db
def test_category_creation():
    category = Category.objects.create(
        title="Ficção", slug="ficcao", description="Livros de ficção"
    )
    assert category.id is not None
    assert category.title == "Ficção"
