# javascript-learning

#### Basics
[Closures](#closures)

## Closures

A closure is when an inner function is closed over (read 'swallowed up') by an outer function thereby allowing the inner function to gain access to the outer function's variables and methods. 

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
### lexical scope
Javascript is a function scoped language, meaning that each function contains its own scope. Simply applying curly braces ({}) without the word 'function', does not create a seperate scope. 

```
function hello(){
  var test = 'hi';
    
}

console.log(test);

```

The term 'lexical scoping' is based on how the compiler attempts to provide meaning to the code. 


### let vs var 
 - loops and functions

### hoisting
### module patterns
### React
#### React Components when to extend component and when not to
#### import {default as Component} from 'path/to/component' - shorthand
#### {...props}

