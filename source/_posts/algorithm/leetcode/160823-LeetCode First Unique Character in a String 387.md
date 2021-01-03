---
title: LeetCode First Unique Character in a String 387
permalink: leetcode-first-unique-character-in-a-string-387
comments: true
date: 2016-08-23 14:30:00
toc: true
tags:
   - leetcode
---
[387. First Unique Character in a String](https://leetcode.com/problems/first-unique-character-in-a-string/)
&emsp;&emsp;Given a string, find the first non-repeating character in it and return it's index. If it doesn't exist, return -1.
&emsp;&emsp;**Examples:**
```
s = "leetcode"
return 0.

s = "loveleetcode",
return 2.
```
<!-- more -->
&emsp;&emsp;**Note:**
&emsp;&emsp;You may assume the string contain only lowercase letters.

### 自己的解法
开始觉的遍历 char[] 然后判断在 String 的首位置和末位置，若一样就返回索引。呃，感觉有点偷鸡

``` java
public int firstUniqChar(String s) {
  for (int i = 0; i < s.length(); i++) {
    if (s.indexOf(s.charAt(i)) == s.lastIndexOf(s.charAt(i))) {
      return i;
    }
  }
  return -1;
}
```

查了下别人的，又是 `new int[26]`

``` java
public int firstUniqChar(String s) {
  int[] count = new int[26];
  for (int i = 0; i < s.length(); i++) {
    count[s.charAt(i) - 'a']++;
  }
  for (int i = 0; i < s.length(); i++) {
    if (count[s.charAt(i) - 'a'] == 1) {
      return i;
    }
  }
  return -1;
}
```

但是在运行时间上，下面的方法更快
