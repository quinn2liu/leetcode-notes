# Trees

## NOTES

There are several ways to traverse a tree.

![Alt text](https://media.geeksforgeeks.org/wp-content/uploads/20240429140116/Tree-Traversal-Techniques-(1).webp)

- BFS does level-order traversal, whereas DFS can be any of the other 3.

### Binary Search Tree

A binary tree in which all nodes to the left of a node have a value less than it, and all nodes to the right of a node have a value greater than it.

## 226. Invert Binary Tree

You are given the root of a binary tree `root`. Invert the binary tree and return its root.

Definition for a binary tree node.

    class TreeNode:
        def __init__(self, val=0, left=None, right=None):
            self.val = val
            self.left = left
            self.right = right

### Key Takeaways

So the main thing to remember here is how we use recursion to our advantage. If we're trying to reverse the tree, we can simply invert each of the subtrees of our root. Once we reach a leaf (where `root == None`), then we return `None` and go back up the tree.

    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        
        if not root:
            return None

        root.left, root.right = root.right, root.left

        self.invertTree(root.left)
        self.invertTree(root.right)

        return root

So traditionally, when this is implemented in Java, you set `node.left = invertTree(root.right)`. In Python, you don't need to do this because we are calling `self.invertTree()`, which has access to the original instance of `root`, and any changed to the children of `root` are present for `root` itself.

## 104. Max Depth of Binary Tree

Given the `root` of a binary tree, return its depth.

The **depth** of a binary tree is defined as the number of nodes along the longest path from the root node down to the farthest leaf node.

### Key Takeaways

There are 3 ways to solve this problem. 

#### 1. Recursive DFS

Here, I simply use the power of recursion to essentially traverse branches of the tree until I reach the leaf nodes. Once you reach the end of a leaf node, you return 0 (as `None` shouldn't add to your depth). Then when you return from recursion, you add 1 to whatever return value you have to accurately get the depth.

Lastly, to ensure that you have the max depth, each time you get the depth from the right and left sides of the tree, you should only return the `max()` of the two sides. Here it is in code:

    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        return 1 + max(self.maxDepth(root.left), self.maxDepth(root.right))


#### 2. BFS

With BFS, we have a deque representing the nodes that we have to explore (initialized to `root`). While there are still elements in the deque, we will take the length of our deque at the time (called i). For `i` iterations (each of the nodes in our layer), we pop the least-recently-added node (`popleft()`), then check if it has a right or left node. If it does, then we will add that node to the deque.

After we've popped `i` nodes, we'll increment a `level` variable, to indicate that we've explored all nodes for that level.

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

## 100. Same Tree

Given the roots of two binary trees `p` and `q`, return `true` if the trees are equivalent, otherwise return `false`.

Two binary trees are considered equivalent if they share the exact same structure and the nodes have the same values.

### Key Takeaways

We similarly recurse through the tree using a DFS-style approach. Essentially, we will evaluate the `root` of each tree, and if they are equal, we continue to traverse down the layers of the tree. If they're not, then we simply return false.

Since this uses recursion, we must determine a base case with which the recursive calls will return. Since we only move down a layer if the roots of the trees exist and are the same, if we reach a case where `p` and `q` are both `None`, then we know we have reached the ends of both trees, and can return `True`.

Here's the code to illustrate:

    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q:
            return True
        
        if p and q and p.val == q.val:
            return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)

        else:
            return False

The key intuition is the line `return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)`. This essentially says, we have evaluated that for the corresponding nodes `p` and `q`, `p.val` == `q.val`. So next we want to check whether the subtrees of `p` and `q` are equal by calling isSameTree() on the left subtrees (compare `p.left` and `q.left`) and the right subtrees (compare `p.right` and `q.right`).

## 572. Subtree of Another Tree (Binary)

Given the roots of two binary trees `root` and `subRoot`, return `true` if there is a subtree of `root` with the same structure and node values of `subRoot` and `false` otherwise.

A subtree of a binary tree tree is a tree that consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree of itself.

### Key Takeaways

This problem can be split into 2 parts. First is traversing the tree, and then at each point, checking whether you have a subtree.

Remember from above, we can check whether 2 binary trees are equal using the following algorithm:

    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q:
            return True
        
        if (p and q) and (p.val == q.vall):
            return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)

        return False

Next, we need to traverse the root tree so that at each node, we check if the the resulting subtrees are equal. This is how we traverse the `root`:

    def isSubtree(self, root: Optional[TreeNode], subTree: Optional[TreeNode]) -> bool:

        if not subTree:
            return True

        if not root:
            return False

        if self.isSameTree(root, subTree):
            return True

        return self.isSubTree(root.left, subTree) or self.isSubtree(root.right, subTree)

Note, we return `isSubtree(root.left, subTree) **or** isSubtree(root.right, subTree)` because we only need one of the two to be true for our algorithm to be true.

## 235. Lowest Common Ancestor (BST)

Given a binary search tree (BST) where all node values are unique, and two nodes from the tree `p` and `q`, return the lowest common ancestor (LCA) of the two nodes.

The lowest common ancestor between two nodes `p` and `q` is the lowest node in a tree T such that both `p` and `q` as descendants. The ancestor is allowed to be a descendant of itself.

### Key Takeaways

A major helper in this problem is the fact that we are given a BST. This has a very nice property in which the value of all nodes to the left of `root` are less than `root.val`, and vice versa to the right of `root`.

We observe that for an arbitrary `node` to be the lowest common ancestor for `p` and `q`, that means that `node.val >= p.val` and `node.val <= q.val`. If this is the case, then we can return `node`.

However, if this isn't the case, we need to continue to traverse our tree. In the case that `node.val > p.val and node.val > p.val`, this means that while `node` could be a common ancestor, it's not the lowest common ancestor, as the lowers common ancestor's value must lie between `p.val` and `q.val`. In this case, the LCA must life somewhere inside the left subtree of `node`, so we call our algorithm but `root.left` is passed in, like so:

    return self.leastCommonAncestor(root.left, p, q)

In our base case, we know that the first `root` is a common ancestor, at the end we return `root`

## 102. Binary Tree Level Order Traversal

Given a binary tree `root`, return the level order traversal of it as a nested list, where each sublist contains the values of nodes at a particular level in the tree, from left to right.

Input: root = [1,2,3,4,5,6,7]

![Alt text](https://imagedelivery.net/CLfkmk9Wzy8_9HRyug4EVA/a4639809-0754-4eda-221f-a4cd58bd9c00/public)

Output: [[1],[2,3],[4,5,6,7]]

### Key Takeaways

Level-order traversal is essentially breadth-first search on a binary tree. At each level, we add the values to a list and then add that list to our result. See the code below:

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



