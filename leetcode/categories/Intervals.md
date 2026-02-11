# Intervals

## 252. Meeting Rooms

Given an array of meeting time interval objects consisting of start and end times `[[start_1,end_1],[start_2,end_2],...] (start_i < end_i)`, determine if a person could add all meetings to their schedule without any conflicts.

Note: (0,8),(8,10) is not considered a conflict at 8

### Key Takeaways

You will have a conflict (overlap) if for a given interval, its end time is after the start time of the next-starting interval.

Translated into an algorithm, you sort the intervals by their start time. Then for `i in range(len(intervals) - 1)`, you just check whether `intervals[i].end > intervals[i+1].start`. 

- If this is true, then you've found 2 overlapping intervals so a valid scheduling does not exist.


## 253. Meeting Rooms II

Given an array of meeting time intervals intervals where `intervals[i] = [start, end]`, return the minimum number of conference rooms required.

### Key Takeaways

The hardest part of this problem is how to track whether to add allocate a new room or not when you schedule the next meeting. The main observation is that out of all the meetings you have scheduled, you only care about the meeting that ends the soonest. So, you run into 2 scenarios:

1. The new meeting's start is earlier than the soonest-ending meeting's end
    - here you have an overlap, so you want to allocate a new room so that both meetings can occur 
2. The new meeting's start is later than the soonest-ending meeting's end
    - if the new meeting starts after one of the soonest-ending meeting ends, it can just take that room, so it doesn't need to add a new room.

While this is great, you need an efficient way to always get the soonest-ending meeting at the time which you are scheduling the curren tmeeting.

This is where a **min heap** comes in handy. We can represent the rooms with which meetings can be allocated by using a min heap containing the end times of meetings.

So, the algorithm process each meeting at a time and pushes it to the min heap. The only check is whether we need to pop the earliest-ending meeting (in this case, that meeting will have concluded by the time we are scheduling this one, so we can remove it).

And then, we return the size of our min heap.

## Insert Interval

You are given an array of non-overlapping intervals `intervals` where `intervals[i] = [start_i, end_i]` represents the start and the end time of the `ith` interval. `intervals` is initially sorted in ascending order by `start_i`.

You are given another interval `newInterval = [start, end]`.

Insert `newInterval` into `intervals` such that `intervals` is still sorted in ascending order by `start_i` and also `intervals` still does not have any overlapping intervals. You may merge the overlapping intervals if needed.

Return `intervals` after adding `newInterval`.

### Key Takeaways

The intuition for this algorithm is straight forward, but it's the logic behind the for loop and the way we handle interval merging that is particularly notable for me.

Intuitively, we should iterate to the point with which we want to insert the interval, merge any intervals if needed, and then continue.

However, figuring out where to insert, how to merge, is not as intuitive as it sounds.

1. We want to find the index/interval that is the first to merge with `newInterval`. This interval is determined to be the first interval whose end is greater than `newInterval`'s start.
    - `interval[i][1] >= newInterval[0]`

2. Now that we're here, we want to merge intervals such that any intervals overlapping with `newInterval` are merged in. 
    - An interval overlaps with `newInterval` if `interval[i][1] >= newInterval[0]` (the interval's end is greater than the new one's start) OR if `interval[i][0] <= newInterval[1]` (the interval's start is before the new one's end)

3. Maintaining this array is a bit cumbersome if you're trying to do it in place, so instead, we will maintain a result array and append intervals to it as they are ready.

The final code looks like this:

```python
def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
    n = len(intervals)
    i = 0
    res = []

    while i < n and intervals[i][1] < newInterval[0]:
        res.append(intervals[i])
        i += 1

    while i < n and newInterval[1] >= intervals[i][0]:
        newInterval[0] = min(newInterval[0], intervals[i][0])
        newInterval[1] = max(newInterval[1], intervals[i][1])
        i += 1
    res.append(newInterval)

    while i < n:
        res.append(intervals[i])
        i += 1

    return res
```