# Misc Notes

## Array vs. Set

While it's easy to default to an Array whenever you need a collection, you can often get away with a Set, which affords you a lot more functionality

```swift
let people: Set = ["Me", "You", "Us"]
// versus
let people = ["Me", "You", "Us"] // this is an array
```

Remember, you can do stuff like :

Intersect -> get overlap
- `exampleSet.intersection(_ other: Set)`
Subtract - pull out the difference
- `exampleSet.subtracting(_ other: Set)`
Disjoint -> check for any overlap (Bool)
- `exampleSet.disjoint(_ other: Set)`
Union -> combine them (but no duplicates)
- `exampleSet.union(_ other: Set)`
Exclusive -> items only in 1 of the sets
- `exampleSet.exclusive(_ other: Set)`
Subset/Superset -> boolean (if one set is a subset/superset of another set)
- `exampleSet.isSubset(of: other: Set)`
- `exampleSet.isSuperSet(of: other: Set)`
Standard operations
- `exampleSet.insert(_ set: Set)`
- `exampleSet.delete(_ set: Set)`
- `exampleSet.find(_ set: Set)`

## Singelton

A singleton is an instance of a class that can only be created once, and is globally accessable in the code base.

ex: `UserDefaults` -> apple api to store system-wide and app-specific settings

### Key question: Is it vital that tehre's only a single instance of this class?

- `UserDefaults` makes sense because we don't want to make a new instance wherever we use it, this will lead to inconsistent values

- `UserDefaults.standard.set(false, forKey: "isFirstUse")` -> `standard` accesses the shared instance 

### Pros and Cons

Pros: 
- Unique, can only have one
- Convenient, access across the entire app (but if this is the only reason, don't use it)

Cons:
- global acessibility -> so many files can access it, making debugging difficult and can cause bugs in other files
- difficult to test
- separation of concerns

### How to create a Singleton

```swift
final class MySingleton { // final means that this class cannot be subclassed

    static let shared = MySingleton() // initializes the instance that will be used across the entire app

    private init() { } // this PRIVATE init means that you can't create an instance of MySingleton anywhere other than that class

    func doSomething() { }
}

// using the singleton
MySingleton.shared.doSomething()
```

## `final`

The `final` keyword in Swift is a declaration modifier used to indicate that a **class, method, property, or subscript cannot be overridden or subclassed**. 

# Questions to Review

- How to use custom coding keys for a model

- for MVVM, what should go in the model file? Is it just the declaration of the model, or should we also include some static methods?

- need to review closures, specifically how to read closures in documentation / function definitions

- what enums can do / how powerful they are

## Key Paths

In a SwiftUI ForEach loop like so:

```swift
ForEach(["A", "B", "C"], id: \.self) { item in
    Text(item)
}
```

`\.self` is known as a key path, or an indicator to swiftui how to uniquely identify each element in the collection.

Key paths can be any `hashable` value to the object. For example, if you're iterating through structs, you can use any of its properties as a key path if it's `hashable`
- granted, this `hashable` value has to be unique across all of the examples.