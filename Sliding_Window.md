# Sliding Window

General Idea: A fixed or variable-size window is moved through a datastructure. Often used for subsets of elements (like a subset or substring that meets a set of conditions).

The window is maintained by 2 pointers, similar to the Two-Pointers technique. The main difference is that 2 pointers only tracks 2 parts of the data structure and moves based on conditions.

**Sliding Window** has right pointer move to expand the window, while the left is used to maintain the window and make sure it's still valid.

Most of the time, you start by expanding the window until the window is no longer valid. Then you move the left pointer to shrink the window until it's valid again.

*Generally*, in case you need to keep track of the frequencies of some items using a dict. A nice way to add an element for the first time without an `if` statement is `myDict[key] = 1 + myDict.get(key, 0)`

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

# 424. Longest Repeating Substring with Replacement

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

# 76. Minimum Window Substring

Given two strings `s` and `t` of lengths m and n respectively, return the minimum window substring of `s` such that every character in `t` (including duplicates) is included in the window. If there is no such substring, return the empty string "".

### Key Takeaways
As is with most sliding window problems, we need to maintain an extra data structure to achieve that O(n) runtime.

- In this case we'll have a hashmap that represents the frequencies of characters in `t` (`t_freq`), and another that has the frequencies of the characters that are currently in our `window`. 
- Additionally, we'll have two integers `need` and `have`, where `need` represents the number of characters in `t` that need to be present in the window, and `have` represents the # of characters needed that are in the present window. 
- Lastly we track our result with `res = [0, 0]` and `res_len = float('inf')`

Like other 2 pointers algorithms, we grow the right pointer until we have reached our success criteria, then shift the left pointer until the criteria has no longer been met.

With left and right pointers, `l = 0`, and we iterate `r` from `0` to `len(s)`. We first add `s[r]` to `window`. Then, if `s[r]` exists in `t_freq`, we check whether `window[s[r] == t_freq[s[r]]`. If so, then `have += `.

After adding `s[r]` to `window` and updating `have`, we do a `while have == need` loop. This means that we've found a valid substring. Here we update `res` and `res_len` with

    while have == need:
        if res_len > r - l + 1:
            res = [l, r]
            res_len = r - l + 1
        
        window[s[l]] -= 1
        if if s[l] in t_dict and window[s[l]] < need[s[l]]:
            have -= 1
        
        l += 1

This shrinks our window (as we want the smallest substring), while still maintaining that we are tracking the shortest valid substring.
    