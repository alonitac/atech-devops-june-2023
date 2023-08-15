def merge_dicts(dict1, dict2):
    """
    This functions merges dict2's keys and values into dict1, and returns dict1

    e.g.
    dict1 = {'a': 1, 'b': 99}
    dict2 = {'b': 2}

    The results will by
    dict1 = {'a': 1, 'b': 2}

    :param dict1:
    :param dict2:
    :return:
    """
    return dict1


if __name__ == '__main__':
    print(merge_dicts({'a': 1}, {'b': 2}))

