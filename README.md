# javascript-learning

#### Fundamentals
[Closures](#closures)

[Lexical scope](#lexical-scope)

[Let Vs Var](#let-vs-var)

[Hoisting](#hoisting)

[Modules](#modules)

## Closures

A closure is when an inner function is closed over (read 'swallowed up') by an outer function thereby allowing the inner function to gain access to the outer function's variables and methods. But its not just that, the inner functions are also able to rememeber it's lexical scope (see below) no matter where it is called. 

```
function outerFunction() {
  var foo = 'hello';
  
  function innerFunction() {
    console.log(foo);
  }
  
  innerFunction();
  
}

outerFunction();

/** Output */
// 'hello'
```

Any variable or function defined within the inner function is private within that scope...

```
function outerFunction() {
  var foo = 'hello';
  
  function innerFunction() {
    var privateBar;
    
  }
  
  alert(privateBar);
  
}

outerFunction();

/** Output */
// ReferenceError: privateBar is not defined
```

..unless the value is exposed to the outer function.

```
function outerFunction() {
  var foo;
  
  function innerFunction() {
    var privateBar = 'hello';
    // Pass the variable to foo 
    // privateBar = 'test';
    // foo = privateBar
    // return foo
    
    // Or
    function manipulatePrivateBar() {
      privateBar = 'test';
      return privateBar;
    }
    
    return manipulatePrivateBar();
    
  }
  
  return innerFunction();
  
}

var exposedBar  = outerFunction();
console.log(exposedBar);

/** Output */
// 'test'

```
### Lexical scope
Javascript is a function scoped language, meaning that each function creates its own scope. Simply applying curly braces ({}) without the word 'function', does not create a seperate scope(although we will see later that 'let' is in fact block scoped). Lexical scoping refers to how variables within a nested function are able to access its parent's function's scope.

```
function hello(){
  var test = 'hi';
    
}

console.log(test);

// Output
// ReferenceError: test is not defined
```

Lexically scoped
```
function outerFunction() {
  var foo = 'hello';
  
  function innerFunction() {
    console.log(foo);
  }
  
  innerFunction();
  
}

outerFunction();

/** Output */
// 'hello'
```

### let vs var 
 
One of the most recent changes to ecmaScript 6 is the introduction of the 'let' keyword. Unlike var's they are not hoisted, and can be confined to within a block scope - curly braces {}. This provides certain advantages. Ever had a loop with a function inside and the iteration variable kept producing the last iterated value?

```
(var i = 0;i < 5; i++) {
  console.log(i);
  setTimeout(function(){
    console.log(i);
  }, 1000);
}
```

The first console.log will count from 0 -> 4, however the second will be 5 each time. Why you ask? Because ***var*** is hoisted, and not re-bound every iteration within the scope, so it is always referencing the same variable sitting in the parent/global scope. Let on the other hand is rebound each iteration as it is block scoped, so each time the loop is ran, let is being assigned the new index.

```
(let i = 0;i < 5; i++) {
 
  setTimeout(function(){
    console.log(i);
  }, 1000);
}

/** Output */
// 0, 1, 2, 3, 4
```
It's important to note that the let vs var arguement also comes down to styling choices and preference. There is no necessary right and wrong regarding when a var or let should be used. In the JS community you will find compelling arguements for each, I personally believe that you should be free to use both. Let - If you wish to show it is only changed within its context, e.g. a function. Var - for when it may be changed much further down from where it is declared. Nothing wrong with variety.

### Hoisting

One of the key principles of Javascript other than it being function-scoped is hoisting. Hoisting occurs during the first phase of code interpreation when variables and declared functions(not function expressions) are sent to the beginning of the script. You may have found that sometimes variables declared after functions and still they are able to be used - this is due to hoisting.

```

function test() {
  alert(hoisted);
}

var hoisted = 'hello world';

test();

// Alert 'hello world'

```

The above script alerts the text 'hello world' because after JS has gone through and interpreted the code, it actually looks like this.

```
var hoisted = 'hello world';

function test() {
  alert(hoisted);
}

test();

// Alert 'hello world'

```
Interestingly if you were to move the test() above its declaration it would also work - due to the function declaration 'test' being hoisted above the function call. However, should the test() be move above the var like this:

```

test();

var hoisted = 'hello world';

function test() {
  alert(hoisted);
}

// Undefined

```

It will not, because even though the variable is in fact hoisted, it has not been assigned yet, therefore it returns 'undefined';

### Modules
Something that had confused me for a while is modules and how they expose only the necessary information, while hiding certain functionality. Below, we have a singleton module- this is a module that is only instantiated the one time, unlike a factory that can be created multiple times.

```

var testModule = (function () {
  var privateVar = 'hello';
  
  var publicAPI = {
    publicFunction: function() {
      privateVar += ' world';
      return privateVar;
    }
  }
  
  return publicAPI;

})();

console.log(testModule.publicFunction());

// Output 'hello world'

```

This is a typical module pattern that hides the private variables and exposes only the publicAPI, useful for when you don't want users inadvertently making changes to certain parts of the code.

### Prototypes
### ES6 Classes are syntatic sugar
### Super()
### OLOO: Objects Linked to Other Objects
### React
#### React Components when to extend component and when not to
#### import {default as Component} from 'path/to/component' - shorthand
#### {...props}
#### Mongo Schema 


