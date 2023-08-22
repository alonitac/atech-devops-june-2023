class Dog:
    """
    The Dog class has a constructor (__init__) that initializes the name and breed attributes of the class.
    It also has two methods: bark(), which prints a simple bark message,
    and describe(), which prints the dog's name and breed.

    1. In the constructor, create a new attribute called `self.position` which defines the position state of the dog.
       The attribute possible values are: sitting, standing, jumping.
    2. Implement the following methods: sit(), stand(), jump(). Each method changes the position of the dog.
    3. Extend the bark() function to receive an argument called `n` with default values of 2, the god should bark n times.
    4. Add the dog position to the description printed in describe method.

    """
    def __init__(self, name, breed):
        self.name = name
        self.breed = breed

    def bark(self):
        print("Woof! Woof!")

    def describe(self):
        print(f"I'm {self.name}, a {self.breed}.")


if __name__ == "__main__":
    my_dog = Dog("Buddy", "Golden Retriever")

    my_dog.bark()
    my_dog.describe()
