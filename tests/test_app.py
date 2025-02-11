import pytest
from app import app, products
from unittest.mock import patch

@pytest.fixture
def client():
    """Creates a test client for the Flask app."""
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_recommend_product(client):
    """Tests the /recommend endpoint."""
    response = client.get('/recommend')
    
    # Ensure response is valid
    assert response.status_code == 200
    assert response.data.decode() in products  # Check response is a valid product

@patch('random.choice', return_value="Laptop")
def test_recommend_mocked(mock_random, client):
    """Tests the /recommend endpoint with a mocked response."""
    response = client.get('/recommend')
    
    # Ensure the mocked value is returned
    assert response.status_code == 200
    assert response.data.decode() == "Laptop"
