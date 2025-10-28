# Tries

## Notes

**Definition**

A tree-based data structure that is often used to store characters. While each node my only store a character, the path from the root to the node represents a word/part of a word, allowing for fast lookups of strings.

*Common Uses*

- Tries are often used in questions that as for word list validation, or string lookup. For example, given a list of strings, find all the celbrity names. 

*Implementation*

    class PrefixTreeNode:
        def __init__(self):
            self.children = {} # keys are characters, values are PrefixTreeNode()
            self.end # whether the current node is the end of a word.

*Common Methods*

- `void insert(String word)` 
    -   Inserts the string word into the prefix tree.
- `boolean search(String word)`
    - Returns true if the string word is in the prefix tree (i.e., was inserted before), and false otherwise.
- `boolean startsWith(String prefix)`
    - Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise. 

## 208. Implement Prefix Trie

Implement the PrefixTreeClass with the `insert`, `search`, and `startsWith` methods.

### Key Takeaways

The methods are implemetned as below.ß

    class PrefixTree:

    def __init__(self):
        self.root = PrefixTreeNode()

    def insert(self, word: str) -> None:
        curr = self.root

        for c in word:
            if not curr.children.get(c):
                curr.children[c] = PrefixTreeNode()
            curr = curr.children[c]
        curr.isComplete = True

    def search(self, word: str) -> bool:
        curr = self.root

        for i in range(len(word)):
            c = word[i]
            if not curr.children.get(c):
                return False
            curr = curr.children.get(c)

        return curr.isComplete
            

    def startsWith(self, prefix: str) -> bool:
        curr = self.root

        for c in prefix:
            if not curr .children.get(c):
                return False
            curr = curr.children.get(c)
        return True

The main takeaway here is the implementation of the PrefixTreeNode. The children is referenced as a dictionary of (character: children). To get the children of a character, `c`, you update curr to be curr.children.get(c), and then assess from there.

## 211. Design and Add and Search Words Data Structure 

Design a data structure that supports adding new words and searching for existing words.

Implement the `WordDictionary` class:

- `void addWord(word)` Adds `word` to the data structure.

- `bool search(word)` Returns `true` if there is any string in the data structure that matches `word` or `false` otherwise. word may contain dots '.' where dots can be matched with any letter.

### Key Takeaways

This data structure is the same as our Trie from before, but with a more-specific search function. The addWord() function is the same and is as follows:

    def addWord(word: str):

        curr = self.root

        for c in word:
            if not curr.children.get(c):
                curr.children[c] = TrieNode()
            curr = curr.children[c]
        
        curr.end = True
    
The more important distinction comes with the search function. There are 2 parts to the function, an iterative case and a recursive case. The iterative case is while the word we are checking has a character. The recursive case is when we encounter a "." in our string, in which we have to perform a DFS operation.

    def search(word: str) -> bool:

        def dfs(j: int, root: TrieNode):

            curr = root

            for i in range(j, len(word)):
                c = word[i]
                if c == ".":
                    for child in curr.children:
                        if dfs(i + 1, child):
                            return True
                
                else:
                    if not curr.children.get(c):
                        return False
                    else:
                        curr = curr.children[c]
            return curr.end
        
        return dfs(0, self.root)

If the current character we're looking at (`c`) is not ".", then we continue to iterate through our for loop by updating `curr = curr.children[c]`.

In the case where c == ".", then we need to recurse. For each of the children of of the "." node we are currently in, we need to pass in the `child` to check if the rest of our `word` matches with it. Lastly, since the "." could occur in any part of the `word`, we need to also pass in the index with which our `child` node represents so that `c = word[i]` is correct.