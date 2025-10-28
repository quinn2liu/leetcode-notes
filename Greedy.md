# Greedy

## Overview

Greedy algorithms are algorithms that use the greedy-choice property and optimal substructure.

1. **Greedy-Choice Property:** A globally optimal solution can be arrived at by choosing locally optimal choices. In other words, you choose the best possible choice at each step with the hope of arriving at an optimal solution.

2. **Optimal Substructure:** The optimal solution to the problem can be constructed efficiently from optimal solutions to its subproblems. Unlike DP, where we store previously-computed values for alter, greedy algorithms only care about the the best choices at the current step.

## 53. Maximum Subarray

Given an array of integers `nums`, find the subarray with the largest sum and return the sum.

A **subarray** is a contiguous non-empty sequence of elements within an array.

Ex: 

    Input: nums = [2,-3,4,-2,2,1,-1,4]

    Output: 8

### Key Takeaway:

So this problem seems relatively simple, but the brute force method is incredibly taxing. The key observation here is that we want to keep track of the previous total of the max-subarray, and the current subarray that we are checking.

As we traverse through the array, we keep track of `curSum`, which we use to contain the current sum of whatever subarray we are checking. 

- One key thing to note is that if `curSum < 0`, then we simply reset `curSum = 0`. We do this because if `curSum < 0`, that means that up until the current number we're checking, the subarray's total is already negative. So if we don't reset `curSum`, then any calculation for `curSum` will include this negative value, in which case we should just start a new subarray.

- Effectively, you test every subarray because you know that whenever you check a new number, you're deciding whether to include the previous subarray.

Code:

    def maxSubArray(self, nums: List[int]) -> int:
        maxSub = nums[0]
        curSum = 0
        for n in nums:
            if curSum < 0:
                curSum = 0
            curSum += n
            maxSub = max(maxSub, curSum)
        
        return maxSub

## 55. Jump Game:

You are given an integer array `nums` where each element `nums[i]` indicates your maximum jump length at that position.

Return `true` if you can reach the last index starting from index `0`, or `false` otherwise.

Ex:

    Input: nums = [1,2,0,1,0]

    Output: true

### Key Takeaways

You could approach this problem using a dynamic programming approach, but it's also easier using a greedy approach.

We want to determine whether we can reach the end (let's call it `goal`) of the array from the start, however, what if we consider whether or not the index before the `goal` can reach it?

If the index before the `goal`, called `i` can reach goal, this means that we now have a subproblem, where we only need to see if the index before `i` can reach `i`.

So, all we have to do is iterate backwards, starting from the goal until we reach the start. If our `goal` has been updated to `== 0`, then we return `True`, if not, then `False`

Code:

    def canJump(self, nums: List[int]) -> bool:
        goal = len(nums) - 1

        for i in range(len(nums) - 1, -1, -1):
            if i + nums[i] >= goal:
                goal = i
        
        return goal == 0