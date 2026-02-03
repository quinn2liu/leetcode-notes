# Classes vs. Structs

`class` and `struct` are both ways to create objects in swift.


You will likely be asked what the differences are between a `class` and a `struct`

**The overall answer is that `class` = reference type and `struct` = value type**

- what this means is that when created, a `struct` is a pointer (on the stack) that points to data on the heap.
- a `struct`, however, is just data (stack)

### `class` Example:

```swift
class Car {
    var year: Int
    var make: String
    var color: String

    init(year: Int, make: String, color: String) {
        self.year = year
        self.make = make
        self.color = color
    }
}
```

```swift
var myCar = Car(year: 2022, make: "Porsche", color: "Grey")
var stolenCar = myCar // two variables, but both references pointing to same piece of data
stolenCar.color = "Yellow"

print("\(myCar.color)")
// outputs: Yellow
```
### `struct` Example

```swift
struct Car {
    var year: Int
    var make: String
    var color: String

    // init is optional if you're not doing anything extra
    init(year: Int, make: String, color: String) {
        self.year = year
        self.make = make
        self.color = color
    }
}
```

```swift
var myCar = Car(year: 2022, make: "Porsche", color: "Grey")
var stolenCar = myCar // stolenCar is now a COPY of myCar

stolenCar.color = "Yellow"

print("\(myCar.color)")
// outputs: Grey
```

- when a value type is passed around, it is **copied**

*Google Sheets vs. Excel Analogy*

Google Sheet -> `struct`
- A google sheet can be accessed by multiple people (`struct` accessed by multiple pointers)
- one pointer's edits are seen by all the other pointers' edits

Excel -> `struct`
- an excel sheet (when created) is only edited and viewed by you
- if you send the sheet to someone else and they make edits, those edits do not appear for you

## Using a `class` vs. `struct`

`class` has inheritance, you can create subclasses of car that inherit all the properties of a car but also have subproperties.
-  ```swift 
    class RaceCar: Car {
        var number: Int
        var team: String
    }
    ```

- inheritance is a double-edges sword, because you don't want to inherit too much and have bloat/baggage

`struct` doesn't have inheretence and thus it's more **lightweight** and **performant**

