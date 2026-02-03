# Network Calls

With network calls, you're going to be pulling, processing, and then maybe sending JSON bewteen a server and client.

## Example: GitHub User API

**JSON Notes:**

- a single object lives within `{ }`
- you can get a list of objects, which looks like `[{ }, { }, { }]`

### Overview when working with network calls

1. Build Dummy UI
    - build it out using dummy data to visualize what data we're actually working with
2. Create Model
    - use the JSON response and create the models in the swift codebase
3. Write Networking Code
4. Connect it
    - use it in our view and connect UI with final result

### Create the Model

- use a struct
- using the dummy view, figure out what we actually need to display/have in the model
- look at the json and find the corresponding fields

`Codable`
- This protocol combines `Decodable` and `Encodable`
    - these are responsible for decoding json objects when downloading and then encoding data back into json objects and uploading, respectively

- when working with codable, you need to have property names match the json exactly
    - if you need custom behavior, then use coding keys
    - 90% of the time when `JSONDecoder.decode()` fails is because of a mismatch between the key names

```swift
struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}
```
- ^^ json uses snakecase, but swift uses camelCase

### Writing Network Code

We're going to use `async/await` because we are doing network calls (and we don't want the app to hang on these calls).

To make a network call, the most barebones setup is:

1. update the endpoint string to get the proper data
2. create a `URL` object
    - whenever we create a `URL` object, it will return as an optional, so need to make sure to unwrap/handle it
3. use `URLSession` to pull the data and then decode it into our model
    - has to take in a `URL` object
    - is async and throws so also need to mark with `try await`
    - returns the data (json), and http response (404 page not found, 200 success)

4. check the `URLResponse` object by unwrapping as `HTTPURLResponse` and check `response.statusCode`

5. create a `JSONDecoder` to decode the JSON to the model/type
- `JSONDecoder.keyDecodingStrategy = .convertToSnakeCase`
- determines how to decode a type's coding keys from JSON keys (in this case, convert the JSON keys from snake_case to camelCase)
- decode the data by doing: `JSONDecoder.decode(type.self, from: data)`, where `type` is your model and `data` is the `Data` object returned by `URLSession`


```swift
func getUser() async throws {
    let endpoint = "https://api.github.com/users/quinn2liu"

    guard let url = URL(string: endpoint) else { throw GHError.invalidURL }

    // (data: Data, response: URLResponse)
    let (data, response) = try await URLSession.shared.data(from: url)

    // need to wrap because 1. could error and not decode to HTTPURLResponse and 2. check the statusCode
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GHError.invalidResponse }

    // create decoder to decode the datea
    do {
        let decoder = JSONdecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubUser.self, from: data)
    } catch {
        throw GHError.invalidData
    }
}
```
- we want to be able to throw errors because so many things can go wrong

To have descriptive or insightful errors, we can create a custom `Error`
- `enum` that conforms to the `Error` protocol

```swift
enum GHError: Error, String {
    case invalidURL
    case invalidResponse
    case invalidData
}
```
### Connect to UI

- The network calls should be refactored into a `ViewModel`

For our case, we want this user data to appear when the view is opened, so we can do this with the `.task { }` modifier.

- `.task { }` adds an async task to perform before the view appears, sort of like `.onAppear( Task { } )`, but specific to async code.
- Any `async` func, when called, has to be preceeded by `await`. And all `await` functions have to be called within a `.task{ }` or `Task { }`

```swift
.task {
    do {
        user = try await getUser()
    } catch GHError.invalidURL {
        print("\(GHError.invalidURL.rawValue)")
    } catch GHError.invalidResponse {
        print("\(GHError.rawValue)")
    } catch GHError.invalidData {
        print("\(GHError.rawValue)")
    } catch {
        print("Unexpected error)
    }
}
```

#### Images

Without getting fancy, you can display an image using the `AsyncImage()` built in api. 

```swift
struct AsyncImage<Content> where Content : View
```

- `<Content>` is a sign of a generic (aka Content can be any type so long as it conforms to `View`)
- `AsyncImage` has several different constructors, but the most-basic is:

```swift
AsyncImage(url: URL(), content: (Image) -> View, placeholder: () -> View)
```
- you can read this as: `content` is a closure, it takes in an `Image` parameter and returns a view. `placeholder` is also a closure with no parameters and returns a view.

