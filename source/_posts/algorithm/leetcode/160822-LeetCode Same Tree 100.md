---
title: LeetCode Same Tree 100
permalink: leetcode-same-tree-100
comments: true
date: 2016-08-22 16:00:00
toc: true
tags:
   - leetcode
description:

---

[100. Same Tree](https://leetcode.com/problems/same-tree/)
&emsp;&emsp;Given two binary trees, write a function to check if they are equal or not. 
&emsp;&emsp;Two binary trees are considered equal if they are structurally identical and the nodes have the same value.
<!-- more -->

关于树结构自己没怎么看过，查了查遍历通常是：递归、stack
### 自己的解法

``` java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Solution {
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if (p == null && q == null) {
			return true;
		}
		if (p == null || q == null) {
			return false;
		}
		if (p.val == q.val) {
			return isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
		}
		return false;
    }
}
```

