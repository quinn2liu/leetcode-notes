# Two Pointers

**Things of note**

observation: you move each pointer **programatically** based on some comparison. i.e. `if (condition 1)`, then move the left pointer. `if (condition 2)`, then move the right pointer.

## 15. Three Sum

Given an integer array nums, return all the triplets `[nums[i], nums[j], nums[k]]` where `nums[i] + nums[j] + nums[k] == 0`, and the indices `i`, `j` and `k` are all distinct.

The output should not contain any duplicate triplets. You may return the output and the triplets in any order.

### Key Takeaways

With 2 pointers, you essentially manipulate the pointers in a programatic way. In this problem, the key is that we sort the array first, so smaller numbers are on the left and larger on the right.

We start with `a` (which has index `i`), which is the left-most number we are checking. This is the smallest number. If `a` > 0, then we break. This is because if the invariant of `a` is that it's the smallest number, then `a` + `l` + `r` can't be 0 if `a` isn't negative. 

Next we have the pointers `l = i + 1`, or the element to the right of `a`, and `r = len(nums) - 1`, or the last element in the list.

While `l < r`, we compute the sum of `a, nums[l], and nums[r] = threeSum`. If this is 0, then we've found a soultion and append it to our return value. We then increase `l` by 1 and decrease `r` by 1 so that the next iteration checks for new values. In the case that `nums[l] == nums[l + 1]`, want to keep increasing `l` by one (while also making sure `l < r`) so that `nums[l]` is a new value.

There are then 2 remaining cases. If the absoute value of `a` is < than `nums[l] + nums[r]`, then we decrease r by 1. We eventually want `abs(a) == nums[l] + nums[r]`, so if the sum is greater than `abs(a)`, that means that we need to decrease the sum, and we can do that by moving the right pointer left.

Lastly, if `abs(a) > nums[l] + nums[r]` then we increase `l` by 1 using the same logic as above.

## 11. Container with Most Water

You are given an integer array `heights` where `heights[i]` represents the height of the ith bar.

You may choose any two bars to form a container. Return the maximum amount of water a container can store.

Ex: Input: height = [1,7,2,5,4,7,3,6], Output: 36

### Key Takeaways

Once again, we have two pointers and for each pass, we programatically update one of the pointers.

In this problem, the condition use to update the pointers is based on the smaller of the two bars. This is because our amount is "bottlenecked" by the smaller of the two bars. So in theory by moving this bar, we are hoping to find another bar that will no longer be the "bottleneck". 

This guarantees that we will eventually calculate the largest bucket amount. This is because we start with the largest amount with which we have tested (0). The only way we get a larger amount while testing all possibilities is if we change the smaller of the two bars in hopes of getting a larger amount. 