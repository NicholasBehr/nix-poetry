def main() -> int:
    print("Hello World!")
    print("1 + 2 =", add(1, 2))
    return 0


def add(a: int, b: int) -> int:
    """Simple function that adds two numbers

    >>> add(7, 13)
    20
    """
    return a + b
