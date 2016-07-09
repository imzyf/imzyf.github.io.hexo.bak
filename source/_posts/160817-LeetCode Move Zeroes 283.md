---
title: LeetCode Move Zeroes 283
permalink: leetcode-move-zeroes-283
comments: true
date: 2016-08-16 19:00:00
toc: true
tags:
   - leetcode
description:
---

[283. Move Zeroes](https://leetcode.com/problems/move-zeroes/)
&emsp;&emsp;Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements. For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
<!-- more -->
Note: 
- You must do this in-place without making a copy of the array. 
- Minimize the total number of operations.

---
 
### 大体意思
将数组中0元素移动到数组的末尾，不改变其他元素的顺序；不能 copy 数组，最小化的操作

### 自己的思路
#### 交换冒泡

``` java
public static void moveZeroes(int[] nums) {

	boolean hasChange = false;
	do {
		hasChange = false;
		for (int i = 0; i < nums.length - 1; i++) {
			if (nums[i] == 0 && nums[i + 1] != 0) {
				nums[i] = nums[i + 1];
				nums[i + 1] = 0;
				hasChange = true;
			}
		}
	} while (hasChange);
	System.out.println(Arrays.toString(nums));
}
```

#### 与0换位置，参考了别人的想法
 
``` java
public static void moveZeroes2(int[] nums) {
	int firstZoneIndex = -1;
	for (int i = 0; i < nums.length; i++) {
		if (firstZoneIndex != -1) {
			// 发现了过0
			if (nums[i] != 0) {
				nums[firstZoneIndex] = nums[i];
				nums[i] = 0;
				firstZoneIndex++;
			}
		} else {
			// 没有发现过0
			if (nums[i] == 0) {
				firstZoneIndex = i;
			}
		}
	}
	System.out.println(Arrays.toString(nums));
}
```

### 别人的算法

- [西施豆腐渣 - leetcode 283: Move Zeroes](http://blog.csdn.net/xudli/article/details/48574521)

``` java
public void moveZeroes(int[] nums) {
	int i = 0;
	int j = 0;
	while (j < nums.length) {
		if (nums[j] != 0) {
			if (j != i) {
				nums[i++] = nums[j];
				nums[j] = 0;
			} else {
				++i;
			}
		}
		++j;
	}
}
```

