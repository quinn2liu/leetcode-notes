# Unit Testing

A unit test is a where we test a small piece of code to ensure it gives us the expected outcome.

Key idea is the word *unit*, you want to test the smallest piece of code possible.

#### Why?

Prevents errors and regressions -> gives a level of safety and confidence
- regression is when you make the functionality, performance, or correctness of the function worse than a previous version

## Example: Tip Calculation Function

```swift
struct Calculation {
    func calculateTip(of enteredAmount: Double, with tip: Double) -> Double? {
        guard entereed amount >= 0 && tip >= 0 else { return nil }
        let tipPercentage = tip / 100
        return enteredAmount * tipPercentage
    }
}
```

**note:** your project must have a testing target.
- can initialize during app creation by checking *Include Tests*
- can add to project by going to *File -> New -> Target -> Unit Testing Bundle* 
- you can either use `XCTest` or `Swift Testing`
- this just generates boilerplate for testing
- you sohould have a test class for each area of your app in separate files for readability and maintainability

```swift
import XCTest
@testable import TipCalculator // TipCalculator is the name of the app, this allows us to use all the classes/structs/funcs within the standard app

final class CalculationTests: XCTestCase {

    // test the happy path (what you should expect)
    func testSuccessfulTipCalculation() {
        // calculateTip(of enteredAmount: Double, with tip: Double) { }

        // Given (arrange)
        let enteredAmount = 100.00
        let tipSlider = 25.0
        let calculation = Calculation()

        // When (act)
        let tip = calculatin.calculateTip(of: enteredAmount, with: tipSlider)

        // Then (assert)
        XCAssertEqual(tip, 25) // pass in the value to test, and then what it should evaluate to
    }

    // test edge cases
    func testNegativeEnteredAmountTipCalculation() {
        // calculateTip(of enteredAmount: Double, with tip: Double) { }

        // Given (arrange)
        let enteredAmount = -100.00
        let tipSlider = 25.0
        let calculation = Calculation()

        // When (act)
        let tip = calculatin.calculateTip(of: enteredAmount, with: tipSlider)

        // Then (assert)
        XCAssertNil(tip) // tip should be nil because we entered a negative amount
    }
}
```
**Basic structure of a test:**
1. set up variables
2. do something
3. assert what the variables should be