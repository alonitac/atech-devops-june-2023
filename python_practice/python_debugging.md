# Python debugging using PyCharm

Based on https://www.jetbrains.com/help/pycharm/2023.1/creating-and-running-your-first-python-project.html

In your PyCharm, let's run the python script located in `python_utils/car.py`.

This app is a simple [class](https://docs.python.org/3/tutorial/classes.html) (classes will be discussed later) that represents a car and provides functionalities such as controlling its speed, accelerating etc... 

In the opened terminal type `s` to get the current car speed:

```text
I'm a car!
What should I do? [A]ccelerate, [B]rake, show [O]dometer, or show average [S]peed? s
```

Observe the returned `ZeroDivisionError` runtime exception.

Our motivation is to find what's went wrong.
We'll use the PyCharm debugger to see exactly what’s happening in our code. 
To start debugging, you have to set some **breakpoints**.
And run the script in debug mode.
