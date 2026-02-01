# 2D Dynamic Programming

Instead of traversing/storing results in a 1d array, we can store them in a 2d array. Similar to 1D DP, we define `dp[i][j]` to be made up of some previously-calculated values in dp.

Instead of using a 2d array, since all we're using the array for is quick lookups, you can use a `dict` instead, where the key is a tuple of the indices `(i, j)`

## 62. Unique Paths

There is a robot on an `m x n` grid. The robot is initially located at the top-left corner (i.e., `grid[0][0]`). The robot tries to move to the bottom-right corner (i.e., `grid[m - 1][n - 1]`). The robot can only move either down or right at any point in time.

Given the two integers `m` and `n`, return the number of possible unique paths that the robot can take to reach the bottom-right corner.

### Key Takeaways

Since we can only move right or down, we can say that the number of unique paths to any position is the number of unique paths to the position to the left plus the position above -> `dp[i][j] = dp[i-1][j] + dp[i][j-1]`. So, we can iterate through and populate an `m x n` dp array and just return the value at `dp[m-1][n-1]`.

However, you need to make sure that you're only adding the # of paths from the left or from above if those are valid positions in the grid.

Lastly, initialize `dp[0][0] = 1` as there's only one path to get there.

```python
def uniquePaths(m, n):
    dp = [[0 for _ in range(n)] for _ in range(m)]
    dp[0][0] = 1
    i, j = 0, 0
    for i in range(m):
        for j in range(n):
            if dp[i][j] == 0:
                paths = 0
                if j-1 >= 0:
                    paths += dp[i][j-1]
                if i-1 >= 0:
                    paths += dp[i-1][j]
                dp[i][j] = paths

    return dp[m-1][n-1]
```

## 1143. Longest Common Subsequence

Given two strings `text1` and `text2`, return the length of their longest common subsequence. If there is no common subsequence, return `0`.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

- For example, `"ace"` is a subsequence of `"abcde"`.

A common subsequence of two strings is a subsequence that is common to both strings.

### Key Takeaways

The key difficulty is that for a subsequence, the elements don't have to be consecutive, but rather maintain a specific order.

Brute force, it's a decision tree. You have two pointers that correspond to `text1` and `text2`. If the `text1[i] == text2[j]`, then you call your dfs again but `i += 1` and `j += 1` (moving onto next characters in the strings) and add 1 to this. 

**BECAUSE:**
Let's have the following strings: `"abcdef"`, `"ade"`

When the first 2 characters are equal, we know that LCS is at least 1, and that we need to find the LCS between the rest of the strings.
- "**a***bcdef*"
- "**a***de*"

Incrementing both pointers to the dfs call says "add one (a == a) to the LCS of the rest of the string"

Using this same logic, if there isn't a match, then we have a decision. We either do `dfs(i+1, j) or dfs(i, j+1)`. These represent the strings with which we are trying to find the LCS's from.

**Introducing DP**

However, this is a lot of repeated calculation because the decision tree nature means that we can have several repeated calculations for `i` and `j` pairs. So for our DFS, on top of returning a length at the end, we will check for an entry in our dp cache (in this case, a hashmap).

So, it looks something like this:

```python
def longestCommonSubsequence(self, text1: str, text2: str) -> int:
    memo = {}
    m, n, = len(text1), len(text2)
    def dfs(i, j):
        if i == m or j == n:
            return 0
        if (i, j) in memo.keys():
            return memo[(i, j)]

        if text1[i] == text2[j]:
            memo[(i, j)] = dfs(i + 1, j + 1) + 1                
        else:
            memo[(i, j)] = max(dfs(i + 1, j), dfs(i, j+1))

        return memo[(i, j)]

    return dfs(0, 0)
```

## 494. Target Sum

You are given an array of integers `nums` and an integer `target`.

For each number in the array, you can choose to either add or subtract it to a total sum.

- For example, if `nums = [1, 2]`, one possible sum would be `"+1-2=-1"`.

If `nums=[1,1]`, there are two different ways to sum the input numbers to get a sum of 0: `"+1-1"` and `"-1+1"`.

Return the number of different ways that you can build the expression such that the total sum equals `target`.

### Key Takeaways

So immedietly you can recognize that this is at worst a backtracking solution, where for each number, you have two choices (add or subtract). When you reach the end of the array, if the result matches target, then you update some global result.

The next step is to recognize that you can memoize this function and thus use dynamic programming.
- memoization is the process of storing the results of a function based on its inputs (i.e. caching the results given its inputs to avoid repeat calculations)

The key distinction is to use **2D Dynamic Programming**.

Using the backtracking mental model, we can derive a definition for each state of the decision tree:

- `dp[i][a]` = number of ways we can sum up to amount `a` using the numbers up to index `i`

We need to keep track of `a` here (and thus we should use 2D Dynamic Programming) because the value we want to keep track of (number of ways to reach `target`) depends on two dimensions:
- which numbers we've "processed" (`i`)
- the different possible amounts that we end up with as a result (`a`)

At any index `i`, the same sum can be reached in multiple ways depending on earlier choices.

To derive our recurrent relation, we must understand that each `nums[i]` has two choices: add or subtract. So using the previous layer, `dp[i-1]`, we can add/subtract our new number (`nums[i]`) and get the new counts for the `ith` layer:

- `dp[i][a + nums[i]] = dp[i - 1][a]`
- `dp[i][a - nums[i]] = dp[i - 1][a]`

While you can think of `dp[0][0] = 1` as the base case, it makes more intuitive sense to do:

- `dp[0][nums[i]], dp[0][-nums[i]] = 1, 1` 

And then to fill out this array, it makes sense to iterate the amounts first, and then the nums index.
- logically, we should compute all the possibiilities at once for each number before moving onto the next number.
- the invariant relies on the fact that a number's entries relies on the previous number's entries, so we should process all the amounts for each number first