# InternetFashionedInstaller

一个用**Inno Setup**仿**2345好压**安装程序的脚本模板，改一改背景图片就可以一键打包属于自己的美观的互联网风格的安装程序。

**注：使用此脚本模板之前请您一定要了解一下 Inno Setup 脚本的常量、区段的作用及用法！大概了解一下就行，看看编译器自带的帮助文档，也就几分钟的事！**

## 效果及特性
- 窗口无边框
- 自定义按钮、标题栏以及窗口背景
- 点住窗口中除按钮和输入框以外的地方均可拖动窗口
- 自定义取消安装时弹出的那个提示框，并可拖动
- 点击*许可协议*按钮，便会跳转到许可协议的网址
- 窗口可伸缩，点击*自定义安装*按钮，窗口变长并显示安装路径输入框以及其他按钮
- 安装前判断是否已经安装将要安装的软件，若已经安装，则将目标安装路径切换为之前的安装路径，并禁止用户修改安装路径
- 自定义安装进度条
- 安装界面显示安装百分比
- 安装程序和应用程序互斥
- 限制只能运行一个安装实例
- 可控制安装程序是否禁止安装旧版本，只能安装新版本（可选功能）
- 可控制安装程序是否只能运行在特定版本的 Windows 操作系统上（可选功能）
- 可控制安装程序是否只能运行在32位/64位操作系统上（可选功能）
- 可控制安装程序是否制作绿色安装包，即只释放文件（也可以进行创建快捷方式和读写INI文件等不需要管理员权限的操作），而不写入任何注册表条目，也不生成卸载程序，但同时也不能获取以前安装的版本了，也不能获取以前安装的路径了，因为没有写注册表，绿色安装模式下，运行安装程序不会弹出UAC提示框（可选功能）
- 其他安装程序应该有的功能

**NEW!!!**
- 显示任务栏缩略图（需系统支持）
- 显示窗口阴影（需系统支持）
- 安装程序支持70种UI语言，并可在安装程序启动时自动切换并加载与系统UI相同的语言，不需要用户手动选择并切换（**注意：强行在不同的语言环境中显示其他语言有很大的概率会导致显示乱码**）
- 自定义卸载程序，同样是无边框可拖动的，效果及特性与安装程序相同
- 窗口伸缩时有动画效果
- 窗口显示gif动画等动态元素
- 安装时图片轮播，并支持点击特定图片后打开特定网址

### 能做但不会添加到此项目的特性
- 播放背景音乐
- 显示闪屏
- 任何与ISDone相关的东西
- 显示全屏或最大化窗口背景
- 安装恶评插件
- 修改系统敏感设置
- 静默（下载）安装推广软件
- 修改浏览器主页
- 任何时候弹出广告
- 安装或卸载完成后弹出网页
- 其他任何损害用户体验的行为

现在互联网应用的整体发展趋势是扁平化、轻量化和自动化，而上述行为严重违反了这种趋势和潮流，个别行为甚至会严重损害用户体验，因此我非常厌恶让安装程序执行以上行为或任何相似的行为。有能力的可以自己实现这些功能，虽然我管不着，但请好自为之。

## 效果预览
安装程序实际效果很好，但GIF动画看起来比较卡，播放速度很慢，我也不清楚是怎么回事。
![Snap](/{snap}/snap.gif)

## 支持平台
- 此脚本打包的安装程序已在**Microsoft Windows XP SP3（仅32位）、Windows 7 SP1、Windows 8.1 with Update 1 以及 Windows 10 1507、1511、1607、1703、1709 32位&64位操作系统**上测试通过，目标功能全部完美实现，无任何BUG
- 若要使安装程序只支持在微软目前仍然提供支持的操作系统（例如 Windows 7 及更新）上运行，请将代码中的`#define Windows7AndNewer`取消注释，目标效果和功能同样能全部完美实现，无任何BUG

## 编译步骤
1. [下载最新版的**Unicode**版**Inno Setup**](http://jrsoftware.org/isdl.php)并安装
2. 下载我提供的这个脚本模板（包含所有资源文件）并解压
3. 修改{tmp}文件夹下的图片素材，更换代码目录下的**MySetup.ico**
4. 打开**MySetup.iss**，根据需求，修改**MyAppID**、**MyAppName**和**MyAppVersion**等涉及到具体项目的信息
5. 若您要打包的项目为64位项目，请将代码中的`#define x64Build`取消注释
6. 若您的软件要进行注册文件后缀名的操作（如果不用注册后缀名则需要注释掉代码中的`#define RegisteAssociations`），请将进行注册后缀名的具体操作的代码写到`check_if_need_change_associations()`函数中（这个函数我已经写了一个了，不要再重复定义了，但目前这个函数的内容只有弹出一个提示框的脚本而已，请去掉弹框的脚本，再添加您自己的脚本）
7. 若要生成绿色版安装程序（不向注册表中写入任何条目且不生成卸载程序），请将代码中的`#define PortableBuild`取消注释
8. 若您不想让安装程序只能安装新版本，请将代码中的`#define OnlyInstallNewVersion`注释掉（默认是不允许用旧版覆盖新版的，并请注意：**若想开启禁止安装旧版本的功能，此处版本号一定要是点分十进制的正整数，除数字和英文半角句点以外不允许出现任何其他字符，否则程序无法判断版本的高低**）
9. 若您有写INI条目、创建快捷方式或写入注册表条目的需求，请取消代码中**INI**、**Icons**或**Registry**区段的注释，并自行添加相关脚本
10. 在代码文件（**MySetup.iss**）所在的目录下新建{app}文件夹（已经有了的话就不用新建了，直接用已经存在的文件夹就行）
11. 把您要打包的所有文件及文件夹都放到上一步新建的{app}下
12. 编译
13. 生成的安装程序位于代码文件所在目录中的{output}文件夹下（如果您没有修改输出路径的话）

## 注意事项
- 此脚本支持**官方原版编译器、SkyGZ（风铃夜思雨）增强版编译器以及Restools增强版编译器**
- 一定要使用**Unicode**版编译器，尽量使用**最新版**，最低不能低于**5.5.0**版
- 安装程序所有用到的UI贴图都在{tmp}文件夹下，您可以随意修改，以此来打造属于您自己的美观的安装程序
- 因为 Inno Setup 没有提供*布局*控件/功能，因此所有控件的尺寸和位置都是写死的，坐标用的都是绝对坐标（坐标原点为窗口左上角），若您要修改按钮的位置或尺寸，或者您要改变窗口的布置，请注意修改脚本中的各处坐标值，所有位置和尺寸受到影响的控件都要修改，否则安装程序的外观会出现异常
- 推荐使用[**Inno Script Studio**](https://www.kymoto.org/products/inno-script-studio/downloads)

## 笔记/备忘录
- Inno Setup 给安装程序提供了丰富的接口，搭配 botva2.dll ，可以实现任何你想要实现的界面和功能，可定制程度很高，但 Inno Setup 给卸载程序提供的接口很少，搭配 botva2.dll ，也只能做到换换窗口背景，改改按钮的文字及位置等，可定制程度很低。因此，若需要完全自定义的卸载程序，我的建议还是用其他的语言或工具（比如 C# 啦、 Qt 啦）专门写一个卸载程序，只写一个界面就可以了，可以通过使用参数`/VERYSILENT /NORESTART`调用卸载程序的“静默卸载”模式，来完成具体的卸载工作。当然，如果采用这种方法，一是要改写注册表的卸载条目，让注册表指向你的卸载程序，而不是原来那个，二是要注意把你自己的卸载程序复制到临时文件夹再启动，不然卸载程序删不掉你那个卸载程序，会有残留的文件，岂不很尴尬。
- 使用 botva2.dll 有一个要注意的地方，那就是在安装程序窗口关闭前，一定要调用其提供的`gdipShutdown()`函数，然后再调用 Inno Setup 提供的`WizardForm.Release()`函数释放窗口资源（不必再调用`WizardForm.Close()`，它会重复释放资源的动作），并且保证整个安装过程这两个函数只执行一遍，而且调用顺序一定不能搞错，此时安装程序的窗口就会正常关闭，安装程序的退出代码也是正常的，否则安装程序的窗口就会在关闭时卡住好一会，退出代码也很诡异，在 Windows 7 操作系统上还会直接报错。
- 不知为什么，在32位安装模式下，读取注册表条目时， Windows 7 操作系统不会自动重定向，要单独指定64位条目的路径，而在更新的系统上，则会自动重定向，不用专门指定64位条目的路径，经过我的测试，在64位安装模式下（脚本中指定`#define x64Build`的意思，不只是单纯的在64位操作系统中运行的意思），没有这个问题。
- 不知道是不是 Inno Setup 的BUG，就是如果代码中通过`WizardForm.Height`改变了窗口的高度，改小之后不能再改大，只能越改越小，改小之后再改大造成的后果就是窗口超出最小的 Height 值的部分（从顶部开始算）会变透明，而且在 Windows 7 和 Windows 10 上透明的效果还不一样，总之都很难看，但只改小一次没事，就像我做的这个模仿好压安装程序的这个，在窗口初始化时先指定一个比较大的 Height 值，处于欢迎界面时再改小，点击*自定义安装*按钮时再变大，安装时再变小，但最小的高度和一直都和欢迎界面的高度一样，这个效果就正常，如果在已经改小的基础上再次改小，那再改大时，窗口下方就有很大一块透明的地方，有时是窗口不透明，但按钮透明了，总之很烦人。

## 许可协议
```
MIT License

Copyright (c) 2017 wangwenx190

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
