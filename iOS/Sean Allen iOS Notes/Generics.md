# Generics

**Eliminate code duplication by creating a general solution that can handle various types.**

Ex: You have a function that drives you home after work. It doesn't care which care you have, but if it has a motor and wheels, then it will work.

```swift
func driveHome<T: Drivable>(vehicle: T) {
    // code to drive the variable home
}
```

How to interpret this:
- `<T: Driveable>` 
    - signifies that `driveHome()` takes a generic type of `T` as a parameter.  
    - this type `T` can be any data type as long as it conforms to `driveable` protocol
- `(vehicle: T)`
    - when calling the function, we have to pass in a parameter `vehicle` of type `T`. `vehicle` is what we perform operations on.

Example protocol:
```swift
protocol Driveable {
    var motor: Motor { get }
    var wheels: Int { get }
}
```

Example types:

```swift
struct Porsche911: Drivable {
    var motor: Motor
    var wheels: Int

    // Porsche-specific code
}

struct Motorcycle: Drivable {
    var motor: Motor
    var wheels: Int
    
    // Motorcycle-specific code ehre
}

let myPorsche = Porsche911(motor: Motor(), wheels: 4)
let myMotorcycle = Motorcycle(motor: Motor(), wheels: 2)

driveHome(vehicle: myPorsche)
driveHome(vehicle: myMotorcycle)
```

## Steps to use a generic

- declare your function and specify the generic type `T` and constrain it (assign protocols).
- then use the generics as you see fit when defining the parameters

```swift
func determineHigherValue<T: Comparable>(valueOne: T, valueTwo: T) {
    let higherValue = valueOne > valueTwo ? valueOne : valueTwo
}
```
- ^^ **note** you if you define multiple parameters as a generic type, all of those parameters must be the same type (even if they both conform to the generic)

    - ex: you **cannot** do `determineHigherValue("one", 2)`

### Fetching Data example

Back from the network calls section, there's a lot of boilerplate for fetching JSON data that isn't unique to the specific item we are trying to fetch. We can use generics to get a simplified version.

```swift
func fetchData<T: Decodable>(for: T.Type, from url: URL) async throws -> T {
    let (data, _) = try await URLSession.shared.data(from: url)
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        throw error
    }
}

// example call
let user = try await NetworkManager.shared.fetchData(for: User.self, from: url)
```

- ^^ `for:` expects a type, not an instance, so we pass in `T.Type`

**Note:** stylistically, only use generics when it's a slam dunk case (i.e. you know you'll be calling it for many different types). If it's like 5, then just use the strict type definition for readability and to avoid premature optimization.


