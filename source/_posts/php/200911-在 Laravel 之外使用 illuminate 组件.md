---
title: 在 Laravel 之外使用 illuminate 组件
permalink: use-illuminate-components-without-laravel
date: 2020-09-11 15:00:39
updated:
tags:
  - php
categories:
description:
comments: true
toc: true
cover_img:
feature_img:
---

当代框架基本都是有组件构成，这使得框架变得更加灵活。[The Laravel Components | github](https://github.com/illuminate) Laravel 中有不少优质组件，那如何在 Laravel 之外使用 illuminate 组件呢？

## illuminate/validation

以 [illuminate/validation](https://github.com/illuminate/validation) 为例，validation 有丰富的数据验证功能。

在项目的 `composer.json` 文件中添加：

```json
...
    "require": {
      ...
      "illuminate/validation": "^5.8",
...
```

从 [Laravel-Lang/lang](https://github.com/Laravel-Lang/lang/tree/master/src/zh_CN) 项目中复制需要的语言文件放到自己的项目中。

例如：在 Yii2 项目中，复制对应语言文件到项目中的 `assets/lang/zh-CN/validation.php`。

创建 `common/Validator.php`：

```php
<?php

namespace app\common;

use Illuminate\Filesystem\Filesystem;
use Illuminate\Translation\FileLoader;
use Illuminate\Translation\Translator;
use Illuminate\Validation\Factory;

class Validator
{
  private static $instance = null;

  private function __construct()
  {
  }

  public static function getInstance(): Factory
  {
    if (null === static::$instance) {
      $translationPath = get_alias('@assets/lang');
      $translationLocale = 'zh-CN';
      $transFileLoader = new FileLoader(new Filesystem(), $translationPath);
      $translator = new Translator($transFileLoader, $translationLocale);
      static::$instance = new Factory($translator);
    }

    return static::$instance;
  }
}
```

在全局函数文件添加：

```php
// https://learnku.com/docs/laravel/5.8/validation/3899#manually-creating-validators
// $rules = [
//  'name' => 'required|string|min:2|max:5',
//  'code' => 'required|string|min:2|max:5',
// ];
function validator(array $data, array $rules, array $messages = [], array $customAttributes = [])
{
  return \app\common\Validator::getInstance()->make($data, $rules, $messages, $customAttributes);
}
```

测试使用：

```php
$rules = ['name' => 'required|numeric'];
$customAttributes = ['name' => 'My name'];
$messages = ['name.required' => 'A name is required',];

$validator = validator($data, $rules, $customAttributes, $messages);
if ($validator->fails()) {
    $errors = $validator->errors()->all();
    Response::error(Errors::ParamsInvalid, implode(',', $errors), $errors);
}
```

-- EOF --
