# Linked Lists

## 206. Reverse (singly) Linked List

Given the beginning of a singly linked list `head`, reverse the list, and return the new beginning of the list.

    class ListNode:
        def __init__(self, val=0, next=None):
            self.val = val
            self.next = next

### Key Takeaways

Iterative Solution:

The key to reversing the order of the pointers is to have a `temp` node with which you store the original, non-reversed part of the list. You also need a `curr` node to represent the current node you are reversing, and a `prev` node to represent the node that you are pointing the reversed pointer to.

    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        prev, curr = None, head

        while curr:
            temp = curr.next
            curr.next = prev
            prev = curr
            curr = temp

        return prev

Essentially, you initialize temp to be `curr.next` so that you store the next node of the original list. Then you update `curr.next` to point to `prev` (the reversal fo the list). Then, you get our variables ready for the next iteration: `prev = curr` since you want the next node to point to the reversed list, and `curr = temp` because you want to update the next "node to be reversed."

This process is repeated until `curr == None`, in which case `prev` is the node that represents the head of yoru new list.

## 21. Merge Two Sorted Linked Lists

You are given the heads of two sorted linked lists `list1` and `list2`.

Merge the two lists into one sorted linked list and return the head of the new sorted linked list.

The new list should be made up of nodes from `list1` and `list2` (don't make a copy).

### Key Takeaways

We need to create 2 placeholder nodes, `dummy` and `tail`. Dummy is used so that we can insert nodes into a list that is guaranteed to not be empty. `tail` is used to represent the tail of our merged linked list, and it's how we will "add" nodes to the merged linked list.

To merge our lists, our algorithm will iterate while `list1` and `list2` are not `None`. The steps of our algorithm are as follows:

1. Compare `list1` and `list2`.

2. Update the tail pointer to point to the smaller of the 2 values:

    - if `list1.val >= list2.val`, then we want to add `list2` to tail. 
    - `tail.next = list2`

3. Now that the smaller of the 2 nodes has been added to our merged list, we need to update the list with which we just removed a node from:

    - `list2 = list2.next`

4. Now that we've added a node to `tail`, it no longer represents the last element in the merged list. So, we update `tail` to be the new end of the list

    - `tail = tail.next`

This process continues until one of `list1` or `list2` are None. If one of `list1` or `list2` are NOT None, we want tail to point to that list so that we properly merge. If they're both `None`, this following line will be correct as we are at the end of our merged list.

- `tail.next = list1 or list2`

Lastly, we `return dummy.next`. dummy.next represents the head of our merged list because on the first pass, tail.next will be updated to the correct start of our merged list. This subsequently also updates `dummy.next` as they are initialized to the same node. However, when `tail = tail.next` is called, `tail` is now a new node and `dummy` is no longer updated.\

Code:

    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        dummy = tail = ListNode()

        while list1 and list2:
            if list1.val < list2.val:
                tail.next = list1
                list1 = list1.next
            else: # list1 >= list2
                tail.next = list2
                list2 = list2.next
            tail = tail.next

        tail.next = list1 or list2

        return dummy.next

## 141. Linked List Cycle Detection

Given the beginning of a linked list `head`, return `true` if there is a cycle in the linked list. Otherwise, return `false`.

There is a cycle in a linked list if at least one node in the list can be visited again by following the next pointer.

### Key Takeaways

So this is relatievly trivial if you want to use `O(n)` space, since you can just make a HashSet of visited nodes. In our case, the ListNode implementation doesn't have an `__eq__()` override, so it goes by the memory address (pointer) of the node, and thus we can add it to a set.

If we want an O(1) space solution, then we need to get a bit creative. The algorithm for this is tortoise and hare pointers (fast and slow pointers). The slow pointer moves by 1 while the fast pointer moves by 2. If there's no cycle, then the fast pointer will reach None. If there is a cycle, however, then the fast pointer will eventually catch up to the slow pointer, and when that happens we can deduce that there is a cycle.

The logic doesn't initially make sense, but if there is a cycle, then both the slow and fast pointers will eventually "enter" the cycle. At this point, there's a gap of spaces between fast and slow. At each iteration, slow will increase that gap by 1, and then fast decreases that gap by 2 (for a net of -1). So eventually, that gap will reduce to 0 and the pointers will meet.

We can guarantee that this is an `O(n)` time solution because the gap between the two pointers inside of a cycle is at most n - 1, where n is the number of elements in the linked list.

This algorithm is known as **Floyd's Cycle Detection Algorithm**

```python
def hasCycle(self, head: Optional[ListNode]) -> bool:
    slow, fast = head, head

    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow == fast:
            return True
    return False
```

## 143. Reorder Linked List

You are given the head of a singly linked-list.

The positions of a linked list of `length = 7` for example, can intially be represented as:

`[0, 1, 2, 3, 4, 5, 6]`

Reorder the nodes of the linked list to be in the following order:

`[0, 6, 1, 5, 2, 4, 3]`

Notice that in the general case for a list of length = n the nodes are reordered to be in the following order:

`[0, n-1, 1, n-2, 2, n-3, ...]`

You may not modify the values in the list's nodes, but instead you must reorder the nodes themselves.

### Key Takeaways

You can think of the re-ordered order as follows: take your original linked-list, reverse the order. Then, starting with your original list, essentially alternate between the starting list and the reversed list.

To implement this, there are 3 steps. First, you can't just create a copy of the head and then reverse the list, as you'll end up reversing the pointers for the original list. You instead need to split the array into 2 halves, where the second half is reversed. To achieve this, we have 2 pointers, `slow` and `fast`, initialized to `head` and `head.next`. We will traverse this list such that the index of `slow` is always half of the index of `fast`. This will continue `while fast and fast.next` exist. Then to mark separete our sublist, we write `second = slow.next` and `slow.next = None`.

- (note that this handles the cases when the linked list is odd or even)

Next, we reverse the seocnd list using the same general procedure of pointer movement.

    while second:
        temp = second
        second = second.next
        temp.next = prev
        prev = temp

Lastly, we want to merge the two lists by alternating them.

- Note that after reversing the list, second is going to be null.

    first, second = head, prev

    while second:
        temp1, temp2 = first.next, second.next
        first.next = second
        second.next = temp1
        first, second = temp1, temp2


Here we iterate while `second` exists, and for each iteration, we have `first` point to `second`, and then `second` point to `temp1`. There's nothing left to update temp2, so we simply just update the pointers to the next corresponding element.

# 19. Remove Nth Node from Linked List

You are given the beginning of a linked list `head` and an integer `n`. Remove the `nth` node form the **end** of the list, and return the list.

### Key Takeaways

**Brute force**

- one pass to find the size of the array
- another pass to remove the nth from the end   

The main difficulty of this problem is knowing how to get to node that is `nth` from the end of the list.

To do this, we'll have a temporary pointer (`right`) (starting from head) that iterates forward `n` times. Then, we'll have a temporary pointer (`prev`) initialized as `prev = dummy`, where `dummy = ListNode(0, head)`, that essentially tracks the previous node from n.

Then, we iterate while `right` exists while also iterating `prev`. Since right is shifted forward `n` times before this, by the time `right` == `None`, that means `prev` is the node right before the `nth` from the end.

Thus, removing the node is as simple as doing `prev.next = prev.next.next`

Lastly, we return `dummy.next`. We do this in case the node to be deleted is the first one. If this is the case, 

