+++
date = "2018-07-10T23:31:01+02:00"
description = "what is rxjs for?"
title = "The main idea behind rxjs"
+++


### What is rxjs?

ReactiveX is a library for composing asynchronous and event-based programs by using observable sequences.
rxjs is implimentation  Observer pattern in javascript programming language ([source](http://reactivex.io/intro.html)).

Not clear yet...

All my following examples are taken from [official guide](https://rxjs-dev.firebaseapp.com/guide/overview).

#### First example: create observable
 - Count how many times the button was clicked.
 
Straightforward solution via using event listener and implementing callback function.
 ```
var count = 0;
var button = document.querySelector('button');
button.addEventListener('click', () => console.log(`Clicked ${++count} times`));
 ```
There is big disadvantage: callback function modifies external state - `count` variable.
In big projects such behaviour may lead to unexpected errors.

In example above we handle each event separately. However, what if we could handle the flow of these events?
This idea is implemented inside Observable object. Observable object emits events and gives possibility to
manipulate them in sequential way.

There are many ways to create an Observable out of html events flow. Let's use `fromEvent` function.
```
let observable = fromEvent(button, 'click');
```

Once we have an Observable that emit events we also need the way to consume those events.
Here is where Observer comes to play. We observe emitted values using `subscribe` method.
Subscribe method consumes 3 callbacks: for success consumes event, error consumes error
and onComplete callback consumes nothing.
```
let observable = fromEvent(button, 'click');
let subscription = observable.subscribe((event) => {}, (error) => {}, () => {})
```

Method subscribe returns `Subscription` object the mainly used for canceling subscription 
by calling `subscription.unsubscribe()`

Based *ONLY* on this knowledge we may implement next solution(*ugly, DO NOT repeat this*) 

```
let count = 0;
const button = document.querySelector('button');
fromEvent(button, 'click').subscribe(count => {
    console.log(`RXJS: Clicked ${count++} times`)
});
```

Where the benefit of using Observable you may ask? After all, we still have global count variable.

What if we could manipulate the flow itself and change each events or values emitted by Observable before getting it
into subscribe function as parameter?
There is where a very power concept of Operators comes to play at this exact moment.
To solve our problem we may use `scan` operator.
```
const button = document.querySelector('button');
fromEvent(button, 'click').pipe(
  scan(count => count + 1, 0)
)
.subscribe(count => console.log(`RXJS: Clicked ${count} times`));
```
`scan` operator implements callback function and aggregates the result into count variable.

Since rxjs-v6 it's mandatory to use `pipe` method and pass operators inside it as its parameters.
Thus, before you get emitted event inside `subscribe` function all events go through the `pipe` and
gets modified by the specified operators.

Last solution by using `observable` and `scan` operators provides clean solution without using global variables
and you can easily scale it.

#### Second example: apply operator
 - The task is to allow and handle at most one click per second.
 
Straightforward solution:
```
var count = 0;
var rate = 1000;
var lastClick = Date.now() - rate;
var button = document.querySelector('button');
button.addEventListener('click', () => {
  if (Date.now() - lastClick >= rate) {
    console.log(`Clicked ${++count} times`);
    lastClick = Date.now();
  }
});
```
Using observables:
```
const { fromEvent } = rxjs;
const { throttleTime, scan } = rxjs.operators;
const button = document.querySelector('button');
fromEvent(button, 'click').pipe(
  throttleTime(1000),
  scan(count => count + 1, 0)
)
.subscribe(count => console.log(`Clicked ${count} times`));
```

Just look at how is readable the solution that uses observables. That is because it allows to control the flow.
`throttleTime` operator emits latest value when specified duration has passed and `scan` operator counts the
total number of events.
Operators are executed in the order they specified inside pipe function. Scan operator is not executed until
`throttleTime` emits the value. `subscribe` function is not executed until all operators are passed.

<img src="https://image.slidesharecdn.com/fpjsluisatenciobocajs-160504163409/95/luis-atencio-on-rxjs-22-638.jpg?cb=1462379809">

#### Third example: scale existing solution
Lets make task more complicated and count the sum of current mouse x positions.
Event listener:
```
let count = 0;
const rate = 1000;
let lastClick = Date.now() - rate;
const button = document.querySelector('button');
button.addEventListener('click', (event) => {
  if (Date.now() - lastClick >= rate) {
    count += event.clientX;
    console.log(count)
    lastClick = Date.now();
  }
});
```
Observable:
```
const { fromEvent } = rxjs;
const { throttleTime, map, scan } = rxjs.operators;

const button = document.querySelector('button');
fromEvent(button, 'click').pipe(
  throttleTime(1000),
  map(event => event.clientX),
  scan((count, clientX) => count + clientX, 0)
)
.subscribe(count => console.log(count));
```

Event listener solution required refactoring of the algorithm but Observable approach 
adding of one more operator - `map`.

`map` transforms the items emitted by an Observable by applying a function to each item.

- Firstly, click happened by user and click event was emitted by browser. 
- The flow of click events is handled by our Observable. Observable emits same event further.
- Then this event is processed via the pipe. `throttleTime` checks whether one second passed and if
so emits click event further to `map` operator. 
- `map` is transform operator and in our case it transforms click event(object) to coordinate(number). 
Therefore, scan get number as input instead of event object.

Browser click(emits Event() object) -> Observable(Event()) ->
-> Pipe[throttleTime(Event()) -> map(number) -> scan(number)] -> subscribe(number).

Note: `scan` first parameter is always aggregated value and the second one is emitted value.


Conclusion: rxjs is (almost as any other library) just helps to solve same problems in different way.

- introduces an abstraction for managing flows of events(first example) and the concept of Observable,
Observer, Subscription operators and creates. 
- helps to solve event based tasks rather in a declarative
than imperative way.
- code becomes more readable and programmer mainly thinks about which operators to apply instead of implementing
algorithms(2nd and 3rd examples).

