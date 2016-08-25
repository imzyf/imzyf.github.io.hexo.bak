---
title: LeetCode Majority Element 169
permalink: leetcode-majority-element-169
comments: true
date: 2016-08-24 9:30:00
toc: true
tags:
- leetcode
---
[169. Majority Element](https://leetcode.com/problems/majority-element/)
&emsp;&emsp;Given an array of size n, find the majority element. The majority element is the element that appears more than [ n/2 ] times.
&emsp;&emsp;You may assume that the array is non-empty and the majority element always exist in the array.
<!-- more -->
### 题目大意
给定一个数组，找这个数组中的主元素，主元素是元素出现次数大于⌊ n/2 ⌋的元素。
假设给定的数组非空，主元素都存在。

### 自己的解法
将数组进行排序，根据题意，那么中间的这个数就是 majority element

``` java
public int majorityElement(int[] nums) {
		Arrays.sort(nums);
		return nums[nums.length / 2];
}
```

### 别人的解法

[【LeetCode-面试算法经典-Java实现】【169-Majority Element（主元素）】 ](http://blog.csdn.net/DERRANTCM/article/details/47902549)

&emsp;&emsp;用一个标记 cnt 记录某个元素出现的次数，如果后面的元素和它相同就加一，有一个元素和他不相同就减一，当 cnt 小于等于0时重新记录新的元素。

``` java
public int majorityElement(int[] nums) {
		int main = nums[0]; // 用于记录主元素，假设第一个是主元素
		int count = 1; // 用于抵消数的个数
		for (int i = 1; i < nums.length; i++) { // 从第二个元素开始到最后一个元素
			if (main == nums[i]) { // 如果两个数相同就不能抵消
				count++; // 用于抵消的数据加1
			} else {
				if (count > 0) { // 如果不相同，并且有可以抵消的数
					count--; // 进行数据抵消
				} else { // 如果不相同，并且没有可以抵消的数
					main = nums[i]; // 记录最后不可以抵消的数
				}
			}
		}
		// 对于数组中可能没有主元素的情况，题中说明存在，此步可以省略。
		// count = 0;
		// for (int a : nums) {
		// if (a == main) {
		// count++;
		// }
		// }
		// if (count >= nums.length / 2) {
		// return main;
		// } else {
		// throw new RuntimeException("No majority element");
		// }
		return main;
}
```
