# Stacks

**Things of note**

As demonstrated in the decode string problem (as well as valid parenthesis), a stack is very helpful in this case / captures the recursive nature.

## 394. Decode String

Given an encoded string, return its decoded string.

The encoding rule is: `k[encoded_string]`, where the encoded_string inside the square brackets is being repeated exactly `k` times. Note that `k` is guaranteed to be a positive integer.

You may assume that the input string is always valid; there are no extra white spaces, square brackets are well-formed, etc. Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, `k`. For example, there will not be input like `3a` or `2[4]`.

### Key Takeaways

So the main nuance of this problem is that you need to handle the case when there are nested encoded portions.

For ex: 

    Input: s = "3[a2[c]]"
    Output: "accaccacc"

You can capture this recursive behavior using recursive function calls, or also using a stack (as that's basically how recursion works).

#### Stack Solution

This is probably the more-straight forward way (at least conceptually). 

You need some way of tracking the order of k's so that you can construct the different encoded strings. What I mean by this is that if you are encoding a string and encounter a "child" encoded string, you still need to append the resulting parent to the result.

So, you can track this using a `strStack` and `countStack`. `strStack` tracks the current "encoded" string we are constructing and the corresponding entry in `countStack` represents the eventual `k` value to multiply the encoded string by.

We will process `s` by each character, and depending on what the character is, we'll perform different actions:
    
    k = 0
    self.index = 0
    res = ""

    for i in range(len(s)):
        c = s[i]

        if c.isdigit():
            k = k * 10 + int(c)
        
        elif c == '[':
            strStack.append("")
            countStack.append(k)
            k = 0
        
        elif c == ']':
            count = countStack.pop()
            appendStr = count * strStack.pop()

            if strStack:
                strStack[-1] += appendStr
            else:
                res += appendStr
        
        else:
            if strStack:
                strStack[-1] += c
            else:
                res += c
    
    return res

So as a quick recap:

- `if c == '['`
    - we are starting a new encoding, so we append `""` to `strStack`, the current `k` value to `countStack`, and then reset `k` in case we start processing digits again.

- `if c == ']'`
    - we have concluded the current encoding, so we must update the previous encoded string (or if there is none, we update the result). So we pop from both `strStack` and `countStack`, and update the last item in `strStack` if it exists, and if not, we update `res`

- `if c.isdigit()`
    - here, we know we are only going to see digits, or '[', so we just update `k` using math for the appropriate digit

- `else`
    - here we just add the character to whatever encoded string we're encoding. similar to the ']' case, though, if there is no `strStack`, we append to `res`

Then after iterating through all the characters, we can return the result

#### Recursive Solution

The recursive solution follows a similar principle, but with recursive function calls using a class variable, self.i.

Instead of specifying a string and count stack, these are stored at the function call level.

so the helper looks something like this:

    def helper():
        k = 0
        res = ""
        while self.i < len(s):
            c = s[i]
            if c.isdigit():
                k = k * 10 + int(c)
            
            elif c == '[':
                self.i += 1
                res += k * helper()
                k = 0
            
            elif c == ']':
                return res                
            else:
                res += c
            self.i += 1

        return res
    
Each call of helper represents the current encoding layer we're on. So k and res are initialized to default values. 

- When we encounter `[`, that means we should go down a layer, aka update `res = k * helper()` and reset k (since we've "used" this k value).
- When `c == ]`, then we pop up a layer by returning the current result
- and then similar logic to the previous case for the other 2 cases

