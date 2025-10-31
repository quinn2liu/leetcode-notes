# Heaps

**Things to know**

can use `[ ]` as both a min and max heap via the **heapq** library
- `[ ]` is initialized as a min heap (smallest element on top).
- if you want to optimize a max heap (largest element on top), you can `heappush(heap, -1 * num)`, so that the largest element is the top.
- pop using `heappop(heap)`
- pushing and popping from a heap are both O(log n) operations

## 295. Find Median from Data Stream

Initialize the `MedianFinder` class, which has the following methods:
- `MedianFinder()` initializes the `MedianFinder` object.
- `void addnum(int num)` adds the integer `num` from the data stream to the data structure
- `double findMedian()` returns the median of all elements so far.

### Key Takewawys
- Via `addNum(num)`, you maintain two heaps small and large (a max heap and min heap, respectively) that are of equal size (to maintain the quick median lookup). 
    - The root of small represents the "left median" (for lack of a better word) of the data stream and the root of large is the "right median."
        - remember that `[ ]` as a heap are only min heaps, so to implement small as a max heap, we store `num` as `-1 * num`.
- If `num` is > the root of large (large[0]), then `heappush(large, num)`, else we `heappush(-1 * num)`
- after adding `num`, we need to balance the heaps themselves to have a size difference no more than 1 (this is so the roots of both nodes properly represent the left and right medians).

        if len(self.small) > len(self.large) + 1:
            val = -1 * heapq.heappop(self.small)
            heapq.heappush(self.large, val)
        if len(self.large) > len(self.small) + 1:
            val = heapq.heappop(self.large)
            heapq.heappush(self.small, -1 * val)

- finding the median just becomes casing on the size of the heaps

**Runtime:** O(log n) 

**NOTE ->** `addNum()` can't be a binary search a data array to find the index to insert num into. While the search is O(log n), inserting the num is an O(n) operation as you have to copy up to n elements each time.