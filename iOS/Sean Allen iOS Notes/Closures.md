# Closures

**Definition:** Closures are self-contained blocks of functionaltity that can be passed around and used in your code.
- i.e. functions that can be passed around

### example: Students' scors

```swift
struct Student {
    let name: String
    var testScore: Int
}

let students = [
    Student(name: "Luke", testScore: 88),
    Student(name: "Han", tesetScore: 73),
    Student(name: "Leia", testScore: 95)
    ]

// closure
var topStudentFilter: (Student) -> Bool = { student in
    return try student.testScore > 80
}

// closure re-written as a function
func topStudentFilterFunc(_ student: Student) -> Bool {
    return try student.testScore > 80
}
```
^^ our closure is a **variable** of type `(Student) -> Bool`

- this means the closure takes in no 1 param of type `Student` and returns a single value of type `Bool`

To actually use this closure, one example is this:

```swift
let topStudents = try students.filter(topStudentFilter)
```

^^ the function call is `students.filter(isIncluded: (Student) throws -> Bool)`
- the signature for the closure (`(Student) -> Bool)`) must match the signature of the closure we pass into it

## Trailing Closure Syntax

When your closure is the last element in a function call, you can use trailing closure syntax

In the previous example:

```swift
let topStudents = try students.filter { student in
    return student.testScore > 80
}
```
- no need to define type because `.filter()` is being executed on an array of type `Student`
- can define the closure right here in the filter call
    - you want to extract the closure out so that it's cleaner and reusable

### Shorthand Syntax

Within trailing closure syntax, you can make it less-verbose by using positional arguments. 

For each input into the closure, you can use `$0`, `$1`, `$2`, etc, where `$0` corresponds to the first parameter of the closure:

```swift
let topStudents = try students.filter {
    return $0.testScore > 80
}
```
or even shorter
```swift
let topStudents = try students.filter { $0.testScore > 80 }
```

Another example:

```swift
let studentRanking = try topStudents.sorted(by: (Student, Student) throws -> Bool)

let studentRanking = try topStudents.sorted { $0.testScore > $1.testScore }
```
