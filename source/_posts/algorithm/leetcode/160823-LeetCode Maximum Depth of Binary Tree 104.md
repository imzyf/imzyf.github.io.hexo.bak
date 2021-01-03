---
title: LeetCode Maximum Depth of Binary Tree 104
permalink: leetcode-maximum-depth-of-binary-tree-104
comments: true
date: 2016-08-23 11:30:00
toc: true
tags:
   - leetcode
---
[104. Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
&emsp;&emsp;Given a binary tree, find its maximum depth.
&emsp;&emsp;The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
<!-- more -->

### 自己的解法

自己想到应该用递归、为空的返回 0，不为空的返回 1，递归累加；但是有两个点这么判断呢？其实很容易取两数字的 MAX

``` java
public int maxDepth(TreeNode root) {
     if (root == null) {
        return 0;
    }
    return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
}
```

参考：
[104 Maximum Depth of Binary Tree | Data Structure and algorithm analysis](https://jingjingshao.gitbooks.io/data-structure-and-algorithm-analysis/content/Tree/104_maximum_depth_of_binary_tree.html)
