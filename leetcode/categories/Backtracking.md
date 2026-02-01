# Backtracking

## Things of Note

At least for these problems, "backtracking" results in some decision tree. One big clue is the runtime, which is something like `O(o^s)`, where o = number of options at each decision, and s = number of decisions.

Since this is a decision **tree**, can traverse it using a dfs (recursion)

Backtracking is also usually used if you need to build a solution step by step and/or do some sort of exhaustive search over all possibilities.

## 39. Combination Target Sum

You are given an array of **distinct** integers `nums` and a target integer `target`. Your task is to return a list of all **unique combinations** of `nums` where the chosen numbers sum to `target`.

The **same** number may be chosen from `nums` an **unlimited number of times**. Two combinations are the same if the frequency of each of the chosen numbers is the same, otherwise they are different.

You may return the combinations in **any order** and the order of the numbers in each combination can be in **any order**.

    Input: 
    nums = [2,5,6,9] 
    target = 9

    Output: [[2,2,5],[9]]

### Key Takeaways

The key in this problem is understanding how we want to make our decision tree. The logic for the tree is as follows:

1. We start with `i`, which denotes the range of numbers in `nums` that we can consider adding to our result. With `i = 0`, this means that we can add `nums[0:n]` to our result (`n` is the length of nums). 
2. At each iteration we have two paths in the decision tree. The left subpath is "what happens when we add `nums[i]` to the current array" (i.e. we can keep adding `nums[i]` to curr). The right subpath is "what happens if we no longer can add `nums[i]` to the array (we can add elements `i+1 to n`). We do this to ensure that all results don't have duplicates.

Since we're using a decision tree, we'll use a depth-first search to traverse it and accumulate our results. To do this, we'll need to define a helper dfs function, where i denotes the current index we are splititng the decision from, curr is the current array of integers. Note that since this is a helper, it has access to our result `res = p[]`, `nums`, and `target`
```python
def dfs(i, curr):
    total = sum(curr)

    # desired case, we've found a valid solution
    if total == target:
        res.append(curr.copy)
        return

    # curr / iteration is not longer valid
    if total > target or i >= len(nums):
        return
    
    # add nums[i] again to curr (left-side)
    curr.append(nums[i])
    dfs(i, curr)
    
    # no longer can add nums[i] (right-side)
    curr.pop()
    dfs(i + 1, curr)
```

Then for our solution, we just do
```python
def combinationSum(self, nums: List[int], target: int) -> List[List[int]]:
    res = []
    # imagine we have dfs declared here

    # i = 0, curr = []
    dfs(0, [])
    return res
```

**NOTE:** You need to do `curr.pop()` after exiting the branch with which curr is getting a new num. This is because curr is shared by all recursive calls, so if we only do `curr.append()` upon entry of the recursive level and not `curr.pop()` upon exit, higher levels of the tree are going to view an expanded `curr`. 

**Runtime:**

The time complexity for this problem is `O(2^t/m)` and the space complexity is `O(t/m)`. The space complexity is since curr can't be larger than `t/m`.

The runtime is because we're traversing a binary decision tree, each step we have 2 options: include `nums[i]` or no longer include `nums[i]`. And since we know that the resulting arrays can be no larger than `t/m`, the runtime is `O(2^t/m)`.

## 79. Word Search

Given a 2-D grid of characters `board` and a string word, return `true` if the word is present in the grid, otherwise return `false`.

For the word to be present it must be possible to form it with a path in the board with horizontally or vertically neighboring cells. The same cell may not be used more than once in a word.

Runtime: `O(4^n)` time, `O(n)` space

**Ex:** searching for "cat"

![Alt text](https://imagedelivery.net/CLfkmk9Wzy8_9HRyug4EVA/7c1fcf82-71c8-4750-3ddd-4ab6a666a500/public)


## Key Takeaways

The giveaway here is that this is a very-inefficient runtime, so we're likely going to need to check many different possibilities, i.e. a decision tree. In this case, it makes sense that the runtime is O(4^n) because for each letter we are checking we are going to check the neighboring letter in each of the 4 directions. And to traverse this decision tree, we will use a recursive dfs approach.

Recall that when writing a dfs, you specify

1. the success and failure cases (when to return from the algorithm)
2. any processing during that iteration
3. the recursive call on new parameters that maintain the subproblem

## 131. Palindrome Partitioning

Given a string `s`, split `s` into substrings where every substring is a palindrome. Return all possible lists of palindromic substrings.

You may return the solution in any order.

**Example 1:**

- Input: `s = "aab"`
- Output: `[["a","a","b"],["aa","b"]]`

**Example 2:**

- Input: `s = "a"`
- Output: `[["a"]]`

### Key Takeaways

After some time trying to come up with a brute force solution, I realized that this would have to be a greedy problem because the solutions would build/branch off of each other (you have to decide whether to continue trying to build a palindrome or to partition and start from the next index).

One thing that I'm running into with backtracking / decision tree problems is to make sure to be careful when passing the partial solution to the next layer of the tree. Depending on the language but for python at least the you're passing in the reference, so updates to that partial solution in subseqent calls will update the original object.

For example:

```python
def createPalindrome(i, currRes):
    if i == len(s): 
        res.append(currRes)
        return
                
    currP = ""

    while i < len(s):
        currP += s[i]
        i += 1
        if isPalindrome(currP):
            print(f"currP: {currP}, index: {i}")
            newRes = currRes[:]
            newRes.append(currP)
            createPalindrome(i, newRes)       
```

If we didn't make newRes and instead did something like `

    currRes.append(currP)
    createPalindrome(i, currRes)

Then currRes would append all the subsequent `currP`s, even if they're not supposed to be in that solution list.

So, you can do what I did here which is create a shallow copy of the list to make a new state, or you can do something like this:

    currRes.append(currP)
    createPalindrome(i, currRes)
    currRes.pop()

This maintains the correct state for currRes as it travels through recusive calls.