---
title: 【Core Java】彩票选取中奖数字-数组例子
date: 2016-03-23 20:10:00
tags: java
permalink: core-java-array-dome
---
从 1,2,3……h 中取 k 个中奖号码

<!-- more -->
java code:
```
package im.zyf.javacore;

import java.util.Arrays;
import java.util.Scanner;

public class LotteryDrawing {

    public static void main(String[] args) {
        // TODO Auto-generated method stub

        Scanner in = new Scanner(System.in);
        System.out.println("how many numbers do you need?");
        int k = in.nextInt();

        System.out.println("what is the highest number?");
        int h = in.nextInt();

        int[] harr = new int[h];
        for (int i = 0; i < h; i++) {
            harr[i] = i + 1;
        }

        int[] karr = new int[k];
        for (int i = 0; i < k; i++) {
            int random = (int) (Math.random() * h);
            karr[i] = harr[random];
            //将数组最后的值，代替掉被取走的值
            harr[random] = harr[h - 1];
            //数组长度减1
            h--;

        }
        Arrays.sort(karr);
        System.out.println(Arrays.toString(karr));

    }
}
```

Console：
```
how many numbers do you need?
3
what is the highest number?
4444444
[433177, 827621, 2607294]
```

有几个点：
取过的数不能再取
取后升序排列

关键点：
每次取的都是下标，而不是实际的值。下标指向包含尚未抽取的数组元素
