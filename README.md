# javascript-learning

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

### let vs var 
 - loops and functions
### lexical scope
### hoisting
### module patterns
### React
#### React Components when to extend component and when not to
#### import {default as Component} from 'path/to/component' - shorthand
#### {...props}

