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

This is there a **min heap** comes in handy. We can represent the rooms with which meetings can be allocated by using a min heap containing the end times of meetings.

So, the algorithm process each meeting at a time and pushes it to the min heap. The only check is whether we need to pop the earliest-ending meeting (in this case, that meeting will have concluded by the time we are scheduling this one, so we can remove it).

And then, we return the size of our min heap.
