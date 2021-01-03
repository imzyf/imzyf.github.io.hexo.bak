---
title: LeetCode Intersection of Two Arrays 349
permalink: leetcode-intersection-of-two-arrays-349
comments: true
date: 2016-08-22 18:00:00
toc: true
tags:
   - leetcode
description:
---
[349. Intersection of Two Arrays](https://leetcode.com/problems/intersection-of-two-arrays/)
&emsp;&emsp;Given two arrays, write a function to compute their intersection.
&emsp;&emsp;**Example:**
&emsp;&emsp;Given nums1 = `[1, 2, 2, 1]`, nums2 = `[2, 2]`, return `[2]`.
<!-- more -->
&emsp;&emsp;**Note:**
&emsp;&emsp;Each element in the result must be unique.
&emsp;&emsp;The result can be in any order.

### 自己的解法

使用 set 进行去重

``` java
public static int[] intersection2(int[] nums1, int[] nums2) {
	Set<Integer> nums1Set = new HashSet<>();
	Set<Integer> set = new HashSet<>();
	for (int integer : nums1) {
		nums1Set.add(integer);
	}
	for (int integer : nums2) {
		if (nums1Set.contains(integer)) {
			set.add(integer);
		}
	}
	int[] result = new int[set.size()];
	int i = 0;
	for (int integer : set) {
		result[i] = integer;
		i++;
	}
	return result;
}
```
### 别人的思路

[LeetCode – Intersection of Two Arrays (Java)](www.programcreek.com/2015/05/leetcode-intersection-of-two-arrays-java/)

Binary Search
``` java
public int[] intersection(int[] nums1, int[] nums2) {
    Arrays.sort(nums1);
    Arrays.sort(nums2);
    ArrayList<Integer> list = new ArrayList<Integer>();
    for(int i=0; i<nums1.length; i++){
        if(i==0 || (i>0 && nums1[i]!=nums1[i-1])){
            if(Arrays.binarySearch(nums2, nums1[i])>-1){
                list.add(nums1[i]);
            }
        }
    }
    int[] result = new int[list.size()];
    int k=0;
    for(int i: list){
        result[k++] = i;
    }
    return result;
}
```

Time = O(nlog(n)).
Space = O(n).
