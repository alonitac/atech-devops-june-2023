def replace_in_file(file_path, text, replace_text):
    """
    This function gets a path of text file, it replaces all occurrences of 'text' by 'replace_text'.
    The function saves the replaces content on the same path (overwrites the file's content)

    You MUST check that file_path exists in the file system before you try to open it

    :param file_path: relative or absolute path to a text file
    :param text: text to search
    :param replace_text: text to replace with
    :return: None
    """
    return None


if __name__ == '__main__':
    replace_in_file('local.json', 'kafka', 'kafffka')

