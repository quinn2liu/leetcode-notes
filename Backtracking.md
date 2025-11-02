# Backtracking

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

Then for our solution, we just do

    def combinationSum(self, nums: List[int], target: int) -> List[List[int]]:
        res = []
        # imagine we have dfs declared here

        # i = 0, curr = []
        dfs(0, [])
        return res
