# Math

## 202. Happy Number (Non-Cyclical Number)

A non-cyclical number is an integer defined by the following algorithm:

Given a positive integer, replace it with the sum of the squares of its digits.

Repeat the above step until the number equals 1, or it loops infinitely in a cycle which does not include 1.
If it stops at 1, then the number is a non-cyclical number.

Given a positive integer `n`, return `true` if it is a non-cyclical number, otherwise return `false`.

`O(log n)` time and space.

### Key Takeaways

So the two parts to this are 1. writing a helper function that computes the sum of the squared digits of a number, and 2. detecting whether it's cyclical or not.

The first part is just standard math, the function looks something like this:

```python
def sumSquaredDigits(n):
    result = 0
    while n > 0:
        digit = n % 10
        result += digit ** 2
        n = n // 2
    return result
```

The second part (depending on how much space you want to use) can be simple. If you're okay with O(log n) space, you can just use a hashset to keep track of numbers that have already been checked. If so, then we can return False.

Note: the runtime is `O(log n)` for 2 reasons. For the `sumSquaredDigits` function, we iterate for the number of digits in `n`, which is log base 10 of n + 1, which translated to `O(log n)`. The check for whether it's cyclic is a bit more complicated. Tbh, I don't fully understand it, but the idea is that at largest, any result from `sumSquaredDigits` is bounded by `9^2 * d`, where `d` is the number of digits of the input. And then because of this the scope of the max possible value decreases a lot with each iteration and can be considered constant (as it will repeat).

If you want O(1) space, then we have to consider the structure of this problem. Essentially, we're trying to detect a cycle between the outputs of `sumSquaredDigits`, where the edge is between the input and output of the function. We can use floyd's cycle detection algorithm (slow and fast pointer).

Instead of creating nodes for this so-called linked list, we can have one value be the current `slow` pointer, and another value be the `fast` pointer. We have `slow` just "move forward" by doing one call of `sumSquaredDigits`, and `fast` moves forward by doing 2 calls of `sumSquaredDigits`. The code then becomes something like this:

```python
def isCyclicNumber(n):
    slow, fast = n, sumSquaredDigits(n)
    while slow != fast: # guaranteed to terminate
        if slow == 1 or fast == 1:
            return True
        slow = sumSquaredDigits(slow)
        fast = sumSquaredDigits(fast)
        fast = sumSquaredDigits(fast)
    
    return True if slow == 1 else False
```