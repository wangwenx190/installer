# Inno Setup 仿UC浏览器的卸载程序

特点
* 界面相似程度达90%以上
* 卸载程序的功能完全可以通过代码进行自由定制

## 编译
1. 下载并安装**Unicode**版**Inno Setup**编译器，最低**5.5.0**版本，尽量用最新版
2. 新建**App**文件夹，并把工程文件放到这个文件夹中
3. 先编译**Uninstaller.iss**生成卸载程序，再编译**Setup.iss**生成安装程序
4. 编译生成的安装程序在**Output**文件夹中

## 笔记
1. 在不修改Inno Setup的源码的前提下，是无法通过脚本来禁止Inno Setup生成的卸载程序开头的“请问您是否卸载XX”的提示的，但可以通过命令行参数`/SILENT`调用静默卸载模式，这样就可以跳过这个提示了，但这样一来用户就无法控制卸载过程了，这样显然不行，因此我的办法是单独写一个准备卸载的程序，通过这个程序来调用真正的卸载程序，卸载程序就只要修改正在卸载的界面就可以了。Inno Setup确实可以通过脚本创建窗口，再搭配**botva2**等插件来个性化定制窗口，但由于Inno Setup对卸载程序部分提供的接口很少，因此很难做到安装界面那种程度的定制（具体为什么很难做到，大家可以自己去尝试一下，试过一次就知道了），因此不专门写一个准备卸载的程序是无法实现我们这种深度定制卸载程序的需求的。但**Inno Setup是开源的**，这种程度的定制是可以通过修改其源码来实现的，只要大家会**Delphi**语言就可以了。但修改Inno Setup的源码就背离我的初衷了，我想尽量快地制作美观的安装程序，改Inno Setup源码再编译实在是太麻烦了。
2. 安装界面和卸载界面的进度条的回调函数的内容是可以完全相同的，但两个界面的进度条的名字是不一样的，搞错了会无法编译通过的。
3. 卸载程序要调用插件的话，要先将需要的文件都复制到临时文件夹中，但卸载程序本身是不打包文件的，因此要先将需要的文件安装到本地文件夹，需要时再复制。调用DLL时要注意DLL的调用路径，安装时调用路径是`files:`，卸载时是`{tmp}\`，这点要注意。
