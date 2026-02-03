# Filter, Map, Reduce

Each are shorthand syntax for basic for loops that operate on an array and stores the output in a variable.

Example array:

```swift
struct IndieApp {
    let name: String
    let monthlyPrice: Double
    let users: Int
}

let appPortfolio = [
    IndieApp(name: "Creator View", monthlyPrice: 11.99, users: 4356),
    IndieApp(name: "FitHero", monthlyPrice: 0.00, users: 1756),
]
```

### Filter

Let's say we want to filter and get the free apps.

```swift
let freeApps = appPortfolio.filter { app in
    return app.monthlyPrice == 0.00
}

let freeApps = appPortfolio.filter { $0.monthlyPrice == 0.00 }
```
- this closure is of type `(self.Element) -> Bool)` and is meant to give the criteria (`true` or `false`) as to whether the result should stay

### Map

A common use of `.map()` is to pull out all of a specific property.

Ex: get names of apps and sort alphabetically

```swift
let appNames = appPortfolio.map { $0.name }.sorted()
```

Add a transform to the property (increase prices)

```swift
let increasedPrices = appPortfolio.map { $0.monthlyPrice * 1.5 }
```

### Reduce

```swift
func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult: (Result, Self.Element) throws -> Result
) rethrows -> Result
```

Simple ex: sum up array

```swift
let numbers = [3, 5, 6, 12, 18]
let sum = numbers.reduce(0, +)
// sum = 47
```

Complex ex:

```swift
let totalUsers = appPortfolio.reduce(0, { $0 + $1.users } )
```

- ^^ we pass in a second closure to reduce, which takes in the accumulated result and the new value to add (the next value)

### Chaining

You can chain these operations together.
 
```swift
let recurringRevenue = appPortfolio.map { $0.monthlyPrice * Double($0.users) }.reduce(0, +)
// gives you one number
```