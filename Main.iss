;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;此脚本主要模仿并实现“好压”安装程序的界面                                                           ;
;请使用 Unicode 版 Inno Setup 5.5.9（或更新） 编译器编译                                            ;
;经测试，此脚本可以在官方原版编译器、SkyGZ增强版编译器和Restools增强版编译器上完美编译通过并正常运行;
;令人遗憾的是原始脚本作者已不可考                                                                   ;
;代码主要思路来源于：http://blog.csdn.net/oceanlucy/article/details/50033773                        ;
;感谢博主 “沉森心” （oceanlucy）                                                                    ;
;此脚本也经过了几个网友的改进，但已无法具体考证，但我仍然很感谢他们                                 ;
;最终版本由 “赵宇航”/“糖鸭君”/“糖鸭”/“唐雅”/“wangwenx190” 修改得到                                  ;
;欢迎大家传播和完善此脚本                                                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IF VER < EncodeVer(5,5,0)
  #error 请升级您的 Inno Setup 编译器到 V5.5.0 或更新的版本
#endif

#ifndef UNICODE
  #error 请使用 Unicode 版 Inno Setup 编译器
#endif

;指定是否为64位安装程序
;#define x64Build

;指定是否只能在 Windows 7 SP1 及更新版本的操作系统上安装
;#define Windows7SP1AndNewer

;指定是否要注册相关后缀名
#define RegisteAssociations

;指定是否为绿色版安装程序（仅释放文件，不写入注册表条目，也不生成卸载程序）
;#define PortableBuild

;指定是否只能安装新版本，而不能用旧版本覆盖新版本
#define OnlyInstallNewVersion 

#ifdef x64Build
  #define MyAppID "{D5FB0325-ED97-46CD-B11C-A199551F529C}"
  #define MyAppName "My Program" + " " + "x64"
  #define MyAppExeName "MyProg64.exe"
  #define MyAppMutex MyAppName
#else
  #define MyAppID "{BDEF4E0C-B337-49C7-8D85-51B8505235FF}"
  #define MyAppName "My Program"
  #define MyAppExeName "MyProg.exe"
  #define MyAppMutex MyAppName
#endif

;若想开启禁止安装旧版本的功能，此处版本号请注意一定要是
;点分十进制的正整数，除数字和英文半角句点以外不允许出现任何其他字符，
;否则程序无法判断版本的高低。
#define MyAppVersion "1.0.0"
#define MyAppPublisher "My Company, Inc."
#define MyAppPublisherURL "http://www.example.com/"
#define MyAppSupportURL MyAppPublisherURL
#define MyAppUpdatesURL MyAppPublisherURL
#define MyAppComments "备注"
#define MyAppContact MyAppPublisher
#define MyAppSupportPhone "13510102020"
#define MyAppReadmeURL "https://github.com/wangwenx190/InternetFashionedInstaller/blob/master/README.md"
#define MyAppLicenseURL "https://github.com/wangwenx190/InternetFashionedInstaller/blob/master/LICENSE"
#define MyAppCopyrightYear "2017"
#define MyAppCopyright "版权所有 © " + MyAppCopyrightYear + ", " + MyAppPublisher

[Setup]
AppId={{#MyAppID}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppPublisherURL}
AppSupportURL={#MyAppSupportURL}
AppUpdatesURL={#MyAppUpdatesURL}
AppComments={#MyAppComments}
AppContact={#MyAppContact}
AppSupportPhone={#MyAppSupportPhone}
AppReadmeFile={#MyAppReadmeURL}
AppCopyright={#MyAppCopyright}
DefaultGroupName={#MyAppPublisher}\{#MyAppName}
VersionInfoDescription={#MyAppName} 安装程序
VersionInfoProductName={#MyAppName}
VersionInfoCompany={#MyAppPublisher}
VersionInfoCopyright={#MyAppCopyright}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoProductTextVersion={#MyAppVersion}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
OutputDir=.\Output\
SetupIconFile=.\Setup.ico
Compression=lzma2/ultra64
InternalCompressLevel=ultra64
SolidCompression=yes
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyMemo=yes
DisableReadyPage=yes
TimeStampsInUTC=yes
SetupMutex={{#MyAppID}Installer,Global\{{#MyAppID}Installer
AppMutex={#MyAppMutex}
ShowLanguageDialog=no
AllowCancelDuringInstall=no
#ifdef x64Build
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
DefaultDirName={pf64}\{#MyAppPublisher}\{#MyAppName}
#else
ArchitecturesAllowed=x86 x64
DefaultDirName={pf32}\{#MyAppPublisher}\{#MyAppName}
#endif
#ifdef Windows7SP1AndNewer
MinVersion=0,6.1.7601
#else
MinVersion=0,5.1.2600
#endif
#ifdef RegisteAssociations
ChangesAssociations=yes
#else
ChangesAssociations=no
#endif
#ifdef PortableBuild
Uninstallable=no
PrivilegesRequired=lowest
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Portable
#else
Uninstallable=yes
PrivilegesRequired=admin
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Setup
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={uninstallexe},0
UninstallFilesDir={app}\Uninstaller
#endif

[Languages]
;安装语言为简体中文，还需要其他语言请在此区段添加
Name: "zh_CN"; MessagesFile: ".\lang\zh-CN.isl"

[Files]
;包含项目文件
;Source: ".\app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;包含所有临时资源文件
Source: ".\tmp\*"; DestDir: "{tmp}"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system

#ifndef PortableBuild
[Dirs]
;创建一个隐藏的系统文件夹存放卸载程序
Name: "{app}\Uninstaller"; Attribs: hidden system
#endif

;若有写入INI条目的需要，请取消此区段的注释并自行添加相关脚本
;[INI] 
;Filename: "{app}\MyProg.ini"; Section: "InstallSettings"; Key: "InstallPath"; String: "{app}"; Flags: uninsdeleteentry

;若有写入注册表条目的需要，请取消此区段的注释并自行添加相关脚本
;[Registry]
;Root: HKCU; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKCU; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
;Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
;Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"

;若有创建快捷方式的需要，请取消此区段的注释并自行添加相关脚本
;[Icons]
;Name: "{group}\My Program"; Filename: "{app}\MYPROG.EXE"; Parameters: "/play filename.mid"; WorkingDir: "{app}"; Comment: "This is my program"; IconFilename: "{app}\myicon.ico"
;Name: "{group}\Documents"; Filename: "{app}\Doc"; Flags: foldershortcut

#ifdef RegisteAssociations
[UninstallRun]
;卸载时运行反注册程序
Filename: "{app}\{#MyAppExeName}"; Parameters: "--uninstall"; WorkingDir: "{app}"; Flags: waituntilterminated skipifdoesntexist
#endif

#ifndef PortableBuild
[UninstallDelete]
;卸载时删除安装目录下的所有文件及文件夹
Type: filesandordirs; Name: "{app}"
#endif

[Code]
//引入脚本区段
#include ".\include\Code.iss"

