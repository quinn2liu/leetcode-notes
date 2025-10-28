# Sliding Window

General Idea: A fixed or variable-size window is moved through a datastructure. Often used for subsets of elements (like a subset or substring that meets a set of conditions).

The window is maintained by 2 pointers, similar to the Two-Pointers technique. The main difference is that 2 pointers only tracks 2 parts of the data structure and moves based on conditions.

**Sliding Window** has right pointer move to expand the window, while the left is used to maintain the window and make sure it's still valid.

Most of the time, you start by expanding the window until the window is no longer valid. Then you move the left pointer to shrink the window until it's valid again.

# 3. Longest Substring Without Duplicates

Given a string s, find the length of the longest substring without duplicate characters.

A substring is a contiguous sequence of characters within a string.

ex: Input: s = "zxyzxyz", Output: 3

## Key Takeaways

This is a sliding window problem with a variable size. Here, `l` is used to maintain our no-duplicate substring, and `r` is expanding the window.

To maintain the window in this problem, we essentially need to update the start of the substring we are checking. 

The pointer `r` serves as the speculative end of our window (is there a window that ends at `r` and starts at `l` that has no duplicates). `r` navigates through the string and continues to increase until `s[r]` is in `charSet`. If this is the case, we continue to remove `s[l]` and update the `l` pointer until `s[r]` is no longer a duplicate. This action essentially moves the left of our window until the remaining window no longer contains any duplicates.

When there are no more duplicates, we then add `s[r]` to our set and then recalculate `res` to be `max(res, r - l + 1)`. 

This means that on the next iteration of r, we can say: "we know that [l:r - 1] has no duplicates and we've already checked if that length is the max. we will check if `s[r]` is a duplicate, if so we will move `l` until `s[r]` is no longer a duplicate, check it's length, and then repeat."

## 424 Longest Repeating Substring with Replacement

You are given a string `s` consisting of only uppercase english characters and an integer `k`. You can choose up to `k` characters of the string and replace them with any other uppercase English character.

After performing at most `k` replacements, return the length of the longest substring which contains only one distinct character.

### Key Takeaways

In this problem, the condition we need to preserve for a valid sliding window is that "the number of characters we need to replace must be `<= k`"

To figure this out, we have a dictionary representing the number of each character currently present in the substring. Then to get the number of characters we need to replace, we do "size of window - count of most-frequent letter", or `(r - l + 1) - max(count.values)`.

While this quantity is `> k`, the left pointer is moved until we have met this condition. Only after this we will update our result to be `max(res, (r - l + 1))`.

    def characterReplacement(self, s: str, k: int) -> int:
        count = {}
        l = 0
        res = 0    

        for r in range(len(s)):
            count[s[r]] = 1 + count.get(s[r], 0)

            while (r - l + 1) - max(count.values()) > k:
                count[s[l]] -= 1
                l += 1

            res = max(res, r - l + 1)
        
        return res


