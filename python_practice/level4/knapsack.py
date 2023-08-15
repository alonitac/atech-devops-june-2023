def knapsack(items, knapsack_limit=50):
    """
    Consider a thief gets into a home to rob and he carries a knapsack.
    There are fixed number of items in the home — each with its own weight and value —
    Jewelry, with less weight and highest value vs tables, with less value but a lot heavy.
    To add fuel to the fire, the thief has an old knapsack which has limited capacity.
    Obviously, he can’t split the table into half or jewelry into 3/4ths. He either takes it or leaves it

    Given a set of items, dict of tuples representing the (weight, value), determine the items to include in a collection
    so that the total weight is less than or equal to a given limit and the total value is as large as possible.

    :param items: dict of tuples e.g. {"bed": (100, 15), "iphone13": (1, 1500)}
    :param knapsack_limit:
    :return: set of items
    """
    return None


if __name__ == '__main__':

    res = knapsack({
        'book': (3, 2),
        'television': (4, 3),
        'table': (6, 1),
        'scooter': (5, 4)
    }, knapsack_limit=8)
    print(res)