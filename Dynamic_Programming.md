# Dynamic Programming

## Things of Note

Generally, you find an optimal solution to a problem by breaking it down into smaller, overlapping subproblems and using previously-computed values to build up to a solution. 

## 1-D DP

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