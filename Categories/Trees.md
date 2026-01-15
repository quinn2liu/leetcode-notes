# Trees

## Things of Note

There are several ways to traverse a tree.

![Alt text](https://media.geeksforgeeks.org/wp-content/uploads/20240429140116/Tree-Traversal-Techniques-(1).webp)

- BFS does level-order traversal, whereas DFS can be any of the other 3.

**Implement BFS using a queue, DFS using recursion.**

**BFS Template**
```python
def bfs(head):
    q = deque([head])
    while q:
        node = q.popleft()
        # in a binary tree this would just be left and right
        for child in node.children:
            q.append(child)
```
**DFS Template**
```python
def dfs(node):
    if node is None:
        return
    for child in node.children:
        dfs(child)
```
^^ note that this dfs is obviously highly-simplified because there's no processing going on.

### Binary Search Tree

A binary tree in which all nodes to the left of a node have a value less than it, and all nodes to the right of a node have a value greater than it.

## 226. Invert Binary Tree

You are given the root of a binary tree `root`. Invert the binary tree and return its root.

Definition for a binary tree node.
```python
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
```
### Key Takeaways

So the main thing to remember here is how we use recursion to our advantage. If we're trying to reverse the tree, we can simply invert each of the subtrees of our root. Once we reach a leaf (where `root == None`), then we return `None` and go back up the tree. This is a depth-first search approach (exploring tree up to a leaf node).
```python
def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
    
    if not root:
        return None

    root.left, root.right = root.right, root.left

    self.invertTree(root.left)
    self.invertTree(root.right)

    return root
```
So traditionally, when this is implemented in Java, you set `node.left = invertTree(root.right)`. In Python, you don't need to do this because we are calling `self.invertTree()`, which has access to the original instance of `root`, and any changed to the children of `root` are present for `root` itself.

**Note** the structre of the recursion. 
1. First you check the base case (conditions that terminate the recursion). 
    - In this case, we want to stop making recursive calls once root becomes none (we've found a leaf). 
2. Then, we do the operations for this iteration (in this case swapping root.left and root.right). 
3. Lastly, we make our recursive call *with new parameters*.
    - This is what makees sure the recursion is working. We are updating the parameters so that the same subproblem is being solved.

## 104. Max Depth of Binary Tree

Given the `root` of a binary tree, return its depth.

The **depth** of a binary tree is defined as the number of nodes along the longest path from the root node down to the farthest leaf node.

### Key Takeaways

There are 3 ways to solve this problem. 

#### 1. Recursive DFS

Here, I simply use the power of recursion to essentially traverse branches of the tree until I reach the leaf nodes. Once you reach the end of a leaf node, you return 0 (as `None` shouldn't add to your depth). Then when you return from recursion, you add 1 to whatever return value you have to accurately get the depth.

Lastly, to ensure that you have the max depth, each time you get the depth from the right and left sides of the tree, you should only return the `max()` of the two sides. Here it is in code:
```python
def maxDepth(self, root: Optional[TreeNode]) -> int:
    if not root:
        return 0

    return 1 + max(self.maxDepth(root.left), self.maxDepth(root.right))
```

#### 2. BFS

With BFS, we have a deque representing the nodes that we have to explore (initialized to `root`). While there are still elements in the deque, we will take the length of our deque at the time (called i). For `i` iterations (each of the nodes in our layer), we pop the least-recently-added node (`popleft()`), then check if it has a right or left node. If it does, then we will add that node to the deque.

After we've popped `i` nodes, we'll increment a `level` variable, to indicate that we've explored all nodes for that level.

```python
def maxDepth(self, root: Optional[TreeNode]) -> int:
    q = deque()
    if root:
        q.append(root)

    level = 0

    while q:

        for i in range(len(q)):
            node = q.popleft()
            if node.left:
                q.append(node.left)
            if node.right:
                q.append(node.right)
        level += 1
    return level
```

## Diameter of Binary Tree

Given the `root` of a binary tree, return the **length** of the diameter of the tree.

The **diameter** of a binary tree is the **length** of the longest path between any two nodes in a tree. This path may or may not pass through the `root`.

The **length** of a path between two nodes is represented by the number of edges between them.

### Key Takeaways

In other words, the `diameter` is really the longest path in the tree.

Since this is a binary tree and not a standard graph, the longest path can either be from one leaf to another leaf (where they meet at a parent node) or from the root to a leaf. The first case is the more interesting, because the first is more of an edge case (where the root only has one child).

If we want to get the **longest path** that passes through a single parent node, at each node we get the max height of its left and right subtrees. From there, we calculate the length of the path using `currPath = height(left) + height(right) + 1`, since we're adding this current node to the path. Then, we determine whether this path is the longest path *in the graph*: `maxPath = max(maxPath, currPath)`.

It makes the most sense to traverse the graph in post-order traversal (process the children first) using dfs. This is because we need to explore the entire left and right subtrees of a node first to then get the max path of that node to one of it's leaves.

Algorithm looks like this:

```python
def diameterBinaryTree(self, root: Optional[TreeNode]) -> int:

    self.maxPathNodes = 1

    def dfs(node):
        if not node:
            return 0

        leftHeight = dfs(node.left)
        rightHeight = dfs(node.right)
        currPathNodes = leftHeight + rightHeight + 1
        self.maxPathNodes = max(self.maxPathNodes, currPathNodes)
        return 1 + max(leftHeight, rightHeight)

    dfs(root)
    return maxPathNodes - 1

```

^^ **Note**
- `currPathNodes = leftHeight + rightHeight + 1` because while we have the height of the left and right subtrees, we add 1 to include this parent node and "connect" them, giving us a path. 
- we return maxPathNodes - 1 because we're tracking the # of nodes in the path, but the length of a path = nodes - 1

You can rewrite it to just track the # of edges, but to me it makes more sense to think of in nodes.

## 100. Same Tree

Given the roots of two binary trees `p` and `q`, return `true` if the trees are equivalent, otherwise return `false`.

Two binary trees are considered equivalent if they share the exact same structure and the nodes have the same values.

### Key Takeaways

We similarly recurse through the tree using a DFS-style approach. Essentially, we will evaluate the `root` of each tree, and if they are equal, we continue to traverse down the layers of the tree. If they're not, then we simply return false.

Since this uses recursion, we must determine a base case with which the recursive calls will return. Since we only move down a layer if the roots of the trees exist and are the same, if we reach a case where `p` and `q` are both `None`, then we know we have reached the ends of both trees, and can return `True`.

Here's the code to illustrate:
```python
def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
    if not p and not q:
        return True
    
    if p and q and p.val == q.val:
        return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)

    else:
        return False
```
The key intuition is the line `return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)`. This essentially says, we have evaluated that for the corresponding nodes `p` and `q`, `p.val` == `q.val`. So next we want to check whether the subtrees of `p` and `q` are equal by calling isSameTree() on the left subtrees (compare `p.left` and `q.left`) and the right subtrees (compare `p.right` and `q.right`).

**BFS Approach**

Similarly, you can do a level order travesal using BFS, can checking at each point whether the nodes are the same. Level order traversal (BFS) is implemented using a queue, which maintains the order in which nodes have been seen.

This is implemented as follows:

    def isSameTree(p: Node, q: Node):
        pq = deque([p])
        qq = deque([q])

        while pq and qq:
            pnode = pq.popleft()
            qnode = qq.popleft()

            # if the curr node is both None, then move onto next node
            if not pnode and not qnode: 
                continue
            
            # this case triggers when pnode or qnode is None when the other not, or the values are not the same
            if not pnode or not qnode or pnode.val != qnode.val:
                return False
            
            pq.append(pnode.left)
            pq.append(pnode.right)
            qq.append(qnode.left)
            qq.append(qnode.right)

        return True

See the comments in the code for some things to note.
## 572. Subtree of Another Tree (Binary)

Given the roots of two binary trees `root` and `subRoot`, return `true` if there is a subtree of `root` with the same structure and node values of `subRoot` and `false` otherwise.

A subtree of a binary tree tree is a tree that consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree of itself.

### Key Takeaways

This problem can be split into 2 parts. First is traversing the tree, and then at each point, checking whether you have a subtree.

Remember from above, we can check whether 2 binary trees are equal using the following algorithm:
```python
def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
    # reached base case (have traversed the trees to their ends, or leaves)
    if not p and not q:
        return True
    
    # these nodes are equivalent, so we recurse the subtrees
    if (p and q) and (p.val == q.val):
        return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)

    # p and q are not equivalent nodes, so not same tree
    return False
```
Next, we need to traverse the root tree so that at each node, we check if the the resulting subtrees are equal. This is how we traverse the `root`:
```python
def isSubtree(self, root: Optional[TreeNode], subTree: Optional[TreeNode]) -> bool:

    if not subTree:
        return True

    if not root:
        return False

    if self.isSameTree(root, subTree):
        return True

    return self.isSubTree(root.left, subTree) or self.isSubtree(root.right, subTree)
```
Note, we return `isSubtree(root.left, subTree) **or** isSubtree(root.right, subTree)` because we only need one of the two to be true for our algorithm to be true.

**BFS Approach**

If we wanted to do a BFS approach, we can use the same approach:

- Traverse the tree in any order so as we touch every node
- At each node, check if the subtree at that node and the given tree are equivalent

To check tree equivalence:
```python
def isSameTree(p, q) -> bool:
    pq = deque([p])
    qq = deque([q])

    while len(qq) > 0:
        pnode = pq.popleft()
        qnode = qq.popleft()

        if not pnode and not qnode:
            continue
        if not pnode or not qnode or pnode.val != qnode.val:
            return False
        
        pq.append(pnode.left)
        pq.append(pnode.right)
        qq.append(qnode.left)
        qq.append(qnode.right)
    return False
```
Then, do a standard BFS traversal to get through each node:
```python
def isSubtree(self, root: Optional[TreeNode], subTree: Optional[TreeNode]) -> bool:
    if not subTree:
        return True
    rq = deque([root])

    while rq:
        rnode = rq.popleft()
        if not rnode:
            continue

        if rq and rq.val == subTree.val:
            if self.isSameTree(root, subTree):
                return True

        rq.append(rnode.left)
        rq.append(rnode.right)

    return False
```
## 235. Lowest Common Ancestor (BST)

Given a binary search tree (BST) where all node values are unique, and two nodes from the tree `p` and `q`, return the lowest common ancestor (LCA) of the two nodes.

The lowest common ancestor between two nodes `p` and `q` is the lowest node in a tree T such that both `p` and `q` as descendants. The ancestor is allowed to be a descendant of itself.

### Key Takeaways

A major helper in this problem is the fact that we are given a BST. This has a very nice property in which the value of all nodes to the left of `root` are less than `root.val`, and vice versa to the right of `root`.

We observe that for an arbitrary `node` to be the lowest common ancestor for `p` and `q`, that means that `node.val >= p.val` and `node.val <= q.val`. If this is the case, then we can return `node`.

However, if this isn't the case, we need to continue to traverse our tree. In the case that `node.val > p.val and node.val > p.val`, this means that while `node` could be a common ancestor, it's not the lowest common ancestor, as the lowers common ancestor's value must lie between `p.val` and `q.val`. In this case, the LCA must life somewhere inside the left subtree of `node`, so we call our algorithm but `root.left` is passed in, like so:

    return self.leastCommonAncestor(root.left, p, q)

In our base case, we know that the first `root` is a common ancestor, at the end we return `root`
```python
def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
    if not root or not p or not q:
        return None
    
    # root.val is larger than both p and q, a least common ancestor would exist on the left
    if max(p.val, q.val) < root.val:
        self.lowestCommonAncestor(root.left, p, q)
    
    # root.val is less than both p and q, least common ancestor would exist on the right
    elif min(p.val, q.val) > root.val:
        self.lowestCommonAncestor(root.right, p, q)

    # root is in between (inclusive) p.val and q.val (no smaller common ancestor exists)
    else:
        return root
```
## 102. Binary Tree Level Order Traversal

Given a binary tree `root`, return the level order traversal of it as a nested list, where each sublist contains the values of nodes at a particular level in the tree, from left to right.

Input: root = [1,2,3,4,5,6,7]

![Alt text](https://imagedelivery.net/CLfkmk9Wzy8_9HRyug4EVA/a4639809-0754-4eda-221f-a4cd58bd9c00/public)

Output: [[1],[2,3],[4,5,6,7]]

### Key Takeaways

Level-order traversal is essentially breadth-first search on a binary tree. At each level, we add the values to a list and then add that list to our result. See the code below:
```python
def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
    res = []

    if not root:
        return res
        
    q = deque()
    
    q.append(root)
    
    while q:
        level = []
        for i in range(len(q)):
            node = q.popleft()
            level.append(node.val)
            if node.left:
                q.append(node.left)
            if node.right:
                q.append(node.right)
        res.append(level)
    
    return res
```
**Alternate BFS**
We can use a more-general approach for level-order traversal (one that doesn't depend on the binary tree invariant)
```python
def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
    q = deque([root])
    res = []
    while q:
        level = []
        for _ in range(len(q)):
            node = q.popleft()
            level.append(node)
            q.append(node.left)
            q.append(node.right)
        
        if len(level) > 0:
            res.append(level)
    return res
```
## 98. Validate Binary Search Tree

Given the `root` of a binary tree, return `true` if it is a valid binary search tree, otherwise return `false`.

A valid binary search tree satisfies the following constraints:

- The left subtree of every node contains only nodes with keys **less than** the node's key.
- The right subtree of every node contains only nodes with keys **greater than** the node's key.
- Both the left and right subtrees are also binary search trees.

### Key Takeaways

The naive approach (and what I did), was to just do a recursive check, where for each subtree, we check if the left value and right value are correct in relation to the current node's value, and then recurse. 

This is wrong because of it doesn't preserve the fact that the value of ALL the elements on the right of the node have to be greater than it (or less than if we're looking at the left side).

To solve this, we then need to do a DFS traversal of the tree, where at each step, we update the left and right values with which our current node must abide by.

For example, our first node can have any value, so it's left and right range is from `-inf` to `inf`. 

When we check the left subtree, we need to update the right bound to make sure that our subtree maintains the BST invariant.

Do achieve this, our dfs traversal takes in the following parameters:

- `dfs(node, leftBound, rightBound)`

To check the left subtree, we call `dfs(node.left, leftBound, node.val)`. The right check is inversely `dfs(node.right, node.val, rightBound)`.

We only update one of the bounds becuase if we're checking the right subtree, the lower bound for the node we are checking is now updated to the previous-node's value, and vice versa.

## 230. Kth Smallest Integer in BST

Given the `root` of a binary search tree, and an integer `k`, return the `k`th smallest value (1-indexed) of all the values of the nodes in the tree.

A **binary search tree** satisfies the following constraints:

- The left subtree of every node contains only nodes with keys less than the node's key.
- The right subtree of every node contains only nodes with keys greater than the node's key.
- Both the left and right subtrees are also binary search trees.

### Key Takeaways

The main thing to note here are the BST constaints. Since we know every node in the left subtree contains nodes that are less than it and vice versa for the right, we can pick up on doing an inorder traversal of the tree. This is implemented using a variation of recursive dfs.
```python
def kthSmallest(root, k):
    tree_arr = []

    def dfs(node):
        if node is None:
            return
        
        dfs(node.left)
        tree_arr.append(node.val)
        dfs(node.right)

    # k - 1 because k is 1-indexed
    return tree_arr[k-1]
```
## 105. Construct Binary Tree from Inorder and Preorder Traversal

Given two integer arrays `preorder` and `inorder` where `preorder` is the preorder traversal of a binary tree and `inorder` is the inorder traversal of the same tree, construct and return the binary tree.

### Key Takeaways.

First thing's first, the main takeaway is what inorder and preorder traversal are. You can refer to the image at the top of the notes, but in words ->

*note: "visit" means we process the node, and "traverse" means we expore until None

- *Inorder:* traverse the left subtree, then visit the current node, then traverse the right subtree.
    - helps to think about as a recursive dfs (explore left until none, then process that node. then process the parent, then that parent's right, and then pop back up another level, etc)
    - in a binary search tree (where all items in the left subtree are less than the root and vice versa for the right), this traversal yields a sorted order

- *Preorder:* process current node, traverse left subtree, traverse right subtree. (aka, process the node before the children)

There are 2 main observations from this problem. First, that the first element of `preorder` is the root of the tree. Second, `inorder` can be split in half to represent nodes in the left subtree and the right subtree.

- So if we want to reconstruct the tree, we should do it in the order of `preorder`, as it goes top down (process parent and then children). Then, we can use `inorder` to determine the structure of the tree.

The way we can deduce the structure of the tree is for each recursive dfs call to take in a `left` and `right` pointer. These signify the region of `inorder` that this recursive call is constructing (since we can split `inorder` into subtrees).
- once `right` < `left`, that means that there is no more nodes in the subtree, so we've reached the end of a leaf

**Algorithm**

We will be reconstructing the tree in in a preorder order.

So at each step / recursive call, we start by processing the root of our current subtree, which is deduced from a global `self.preIndex` variable from `preorder`. 

Then `self.preIndex` is incremented because we want to know the next node to process in `preorder`. 

We the initialize a node from this value and get the index of this root in `inorder`. This `rootIndex` is then used to split `inorder`so that we can perform a recursive call to create the left and right subtrees.
- `node.left = dfs(left, rootIndex - 1)` and `node.right = dfs(rootIndex + 1, right)`.

As our base case, we've reached a leaf node when `right < left`, since that means that the subtree we are trying to create is no longer valid. So we can return `None` and begin propogating back up the call stack.

After initializing `node.left` and `node.right`, we can then return the root since the subtrees will have been constructred.
```python
def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
    indices = {value: index for index, value in enumerate(inorder)}

    self.preIndex = 0
    def dfs(l, r):
        if r < l:
            return None
        rootVal = preorder[self.preIndex]
        rootIndex = indices[rootVal]
        self.preIndex += 1

        root = TreeNode(rootVal)
        root.left = dfs(l, rootIndex - 1)
        root.right = dfs(rootIndex + 1, r)

        return root

    return dfs(0, len(inorder) - 1)
```