def valid_parentheses(s):
    """
    This function gets a string containing just the characters '(', ')', '{', '}', '[' and ']',
    and determines if the input string is valid.

    An input string is valid if:
        Open brackets must be closed by the same type of brackets.
        Open brackets must be closed in the correct order.

    e.g.
    s = '[[{()}](){}]'  -> True
    s = '[{]}'          -> False

    Hist: use stack
    """
    return None


if __name__ == '__main__':
    print(valid_parentheses('[[{()}](){}]'))
