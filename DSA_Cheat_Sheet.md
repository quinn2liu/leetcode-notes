## Data Structures

### Arrays
**When to use:**
- Need indexed access to elements
- Sequential data that doesn't require frequent insertions/deletions in the middle
- When you know the size ahead of time or can allocate fixed-size arrays
- Implementing other data structures (stacks, queues, heaps)

**Time Complexities:**
- Access: O(1)
- Search: O(n)
- Insertion (end): O(1) amortized
- Insertion (middle): O(n)
- Deletion: O(n)

**Space Complexity:** O(n)

**Python Examples:**
```python
# Create array
arr = [1, 2, 3, 4, 5]

# Access element (O(1))
first = arr[0]  # 1
last = arr[-1]  # 5

# Modify element (O(1))
arr[0] = 10

# Append to end (O(1) amortized)
arr.append(6)

# Insert at index (O(n))
arr.insert(2, 99)  # Insert 99 at index 2

# Delete element (O(n))
arr.remove(99)  # Remove first occurrence
del arr[0]  # Delete at index
arr.pop()  # Remove and return last element

# Search (O(n))
index = arr.index(3)  # Find index of value
exists = 3 in arr  # Check membership

# Slice (O(k) where k is slice size)
subarray = arr[1:4]  # [2, 3, 4]

# Initialize empty array
empty = []
fixed_size = [0] * 10  # Array of 10 zeros
```

---

### Hash Tables / Hash Maps / Dictionaries
**When to use:**
- Need O(1) average lookup, insertion, deletion
- Counting frequencies of elements
- Mapping keys to values efficiently
- Detecting duplicates
- Caching/memoization
- Grouping elements by some property (e.g., grouping anagrams)

**Time Complexities:**
- Access: O(1) average, O(n) worst case
- Search: O(1) average, O(n) worst case
- Insertion: O(1) average, O(n) worst case
- Deletion: O(1) average, O(n) worst case

**Space Complexity:** O(n)

**Common patterns:**
- Two sum problems
- Frequency counting
- Prefix/suffix tracking
- Caching computed results

**Python Examples:**
```python
# Create dictionary
d = {}
d = dict()
d = {'a': 1, 'b': 2}

# Insert/Update (O(1))
d['c'] = 3
d['a'] = 10  # Update existing

# Access (O(1))
value = d['a']  # Raises KeyError if not found
value = d.get('a', 0)  # Returns 0 if not found

# Check membership (O(1))
if 'a' in d:
    print("Key exists")

# Delete (O(1))
del d['a']
value = d.pop('b', None)  # Remove and return, None if not found

# Iterate
for key in d:
    print(key, d[key])
for key, value in d.items():
    print(key, value)

# Common patterns
# Frequency counting
freq = {}
for num in nums:
    freq[num] = freq.get(num, 0) + 1

# Default dict (no need for .get())
from collections import defaultdict
freq = defaultdict(int)
for num in nums:
    freq[num] += 1
```

---

### Hash Sets
**When to use:**
- Need O(1) average membership testing
- Removing duplicates
- Tracking visited nodes/elements
- Fast lookups without needing values

**Time Complexities:**
- Search: O(1) average, O(n) worst case
- Insertion: O(1) average, O(n) worst case
- Deletion: O(1) average, O(n) worst case

**Space Complexity:** O(n)

**Python Examples:**
```python
# Create set
s = set()
s = {1, 2, 3}
s = set([1, 2, 3])

# Add element (O(1))
s.add(4)
s.add(1)  # No duplicates

# Remove element (O(1))
s.remove(4)  # Raises KeyError if not found
s.discard(4)  # No error if not found

# Check membership (O(1))
if 2 in s:
    print("Exists")

# Set operations
s1 = {1, 2, 3}
s2 = {3, 4, 5}
union = s1 | s2  # {1, 2, 3, 4, 5}
intersection = s1 & s2  # {3}
difference = s1 - s2  # {1, 2}

# Common pattern: Remove duplicates
unique = list(set([1, 2, 2, 3, 3]))  # [1, 2, 3]

# Common pattern: Track visited
visited = set()
visited.add((i, j))  # Track coordinates
if (i, j) not in visited:
    # Process
    pass
```

---

### Stacks
**When to use:**
- LIFO (Last In First Out) operations
- Expression evaluation and parsing
- Matching parentheses/brackets
- Undo/redo functionality
- Depth-first search (DFS) implementations
- Reversing order of elements
- Nested structures (decode strings, nested lists)

**Time Complexities:**
- Push: O(1)
- Pop: O(1)
- Peek/Top: O(1)
- Search: O(n)

**Space Complexity:** O(n)

**Common patterns:**
- Valid parentheses
- Next greater element
- Monotonic stack problems
- Recursive problems (can be converted to iterative with stack)

**Python Examples:**
```python
# Create stack (use list)
stack = []

# Push (O(1))
stack.append(1)
stack.append(2)
stack.append(3)  # [1, 2, 3]

# Pop (O(1))
top = stack.pop()  # Returns 3, stack is now [1, 2]

# Peek/Top (O(1))
if stack:
    top = stack[-1]  # 2, doesn't remove

# Check if empty
if not stack:  # or len(stack) == 0
    print("Empty")

# Common pattern: Valid parentheses
def isValid(s):
    stack = []
    pairs = {')': '(', '}': '{', ']': '['}
    for char in s:
        if char in pairs:
            if not stack or stack.pop() != pairs[char]:
                return False
        else:
            stack.append(char)
    return not stack
```

---

### Queues
**When to use:**
- FIFO (First In First Out) operations
- Breadth-first search (BFS)
- Level-order tree traversal
- Task scheduling
- Sliding window maximum/minimum
- Implementing caches (LRU with deque)

**Time Complexities:**
- Enqueue: O(1)
- Dequeue: O(1)
- Peek: O(1)
- Search: O(n)

**Space Complexity:** O(n)

**Variants:**
- **Deque (Double-ended queue):** Can add/remove from both ends
- **Priority Queue:** See Heaps section

**Python Examples:**
```python
from collections import deque

# Create queue
q = deque()

# Enqueue (O(1))
q.append(1)  # Add to right
q.append(2)
q.append(3)  # [1, 2, 3]

# Dequeue (O(1))
front = q.popleft()  # Returns 1, queue is [2, 3]

# Peek (O(1))
if q:
    front = q[0]  # 2, doesn't remove

# Deque operations (double-ended)
dq = deque([1, 2, 3])
dq.appendleft(0)  # Add to left: [0, 1, 2, 3]
dq.pop()  # Remove from right: 3
dq.popleft()  # Remove from left: 0

# Common pattern: BFS
def bfs(root):
    if not root:
        return
    queue = deque([root])
    while queue:
        node = queue.popleft()
        # Process node
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)
```

---

### Linked Lists
**When to use:**
- Dynamic size (don't know size ahead of time)
- Frequent insertions/deletions at arbitrary positions
- When memory allocation is fragmented
- Implementing other data structures (stacks, queues)
- Reversing or reordering elements

**Time Complexities:**
- Access: O(n)
- Search: O(n)
- Insertion (at position): O(1) if you have pointer, O(n) to find position
- Deletion: O(1) if you have pointer, O(n) to find position

**Space Complexity:** O(n)

**Common patterns:**
- Two pointers (fast/slow for cycle detection)
- Reversing linked lists
- Merging sorted lists
- Finding middle element

**Python Examples:**
```python
# Define ListNode
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

# Create linked list
head = ListNode(1)
head.next = ListNode(2)
head.next.next = ListNode(3)

# Traverse
def traverse(head):
    current = head
    while current:
        print(current.val)
        current = current.next

# Insert at beginning (O(1))
new_node = ListNode(0)
new_node.next = head
head = new_node

# Insert after node (O(1))
def insert_after(prev_node, val):
    new_node = ListNode(val)
    new_node.next = prev_node.next
    prev_node.next = new_node

# Delete node (O(1) if you have pointer)
def delete_node(node):
    node.val = node.next.val
    node.next = node.next.next

# Find middle (two pointers)
def find_middle(head):
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
    return slow

# Reverse linked list
def reverse(head):
    prev = None
    current = head
    while current:
        next_node = current.next
        current.next = prev
        prev = current
        current = next_node
    return prev
```

---

### Trees
**When to use:**
- Hierarchical data representation
- Search operations (especially BST)
- Maintaining sorted data with efficient insertion/deletion
- Expression trees
- Decision trees
- File system representation

**Time Complexities (for balanced BST):**
- Search: O(log n)
- Insertion: O(log n)
- Deletion: O(log n)
- Traversal: O(n)

**Space Complexity:** O(n)

**Tree Types:**
- **Binary Tree:** Each node has at most 2 children
- **Binary Search Tree (BST):** Left < Root < Right property
- **Balanced BST (AVL, Red-Black):** Maintains O(log n) operations
- **Trie:** See Tries section

**Traversal Methods:**
- **Inorder:** Left → Root → Right (gives sorted order for BST)
- **Preorder:** Root → Left → Right (useful for copying tree structure)
- **Postorder:** Left → Right → Root (useful for deletion)
- **Level-order (BFS):** Level by level using queue

**Python Examples:**
```python
# Define TreeNode
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

# Inorder traversal (Left → Root → Right)
def inorder(root):
    if not root:
        return
    inorder(root.left)
    print(root.val)  # Process
    inorder(root.right)

# Preorder traversal (Root → Left → Right)
def preorder(root):
    if not root:
        return
    print(root.val)  # Process
    preorder(root.left)
    preorder(root.right)

# Postorder traversal (Left → Right → Root)
def postorder(root):
    if not root:
        return
    postorder(root.left)
    postorder(root.right)
    print(root.val)  # Process

# Level-order (BFS)
from collections import deque
def level_order(root):
    if not root:
        return []
    queue = deque([root])
    result = []
    while queue:
        node = queue.popleft()
        result.append(node.val)
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)
    return result

# Search in BST (O(log n) if balanced)
def search_bst(root, val):
    if not root or root.val == val:
        return root
    if val < root.val:
        return search_bst(root.left, val)
    return search_bst(root.right, val)
```

---

### Heaps / Priority Queues
**When to use:**
- Need to repeatedly extract min/max element
- Finding kth largest/smallest elements
- Merging k sorted lists
- Scheduling problems with priorities
- Finding median from data stream (using two heaps)
- Dijkstra's algorithm

**Time Complexities:**
- Find min/max: O(1)
- Extract min/max: O(log n)
- Insert: O(log n)
- Delete: O(log n)
- Build heap from array: O(n)

**Space Complexity:** O(n)

**Types:**
- **Min Heap:** Parent ≤ children (root is minimum)
- **Max Heap:** Parent ≥ children (root is maximum)

**Common patterns:**
- Top K frequent elements
- Merge k sorted lists
- Find median from data stream (two heaps technique)
- Kth largest element

**Python Examples:**
```python
import heapq

# Min heap (default)
heap = []
heapq.heappush(heap, 3)
heapq.heappush(heap, 1)
heapq.heappush(heap, 2)
# heap = [1, 3, 2] (heapq maintains min heap property)

# Pop minimum (O(log n))
min_val = heapq.heappop(heap)  # Returns 1

# Peek minimum (O(1))
min_val = heap[0]  # Doesn't remove

# Max heap (multiply by -1)
max_heap = []
heapq.heappush(max_heap, -3)
heapq.heappush(max_heap, -1)
heapq.heappush(max_heap, -2)
max_val = -heapq.heappop(max_heap)  # Returns 3

# Build heap from list (O(n))
nums = [3, 1, 2, 4]
heapq.heapify(nums)  # In-place, O(n)

# Find k largest elements
def find_k_largest(nums, k):
    heap = []
    for num in nums:
        heapq.heappush(heap, num)
        if len(heap) > k:
            heapq.heappop(heap)  # Remove smallest
    return heap
```

---

### Tries (Prefix Trees)
**When to use:**
- String prefix matching
- Autocomplete functionality
- Word search problems
- IP routing (longest prefix matching)
- Spell checkers
- When many strings share common prefixes

**Time Complexities:**
- Insert: O(m) where m is length of string
- Search: O(m)
- Prefix search: O(m)
- Delete: O(m)

**Space Complexity:** O(ALPHABET_SIZE × N × M) where N is number of strings, M is average length

**Common patterns:**
- Word search II
- Longest common prefix
- Prefix matching
- Design search autocomplete system

**Python Examples:**
```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()
    
    # Insert word (O(m))
    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True
    
    # Search word (O(m))
    def search(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end
    
    # Check if prefix exists (O(m))
    def startsWith(self, prefix):
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True

# Usage
trie = Trie()
trie.insert("apple")
trie.search("apple")  # True
trie.search("app")  # False
trie.startsWith("app")  # True
```

---

### Graphs
**When to use:**
- Representing relationships between entities
- Network routing
- Social networks
- Dependency resolution
- Path finding
- Cycle detection

**Representations:**
- **Adjacency List:** Space O(V + E), good for sparse graphs
- **Adjacency Matrix:** Space O(V²), good for dense graphs, fast edge lookup
- **Edge List:** Space O(E), simple but less efficient queries

**Time Complexities (varies by algorithm):**
- BFS/DFS: O(V + E)
- Shortest path (Dijkstra): O((V + E) log V) with binary heap
- Topological sort: O(V + E)
- Cycle detection: O(V + E)

**Space Complexity:** O(V + E) for representation, O(V) for visited tracking

**Common algorithms:**
- BFS: Shortest unweighted path, level-order traversal
- DFS: Path finding, cycle detection, connected components
- Topological Sort: Course scheduling, build order
- Union-Find: Connected components, cycle detection in undirected graphs

**Python Examples:**
```python
# Adjacency list representation
graph = {
    0: [1, 2],
    1: [0, 3],
    2: [0, 3],
    3: [1, 2]
}

# Adjacency list from edge list
edges = [[0, 1], [0, 2], [1, 3], [2, 3]]
graph = {}
for u, v in edges:
    if u not in graph:
        graph[u] = []
    if v not in graph:
        graph[v] = []
    graph[u].append(v)
    graph[v].append(u)  # For undirected

# Adjacency matrix representation
n = 4
matrix = [[0] * n for _ in range(n)]
matrix[0][1] = 1  # Edge from 0 to 1
matrix[0][2] = 1

# DFS on graph
def dfs(graph, start, visited):
    visited.add(start)
    print(start)
    for neighbor in graph.get(start, []):
        if neighbor not in visited:
            dfs(graph, neighbor, visited)

# BFS on graph
from collections import deque
def bfs(graph, start):
    visited = set()
    queue = deque([start])
    visited.add(start)
    while queue:
        node = queue.popleft()
        print(node)
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
```

---

## Algorithms

### Two Pointers
**When to use:**
- Array/string is sorted (or can be sorted)
- Finding pairs/triplets that satisfy a condition
- Comparing elements from opposite ends
- Merging two sorted arrays
- Removing duplicates from sorted array

**Data requirements:**
- Usually works best with sorted data
- Can work with unsorted if you're comparing two different arrays/lists

**Time Complexity:** O(n) typically, O(n log n) if sorting needed first

**Space Complexity:** O(1) if in-place, O(n) if creating new array

**Common patterns:**
- Two sum (sorted array)
- Three sum / Four sum
- Container with most water
- Valid palindrome
- Merge sorted arrays
- Remove duplicates

**Python Example:**
```python
# Two sum in sorted array
def two_sum_sorted(nums, target):
    left, right = 0, len(nums) - 1
    while left < right:
        current_sum = nums[left] + nums[right]
        if current_sum == target:
            return [left, right]
        elif current_sum < target:
            left += 1
        else:
            right -= 1
    return []

# Valid palindrome
def is_palindrome(s):
    left, right = 0, len(s) - 1
    while left < right:
        if s[left] != s[right]:
            return False
        left += 1
        right -= 1
    return True

# Merge sorted arrays
def merge_sorted(arr1, arr2):
    i, j = 0, 0
    result = []
    while i < len(arr1) and j < len(arr2):
        if arr1[i] < arr2[j]:
            result.append(arr1[i])
            i += 1
        else:
            result.append(arr2[j])
            j += 1
    result.extend(arr1[i:])
    result.extend(arr2[j:])
    return result
```

---

### Sliding Window
**When to use:**
- Subarray/substring problems
- Finding longest/shortest subarray with certain property
- Problems involving contiguous elements
- When you need to maintain a "window" of elements
- Frequency-based problems on substrings

**Data requirements:**
- Works on arrays, strings, or any linear data structure
- Often needs auxiliary data structure (hash map) to track window state

**Time Complexity:** O(n) typically

**Space Complexity:** O(k) where k is number of unique elements in window

**Common patterns:**
- Longest substring without repeating characters
- Minimum window substring
- Longest repeating character replacement
- Subarray with given sum
- Maximum average subarray

**Key insight:** Expand window with right pointer until invalid, then shrink with left pointer until valid again.

**Python Example:**
```python
# Longest substring without repeating characters
def length_of_longest_substring(s):
    char_set = set()
    left = 0
    max_len = 0
    
    for right in range(len(s)):
        # Shrink window until valid
        while s[right] in char_set:
            char_set.remove(s[left])
            left += 1
        # Expand window
        char_set.add(s[right])
        max_len = max(max_len, right - left + 1)
    
    return max_len

# Fixed-size sliding window (size k)
def max_sum_subarray(nums, k):
    window_sum = sum(nums[:k])
    max_sum = window_sum
    
    for right in range(k, len(nums)):
        window_sum = window_sum - nums[right - k] + nums[right]
        max_sum = max(max_sum, window_sum)
    
    return max_sum
```

---

### Binary Search
**When to use:**
- Searching in sorted array
- Finding boundaries (first/last occurrence)
- Search space reduction problems
- When you can eliminate half the search space each iteration
- Finding peak/mountain in array

**Data requirements:**
- Data must be sorted (or have some monotonic property)
- Or search space must be ordered (e.g., searching for a value in a range)

**Time Complexity:** O(log n)

**Space Complexity:** O(1) iterative, O(log n) recursive

**Common patterns:**
- Search in rotated sorted array
- Find first/last position of element
- Search in 2D matrix
- Find peak element
- Square root calculation
- Search in infinite array

**Template:**
```python
left, right = 0, len(arr) - 1
while left <= right:
    mid = (left + right) // 2
    if condition:
        right = mid - 1  # or left = mid + 1
    else:
        left = mid + 1  # or right = mid - 1
```

**Python Examples:**
```python
# Basic binary search
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return -1

# Find first occurrence
def find_first(arr, target):
    left, right = 0, len(arr) - 1
    result = -1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            result = mid
            right = mid - 1  # Continue searching left
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return result

# Search in rotated sorted array
def search_rotated(nums, target):
    left, right = 0, len(nums) - 1
    while left <= right:
        mid = (left + right) // 2
        if nums[mid] == target:
            return mid
        # Left half is sorted
        if nums[left] <= nums[mid]:
            if nums[left] <= target < nums[mid]:
                right = mid - 1
            else:
                left = mid + 1
        # Right half is sorted
        else:
            if nums[mid] < target <= nums[right]:
                left = mid + 1
            else:
                right = mid - 1
    return -1
```

---

### Depth-First Search (DFS)
**When to use:**
- Exploring all paths in a graph/tree
- Backtracking problems
- Finding connected components
- Topological sorting
- Path finding (not necessarily shortest)
- Cycle detection
- Tree/graph traversal

**Data requirements:**
- Tree or graph structure
- Can be represented as adjacency list, matrix, or implicit (like 2D grid)

**Time Complexity:** O(V + E) for graphs, O(n) for trees

**Space Complexity:** O(V) for visited set, O(h) for recursion stack where h is height

**Common patterns:**
- Tree traversal (preorder, inorder, postorder)
- Number of islands
- Clone graph
- Word search
- Path sum problems
- All paths problems

**Implementation:**
- Recursive (simpler, uses call stack)
- Iterative (using explicit stack)

**Python Examples:**
```python
# DFS on tree (recursive)
def dfs_tree(root):
    if not root:
        return
    # Process node
    print(root.val)
    dfs_tree(root.left)
    dfs_tree(root.right)

# DFS on graph (recursive)
def dfs_graph(graph, node, visited):
    visited.add(node)
    print(node)
    for neighbor in graph.get(node, []):
        if neighbor not in visited:
            dfs_graph(graph, neighbor, visited)

# DFS iterative (using stack)
def dfs_iterative(graph, start):
    visited = set()
    stack = [start]
    while stack:
        node = stack.pop()
        if node not in visited:
            visited.add(node)
            print(node)
            # Add neighbors in reverse to maintain order
            for neighbor in reversed(graph.get(node, [])):
                if neighbor not in visited:
                    stack.append(neighbor)

# DFS on 2D grid (number of islands pattern)
def dfs_grid(grid, i, j, visited):
    if (i < 0 or i >= len(grid) or j < 0 or j >= len(grid[0]) or
        (i, j) in visited or grid[i][j] == '0'):
        return
    visited.add((i, j))
    # Explore 4 directions
    dfs_grid(grid, i+1, j, visited)
    dfs_grid(grid, i-1, j, visited)
    dfs_grid(grid, i, j+1, visited)
    dfs_grid(grid, i, j-1, visited)
```

---

### Breadth-First Search (BFS)
**When to use:**
- Finding shortest unweighted path
- Level-order traversal
- Finding nodes at specific distance
- When you need to explore level by level
- Minimum steps/transformations problems

**Data requirements:**
- Tree or graph structure
- Usually implemented with queue

**Time Complexity:** O(V + E) for graphs, O(n) for trees

**Space Complexity:** O(V) for queue and visited set

**Common patterns:**
- Level-order tree traversal
- Shortest path in unweighted graph
- Word ladder
- Rotting oranges
- Perfect squares
- Binary tree level order traversal

**Key insight:** Processes all nodes at current level before moving to next level.

**Python Examples:**
```python
from collections import deque

# BFS on tree
def bfs_tree(root):
    if not root:
        return []
    queue = deque([root])
    result = []
    while queue:
        node = queue.popleft()
        result.append(node.val)
        if node.left:
            queue.append(node.left)
        if node.right:
            queue.append(node.right)
    return result

# BFS on graph (shortest path)
def bfs_graph(graph, start, target):
    queue = deque([(start, 0)])  # (node, distance)
    visited = {start}
    while queue:
        node, dist = queue.popleft()
        if node == target:
            return dist
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, dist + 1))
    return -1

# Level-order traversal (return levels)
def level_order(root):
    if not root:
        return []
    queue = deque([root])
    result = []
    while queue:
        level_size = len(queue)
        level = []
        for _ in range(level_size):
            node = queue.popleft()
            level.append(node.val)
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        result.append(level)
    return result
```

---

### Dynamic Programming
**When to use:**
- Optimization problems (min/max/count)
- Problems with overlapping subproblems
- Problems with optimal substructure
- When brute force would be exponential
- When you can break problem into smaller subproblems
- Caching/memoization needed

**Data requirements:**
- Problem must have:
  1. **Optimal substructure:** Optimal solution contains optimal solutions to subproblems
  2. **Overlapping subproblems:** Same subproblems computed multiple times

**Time Complexity:** Varies, typically O(n) or O(n²) for 1D/2D DP

**Space Complexity:** O(n) for 1D, O(n²) for 2D, can often be optimized

**Common patterns:**
- 1D DP: Climbing stairs, house robber, coin change
- 2D DP: Longest common subsequence, edit distance, unique paths
- Knapsack problems
- Palindrome problems
- Stock trading problems

**Approaches:**
- **Top-down (Memoization):** Recursive with caching
- **Bottom-up (Tabulation):** Iterative, filling table

**Steps:**
1. Define state (what does dp[i] represent?)
2. Find recurrence relation
3. Identify base cases
4. Determine iteration order
5. Optimize space if possible

**Python Examples:**
```python
# 1D DP: Climbing Stairs (bottom-up)
def climb_stairs(n):
    if n <= 2:
        return n
    dp = [0] * (n + 1)
    dp[1] = 1
    dp[2] = 2
    for i in range(3, n + 1):
        dp[i] = dp[i-1] + dp[i-2]
    return dp[n]

# 1D DP: Climbing Stairs (space optimized)
def climb_stairs_optimized(n):
    if n <= 2:
        return n
    prev2, prev1 = 1, 2
    for i in range(3, n + 1):
        curr = prev1 + prev2
        prev2, prev1 = prev1, curr
    return prev1

# 1D DP: House Robber (memoization - top-down)
def rob_memo(nums):
    memo = {}
    def dp(i):
        if i >= len(nums):
            return 0
        if i in memo:
            return memo[i]
        memo[i] = max(dp(i+1), nums[i] + dp(i+2))
        return memo[i]
    return dp(0)

# 1D DP: House Robber (tabulation - bottom-up)
def rob_tab(nums):
    if len(nums) == 1:
        return nums[0]
    dp = [0] * len(nums)
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])
    for i in range(2, len(nums)):
        dp[i] = max(dp[i-1], dp[i-2] + nums[i])
    return dp[-1]

# 2D DP: Unique Paths
def unique_paths(m, n):
    dp = [[1] * n for _ in range(m)]
    for i in range(1, m):
        for j in range(1, n):
            dp[i][j] = dp[i-1][j] + dp[i][j-1]
    return dp[m-1][n-1]
```

---

### Backtracking
**When to use:**
- Generating all possible solutions
- Constraint satisfaction problems
- Combinatorial problems (permutations, combinations)
- When you need to explore all possibilities
- Decision tree problems
- Problems with exponential time complexity expected

**Data requirements:**
- Usually works with arrays, strings, or grids
- Need to track current state and constraints

**Time Complexity:** Often exponential O(2^n) or O(n!)

**Space Complexity:** O(n) for recursion depth and current solution

**Common patterns:**
- Generate all permutations/combinations
- N-Queens
- Sudoku solver
- Word search
- Subset generation
- Combination sum

**Key insight:** Build solution incrementally, backtrack when constraint violated, explore all possibilities.

**Template:**
```python
def backtrack(current_state):
    if is_solution(current_state):
        add_to_results(current_state)
        return
    
    if is_invalid(current_state):
        return
    
    for option in get_options():
        make_choice(option)
        backtrack(updated_state)
        undo_choice(option)  # backtrack
```

**Python Examples:**
```python
# Generate all permutations
def permute(nums):
    result = []
    
    def backtrack(current):
        if len(current) == len(nums):
            result.append(current[:])
            return
        
        for num in nums:
            if num not in current:
                current.append(num)
                backtrack(current)
                current.pop()  # Backtrack
    
    backtrack([])
    return result

# Generate all subsets
def subsets(nums):
    result = []
    
    def backtrack(start, current):
        result.append(current[:])
        for i in range(start, len(nums)):
            current.append(nums[i])
            backtrack(i + 1, current)
            current.pop()  # Backtrack
    
    backtrack(0, [])
    return result

# N-Queens (simplified)
def solve_n_queens(n):
    result = []
    board = [['.'] * n for _ in range(n)]
    
    def is_valid(row, col):
        # Check column
        for i in range(row):
            if board[i][col] == 'Q':
                return False
        # Check diagonals
        for i, j in zip(range(row-1, -1, -1), range(col-1, -1, -1)):
            if board[i][j] == 'Q':
                return False
        for i, j in zip(range(row-1, -1, -1), range(col+1, n)):
            if board[i][j] == 'Q':
                return False
        return True
    
    def backtrack(row):
        if row == n:
            result.append([''.join(row) for row in board])
            return
        
        for col in range(n):
            if is_valid(row, col):
                board[row][col] = 'Q'
                backtrack(row + 1)
                board[row][col] = '.'  # Backtrack
    
    backtrack(0)
    return result
```

---

### Greedy Algorithms
**When to use:**
- Optimization problems where local optimal choice leads to global optimum
- Interval scheduling
- Activity selection
- Minimum spanning tree (Kruskal's, Prim's)
- Shortest path (Dijkstra's for non-negative weights)
- When problem has greedy choice property

**Data requirements:**
- Problem must have greedy choice property
- Optimal substructure required
- Usually works with sorted data

**Time Complexity:** Varies, often O(n log n) due to sorting

**Space Complexity:** Usually O(1) or O(n)

**Common patterns:**
- Activity selection
- Interval scheduling
- Fractional knapsack
- Minimum number of arrows to burst balloons
- Non-overlapping intervals
- Jump game

**Key insight:** Make locally optimal choice at each step, hoping it leads to globally optimal solution. Not always applicable - must prove greedy choice property.

**Python Examples:**
```python
# Activity selection (maximize activities)
def activity_selection(start, end):
    # Sort by end time
    activities = sorted(zip(start, end), key=lambda x: x[1])
    result = [0]  # First activity always selected
    last_end = activities[0][1]
    
    for i in range(1, len(activities)):
        if activities[i][0] >= last_end:
            result.append(i)
            last_end = activities[i][1]
    return result

# Jump game (can reach end?)
def can_jump(nums):
    max_reach = 0
    for i in range(len(nums)):
        if i > max_reach:
            return False
        max_reach = max(max_reach, i + nums[i])
    return True

# Minimum coins (greedy - works for certain coin systems)
def min_coins_greedy(coins, amount):
    coins.sort(reverse=True)
    count = 0
    for coin in coins:
        count += amount // coin
        amount %= coin
    return count if amount == 0 else -1
```

---

### Sorting Algorithms
**When to use:**
- Need data in sorted order
- Preprocessing step for other algorithms (binary search, two pointers)
- Finding kth largest/smallest (can use partial sort)
- Removing duplicates efficiently

**Common algorithms:**
- **Quick Sort:** O(n log n) average, O(n²) worst, in-place
- **Merge Sort:** O(n log n) worst, stable, needs O(n) space
- **Heap Sort:** O(n log n) worst, in-place
- **Counting Sort:** O(n + k) when range is known
- **Radix Sort:** O(d × n) for numbers with d digits

**Time Complexity:** Best is O(n log n) for comparison-based sorts

**Space Complexity:** O(1) for in-place, O(n) for merge sort

**Python Examples:**
```python
# Built-in sort (Timsort - hybrid)
arr = [3, 1, 4, 1, 5, 9, 2, 6]
arr.sort()  # In-place: [1, 1, 2, 3, 4, 5, 6, 9]
sorted_arr = sorted(arr)  # Returns new list

# Sort with key
students = [('Alice', 20), ('Bob', 18), ('Charlie', 22)]
students.sort(key=lambda x: x[1])  # Sort by age

# Quick sort (simplified)
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)

# Merge sort
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    while i < len(left) and j < len(right):
        if left[i] < right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    result.extend(left[i:])
    result.extend(right[j:])
    return result
```

---

### Union-Find (Disjoint Set)
**When to use:**
- Finding connected components
- Cycle detection in undirected graphs
- Kruskal's algorithm for MST
- Network connectivity problems
- Grouping elements

**Data requirements:**
- Set of elements that can be grouped
- Usually represented as array where index is element and value is parent

**Time Complexity:** 
- Find: O(α(n)) amortized (nearly constant with path compression)
- Union: O(α(n)) amortized
- α is inverse Ackermann function (practically constant)

**Space Complexity:** O(n)

**Common patterns:**
- Number of connected components
- Redundant connection
- Accounts merge
- Friend circles

**Python Examples:**
```python
class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
    
    def find(self, x):
        # Path compression
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]
    
    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)
        
        if root_x == root_y:
            return False  # Already connected
        
        # Union by rank
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1
        return True
    
    def connected(self, x, y):
        return self.find(x) == self.find(y)

# Usage: Number of connected components
def num_components(n, edges):
    uf = UnionFind(n)
    for u, v in edges:
        uf.union(u, v)
    # Count distinct roots
    roots = set(uf.find(i) for i in range(n))
    return len(roots)
```

---

## Problem-Solving Strategies

### When to use which approach:

1. **Need O(1) lookup?** → Hash table/set
2. **Sorted data?** → Binary search, two pointers
3. **Subarray/substring?** → Sliding window
4. **All possibilities?** → Backtracking
5. **Optimal solution with subproblems?** → Dynamic programming
6. **Shortest path (unweighted)?** → BFS
7. **Explore all paths?** → DFS
8. **Need min/max repeatedly?** → Heap
9. **String prefix matching?** → Trie
10. **Connected components?** → Union-Find or DFS/BFS

### Complexity Guidelines:

- **O(1):** Hash operations, array access
- **O(log n):** Binary search, heap operations, balanced tree operations
- **O(n):** Single pass through array, tree traversal
- **O(n log n):** Sorting, divide and conquer
- **O(n²):** Nested loops, 2D DP
- **O(2^n):** Backtracking, subsets
- **O(n!):** Permutations

