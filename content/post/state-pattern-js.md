---
author: "O. Dushyn"
date: 2017-11-05
linktitle: State Pattern. JavaScript implementation.
menu:
  main:
    parent: tutorials
next: /tutorials/github-pages-blog
prev: /tutorials/automated-deployments
title: State Pattern. JavaScript implementation.
weight: 10
---

### Introduction: 
[According to wikipedia](https://en.wikipedia.org/wiki/State_pattern) it is a behavioral software design pattern that 
implements a *state machine* in an object-oriented way.

What's *state machine*?
Finite State Machine(FSM) is some abstract machine that can be in exactly one state at particular moment of time and 
has rules for changing the states(making transition).


Basically, FSM can be defined by 3 things:

1. list of states
2. rules for chaning the states
3. initial state

### Examples

We interact with state machines every day.  

- traffic lights
- elevators
- ticket machines
- minibanks

### Defining traffic light as state machine

1. List of states: green/yellow/red
2. Rules:   

    -if light is green move to yellow condition.
    
    -if light is yellow move to red condition.
    
    -if light is red move to green condition
3. Initial state: green.

### Implementation without state pattern

Before using state pattern itself let's try to implement traffic light logic straightforward. We are going to create
object *State* that will represents traffic lights(green, yellow or red) and use if/else statements to handle lights 
changing.  

```js
function LightMachine(light) {
  // current state  
  this.light = light;
  printInfo(this.light);
  
  this.changeLight = function() {
    // transition rules  
    if (this.light === "GREEN") {
      this.light = "YELLOW";
    } else if (this.light === "YELLOW") {
      this.light = "RED";
    } else if (this.light === "RED") {
      this.light = "GREEN";
    }
    printInfo(this.light);
  };
  
  function printInfo(light){
    console.log('Current light: ' + light);
  }
}

// create initial state 'GREEN'
var lightMachine = new LightMachine('GREEN');
lightMachine.changeLight(); // YELLOW
lightMachine.changeLight(); // RED
lightMachine.changeLight(); // GREEN
lightMachine.changeLight(); // YELLOW
lightMachine.changeLight(); // RED
```

Everything looks great except the branched out and coupled code in the rules part. Considering more complex example, you will get 
more different and complicated if/else statements which makes code even less readable and maintainable.

### Implementation with state pattern

So, let's try to decouple this code.

The reason of such branching code is that we try to handle all transition logic in one place. Let's make it different way, 
so each state keeping its transition rules logic by itself.
```js
let Green = function() {
  this.name = "Green";
  this.transition = function(trafficLight) {
    trafficLight.setLight(new Yellow());
  }
};
```
We have created an object that encapsulates(holds) all particular state internal data(i.e. state name) 
and implements common for all states function *transition* that contains rules. 
The same should be done for each state. Basically, state object by itself only answers the question: 

*"What must be the next state according to the defined rules?"*.
```js
let Yellow = function() {
  this.name = "Yellow";
  this.transition = function(trafficLight) {
    // according to the rules next state should be Red
    trafficLight.setLight(new Red());
  }
};

let Red = function(trafficLight) {
  this.name = "Red";
  // according to the rules next state should be Green
  this.transition = function(trafficLight) {
    trafficLight.setLight(new Green());
  }
};
```

We are done with states, but we need to be able to start, stop the system, put system in the specified state, 
keep the particular state, implement any logic between the transitions.
We also would like to know answers on following questions:

- What is the current state of the system?
- What are the statistics (how many times states are changed, what state is the most "popular", etc)?

Let's create a function for that exact reason. People usually  call it *context* object because it keeps information 
that's common and available for each state.

```
let TrafficLight = function(initialState) {
  this.currentState = initialState;
  
  this.setLight = function(newLight) {
    this.currentState = newLight;
    console.log('Current state: ' + this.currentState.name);
  }
  this.changeLight = function() {
    this.currentState.transition(this);
  }
};
```

As we see it contains two methods. *setLight* sets the current traffic light and *changeLight* is responsible 
for transition according to the current state's rules. The rules are encapsulated in each state object. 
Therefore, we do not have if/else hell and spaghetti code anymore

*There is only one interface(TrafficLight) which contains current state and delegates implementation of transitions to state objects.*

Code looks much more readable and cleaner than in the first approach. This approach is called "State pattern".
We are ready to use our traffic light implemented via *State Pattern* now!
```
var stateContext = new TrafficLight(new Green());
stateContext.changeLight();
stateContext.changeLight();
stateContext.changeLight();
stateContext.changeLight();
stateContext.changeLight();
```
Check out [plunker](http://plnkr.co/edit/iJo6CfGjX0EuiZ9BIj4l) to see full version.

### Smart traffic light

I've added timing for switching between the lights to make our traffic light more real.
Check out [this plunk](http://plnkr.co/edit/V5bUWp)

Hope you enjoyed reading!