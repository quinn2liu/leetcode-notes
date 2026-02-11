# Graphs

## General Notes

### Graph Representations

**Adjacency List**

An adjacency list can take many forms, but it's essentially some form of map where the key is a node and the value is a list of nodes that are neighbors to that node.

**ex: Directed**
```python
graph = {
    'A': ['B', 'C'],
    'B': ['C'],
    'C': []
}
```

**ex: Undirected**
```python
graph = {
    'A': ['B'],
    'B': ['A', 'C'],
    'C': ['B']
}
```

**ex: Weighted**
```python
graph = {
    'A': [('B', 5), ('C', 2)],
    'B': [('C', 1)]
}
```
- ^^ will need to account for repeat edges

Pros:
- fast neightbor iteration (BFS, DFS)
- easy to modify
Cons:
- checking if an edge exists (unless using sets)

**Adjacency Matrix**

An adjacency matrix is a 2d array where `matrix[i][j]` indicates whether there is an edge (or that edge's weight). *Note:* in an undirected graph, a value should exist for both `matrix[i][j]` and `matrix[j][i]`

**ex: Unweighted**
```python
graph = [
    [0, 1, 1],
    [0, 0, 1],
    [0, 0, 0]
]
```

**ex: Weighted**
```python
INF = float('inf')
graph = [
    [0, 5, 2],
    [INF, 0, 1],
    [INF, INF, 0]
]
```

Pros:
- O(1) edge lookup (can also be achieved with adj list)
- good for dense graphs
Cons:
- O(V^2) memory
- slower to iterate neighbors

***Edge List***
Stores edges as pairs (triples for weights)

**ex: Unweighted**
```python
edges = [
    ('A', 'B'),
    ('A', 'C'),
    ('B', 'C')
]
```

**ex: Weighted**
```python
edges = [
    ('A', 'B', 5),
    ('A', 'C', 2)
]
```


**Node**



### DFS:

When performing DFS, you should start by defining the actual DFS that you're going to call first before implementing. What this means is that you should think about what your initial DFS call will look like (what variables you need to pass through and what the initial case looks like).

After that has been thought out, it will be easier to reason through.

The general way to implement DFS is the following:

- Recursively call DFS with updated parameters based on the problem (like if we're in a grid, call DFS in each of the possible directions)

- When an invalid case or edge of the graph has been reached, then return.

- If you don't immedietly return, then do whatever you need to do with the nodes.

### BFS

BFS is relatively easy to implement. Here are the following steps:

- Create a deque(). This is going act as the queue of nodes that still need to be traversed

- Create a set(). This is going to keep track of which nodes have already been visited

- Take the first node and add it to the set/deque, while the deque() is not empty, popleft() as the new node, add it's children to the deque/set, and repeat. 

- ^^ in this step, do whatever you need to do at each node.

## 200. Count Number of Islands

Given a 2D grid `grid` where `'1'` represents land and `'0'` represents water, count and return the number of islands.

An **island** is formed by connecting adjacent lands horizontally or vertically and is surrounded by water. You may assume water is surrounding the grid (i.e., all the edges are water).

Example: 

    Input: grid = [
        ["0","1","1","1","0"],
        ["0","1","0","1","0"],
        ["1","1","0","0","0"],
        ["0","0","0","0","0"]
    ]
    Output: 1

### Key Takeaways:

So first and foremost we need to interpret this as a graph problem, where each element in the grid is a node. Islands (1's) are connected if they are adjacent either horizontally or vertically (not diagonally). 

To "explore" an island and make sure you only count it once, you want to use BFS search to explore how far the island goes. In other words, when you encounter a `1` that hasn't been already visited, continue visiting all neighboring cells. Whenever an adjacent `1` is reached, mark it as visited and to the current island. Continue searching out until the "current island" queue no longer has edges to explore. 

Here's the code:

    def numIslands(self, grid: List[List[str]]) -> int:
        visited = set()
        rows, cols = len(grid), len(grid[0])
        islands = 0
        for i in range(len(grid)): # rows

            for j in range(len(grid[0])): # cols
                islandQueue = deque()
                
                if grid[i][j] == "1" and (i, j) not in visited:
                    islands += 1
                    islandQueue.append((i, j))
                if (i, j) not in visited:
                    visited.add((i, j))
                while islandQueue: 
                    row, col = islandQueue.popleft()
                    directions = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
                    for newRow, newCol in directions:
                        if (newRow < rows and newRow >= 0) and (newCol < cols and newCol >= 0): # if check is valid
                            if (newRow, newCol) not in visited:
                                visited.add((newRow, newCol))
                                if grid[newRow][newCol] == "1":
                                    islandQueue.append((newRow, newCol))                     
        return islands

## 133. Clone Graph

Given a node in a connected undirected graph, return a deep copy of the graph.

Each node in the graph contains an integer value and a list of its neighbors.

    class Node {
        public int val;
        public List<Node> neighbors;
    }

The graph is shown in the test cases as an adjacency list. An adjacency list is a mapping of nodes to lists, used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

For simplicity, nodes values are numbered from 1 to n, where n is the total number of nodes in the graph. The index of each node within the adjacency list is the same as the node's value (1-indexed).

The input node will always be the first node in the graph and have 1 as the value.

### Key Takeaways

We're going to traverse the graph using depth first search (aka recursive). The main idea in this problem is that we're going to use a hashmap to map the original nodes to their copies. Let's call it `oldToNew`

Our DFS is defined with the following logic:

1. If the node value that we are hoping to copy already exists in `oldToNew`, then return the copy.

2. If the node value doesn't already have an associated value, then we create a copy of it and assign the node to have a value of the copy in the hashmap.

3. For all the neighbors for our given node, we append `dfs(neighbor)` to the copy's list of children.

4. Lastly in the parent function, we call `dfs(node)`, where node is the first node in our graph.

Code:

    def cloneGraph(self, node: Optional['Node']) -> Optional['Node']:

        oldToNew = {}

        def dfs(node):
            if node in oldToNew:
                return oldToNew[node]

            copy = Node(node.val) # a copy without neighbors

            oldToNew[node] = copy

            for neighbor in node.neighbors:
                copy.neighbors.append(dfs(neighbor))
            return copy 

        return dfs(node) if node else None

## 417. Pacific Atlantic Water Flow

You are given a rectangular island `heights` where `heights[r][c]` represents the height above sea level of the cell at coordinate `(r, c)`.

The islands borders the **Pacific Ocean** from the top and left sides, and borders the **Atlantic Ocean** from the bottom and right sides.

Water can flow in **four directions** (up, down, left, or right) from a cell to a neighboring cell with **height equal or lower**. Water can also flow into the ocean from cells adjacent to the ocean.

Find all cells where water can flow from that cell to both the Pacific and Atlantic oceans. Return it as a 2D list where each element is a list `[r, c]` representing the row and column of the cell. You may return the answer in any order.

### Key Takeaways

The brute force method is to perform DFS on each of the cells and see whether it can reach the top, left, right, and bottom borders. This is incredibly inefficient and hypothetically you could try to not traverse visited nodes, but for some reason that doesn't work.

The key observation here is to reconsider the direction of flow and think about the problem as "which cells can the pacific ocean reach, and which cells can the atlantic ocean reach, and then which can reach both." This means that we only need to start traversing from the border cells, aka the top/bottom rows and the left/right columns.

The algorithm is as follows: 

- For each cell in the top/bottom row and left/right column, perform DFS and find all the cells that can be reached where the height of a cell is **greater than or equal to** the previous height. 
- Keep track of whether a cell can be reached from the pacific/atlantic using sets. 
- If a cell cannot be reached, then simply return, if it can be reached, add it to corresponding set. 
- Lastly, parse through each cell and check if it exists in both sets.

code: 

    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        
        ROWS, COLS = len(heights), len(heights[0])
        pacific, atlantic = set(), set()
        res = []

        def dfs(r, c, visit, prevHeight):
            if ((r, c) in visit or 
            r < 0 or c < 0 or r == ROWS or c == COLS or
            heights[r][c] < prevHeight): # all the cases in which we don't want to explore this node
                return
            
            # this is a valid position can be reached from our ocean
            visit.add((r, c))

            # DFS in each of the directions
            dfs(r + 1, c, visit, heights[r][c])
            dfs(r - 1, c, visit, heights[r][c])
            dfs(r, c + 1, visit, heights[r][c])
            dfs(r, c - 1, visit, heights[r][c])

        # all elements in the first and last row (can visit pacific/atlantic)
        for c in range(COLS):
            dfs(0, c, pacific, heights[0][c])
            dfs(ROWS - 1, c, atlantic, heights[ROWS - 1][c])

        # all elements in the first and last column (can visit pacific/atlantic)
        for r in range(ROWS):
            dfs(r, 0, pacific, heights[r][0])
            dfs(r, COLS - 1, atlantic, heights[r][COLS - 1])

        for r in range(ROWS):
            for c in range(COLS):
                if (r, c) in pacific and (r, c) in atlantic:
                    res.append([r, c])
        
        return res

## 207. Course Schedule

You are given an array prerequisites where `prerequisites[i] = [a, b]` indicates that you must take course `b` first if you want to take course `a`.

The pair `[0, 1]`, indicates that must take course `1` before taking course `0`.

There are a total of numCourses courses you are required to take, labeled from `0` to `numCourses - 1`.

Return `true` if it is possible to finish all courses, otherwise return `false`.

### Key Takeaways

There are 2 ways to solve this problem. The first is through a DFS approach, and the second is to attempt to topologically sort the graph. 

DFS:

In this approach, first need to create an adjacency list to represent the prereqs.

    let preMap = {i:[] for i in range(numCourses)}
    for prereq in prerequisites:
        a, b = prereq[0], prereq[1]
        preMap[a].append(b)
    
Next, we need to keep track of which nodes we've visited:

    visited = set()

For our actual DFS, the general method is that we're going to recursively traverse down the tree. Let's call an arbitrary course `course`. If `preMap[course] == []`, that means that it no longer has an prerequisites that need to be completed, and we can return True. If `course` is in `visited()`, that means that we've reached a cycle and the prereqs are invalid.

Then, for each of the children of `course`, we call `dfs(child)`. If any of these return `false`, this means that one of the children has reached a cycle. If not, then that means that all the children's prereqs are satisfied.

If all the children's prereqs are satisfied, that means that we need to update `course` to reflect that all it's prereqs have been satisfied (`preMap[course] = []`), and return `True`.

Lastly, we want to check this for all of the courses:
    
    for course in range(numCourses):
        if not dfs(coruse):
            return False

Topological Sort: (Kahn's):

Intuition:

- Repeadetly remove nodes without any dependencies (incoming edges) from the graph and add them to the topological ordering
- As nodes without dependencies are removed, there should be new nodes that don't have dependencies.
- We continue removing nodes without dependencies until all nodes are removed. If not all nodes can be removed, a cycle has been detected.

To do this, we need to keep track of 2 things.

1. Adjacency list for our graph

2. The current inDegree of each of the nodes in our graph.

        def canFinish(self, numCourses: int,        prerequisites: List[List[int]]) -> bool:
            
            # making inDegree array and adjacency list
            inDegree = [0] * numCourses
            adj = [[] for i in range(numCourses)]
            for src, dst in prerequisites:
                inDegree[dst] += 1
                adj[src].append(dst)
            
            q = deque()
            for course in range(numCourses):
                if inDegree[course] == 0:
                    q.append(course)
            
            # BFS (finishes executing when there are no more 0 in-degree nodes)
            while q:
                curr = q.popleft()
                for neighbor in adj[curr]:
                    inDegree[neighbor] -= 1
                    if inDegree[neighbor] == 0:
                        q.append(neighbor)
            
            return sum(inDegree) == 0

## 323. Number of Connected Components in an Undirected Graph

There is an undirected graph with `n` nodes. There is also an `edges` array, where `edges[i] = [a, b]` means that there is an edge between node `a` and node `b` in the graph.

The nodes are numbered from `0` to `n - 1`.

Return the total number of connected components in that graph.

### Key Takeaways

So the main mistake I made when thinking about this problem was not recognizing that you can still use graph traversal algorithms to explore an entire graph, even if the graph isn't fully connected.

In this problem, either using dfs or bfs, you can iteratively traverse the graph with the use of a visited array and an adjacency list. The adjacency list as a data structure lends itself to a bfs-style traversal.

- **adjacency list:** a list of lists, where the index represents the node, and the list at that index is a list of neighbors to that node.

So, all we have to do is define a bfs helper function that explores a given node's connected component. Then we iterate through the nodes and whenever we come across one that hasn't been visited, we call this helper and add 1 to our connected component count.

    visited = [False] * n
    def bfs(node):
        q = deque([node])
        while q:
            curr = q.popleft()
            if not visited[curr]:
                visited[curr] = True
                for neighbor in adj[curr]:
                    q.append(neighbor)
                    visited[neighbor] = True
    
## 261. Graph Valid Tree

Given `n` nodes labeled from `0` to `n - 1` and a list of undirected edges (each edge is a pair of nodes), write a function to check whether these edges make up a valid tree.

You can assume that no duplicate edges will appear in edges. Since all edges are undirected, `[0, 1]` is the same as `[1, 0]` and thus will not appear together in edges.

### Key Takeaways

So my initial struggle with this problem was that it was given to me too vaguely (thanks chatgpt), but there are 2 main parts to this problem. 

1. **What makes a graph a tree vs. not a tree?**
    - A tree is a specal type of graph, which specifically has no cycles and is fully connected (all nodes are reachable).
2. **How do you check these conditions?**

Since we are told nodes are uniquely labeled `0` to `n - 1`, we can do a simple check by iterating through the edges and seeing whether any of the node isn't seen.

To check for a cycle, though, the most-intuitive method for me is to traverse the graph in level-order traversal (bfs) and keep track of the nodes visited up until that point. You can also use dfs (just need to traverse the graph), but I think it makes more sense in my head using bfs.

However, given an edge list you can't do either of these traversals, since you need to know all of a node's children at once. **So, the solution for this is to create an adjacency list from our edge list to traverse the graph.** This is simple because the nodes are labeled via unique numbers. The one caveat is that since we are given unique edges, we have to create bi-directional edges in the adjacency list (`u -> v` and `v -> u`).

The last twist in this problem is that when doing bfs, your queue doesn't just contain a queue of lists to be processed, but rather the **node and it's parent**. 

**Let's use `u` and `v` as an example:**
- When we process `u` and add it to `visited`, we then add all of `adj[u]` to the queue (now `v` is in the queue). When we later process `v`, `u` is going to show up in `adj[v]`, but since `u` is already in `visited`, we wrongly return false. 
- So to solve this, we will append `(node, parent)` tuples to the queue instead of just the node. So as we're checking through the children in `adj[node]`, if `child == parent`, that means that this edge is not creating a cycle but rather the other-direction of that node's parent edge.

```python
def validTree(self, n: int, edges: List[List[int]]) -> bool:
    if len(edges) > n - 1:
        return False

    adj = [[] for _ in range(n)]
    for u, v in edges:
        adj[u].append(v)
        adj[v].append(u)

    q = deque()
    visited = set()

    q.append((0, -1)) # initial value, 0 shouldn't have a parent

    while len(q) > 0:
        node, parent = q.popleft()
        visited.add(node)
        children = adj[node]

        for child in children:
            if child == parent: 
                continue
            if child in visited: 
                return False
            else: 
                q.append((child, node))
    
    return len(visited) == n
```

## 210. Course Schedule II

You are given an array `prerequisites` where `prerequisites[i] = [a, b]` indicates that you must take course `b` first if you want to take course `a`.

For example, the pair `[0, 1]`, indicates that to take course `0` you have to first take course `1`.
There are a total of `numCourses` courses you are required to take, labeled from `0` to `numCourses - 1`.

Return a valid ordering of courses you can take to finish all courses. If there are many valid answers, return **any of them**. If it's not possible to finish all courses, return an empty array.

### Key Takeaways

We can think of the courses as a directed graph, since we're given this dependency hierarchy (`[a, b]`, `b` must go before `a`). In this case, we can try and find a topological ordering. If we find a topological ordering, then we know that there is an ordering s.t. all courses' dependencies are taken before them.

#### Algorithm (Kahn's Topological Sort):

At a high level, Kahn's works by
- taking nodes with `indegree = 0`
- removing from the graph
- gradually unlocking other nodes
If at the end there are some nodes "locked", a cycle exists, so no valid order is possible

1. Build the graph (adj list) and compute `indegree` for each of the courses (# of prerequisites)
2. Add all courses with `indegree == 0` to the queue
3. While the queue is not empty:
    - remove a course and add to result
    - reduce the indegree of the courses it depends on (children)
    - if any dependent course now has `indegree == 0`, add it to the queue
4. if all courses are processed (added to result), return the result
5. else, return empty list

We can tell if all courses are processed based on whether result has all of the courses.

```python
def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
    adjList = defaultdict(list)
    indegrees = defaultdict(int)
    
    startNodes = set([n for n in range(numCourses)])

    for a, b in prerequisites:
        adjList[b].append(a)
        indegrees[a] += 1
        if a in startNodes:
            startNodes.remove(a)

    q = deque(list(startNodes))
    res = []
    while q:
        curr = q.popleft()
        if indegrees[curr] == 0:
            res.append(curr)
        
        for child in adjList[curr]:
            indegrees[child] -= 1
            if indegrees[child] == 0:
                q.append(child)

    return res if len(res) == numCourses else [] 
```