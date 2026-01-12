# Arrays + Hashing

**Things of note**

- Lambdas, Hashing with tuples vs lists, ord() for ascii
- To initialize empty array: `[""] * n`
- To initialize empty 2d array: `[[""] * n for i in range(n)]`
- `ord(char)` -> returns unicode character for the given char. if you want relative to the alphabet, use `ord(char) - ord('a')` 
- when you are traversing a list and are allowed O(n) space, probably storing some copy/information about the original input list as a hashmap/hashset/another list.
    - O(n) time can be 2 pointers, sliding window, or if you have O(n) space then some form of hash map/set (because those have O(1)) lookups.

## 1. Two Sum

Given an array of integers `nums` and an integer `target`, return the indices `i` and `j` such that `nums[i] + nums[j] == target` and `i != j`.

You may assume that every input has exactly one pair of indices `i` and `j` that satisfy the condition.

Return the answer with the smaller index first.

### Key Takeaways

To reduce complexity, you iterate through each value and then calculate it's subsequent "target pair" (target - value). Then, iterate through the remainder of the list and see if this "target pair" exists. If it does then you have your two values.

^^ brute force (O(n^2))

Better solution: make a pass through the array, creating a dict where keys are the nums and its index as the value. Then iterating through the dict's keys, calculate "target pair" (target - value) and search for it's existence in the dict. If the target pair exists, return it's corresponding index.
- a less-intuitive but more-optimized solution is do one pass, and check whether the "target pair" exists in the up-to-date dict. This is because since there are a pair of values, if you search behind for a num's pair and don't find it, the pair will be later in the list and when searching back through, will find it's pair from earlier in the array. 

## 49. Group Anagrams

Given an array of strings `strs`, group all anagrams together into sublists. You may return the output in any order.

An anagram is a string that contains the exact same characters as another string, but the order of the characters can be different.

### Key Takeaways

The overall idea is to create a list that keep's track of the count of each character in a word. Then, using that as a key, we can add strings that have the same letter counts.

Key point, however, is that in Python, lists are not-hashable. To avoid this, we can convert our frequency list into a tuple, which can be used as a key for a hash map.



## 347. Top K Frequent Elements

Given an integer array `nums` and an integer `k`, return the `k` most frequent elements within the array.

The test cases are generated such that the answer is always unique.

You may return the output in any order.

## Key Takeaways

If you want to sort a dictionary based on it's values, you can use the dict(sorted()) function with a lambda function to do so.

`sortedDict = dict(sorted(yourDictionaryHere.items(), key = lambda item: item[1], reverse = True))`

What's happening here is that `sorted()` requires an iterable to then sort, so `yourDictionaryHere.items()` converts the dictionary into a list of tuples. We use the `key` parameter to specify what we want to sort by. To sort by values, we use a lambda function that says for any input, denoted as item, we return item[1] (the second item in the tuple). 

**Runtime**: 
- sorting -> O(nlogn) from sorting
- heap -> O(klogn) k * time per heappop
- bubble sort -> O(n)

If you want to get fancy, you can maintain a max heap (min heap times -1), and heappop k times.

If you want to get fancy fancy, you can use a bubble sort. Store a fixed-size list of where the index con the numbers that have that index's frequency. The size of this list is = to the size of the input array. For example, index 2 contains a list of numbers that have frequency 2. This is O(n) space and nice because we just care about which numbers have the highest frequency.

## 271. Encode and Deocde Strings

Design an algorithm to encode a list of strings to a single string. The encoded string is then decoded back to the original list of strings.

Please implement `encode` and `decode`

### Key Takeaways

My solution essentially has the first 2 characters be the number of strings, and then the size of the corresponsding string in blocks of 3 characters. This solution depends on the fact that we know that there are < 100 strings and each string is < 200 characters long.

If we want to better generalize the solution, we can do this:

    def encode(self, strs: List[str]) -> str:
        res = ""
        for s in strs:
            res += str(len(s)) + "#" + s
        return res

    def decode(self, s: str) -> List[str]:
        res = []
        i = 0
        
        while i < len(s):
            j = i
            while s[j] != '#':
                j += 1
            length = int(s[i:j])
            i = j + 1
            j = i + length
            res.append(s[i:j])
            i = j
            
        return res

The main difference here is that the encoding is formatted so that the characters up to the first `#` represent the size of the string. This means that we don't need a standard length of characters to represent the length of each word.

## 238. Products of Array Discluding Self

Given an integer array `nums`, return an array `output` where `output[i]` is the product of all the elements of nums except `nums[i]`.

Each product is guaranteed to fit in a 32-bit integer.

Follow-up: Could you solve it in `O(n)` time without using the division operation?

### Key Takeaways

My solution uses the divide operator and an overall "product", which is just the total product without considering what index we're on. For our output, we just go by each index and divide by `nums[i]` (with some edge cases for 0's).

If we don't want to use divide, that's where it gets tricky.

First, this code, `for i in range(len(nums) - 1, -1, -1):`, means that i starts at `i = len(nums) - 1`, and will go until `i == -1` (non-inclusive). The last `-1` means that for each iteration we will "step" by -1.

    def productExceptSelf(self, nums: List[int]) -> List[int]:
        res = [1] * (len(nums))

        for i in range(1, len(nums)):
            res[i] = res[i-1] * nums[i-1]
        postfix = 1
        for i in range(len(nums) - 1, -1, -1):
            res[i] *= postfix
            postfix *= nums[i]
        return res

Here, the solution is essentially iterating through the list twice. 

On the first pass, res[i] is the previous value in res times it's corresponding value in nums. This means that by the end, `res[len(nums)]` is the product of all the numbers in nums before it, aka the prefix.

In the second pass, it essentially goes backwards and finds the "postfix", or the product of the numbers after any given index `i`.

**Okay better solution to ^^**
Prefix and suffix arrays. Make 2 passes through the array (forward and backwards, respectively) where prefix[i] is the product of all values before i, not including i. Same logic for suffix. Then `return [prefix[i] * suffix[i] for i in range(len(nums))]`

## 128. Longest Consecutive Sequence

Given an array of integers `nums`, return the length of the longest consecutive sequence of elements.

A consecutive sequence is a sequence of elements in which each element is exactly `1` greater than the previous element.

You must write an algorithm that runs in `O(n)` time.

### Key Takeaways

There are two keys to this problem. First, sets have amortized O(1) access time (average). The second, is a bit more involved.

If we think about a consecutive sequence, we know that a number `num` is the start of a sequence if `num - 1` doesn't exist in the set. So using this fact, everytime that `num - 1` is not in our set of numbers, we keep looking for `num + length`, where `length = 1`. 

In english, whenever we find the start of a sequence, we keep checking for the next item in the sequence until no more, and then we can compare this value `length` with whatever the length of the current longest sequence is.

    def longestConsecutive(self, nums: List[int]) -> int:
        numSet = set(nums)
        longest = 0
        if len(nums) == 0:
            return 0
        for num in nums:
            if (num - 1) not in numSet:
                length = 1
                while (num + 1) in numSet:
                    length += 1
                    num += 1
                longest = max(longest, length)

        return longest

## 560. Subarray Sum Equals K

Given an array of integers `nums` and an integer `k`, return the total number of subarrays whose sum equals to `k`.

A subarray is a contiguous non-empty sequence of elements within an array.

### Key Takeaways

The main difficulty of this problem is that the entries in `nums` can be negative. If they were strictly positive, we could do an iterative approach, where we add the next number to a running total, check if it's >= `k`, then handle it as so and reset the total.

The problem with using this solution with negative numbers is that it assumes the subarray total is constantly increasing, when in fact it may decrease and then increase again, resulting in a different subarray.

We want to similarly iterate through `nums`, but whenever we add a new `num`, I find it helpful to think about it as so:
- "Now that we've iterated to `num`, what (if any) are all the possible subarrays from this `num` to the start of `nums` that sum up to `k`?"

This is where the crux of the problem comes, you can observe that for any subarray, `sum(nums[i:j]) = sum(nums[0:j]) - sum(nums[0:i])`. So since we're basically incrementing `j` with each iteration of `num` in `nums`, we can check if at that point, there are any "prefix" sum arrays that have a value ` = sum(nums[0:j]) - k`.
- this is beacuse we're trying to get the equation `k = sum(nums[i:j]) = sum(nums[0:j]) - sum(nums[0:i])`
- so solving for k, this gives us `sum(nums[0:i]) = sum(nums[0:j]) - k`

So to know whether we have any prefix sums = `sum(nums[0:j]) - k`, we can maintain a hashmap where the keys are prefix array sums, and the value is the number of arrays that have this sum. We need a hash map because negative numbers means that a prefix sum could be a result of multiple different prefix arrays.

Putting this all together, we get something like this:

    def solution(nums, k):
        prefixSum = {0:1}
        currSum = 0
        res = 0

        for num in nums:
            currSum += num
            diff = currSum - k
            if prefixSum.get(diff):
                res += prefixSum[diff]
            prefixSum[currSum] = prefixSum.get(currSum, 0) + 1
        
        return res

- Note ^^ you need to initialize `prefixSum = {0:1}` with that base case in case a subarray (currSum) sums up to `k` without needing to chop off a subarray.

## 242: Valid Anagram

Given two strings `s` and `t`, return `true` if the two strings are anagrams of each other, otherwise return `false`.

An anagram is a string that contains the exact same characters as another string, but the order of the characters can be different.

### Key Takeaways

The main difficulty of this problem is that you are constrained by O(n + m) time (length of the strings) and O(1) space, so you can't make data structures that are O(n) or O(m).

Since we really only care about the frequency of each of the characters in the strings, we need some mapping between characters and count. A hashmap doesn't work though because we don't know how many key-value pairs there will be (even though in theory it's bounded by the alphabet).

So in this case, we can create an O(1) hash table by making arrays of size 26 (alphabet), where the indicies correspond to a letter of the alphabet and the values are its frequency in the word.

Use `ord(char) - ord('a')` to get the letter's unicode relative to 0.