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

## Dictionary

### Sort Dictionary by Values
- `sorted()` requires an iterable
- `myDict.items()` converts the dict into a list of tuples
- `sorted(myDict.items(), key=lambda item: item[1])` returns list of tuples sorted by the second element of the tuple
    - `key` tells sorted what value to use when sorting, and `key=lambda item: item[1]` signifies for each item in items, look at the 2nd element
- wrap in `dict()` to convert back to dict if desired
    - `dict(sorted(yourDictionaryHere.items(), key = lambda item: item[1]))`


