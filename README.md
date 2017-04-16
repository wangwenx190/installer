# InternetFashionedInstaller
一个用InnoSetup仿好压安装程序的脚本模板，改一改背景图片就可以一键打包属于自己的美观的互联网风格的安装程序

## 编译
* 下载安装最新版的`Unicode`版`Inno Setup`（http://jrsoftware.org/isdl.php）
* 在此目录下新建`App`文件夹
* 把您要打包的所有文件及文件夹都放到上一步新建的`App`下
* 打开`Setup.iss`，修改`AppId`及其他涉及到具体项目的信息
* 修改`tmp`文件夹下的图片素材，替换此目录中的`Setup.ico`
* 编译

## 注意事项
* 此脚本支持官方原版编译器、SkyGZ（风铃夜思雨）增强版编译器以及Restools增强版编译器
* 一定要使用`Unicode`版编译器，尽量使用最新版
* 安装程序所有用到的UI图片都在`tmp`文件夹下，在不改变图片尺寸的前提下，您可以自由修改图片素材，以此来打造属于您自己的安装程序
* 如果您改变了图片素材的尺寸，请注意一并修改代码，否则安装程序的外观会很差
* 使用此脚本打包的安装程序为绿色版安装程序，不会生成卸载程序，也不会向注册表中写入任何条目，若您需要生成卸载程序，请在代码中指定`Uninstallable=yes`，并取消`[UninstallDelete]`区段的注释
* 此脚本指定了安装程序为最小权限，运行安装程序将不会出现UAC窗口，在此权限下，安装程序将没有权限向系统盘的`Program Files`文件夹中写入任何文件，也没有权限向注册表的`HKEY_LOCAL_MACHINE`下写入任何条目，只能向`HKEY_CURRENT_USER`下写入，若您需要使安装程序获取管理员权限，请在脚本中指定`PrivilegesRequired=admin`
* 请及时修改`[Code]`段的`is_installed_before()`函数，因为若无管理员权限，安装程序只能向`HKEY_CURRENT_USER`下写入条目，而在管理员权限下则是向`HKEY_LOCAL_MACHINE`下写入条目（此处特指卸载条目），若您硬性指定条目路径，安装程序则会无视系统，向您指定的条目写入（如果权限足够的话）。
* 推荐使用`Inno Script Studio`

## 截图预览
![01](/Snapshot/01.PNG)
![02](/Snapshot/02.PNG)
![03](/Snapshot/03.PNG)
![04](/Snapshot/04.PNG)
