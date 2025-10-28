# Binary Search

Notes: The only algorithm that runs in `O(log n)` time. 

## 153. Find Minimum in Rotated Sorted Array

You are given an array of length n which was originally sorted in ascending order. It has now been rotated between `1` and `n` times. For example, the array `nums = [1,2,3,4,5,6]` might become:

`[3,4,5,6,1,2]` if it was rotated `4` times.
`[1,2,3,4,5,6]` if it was rotated `6` times.
Notice that rotating the array `4` times moves the last four elements of the array to the beginning. Rotating the array `6` times produces the original array.

Assuming all elements in the rotated sorted array `nums` are unique, return the **minimum** element of this array.

### Key Takeaways

So the key thing here is that we need to perform binary search, but we need to make sure that we change the way that we're updating our `start` and `end` pointers. 

If the array is rotated, there are 2 parts, where the left part is greater than the right part. If  `nums(mid)` is greater than the `nums(start)`, that means that `nums(mid)` is still in the left (or greater) part of the array, meaning that the minimum is somewhere to the right of `mid`. If `nums(mid)` is less than `nums(start)`, that means that we've either found the min, or it exists somewhere to the left of `mid`.

So for each iteration until the `start` and `end` pointers converge (they will eventually become the same based on the pointer updating we've specified), we will calculate `mid = (start + end) // 2`. Then, `result = min(result, nums[mid])`. This will return the correct result, because when `start = end`, then `nums[mid]` will either be the min, or next to the min.

    def findMin(self, nums: List[int]) -> int:
        start, end = 0, len(nums) - 1
        res = nums[0]

        while start <= end:
            if nums[start] < nums[end]:
                res = min(res, nums[start])
                break

            mid = (start + end) // 2
            res = min(res, nums[mid])
            if nums[mid] >= nums[start]: # mid is in the larger side of the array
                start = mid + 1
            else: # mid is in the smaller side of array
                end = mid - 1
        return res

## 33. Find Target in Sorted Rotated Array

You are given an array of length `n` which was originally sorted in ascending order. It has now been rotated between `1` and `n` times. For example, the array `nums = [1,2,3,4,5,6]` might become:

`[3,4,5,6,1,2]` if it was rotated 4 times.
`[1,2,3,4,5,6]` if it was rotated 6 times.
Given the rotated sorted array nums and an integer target, return the index of target within `nums`, or -1 if it is not present.

You may assume all elements in the sorted rotated array nums are unique,

A solution that runs in `O(n)` time is trivial, can you write an algorithm that runs in `O(log n)` time?

## Key Takeaways

This is very similar to the previous problem, but now we're actually given a target value to search for. This means that we need to more careful when updating our start and end pointers.

Solution:

    def findTarget(self, nums: List[int], target: int) -> int:
        start, end = 0, len(nums) - 1
        
        while start <= end:

            mid = (start + end) // 2

            if nums[mid] == target:
                return mid

            if nums[start] <= nums[mid]: # mid is in the larger side of the array
                if target < nums[mid] or target < nums[start]:
                    start = mid + 1
                else:
                    end = mid - 1
            else: # mid is in the smaller side of array
                if target > nums[mid] or target > nums[end]:
                    end = mid - 1
                else:
                    start = mid + 1

        return -1

Now that there's a target value, we have to be able to move in both directions based on our target value. Let's break down the logic.

Remember that if the array is rotated, there are 2 parts of the array, where the left-most element is larger than the right-most element (aka 2 sorted sections, where the left section's values are greater than the right section's)

`if nums[start] <= nums[mid]:`, this means the value `nums[mid]` has fallen within the larger section. Now we must consider whether we want to update `start` or `end`.

If we updated start = mid + 1, that happens in two situations. The first is when the `target > num[mid]`, this means that our target value falls to the right of mid, so `start = mid + 1`. The second is when `target < nums[start]`. Since we know that mid is in the larger section, if `target < nums[start]`, then target must live on the right side of the array, so `start = mid + 1`.

In every other case, we want to update `end = mid - 1`.

We can apply the opposite logic for when `nums[mid]` falls in the smaller portion of the array.