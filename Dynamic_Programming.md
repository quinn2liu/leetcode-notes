## Things of Note

Generally, you find an optimal solution to a problem by breaking it down into smaller, overlapping subproblems and using previously-computed values to build up to a solution. 

This concept is `memoization`, or storing the results of expensive function calls and reusing them for later when the same inputs (or subset of inputs) are used again.

# 1-D Dynamic Programming

You usually store the results in a 1-D array.

1. DP is useful when the problem can be divided into smalelr subproblems, which are reused multiple times (**optimal substructure**)

    - Subproblems should overlap, meaning that the solution for 1 can be used for others.

2. Define the state

    - for 1-D DP, the state is usualy represented by an index `i`, where `dp[i]` holds information about the optimal solution for a subproblem involving the first `i` elements.

3. Recurrence Relation

    - defines how to compute the value of `dp[i]` using previously-computed states.

4. Base Case Initialization

    - The base case is the simplist version of the problem that can be solved without recursion

5. Iterative Computation

    - Can use the recurrence relation and base case to fill each value in `dp[]` from left to right (bottom-up).

## 70. Climbing Stairs

You are given an integer `n` representing the number of steps to reach the top of a staircase. You can climb with either `1` or `2` steps at a time.

Return the number of distinct ways to climb to the top of the staircase.

### Key Takeaways:

This is a 1-D Dynamic Programming problem. In this problem, we can define an array, called `dp`, of size `n + 1` to represent each of the stairs, where the `nth` index is stair n, and the `0th` index is before any stairs.

Since this is DP, we need to define what each element in the array represents. In our problem, the `ith` element in the array will contain the number of ways we can reach the `ith` step.

With that logic, we can say that `dp[0]` and `dp[1]` are both initialized to equal 1. 

So then the rest of the problem is to populate the rest of the items in the array. So for the `range (2, n + 1)`, `dp[i]` is sum of the number of unique ways to get from the `i-1` stair to the `i` stair, and the unique ways to get from the `i-2` stair to the `i` stair. This represents the fact that we can only take 1 or 2 steps at a time.

Code:

    def climbStairs(self, n: int) -> int:
        dp = [0] * (n + 1)
        dp[0] = 1
        dp[1] = 1

        for i in range(2, n + 1):
            dp[i] = dp[i-1] + dp[i-2] # curr stair minus 1, curr stair - 2
        
        return dp[n]


## 198. House Robber

You are given an integer array `nums` where `nums[i]` represents the amount of money the `ith` house has. The houses are arranged in a straight line, i.e. the `ith` house is the neighbor of the `(i-1)th` and `(i+1)th` house.

You are planning to rob money from the houses, but you cannot rob **two adjacent houses** because the security system will automatically alert the police if two adjacent houses were both broken into.

Return the maximum amount of money you can rob without alerting the police.

### Key Takeaways:

To solve this problem, you need to remember that with DP, you're breaking things down into subproblems. 

In this problem, let's define our dp array as `dp = [0] * len(nums)`. Here, we will consider the `ith` element in `dp` to be the maximum value that we can steal up to the `ith` house.

Given this definition, we need to consider what happens at the ith house. `dp[i - 1]` can be interpreted as the max value that can be stolen if we DON'T want to steal from the `ith` house. If we do want to steal from the ith house, then the total value that we can steal becomes `dp[i - 2] + nums[i]`, to account for the adjacent restriction. 

Then, `dp[i]` becomes `max(dp[i - 1], dp[i - 2] + nums[i])`, or whichever of the 2 choices yields the greater result.

At the end, we just return the last element in the array, as we've considered all `n` houses.

Code:

    def rob(self, nums: List[int]) -> int:
        dp = [0] * len(nums)

        if len(nums) == 1:
            return nums[0]

        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])

        return dp[len(nums) - 1]

## 213. House Robber II

Same as House Robber I, but the houses are in a loop, meaning that the last house is now adjacent to the first house.

### Key Takeaways:

This is actually a very similar problem to House Robber I, and we can use the exact same code, just with a slight modification.

Now that the houses are in a circle, we know that house `0` and house `n` are neighbors. If we choose to rob the first house, that means we can't also rob the last house, and vice versa.

This means that we need to run house robber on a 2 subarrays, where the first subarray is if we decide to rob the first house (and not the last)and the second array is if we decide to rob the last house (and not the first).

These subarrarys are nums[1:] and nums[:-1].

Code:

    def helper(self, nums):

        if len(nums) == 1:
            return nums[0]

        dp = [0] * len(nums)

        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])
        
        return dp[-1]


    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]

        return max(self.helper(nums[1:]), self.helper(nums[:-1]))

## 152. Maximum Product Subarray

Given an integer array `nums`, find a **subarray** that has the largest product within the array and return it.

A **subarray** is a contiguous non-empty sequence of elements within an array.

### Key Takeaways

The key difficulty of this problem is that the number in nums could be negative. So whenever you introduce a new number to your current max subarray, it could just invert the sign. You would think it is best then to get rid of this subarray product when it's negative, it could be multiplied by a later negative number to become positive again.

But, let's imagine if the numbers were stricty positive (and maybe 0), then what would we do?
- You would keep a global `result` and `currMax` variable. Current max is the product of the current max subarray. So while iterating through each `num` in `nums`, we do the following:

        newMax = currMax * num
        currMax = max(newMax, num)
        result = max(result, currMax)

    - the key point is knowing when to reset our subarray. In this case, we'd reset in case a num is 0, hence why `currMax = max(newMax, num)`, in case the `newMax` becomes 0

So to handle the negative number case, we want to keep a running minimum value, `currMin` as well. This is so that if the next `num` is negative and `currMin` is negative, then the resulting product is our new `result`.

So to support negative numbers, for each iteration of the for loop we do:

    newMin, newMax = currMin * num, currMax * num

    currMax = max(newMin, newMax, num)
    currMin = min(newMin, newMax, num)

    result = max(currMax, result)

- ^^ note that we do the min/max of `newMin`, `newMax`, and `num` because `newMin` could be the new max after a negative is multiplied, `newMax` could the new min after a negative is multiplied, and `num` resets the subarray.

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
