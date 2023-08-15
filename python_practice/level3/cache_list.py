class CacheList(list):
    """
    Implement CacheList class which is a regular Python list,
    but it holds the last n elements only (old elements will be deleted)

    Usage example:
    x = CacheList(3)

    x.append(1)
    x.append(2)
    x.append(3)

    print(x)
    >> [1, 2, 3]

    x.append(1)
    print(x)
    >> [2, 3, 1]

    x.append(1)
    print(x)
    >> [3, 1, 1]
    """
    def __init__(self, cache_size=5):
        super().__init__()
        pass

    def append(self, element):
        pass


if __name__ == '__main__':
    c_list = CacheList(5)
    c_list.append(1)
    c_list.append(2)
    c_list.append(3)
    c_list.append(4)
    c_list.append(5)
    c_list.append(6)
    print(c_list)
