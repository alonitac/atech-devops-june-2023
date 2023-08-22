class Car:
    """
    Design a Car class that represents a car in a car rental system. The class should have the following attributes and methods:

    model: The model of the car (Toyota, Honda, etc.).
    year: The manufacturing year of the car.
    rented: A boolean flag indicating whether the car is currently rented or not.

    rent_car(): Sets the rented flag to True to indicate that the car has been rented.
    return_car(): Sets the rented flag to False to indicate that the car has been returned.
                  Raise a RuntimeError() exception if the car is not rented
    is_rented(): Returns True if the car is currently rented, and False otherwise.
    """
    def __init__(self, model, year):
        pass

    def rent_car(self):
        pass

    def return_car(self):
        pass

    def is_rented(self):
        pass


if __name__ == "__main__":
    my_car = Car("Toyota", 2010)

    print(my_car.model)         # Toyota
    print(my_car.year)          # 2010
    print(my_car.is_rented())   # False

    try:
        print(my_car.return_car())
        print('car returned')
    except RuntimeError:
        print('cat is not rented')

    my_car.rent_car()

    print(my_car.is_rented())   # True
    print(my_car.return_car())

