import pytest
from math_calculations import add_numbers

def test_add_numbers():
    assert add_numbers(2, 3) == 5
    assert add_numbers(-1, 1) == 0
    assert add_numbers(-2, -2) == -4
if __name__ == "__main__":
    pytest.main()