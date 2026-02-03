# Dependency Injection

## Initializer/Constructor Injection

**Example: Chipotle App** 

- You have a parent view that has all the possible menu items to order for this ordering session.
    - it's likely that you have some `NetworkManager` that handles the API calls, and a `Bag` to keep track of the items in the current order session
- When clicking an item, this brings you to a child view for that item, where you can modify and add it to your order.

This child view, then, you should keep track of the same `Bag` and will also need some `NetworkManager` to send network calls.
    - `Bag` and `NetworkManager` are **dependencies** required by the child view

Dependency injection in this case, is where the parent view, since it already has these objects, passes them into the child as dependencies. 
- we pass this through the initializer

```swift
class NetworkManager {
    func fetchIngredients() {
        print("Ingredients fetched")
    }
}

class Bag {
    var items: [String] = []

    func placeOrder() {
        print("Order placed")
    }
}

class BurritoIngredientsViewModel() {
    
    let networkManager = NetworkManager()
    let bag = Bag()

    func fetchItems() {
        networkManager.fetchIngredients()
    }

    func placeOrder() {
        bag.placeOrder()
    }
}
```

With dependency (initializer) injection, we don't want to create instances of `NetworkManager` and `Bag` in the initializer of the viewmodel, but rather we pass it in via the initializer:

```swift
// dependency injection version

class BurritoIngredientsViewModel() {
    
    let networkManager: NetworkManager
    let bag: Bag

    init(networkManager: NetworkManager, bag: Bag) {
        self.networkManager = networkManager
        self.bag = bag
    }

    func fetchItems() {
        networkManager.fetchIngredients()
    }

    func placeOrder() {
        bag.placeOrder()
    }
}
```

### Benefits

- simplify the data flow
- separation of concerns (we can swap out components)
    - let's say we want to change how the networkManager works, or even make a new one. 
    - with dependency injection, we can just change out which version of the networkManager we pass into the constructor and that's that
        - assuming that the new version has the same protocols, functions, etc
- for ^^ reason, that's what makes it easier to test. you can pass in a dummy version to a child view / function to test 
    - (like if you want to test how network calls are done, you can make a `MockNetworkManager` that calls dummy data and doesn't actually do any network calls)