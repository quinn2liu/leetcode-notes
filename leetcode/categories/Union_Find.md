# Union Find

Union Find is a rarer algorithm to find in a leetcode problem, but it's purpose is to find the number of connected components in a graph. This is an O(e) algorithm, so slightly faster than the dfs version.

- you can also check # of cc's using dfs, where you convert an edge list to an adjacency list. Then perform dfs starting at each of the nodes while tracking which ones have been visited. When starting dfs, if the node has been visited, then exit. If not, then add 1 to the number of cc's. This is O(v + e) time.

# Algorithm

### Initialize a `parent` and `rank` array and a `count` value

Both of these arrays are of size n, where n is the number of nodes in the graph. The indices of these arrays correspond to the same-indexed node (where nodes are identified by `0` to `n - 1`)

The value at `parent[i]` is an index which represents the node of the parent of this connected component.
- this is initialized to the original index of the array: `parent[i] = i`

The value a `rank[i]` is the current size of this connected component.
- this is initialized all to 1

The `count` value represents the current number of connected components. Since we start with each node as a connected component, this is initialized to n

### Connect Components

To do this algorithm, we should have an edge list. So for each edge, we will "merge" the two corresponding cc's. We will use two helper functions for this:

```python
def find(x):
    if x != parent[x]:
        find(parent[x])
    else: # x == parent[x], x is the head of its cc
        return x

def join(x, y):
    p1, p2 = find(x), find(y)

    if p1 == p2: # they're already combined
        return False
    if rank[p1] < rank[p2]: # merge p1 into p2
        parent[p1] = p2
        rank[p2] += rank[p1]
    else: # merge p2 into p1
        parent[p2] = p1
        rank[p1] += rank[p2]
```

Then, to actually merge them, we do the following loop through the edges:

```python
count = n

for x, y in edges:
    if join(x, y):
        count -= 1
    
return count
```