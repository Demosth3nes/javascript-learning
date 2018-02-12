# javascript-learning

#### Fundamentals
[Closures](#closures)

[Lexical scope](#lexical-scope)

[Let Vs Var](#let-vs-var)

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
Javascript is a function scoped language, meaning that each function creates its own scope. Simply applying curly braces ({}) without the word 'function', does not create a seperate scope(although we will see later than 'let' is in fact block scoped). Lexical scoping refers to how variables within a nested function are able to access its parent's function's scope.

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
 - loops and functions
 
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


### hoisting
### module patterns
#### module factory and singleton
### React
#### React Components when to extend component and when not to
#### import {default as Component} from 'path/to/component' - shorthand
#### {...props}
#### Mongo Schema 


