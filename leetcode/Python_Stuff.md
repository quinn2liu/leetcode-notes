# Python Stuff

## String

### Remove punctuation from string
- given string `word`
- `translator = str.maketrans('', '', string.punctuation)`
- `cleaned_word = word.translate(translator)`
    - The `maketrans(x, y, z)` method returns a mapping table that can be used with the translate() method to replace specified characters.
    - x ->	Required. If only one parameter is specified, this has to be a dictionary describing how to perform the replace. If two or more parameters are specified, this parameter has to be a string specifying the characters you want to replace.
    - y	-> Optional. A string with the same length as parameter x. Each character in the first parameter will be replaced with the corresponding character in this string.
    - z	-> Optional. A string describing which characters to remove from the original string.

### Getting unicode integer of a character
- given a `char`, call `ord(char)` to get its unicode
- if you want the numbers relative to the alphabet, do `charInt = ord(char) - ord('a')`

## Dictionary

### Sort Dictionary by Values
- `sorted()` requires an iterable
- `myDict.items()` converts the dict into a list of tuples
- `sorted(myDict.items(), key=lambda item: item[1])` returns list of tuples sorted by the second element of the tuple
    - `key` tells sorted what value to use when sorting, and `key=lambda item: item[1]` signifies for each item in items, look at the 2nd element
- wrap in `dict()` to convert back to dict if desired
    - `dict(sorted(yourDictionaryHere.items(), key = lambda item: item[1]))`

### Dictionary from Array
initialize a `dict` of key's and values from an array, where the keys are indexes and values are values

- `dict = {val: idx from idx, val in enumerate(your_array)}`


### Equality of Dictionaries
- You can easily check whether 2 dictionaries are equal by using the equals operator.
    - `dict1 == dict2` -> returns a Bool

### Max Value of Dictionary Values (and maybe keys?)

- You can get the max value of all dictionary values like this:
    - `maxValue = max(dict.values())`
    - can also do `min()`, and also for `dict.keys()` 

## Dictionary Keys

User-specified objects (unless there are defined `__eq__` or `__hash__` methods) are hashable using the object's id (aka referenced similarity instead of object similarity).

```python
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = int(x)
        self.next = next
        self.random = random
```

In this case, `a, b = Node(1), Node(1)`, `a == b` is False, because they are different objects. This means that we can use them as keys in a dict.

### Array/Tuple/Set as Key

There are some important caveats when using different data types as dictionary keys in python. The main thing is that the key has to be hashable (and in these cases, their elements have to be hashable).

An array is mutable and thus is not hashable, but you can get around this with either of the following options:

1. Tuple as a key
    - you can convert the array to a tuple (if you're fine with not ever mutating it)
    - `resTuple = tuple(originalArray)`
2. Set as a key
    - you can't use a standard set because it's mutable, but you can instead use a `frozenset()`
    - frozen sets are sets that can't add or remove elements (but can still be used for union, intersection, difference)

## "None" as a Key

Along the same vein, you can use `None` as a key in a dictionary as well.