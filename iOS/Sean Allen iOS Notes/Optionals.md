# Optionals

An optional, denoted by `?`, is a value that can also be `nil`.

ex: we mark age as optional because we literally might make it optional for users to give their age.

```swift
struct User {
    let name: String
    let age: Int?
}
```

## Unwrapping Optionals

```swift
let user = User(name: "Quinn", age: nil)
```

### `if let`
```swift
if let age = user.age {
    print("users's age is \(age)")
} else {
    // age is nil
}
```
pros/use cases: 
- simple
- can perform different/branched logic based on whether it's optional or not (do different work depending on whether it's optional)

cons: can only use age in that scope

### `guard let`

```swift
func check(age: Int?) {
    guard let age = age else {
        print("users's age is \(age)")
        return
    } 

    if age > 40 {
        // other stuff
    }
}
```
pros/use cases:
- early exit if optional, if passes guard, can use it in the whole scope of the function. 
- great for checking conditions or validity of inputs

cons: 

### nil coalescing (default value)

```swift
let age = user.age ?? 0 // defining a default value
```

pros/use cases: whenever you care about a specific value and only care about a default value in the `nil` case

### force unwrap

```swift
let age = user.age! // extracting the value and don't check (result of bad design, shouldn't really happen)
```

### Optional Chaining
We use optional chaining when the entire object is optional
```swift
struct User? {
    let name: String
    let age: Int?
}

var optionalUser: User?

guard let name = optionalUser?.name else { print("name is nil")}

let name = optionalUser?.name ?? "Not Given"

if let newName = optionalUser?.name {
    print(newName)
}

let name = optionalUser?.name!
```
- if `optionalUser` is `nil` -> name is `nil`
- you can use any sort of unwrapping here since we are "chaining" the optional down to the name value