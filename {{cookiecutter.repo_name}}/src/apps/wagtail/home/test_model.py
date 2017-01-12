from django.test import TestCase

def inc(x):
    return x + 1

def test_answer():
    assert inc(3) == 4
