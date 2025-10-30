# Python Stuff

## Strings

**Remove punctuation from string**
- given string `word`
- `translator = str.maketrans('', '', string.punctuation)`
- `cleaned_word = word.translate(translator)`
    - The `maketrans(x, y, z)` method returns a mapping table that can be used with the translate() method to replace specified characters.
    - x ->	Required. If only one parameter is specified, this has to be a dictionary describing how to perform the replace. If two or more parameters are specified, this parameter has to be a string specifying the characters you want to replace.
    - y	-> Optional. A string with the same length as parameter x. Each character in the first parameter will be replaced with the corresponding character in this string.
    - z	-> Optional. A string describing which characters to remove from the original string.



