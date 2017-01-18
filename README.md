ZLD 购物车Demo
==============
这是一款使用MVVM框架并结合RAC的一款仿淘宝购物车Demo，下面将详细介绍整体思路

#简介
- **完整**: 和淘宝购物车逻辑一致，目前未发现逻辑上的bug
- **咨询**: 81516741
- **作者**: 曾令达

#使用的第三方库
* Github：[ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)</br>

#演示
<img src = "https://github.com/81516741/RAC_Demo/blob/master/demo_show.gif">

#要求
* iOS 6.0 or later
* Xcode 8.0 or later

#核心逻辑
* 文件结构该Demo整体使用的是MVVM结构，下图为文件结构

<img src = "https://github.com/81516741/RAC_Demo/blob/master/document_introduction.png">

* 下图为UI控件名词介绍，为方便后面思路讲解作参考

<img src = "https://github.com/81516741/RAC_Demo/blob/master/UI_introduction.png">

* 思路讲解

在ShopCartUIViewModel对象中创建cell sectionHeader的时候用RAC对其与用户交互的事件进行监听，并将逻辑处理需要的参数传给处理逻辑的对象ShopCartLogicViewModel，具体见代码

特别说明:sectionSelectedCount 的值改变是随sectionHeader的复选框的选中状态改变而改变的,sectionSelectedCount的只改变会影响allselected的值，allselected的值发生改变就会影响全选复选框的显示(具体见ShopCartLogicViewModel 类中的方法 addKVOFunction)

