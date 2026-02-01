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

```python
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
```
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
```python
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
```
Each call of helper represents the current encoding layer we're on. So k and res are initialized to default values. 

- When we encounter `[`, that means we should go down a layer, aka update `res = k * helper()` and reset k (since we've "used" this k value).
- When `c == ]`, then we pop up a layer by returning the current result
- and then similar logic to the previous case for the other 2 cases

## 155. Min Stack

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

Implement the `MinStack` class:

- `MinStack()` initializes the stack object.
- void `push(int val)` pushes the element `val` onto the stack.
- void `pop()` removes the element on the top of the stack.
- int `top()` gets the top element of the stack.
- int `getMin()` retrieves the minimum element in the stack.

You must implement a solution with `O(1)` time complexity for each function.

### Key Takeaways
My main difficulty with this problem was not properly understanding it when reading, but it's actually pretty simple.

You have 2 stacks, one that tracks the minimum at that "level" of the stack, and another being the stack itself. Whenever you append to the stack, you'll check whether this new value is smaller than the previous min. If it is then add it to the minStack and if not add the same minimum.

Then whenever you pop, you also pop the min to maintain the invariant.

## 678. Valid Parenthesis String

You are given a string `s` which contains only three types of characters: `'('`, `')'` and `'*'`.

Return `true` if `s` is valid, otherwise return `false`.

A string is valid if it follows all of the following rules:
- Every left parenthesis `'('` must have a corresponding right parenthesis `')'`.
- Every right parenthesis `')'` must have a corresponding left parenthesis `'('`.
- Left parenthesis `'('` must go before the corresponding right parenthesis `')'`.
- A `'*'` could be treated as a right parenthesis `')'` character or a left parenthesis `'('` character, or as an empty string `""`.

### Key Takeaways

There are 2 ways to do this problem efficiently (and then a brute force version). The key difficulty is that while scanning `s`, you have no way of knowing what the `'*'` should be at that time. 

The **brute force** way of handling this is to use a decision tree, where you do a recursive call for each of the 3 possibilities of `'*'`. 
- For each of these calls (depending on what it is), you should keep track of the number of "unclosed" open brackets. Encountering a `)` or setting a wildcard as `)` would reduce this by one, and if you reach the end of the string then and the # of left closing brackets is 0, then it's valid.

The **less-intuitive but optimal solution** is a greedy solution. As mentioned above, you can think about whether parenthesis are valid based on the number of "unclosed" open brackets there are at that point in the string.

- however, instead of trying all possibilities when encountering `'*'`, you can think of the scenario for if we count it as open or closed.
- if it's open, the number of unclosed increases by one, whereas if it's closed, the number of unclosed decreases by one.
- so, we can keep track of both the min and max possible unclosed brackets at that time, which we update as follows:
    - if `(`, `min += 1` and `max += 1`
    - if `*`, `min -= 1` (considering it as `)`) and `max += 1` (considering it as `(`).
    - if `)`, `min -= 1` and `max -= 1` 

- If at any point `max < 0`, then return false (since at this point, there are more `)` than both `(` and `*`).
- If `leftMin < 0`, then `leftMin = 0` (if we get here, then `leftMax > 0`, so there for sure some `*`, which we can treat as empty)

The more-intuitive version is a stacks approach, which is more similar to the first version of this problem.

The key is recognizing that we should first try and close any closing brackets that we see using open brackets (and `*` if necessary). Then, if there are any remaining open brackets, try closing them with the stars.
- the reasoning is that every `(` and `)` needs to be closed, so we should try and closing as many of them with each other that we can. And then any extra `*` can close or be empty if needed.

So to be able to do both of these checks, we need to keep track of the positions of `(` and `*`, in their own separate stacks.

The code looks like something that this:

```python
def checkValidString(self, s: str) -> bool:

    starStack = []
    openStack = []

    for i, c in enumerate(s):
        if c == "(":
            openStack.append(i)
        elif c == "*":
            starStack.append(i)
        else: # c == ")"
            if openStack:
                openStack.pop()
                continue
            elif starStack:
                starStack.pop()
                continue
            else: # no valid elements in either stack to close this bracket
                return False
    
    while len(openStack) > 0 and len(starStack) > 0:
        openI, starI = openStack.pop(), starStack.pop()
        if openI > starI:
            return False
    
    return False if len(openStack) > 0 else True
```

- ^^ the final check is in case there are lingering `(` after closing all the `)`. In case of lingering `(`, we need to check if there is a `*` to its right. Since we've been storing the positions of `(` and `*` in stacks, we can pop from both and count this as "closing".
- if the position of the right-most `(` is farther than the right-most `*`, then this `(` can't actually be closed, so we return `False`.

## 853. Car Fleet

There are `n` cars traveling to the same destination on a one-lane highway.

You are given two arrays of integers `position` and `speed`, both of length n.

- `position`[i] is the position of the ith car (in miles)
- `speed`[i] is the speed of the ith car (in miles per hour)

The **destination** is at position `target` miles.

A car can not pass another car ahead of it. It can only catch up to another car and then drive at the same speed as the car ahead of it.

A car fleet is a non-empty set of cars driving at the same position and same speed. A single car is also considered a car fleet.

If a car catches up to a car fleet the moment the fleet reaches the destination, then the car is considered to be part of the fleet.

Return the number of **different car fleets** that will arrive at the destination.

### Key Takeaways

So I'd say this problem boils down to 1 main question: **How can you determine (without simulating) whether any 2 cars will result in a fleet?**

- You can calculate the `time` it takes for a car to reach the destination by doing `(target - position) / speed`.
- if car a's `time` is less than car b's `time` to reach the destination (and car b's position is ahead of car s's) then you have a fleet

While you can go through each pair of cars and eliminate one if it ends up bottlenecked (join a fleet), you'd end up with an O(n^2) time algorithm, since you would have to keep iterating through the cars and processing each pair.

So to do this more systematically, since you know that a car can only be bottlenecked by a car ahead of it position-wise, you can start by sorting the cars in descending order based on their positions.

Then, by using a stack, we process each car by comparing its time to the fleet with the highest time which starts before it.
- in other words, the top of the stack represents the fleet that starts before our current car and its time to reach the destination
- if the current car's time is <= fleet's time, then it will just join the fleet and we continue
- else (curr time > fleet), this car becomes it's own fleet and is added to the stack.

### **Note:** there are several ways in which it's intuitive to use a stack here.
- you sort to process elements in a specific order (position desc order)
    - or scan in one direction in general 
- each element only interacts with its predecessor (LIFO)
- only the boundary values survive (in this case, we only care about the most-recent fleet)