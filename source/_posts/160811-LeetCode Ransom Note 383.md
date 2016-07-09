---
title: LeetCode Ransom Note 383
permalink: leetcode-ransom-note-383
comments: true
date: 2016-08-11 13:00:00
toc: true
tags:
   - leetcode
description:
---

[383. Ransom Note](https://leetcode.com/problems/ransom-note/)
&emsp;&emsp;Given an arbitrary ransom note string and another string containing letters from all the magazines, write a function that will return true if the ransom note can be constructed from the magazines ; otherwise, it will return false.
&emsp;&emsp;Each letter in the magazine string can only be used once in your ransom note.
<!-- more -->
Note:
You may assume that both strings contain only lowercase letters.
```
canConstruct("a", "b") -> false
canConstruct("aa", "ab") -> false
canConstruct("aa", "aab") -> true
```

---
自己第一次做 LeetCode 上面的题，也没什么算法方面的学习，摸着石头过河，步步提高。

### 大体意思
判断第二个字符串中的字母是否可以组成第一个字符串，每个字母只能用一次；两个字符串仅包含小写字母

### 自己的思路
将 ransom 转成 char 数组，遍历数组，然后在 magazines，进行对比，然后除去一个一样的字母

``` java
public static boolean canConstruct(String ransom, String magazine) {

	if (ransom.length() > magazine.length()) {
		return false;
	}

	char[] ransomChar = ransom.toCharArray();
	for (int i = 0; i < ransomChar.length; i++) {
		String str = String.valueOf(ransomChar[i]);
		if (magazine.indexOf(str) == -1) {
			return false;
		} else if (magazine.indexOf(str) == magazine.length() - 2) {
			magazine = magazine.substring(0, magazine.indexOf(str));
		} else {
			magazine = magazine.substring(0, magazine.indexOf(str)) + magazine.substring(magazine.indexOf(str) + 1);
		}
	}
	return true;
}
```

### 别人的算法

- [leetcode Ransom Note - 细语呢喃](https://www.hrwhisper.me/leetcode-ransom-note/)

``` java
public class Solution {
    public boolean canConstruct(String ransomNote, String magazine) {
        int[] cnt = new int[26];
        for (int i = 0; i < magazine.length(); i++) cnt[magazine.charAt(i) - 97]++;
		for (int i = 0; i < ransomNote.length(); i++) if (--cnt[ransomNote.charAt(i) - 97] < 0) return false;
		return true;
    }
}
```

- 我的理解
26个元素的数组，每个元素存放字母的个数，如果需要的多于存在的 return false
