---
title: SpringMVC 入门使用
permalink: springmvc-getting-started-tutorial
date: 2016-09-07 14:00:00
comments: true
toc: true
tags:
  - java
description:
---

本文主要参考了 [imooc-SpringMVC 起步](http://www.imooc.com/video/7237) 视频教程和 [SpringMVC 从入门到精通 系列 - HansonQ](http://www.imooc.com/article/3804) ，还有自己的一些总结。

主要内容：MVC 简介、前端控制器模式、SpringMVC 基本概念、SpringMVC 配置、SpringMVC 中的注解、SpringMVC 数据绑定。

## MVC 简介

1、MVC 是一种架构模式
程序分层，分工合作，既相互独立，又协同工作，分为三层：模型层、视图层和控制层

2、MVC 是一种思考方式
View：视图层，为用户提供 UI，重点关注数据的呈现，为用户提供界面
Model：模型层，业务数据的信息表示，关注支撑业务的信息构成，通常是多个业务实体的组合
Controller：控制层，调用业务逻辑产生合适的数据（Model），传递数据给视图用于呈现

MVC 设计模式在 B/S 下的应用：
![MVC设计模式在B/S下的应用](https://cdn-qn.yifans.com/160907-springmvc-getting-started-tutorial-mvc.gif)

①：浏览器发送请求到控制器(这里要知道控制器的作用)
②：控制器不能处理请求必须交给模型层来处理接着去访问数据库
③：模型层将处理好的结果返回给控制层
④：控制层将逻辑视图响应给浏览器(浏览器显示的是渲染过的视图)

**MVC 本质：MVC 的核心思想是业务数据抽取同业务数据呈现相分离；分离有利于程序简化，方便编程**

<!-- more -->

## 前端控制器模式

前端控制器模式（Front Controller Pattern）是用来提供一个集中的请求处理机制，所有的请求都将由一个单一的处理程序处理。该处理程序可以做认证/授权/记录日志，或者跟踪请求，然后把请求传给相应的处理程序。

- 前端控制器（Front Controller）- 处理应用程序所有类型请求的单个处理程序，应用程序可以是基于 web 的应用程序，也可以是基于桌面的应用程序。
- 调度器（Dispatcher） - 前端控制器可能使用一个调度器对象来调度请求到相应的具体处理程序。
- 视图（View） - 视图是为请求而创建的对象。

前端控制器的主要作用：

- 指前端控制器将我们的请求分发给我们的控制器去生成业务数据
- 将生成的业务数据分发给恰当的视图模版来生成最终的视图界面

![Front Controller(MVC)](https://cdn-qn.yifans.com/160907-springmvc-getting-started-tutorial-front-controller.jpg)

## SpringMVC 基本概念

![SpringMVC 基本概念](https://cdn-qn.yifans.com/160907-springmvc-getting-started-tutorial-springmvc01.jpg)

对组件说明：

1. DispatherServlet：前端控制器 用户请求到达前端控制器，相当于 MVC 中的 C，而 DispatherServlet 是整个流程的核心，它来调用其他组件来处理用户的请求，前端控制器的存在降低了其他组件之间的耦合度。
2. HandlerMapping：处理器映射器 它的作用就好比去看电影要拿着电影票根据电影票上面的座位号找到座位其中座位就是 Handler，电影票以及上面的座位号就是 URL HandlerMapping 负责根据用户请求找到 Handler 即处理器，SpringMVC 提供了不同的映射器实现不同的映射方式，例如：配置文件方式，实现接口方式，注解方式等。
3. Handler：处理器 Handler 是后端控制器，在前端控制器的控制下后端控制器对具体的用户请求进行处理，Handler 涉及到具体的用户业务请求，所以一般情况下需要程序员根据业务需求开发。
4. HandlerAdapter：处理器适配器 通过 HandlerAdapter 对处理器进行执行，这是适配器模式的应用，通过适配器可以对更多类型的处理器进行执行。播放的电影是 3D 的你看不清楚，因此电影院跟你说你要想看清电影就必须戴 3D 眼镜。也就是说 Handler 满足一定的要求才可以被执行。
5. ViewResolver：视图解析器 ViewResolver 负责将处理结果生成 View 视图，ViewResolver 首先根据逻辑视图名解析成物理视图名即具体的页面地址，再生成 View 视图对象，最后对 View 进行渲染将处理结果通过页面展示给用户。

![SpringMVC 基本概念](https://cdn-qn.yifans.com/160907-springmvc-getting-started-tutorial-springmvc02.jpg)

工作原理解释说明：
1、用户发送请求到 SpringMVC 框架提供的 DispatcherServlet 这个前端控制器（了解 struts2 的朋友也都知道其实 struts2 也有一个前端控制器 web.xml 中的 filter 标签就是）。
2、前端控制器会去找处理器映射器（HandlerMapping），处理器映射器根据请求 url 找到具体的处理器，生成处理器对象及处理器拦截器（如果有则生成）一并返回给 DispatcherServlet 。
3、根据处理器映射器返回的处理器，DispatcherServlet 会找“合适”的处理器适配器（HandlerAdapter）
4、处理器适配器 HandlerAdpater 会去执行处理器（Handler 开发的时候会被叫成 Controller 也叫后端控制器在 struts2 中 action 也是一个后端控制器）执行之前会有转换器、数据绑定、校验器等等完成上面这些才会去正在执行 Handler
5、后端控制器 Handler 执行完成之后返回一个 ModelAndView 对象 。
6、处理器适配器 HandlerAdpater 会将这个 ModelAndView 返回前端控制器 DispatcherServlet。前端控制器会将 ModelAndView 对象交给视图解析器 ViewResolver。
7、视图解析器 ViewResolver 解析 ModelAndView 对象之后返回逻辑视图。
8、前端控制器 DispatcherServlet 对逻辑视图进行渲染（数据填充）之后返回真正的物理 View 并响应给浏览器。

![SpringMVC 基本概念](https://cdn-qn.yifans.com/160907-springmvc-getting-started-tutorial-springmvc03.jpg)

## SpringMVC 配置

1、前端控制器需要在 web.xml 中配置

```xml
<!-- 配置前端控制器 -->
<servlet>
	<servlet-name>web-dispatcher</servlet-name>
	<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
	<!--加载前端控制器配置文件 上下文配置位置-->
	<init-param>
		<!-- 备注：
            contextConfigLocation：指定 SpringMVC 配置的加载位置，如果不指定则默认加载
            WEB-INF/[DispatcherServlet 的 Servlet 名字]-servlet.xml
         -->
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:spring/spring-*.xml</param-value>
	</init-param>
	<!-- 表示随WEB服务器启动 -->
	<load-on-startup>1</load-on-startup>
</servlet>
<servlet-mapping>
<servlet-name>web-dispatcher</servlet-name>
	<!-- 备注：可以拦截三种请求
        第一种：拦截固定后缀的url，比如设置为 *.do、*.action， 例如：/user/add.action 此方法最简单,不会导致静态资源（jpg,js,css）被拦截
        第二种：拦截所有,设置为/，例如：/user/add  /user/add.action此方法可以实现REST风格的url,
        很多互联网类型的应用使用这种方式.但是此方法会导致静态文件(jpg,js,css)被拦截后不能正常显示.需要特殊处理
        第三种：拦截所有,设置为/*，此设置方法错误,因为请求到Action,当action转到jsp时再次被拦截,提示不能根据jsp路径mapping成功
    -->
	<!-- 默认匹配所有的请求 -->
	<url-pattern>/</url-pattern>
</servlet-mapping>
```

2、在 `spring/spring-web.xml` 配置视图解析器

```xml
<!-- 配置视图解析器 -->
<!-- InternalResourceViewResolver：支持JSP视图解析 -->
<!-- viewClass：JstlView 表示JSP模板页面需要使用JSTL标签库，所以classpath中必须包含jstl的相关jar包； -->
<!-- prefix 和 suffix：查找视图页面的前缀和后缀，最终视图的址为： -->
<!-- 前缀+逻辑视图名+后缀，逻辑视图名需要在controller中返回ModelAndView指定，比如逻辑视图名为hello，-->
<!-- 则最终返回的jsp视图地址 "WEB-INF/jsp/hello.jsp" -->
<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<!-- 决定视图类型，如果添加了jstl支持（即有jstl.jar），那么默认就是解析为jstl视图 -->
	<property name="viewClass" value="org.springframework.web.servlet.view.JstlView" />
	<!-- 视图前缀 -->
	<property name="prefix" value="/WEB-INF/jsp/" />
	<!-- 视图后缀 -->
	<property name="suffix" value=".jsp" />
</bean>
```

3、在 `spring/spring-web.xml` 配置 注解模式

```
<!-- 自动加载RequestMappingHandlerMapping和RequestMappingHandlerAdapter， -->
<!-- 可用在xml配置文件中使用<mvc:annotation-driven>替代注解处理器和适配器的配置。 -->
<mvc:annotation-driven/>
```

4、在 `spring/spring-web.xml` 配置 扫描 web 相关的 bean

```
<!-- 组件扫描器：可以扫描 @Controller、@Service、@Repository 等等 -->
<context:component-scan base-package="com.controller" />
```

## SpringMVC 中的注解

### `@Controller`

@Controller 注解，用于标识这个类是一个后端控制器（类似 struts 中的 action），主要作用就是接受页面的参数，转发页面。
@Controller 源码：

```java
@Target({ElementType.TYPE}) // 表明只能定义在类上面
@Retention(RetentionPolicy.RUNTIME) //保留策略是RUNTIME，在JVM加载类时，会把注解加载到JVM内存中（它是唯一可以用反射来读取注解的策略）
@Documented //@Documented用于描述其它类型的annotation应该被作为被标注的程序成员的公共API，因此可以被例如javadoc此类的工具文档化。Documented是一个标记注解，没有成员。
@Component //spring框架规定当一个类不好归类（service、dao、controller）的时候可以使用这个注解，由此可见即便好归类内部还是使用的@Component注解
public @interface Controller {
	/**
	 * The value may indicate a suggestion for a logical component name,
	 * to be turned into a Spring bean in case of an autodetected component.
	 * @return the suggested component name, if any
	 */
	String value() default "";
}
```

### `@RequestMapping`

这个注解的作用目标就跟 @Controller 不一样了，这个注解可以定义在类上面也可以定义在方法上面。

```java
/**
* 1.@RequestMapping：除了修饰方法,还可以修饰类
* 2.类定义处：提供初步的请求信息映射.相对于WEB应用的根目录(窄化请求)
* 3.方法处：提供进一步的细分映射信息。相对于类定义处的URL。
*      若类定义处为标注@RequestMapping,则方法出的URL相对于WEB应用的根目录
*/
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Mapping
public @interface RequestMapping {
	String[] value() default {};
	RequestMethod[] method() default {}; //限制请求方式
	String[] params() default {}; //要求请求的URL包含指定的参数
}
```

代码实例

```
@Controller
@RequestMapping("/demo")
public class IndexController {
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String index(Model model, HttpServletRequest request) {
		// 在游览器访问 http://localhost:8080/demo/test 将进入这里
		model.addAttribute("originURL", "");
		model.addAttribute("controllerName", "index");
		return "index";
	}
}
```

@RequestMapping 还支持 Ant 方格的请求

```
?：匹配文件中的一个字符
*：匹配文件中任意字符
**：**匹配多层路径

/user/*/createUser : 匹配 -/user/aa/createUser 或者 -/user/aa/createUser
/user/**/createUser : 匹配 -/user/aa/createUser 或者 -/user/createUser 或者 -/user/aa/cc/createUser
/user/createUser?? : 匹配 -/user/aa/createUseraa
```

### `@PathVariable`

@PathVariable 这个注解支持现在当下较为流行的 Restful 风格的 URL。 先说说这个注解的作用，支持将 url 中的占位符参数绑定到目标方法的参数上， 该功能也是 SpringMVC 实现 Restful 风格 url 的重要措施。

代码实例

```
// http://localhost:8080/demo/sss
@RequestMapping(value = "/{slug:.+}", method = RequestMethod.GET)
	public String index2(@PathVariable("slug") String slug, Model model) {
	LOG.info("DemoController index2 slug  " + slug);
	// common
	model.addAttribute("originURL", "demo/");
	model.addAttribute("controllerName", "demo");
	model.addAttribute("controllerMethod", "index2");
	model.addAttribute("slug", slug);
	return "demo";
}

//slug = sss
```

我们熟悉的请求应该是 POST 和 GET 请求，这两个请求也是最常用的而实际上 HTTP1.1 请求还有 PUT、DELETE 等 8 种来表名请求的动作。

在 SpringMVC 中要实现 PUT 和 DELETE 请求需要在 web.xml 额外配置一个过滤器，这个过滤器的作用就是把 POST 请求变为 PUT 和 DELETE 请求。
_关于 Restful 的内容计划单独写。_

### `@RequestParam`

```java
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface RequestParam {
	String value() default "";//值即为请求参数的参数名
	boolean required() default true;//该参数是否是必须。默认值为true
	String defaultValue() default ValueConstants.DEFAULT_NONE;//请求参数的默认值
}
```

```java
// http://localhost:8080/demo/para?slug=google
@RequestMapping(value = "/para", method = RequestMethod.GET)
public String index3(@RequestParam(value = "slug", defaultValue = "") String slug, Model model) {
	model.addAttribute("originURL", "demo/");
	model.addAttribute("controllerName", "demo");
	model.addAttribute("controllerMethod", "index3");
	model.addAttribute("slug", slug);
	return "demo";
}
slug = google
```

另外还有一点要提示一下，参数没有加这个注解也能映射成功，这是应为 SpringMVC 框架支持请求参数和目标方法参数一致的时候可以省略这个注解。

### `@ResponseBody`

```java
/**
 * Annotation that indicates a method return value should be bound to the web
 * response body. Supported for annotated handler methods in Servlet environments.
 *
 * 这个注解指明一个方法的返回值应该绑定在 web response body 中，在 Servlet 环境中支持注解处理方法
 *
 * <p>As of version 4.0 this annotation can also be added on the type level in
 * which case it is inherited and does not need to be added on the method level.
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface ResponseBody {
}
```

代码

```java
// http://localhost:8080/demo/json
@RequestMapping(value = "/json", method = RequestMethod.POST)
public @ResponseBody Domain index7(HttpServletRequest request, Model model) {

	LOG.info("DemoController demo index7");
	model.addAttribute("originURL", "demo/");
	model.addAttribute("controllerName", "demo");
	model.addAttribute("controllerMethod", "index7");

	Domain domain = new Domain();
	domain.setDomain("gggoogle.com");
	domain.setId(100);
	return domain;
}

/* response body
{
	"id": 100,
	"domain": "gggoogle.com"
}
*/
```

## SpringMVC 数据绑定

简单说一下场景：
对于一个注册页面有很多信息譬如：用户名、密码、确认密码、邮箱、手机、兴趣等等。这时候就会想能不能将这些个参数包装在一个对象中（POJO），用这个 POJO 来做目标方法的形参上面。

可以说的是 SpringMVC 是支持将 POJO 作为目标参数的。当然也是要遵循一些规则的，就是表单的 name 属性值要和 POJO 的属性值要一致。当然了，这样又会有一个新的疑问支不支持级联属性答案是支持的。

```java
public class Address {
	private String city;
	...
}
```

```java
public class Persion {
	private String name;
	private Address address;
	...
}
```

```html
<form action="/demo/pojo">
  NAME:<input type="text" name="name" /> CITY:<input
    type="text"
    name="address.city"
  />
</form>
```

```java
@RequestMapping(value = "/pojo", method = RequestMethod.POST)
public String index4(Persion persion, Model model) {
	model.addAttribute("originURL", "demo/");
	model.addAttribute("controllerName", "demo");
	model.addAttribute("controllerMethod", "index4");
	model.addAttribute("persion", persion);
	return "demo";
}
```

### SpringMVC 使用 Servlet API

可以使用 Servlet 原生的 API 作为目标方法的参数。具体支持以下类型：HttpServletRequest、HttpServletResponse、HttpSession、java.security.Principal、Locale、InputStream、OutputStream、Reader、Writer

```java
// http://localhost:8080/demo/req?slug=facebook
@RequestMapping(value = "/req", method = RequestMethod.GET)
public String index5(HttpServletRequest request, Model model) {
	String slug = request.getParameter("slug");
	model.addAttribute("originURL", "demo/");
	model.addAttribute("controllerName", "demo");
	model.addAttribute("controllerMethod", "index5");
	model.addAttribute("slug", slug);
	return "demo";
}
```

> Reference:
>
> - [IMOOC-SpringMVC 起步](http://www.imooc.com/video/7237)
> - [SpringMVC 从入门到精通 系列 - HansonQ](http://www.imooc.com/article/3804)
