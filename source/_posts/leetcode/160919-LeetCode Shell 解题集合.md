---
title: LeetCode Shell 解题集合
permalink: leetcode-shell-solutions
comments: true
toc: true
date: 2016-09-19 16:00:00
tags: 
   - leetcode
   - shell
description:
---

&emsp;&emsp;LeetCode Shell 的试题多为文本操作，[195. Tenth Line](https://leetcode.com/problems/tenth-line/)、[193. Valid Phone Numbers](https://leetcode.com/problems/valid-phone-numbers/)、[192. Word Frequency](https://leetcode.com/problems/word-frequency/)、[194. Transpose File](https://leetcode.com/problems/transpose-file/) 暂时只有4道题，就整合在这一起了
&emsp;&emsp;Shell 中文本处理的事情基本 `awk` `sed` `grep` `sort` `uniq` `tail` `head` 几个命令组合组合就搞定了
<!-- more -->

## [195. Tenth Line](https://leetcode.com/problems/tenth-line/)

### 大体意思
How would you print just the 10th line of a file?
For example, assume that file.txt has the following content:
```
Line 1
Line 2
Line 3
Line 4
Line 5
Line 6
Line 7
Line 8
Line 9
Line 10
```
Your script should output the tenth line, which is:
```
Line 10
```
打印出文本文件中第 10 行的内容。

### 自己的解法
``` bash
cat  file.txt | tail -n +10 | head -n 1
```
这是学习了：[linux 如何显示一个文件的某几行(中间几行) - 香格里拉\(^o^)/](http://www.cnblogs.com/xianghang123/archive/2011/08/03/2125977.html)

### 别人的解法

方法一：
``` bash
awk 'NR==10' file.txt
# awk的默认动作就是打印$0，所以NR==10后面可以不用加{print $0}
```
方法二：
``` bash
sed -n '10p' file.txt
# 如果不够10行，则什么也不打印
```
方法三：
``` bash
line=$(cat file.txt | wc -l)     # 千万注意，等号前后一定不要有空格
if [ "$line" -ge 10 ] ; then     # $line的双引号也可以不用加
  cat file.txt | head -n 10 | tail -n 1 
fi
```
Reference: [leetcode-195 Tenth Line - 2&gt; /dev/null](http://blog.csdn.net/sole_cc/article/details/44977821)


## [193. Valid Phone Numbers](https://leetcode.com/problems/valid-phone-numbers/)
### 大体意思
Given a text file `file.txt` that contains list of phone numbers (one per line), write a one liner bash script to print all valid phone numbers.
You may assume that a valid phone number must appear in one of the following two formats: (xxx) xxx-xxxx or xxx-xxx-xxxx. (x means a digit)
You may also assume each line in the text file must not contain leading or trailing white spaces.

For example, assume that `file.txt` has the following content:
```
987-123-4567
123 456 7890
(123) 456-7890
```
Your script should output the following valid phone numbers:
```
987-123-4567
(123) 456-7890
```
匹配有效的电话号码

### 自己的解法
``` bash
cat file.txt | grep '^[0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}$\|^([0-9]\{3\}) [0-9]\{3\}-[0-9]\{4\}$'
```

### 别人的解法
``` bash
grep -P '^(\(\d{3}\)|\d{3}-)\d{3}-\d{4}$' file.txt
```

Reference: [LeetCode 193: Valid Phone Numbers &#8211; Revo](https://ruixublog.wordpress.com/2015/05/13/leetcode-193-valid-phone-numbers/)



## [192. Word Frequency](https://leetcode.com/problems/word-frequency/)

### 大体意思
Write a bash script to calculate the frequency of each word in a text file `words.txt`.

For simplicity sake, you may assume:

`words.txt` contains only lowercase characters and space `' '` characters.
Each word must consist of lowercase characters only.
Words are separated by one or more whitespace characters.
For example, assume that `words.txt` has the following content:
```
the day is sunny the the
the sunny is is
```
Your script should output the following, sorted by descending frequency:
```
the 4
is 3
sunny 2
day 1
```
Note:
Don't worry about handling ties, it is guaranteed that each word's frequency count is unique.

统计单词出现的频次，然后倒序排列

### 别人的解法
``` bash
awk '{i=1;while(i<=NF){print $i;i++}}' words.txt  | sort | uniq -c  | sort -k1nr  | awk '{print $2 " " $1}'
```

1、利用 awk 默认一行一条记录，默认以空格划分每条记录，NF 为划分的总块数先打印出所有单词
2、排序 + 统计 + 消除重复
3、输出

Reference: [LeetCode 192 Word Frequency - wangxiaobupt的专栏](http://blog.csdn.net/wangxiaobupt/article/details/45201817)


``` bash
awk '
{ for (i=1; i<=NF; i++) { ++S[$i]; } }
END { for (i in S) { print i, S[i] } }
' words.txt | sort -nr -k 2
```

Reference: [leetcode/solutions/192.Word_Frequency at master · illuz/leetcode](https://github.com/illuz/leetcode/tree/master/solutions/192.Word_Frequency)

## [194. Transpose File](https://leetcode.com/problems/transpose-file/)

### 大体意思
Given a text file `file.txt`, transpose its content.

You may assume that each row has the same number of columns and each field is separated by the `' '` character.

For example, if `file.txt` has the following content:
```
name age
alice 21
ryan 30
```
Output the following:
```
name alice ryan
age 21 30
```
### 别人的解法
```
awk '
{
    for (i = 1; i <= NF; i++) {
        if(NR == 1) {
            s[i] = $i;
        } else {
            s[i] = s[i] " " $i;
        }
    }
}
END {
    for (i = 1; s[i] != ""; i++) {
        print s[i];
    }
}' file.txt
```

Reference: [leetcode/solutions/194.Transpose_File at master · illuz/leetcode](https://github.com/illuz/leetcode/tree/master/solutions/194.Transpose_File)


## 总结
&emsp;&emsp;Shell 中文本处理的事情基本 `awk` `sed` `grep` `sort` `uniq` `tail` `head` 几个命令组合组合就搞定了，各命令的常用方法之后总结

