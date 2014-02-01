The Elevator Algorithm
======================

![](https://raw2.github.com/somlor/elevatory-ruby/master/elevator.jpg)

Create an Elevator System class that manages all the elevators in a highrise.

The behavior of the cars in response to button pushes can be any reasonable scheme of your own defining. For example, if someone on the fifth floor pushes the "down" button, what are the factors that will determine which car or cars are sent to service that request?

Come up with your own spec that answers such questions. The main interest is in seeing your design and implementation for meeting that spec.

Notes:
------

1. Feel free to create additional classes and internal objects; whatever you feel you need to model the elevator system well.

2. The code doesn't need to be complete if you don't have the time. Primary concerns are design and algorithmic sense. The priorities are: class hierarchy and object model, public interfaces, major member variables, important private methods, implementations. However, every major method of every major class should at least have a pseudo code implementation that explains what that method would actually do. Also, at least one complicated method should be implemented in real code.

3. Assume you'll have an API for sending commands to the physical cars themselves and for receiving notifications about things like button presses on the floors and in the cars and the current positions and movement of the cars. Define how you'd want that API to look and what you'd want it to do for you. You don't have to implement any of these functions.
