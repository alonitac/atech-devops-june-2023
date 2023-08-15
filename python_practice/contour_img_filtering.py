import python_practice.utils


def list_diff(elements):
    """
    Given a list of integers as an input, return the "diff" list - each element is
    reduces by its previous one.

    e.g.
    [1, 2, 3, 4, 7, 11] -> [1, 1, 1, 3, 4]

    :param elements: list of integers
    :return: the diff list
    """
    difference = []
    for x in range(1, len(elements)):
        d = abs(elements[x] - elements[x - 1])
        difference.append(d)

    return difference


img = python_practice.utils.open_img('67203.jpeg')

new_img = []
for row in img:
    new_img.append(list_diff(row))

python_practice.utils.save_img(new_img, 'new.jpeg')

