# Graphs

## General Notes

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


