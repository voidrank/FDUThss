# 复旦大学毕业论文模板

强烈建议没有latex洁癖的同学使用word。从2020年开始，部分学院(或者是所有学院)要求毕业论文同时提供word和pdf版本，以及对各版本有一些格式上的要求。理论上latex也能转换成word，但我在这里无法够提供详细的可行的教程。

本人对这种中国公立大学强推外公公司软件的行为表示遗憾



## Windows用户: 

1. 使用cmd，运行make.bat编译
2. 使用TeX软件

## MacOS用户:

1. 使用Terminal，运行make编译
2. 使用TeX软件

推荐安装[MacTex](https://tug.org/mactex/mactex-download.html)


## 请先完成编译后打开pdf获得更多帮助

## 常见编译错误

### 缺少字体

编译错误常见报错信息：
\* fontspec warning: "script-not-exist" , Font 'Kaiti SC Regular' does not contain script 'CJK'.

解决方案：安装字体

[字体下载](https://github.com/dolbydu/font)

安装方法：先在github找到download zip，然后在文件夹里找到对应缺少的字体（如上示例中缺少的是Kaiti SC Regular），然后找到对应的ttf，双击安装即可。

## 如果还有问题怎么办？

### 认真再读三遍README

### 点开ISSUE，提交一个ISSUE

