# InternetFashionedInstaller
一个用InnoSetup仿好压安装程序的脚本模板，改一改背景图片就可以一键打包属于自己的美观的互联网风格的安装程序

## 支持平台
* 此脚本打包的安装程序已在 Microsoft Windows 7 SP1、Windows 8.1 with Update 以及 Windows 10 1703 32位&64位操作系统上测试通过，无任何BUG，效果完美
* 若要使安装程序支持更早版本的操作系统，请注释掉代码中的`MinVersion=0,6.1.7601`，但不能保证安装程序的最终效果

## 编译
* 下载安装最新版的`Unicode`版`Inno Setup`（ http://jrsoftware.org/isdl.php ）
* 在代码文件（`Setup.iss`）所在的目录下新建`App`文件夹
* 把您要打包的所有文件及文件夹都放到上一步新建的`App`下
* 打开`Setup.iss`，修改`AppId`及其他涉及到具体项目的信息（默认不会创建任何快捷方式，若有需求请自行添加`[Icons]`区段）
* 修改`tmp`文件夹下的图片素材，替换代码目录下的`Setup.ico`
* 编译

## 注意事项
* 此脚本支持`官方原版`编译器、`SkyGZ（风铃夜思雨）增强版`编译器以及`Restools增强版`编译器
* 一定要使用`Unicode`版编译器，尽量使用最新版，最低不能低于 5.5.0 版，若您的编译器版本低于 5.5.9 ，请将代码中的`#IF VER < EncodeVer(5,5,9)`宏注释掉
* 安装程序所有用到的UI图片都在`tmp`文件夹下，在不改变图片尺寸的前提下，您可以自由修改图片素材，以此来打造属于您自己的安装程序
* 如果您改变了图片素材的尺寸，请注意一并修改代码，否则安装程序的外观会出现异常
* 若要生成绿色版安装程序（不向注册表中写入任何条目且不生成卸载程序），请取消`Uninstallable=no`的注释，并注释掉原本的`Uninstallable=yes`，同时注释掉`[UninstallDelete]`区段
* 推荐使用`Inno Script Studio`

## 截图预览
![01](/Snapshot/01.PNG)
![02](/Snapshot/02.PNG)
![03](/Snapshot/03.PNG)
![04](/Snapshot/04.PNG)
