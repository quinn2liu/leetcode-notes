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

We start with `i`, which denotes the range of numbers in `nums` that we can consider adding to our result. With `i = 0`, this means that we can add `nums[0:n]` to our result (`n` is the length of nums). 

So for each node in our decision tree, we can think of it as the following: 

- In the left subtree, we can add elements from `i to n` to our result. In the right subtree, we can only consider adding elements `i + 1 to n`. We do this to ensure we don't have any duplicates in our output.

