# Advanced Graphs

## Dijkstra's Algorithm

A rarer algorithm but important one that finds the shortest path between a given source and any other node in the graph.

A key condition is that all of the edges must have positive edge weights. In the case of a negative edge weight, Dijkstra's would just continue iterating through that negative weight (as it would continue to make the dist to those edges smaller with each iteration).

**Algorithm Overview:**

You're given a graph (directed or undirected) with edge weights, and a source node to compute distances from.

1. You maintain two data structures, a min heap and dictionary. 
    - the min heap is to store `(distance, node)` values, where `distance` is one of potentially several *found* distances from the `source` to `node`,
    - the dictionary has keys which represent the nodes, and the corresponding value is the shortest distance between the `source` and the `key`

2. Pop a `(distance, node)` pair from the min heap.
    - bc of the invariant that min heaps always have the smallest-element first, we know that whenever we pop an element from a min heap that this is the current-shortest distance to get to that node.
    - thus, we use this node and it's neighbors to continue exploring the graph

3. Iterate through each of the neighbors of this node (using an adjacency list)
    - while we may encounter a shorter path later, it makes the most sense to start with the shortest-distance

4. For each of the neighbors, we calculate a new distance from the source. 
    - Let's say we popped `(dist, node)` from the min heap. Then we encoutner `(neighbor, weight)` from node's adj list. Then, `newDist = dist + weight`. 

5. If `newDist < dist[neighbor]`, then we end up updating `node[neighbor]`, as we've found a shorter distance to `neighbor` from `source`.
    - it's also here where if `newDist < dist[neighbor]`, then we add this `(newDist, neighbor)` element to the min heap. 
        - If `newDist > dist[neighbor]`, then there's no point in adding this `(newDist, neighbor)` to the minHeap, since it's not shorter than an existing path to that `neighbor`. This ensures that our min heap doesn't keep growing.

example implementation:

```python
import heapq

def networkDelayTime(self, times: List[List[int]], n: int, source: int) -> int:

    minHeap = [(0, source)]

    edges = collections.defaultdict(list)
    for u, v, time in times:
        edges[u].append((time, v))
    
    distances = {u: float('inf') for u in range(0, n)}
    distances[source] = 0 


    while len(minHeap) > 0:
        currDist, node = heapq.heappop(minHeap)

        for time, neighbor in edges[node]:
            newDist = currDist + time
            if newDist < distances[neighbor]: 
                distances[neighbor] = newDist
                heapq.heappush(minHeap, (newDist, neighbor))
```

- note: if you need to access the actual minimal path, you can maintain a `parents` dictionary. whenever we update the distance bewteen a node and it's neighbor, we update the parent of neighbor to be node: `parent[neighbor] = node`.

## 743. Network Time Delay

You are given a network of `n` directed nodes, labeled from `1` to `n`. You are also given times, a list of directed edges where `times[i] = (ui, vi, ti)`.

- `ui` is the source node (an integer from 1 to n)
- `vi` is the target node (an integer from 1 to n)
- `ti` is the time it takes for a signal to travel from the source to the target node (an integer greater than or equal to 0).

You are also given an integer `k`, representing the node that we will send a signal from.

Return the minimum time it takes for all of the n nodes to receive the signal. If it is impossible for all the nodes to receive the signal, return `-1` instead.

### Key Observations:

My immediate interpretation of the problem was incorrect. I thought you had to find a path that reaches all nodes (that is minimal), so I thought that a dfs/decision tree approach to find all connected paths and store their path costs. 

However, we don't need all the nodes to be connected in this path, but rather a path must exist from the source, `k`, to all of the other nodes, and we must return the minimal time in which all nodes are reached.

So, this actually lends itself well to Dijkstra's, which finds the shortest-cost path from a source to each of the other nodes in the graph. 

- When we run this algorithm, we're left with a dictionary of `{node: distance}` pairs. If all of the distances are initialized (not infinity), that means that the largest of these values is the minimal time it will take to reach ALL of the ndoes in the graph (per definition of dijkstra's).

```python
def networkDelayTime(self, times: List[List[int]], n: int, source: int) -> int:

    minHeap = [(0, source)]

    edges = collections.defaultdict(list)
    for u, v, time in times:
        edges[u].append((time, v))
    
    distances = {u: float('inf') for u in range(0, n)}
    distances[source] = 0 


    while len(minHeap) > 0:
        currDist, node = heapq.heappop(minHeap)

        for time, neighbor in edges[node]:
            newDist = currDist + time
            if newDist < distances[neighbor]: 
                distances[neighbor] = newDist
                heapq.heappush(minHeap, (newDist, neighbor))

    res = -1
    for node, dist in distances:
        if dist == float('inf'):
            return -1
        else:
            res = max(res, dist)

    return res
```