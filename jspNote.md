# JSP声明

JSP声明的语法格式：

```jsp
<%! declaration; [ declaration; ]+ ... %>
```

# JSP表达式

一个JSP表达式中包含的脚本语言表达式，先被转化成String，然后插入到表达式出现的地方。但是**不能使用分号来结束**表达式。

JSP表达式的语法格式：

```jsp
<%= 表达式 %>
```

 JSP 有三个指令元素：page、include 和 taglib 

 如果用户把 buffer 设置为 none，那么 autoFlush 就不能设置为 false。

info可使用 getServletInfo() 方法取回

contentType 中可以同时指定返回页面中所使用的字符编码

### JSP：include

JSP 中的 include 指令用来包含一个 静态的文件，而且不能进行传递参数操作。
当文件的内容包含中文时，Tomcat 会显示为乱码；在外部文件中加入 page 指令，即可将中文正确显示出来。

被包含文件可以是 JSP 文件、HTML 文件、文本文件、inc 文件等。如果包含的文件包含可执行代码，那么这个包含的文件的代码将会被执行。

| 语法 | 状态 | 对象 | 描述 |
| ----------- | ----------- | ---| ---|
| <%@include file="...."%> | 编译时包含 | 静态 | JSP 引擎将对所包含的文件进行语法分析 |
| <jsp:include page=""/> | 运行时包含 | 静态和动态 | JSP 引擎将**不对**所包含的文件进行语法分析 |

### JSP:forward

“<jsp:forward>”标签以后的代码，将不能执行。


BeanName 属性不能与 class 属性一起使用。
