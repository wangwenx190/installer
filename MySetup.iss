;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;此脚本主要模仿并实现“2345好压”安装程序的界面                                                       ;
;请使用 Unicode 版 Inno Setup 5.5.0（或更新） 编译器编译                                            ;
;经测试，此脚本可以在官方原版编译器、SkyGZ增强版编译器和Restools增强版编译器上完美编译通过并正常运行;
;令人遗憾的是原始脚本作者已不可考                                                                   ;
;代码主要思路来源于：http://blog.csdn.net/oceanlucy/article/details/50033773                        ;
;感谢博主 “沉森心” （oceanlucy）                                                                    ;
;此脚本也经过了几个网友的改进，但已无法具体考证，但我仍然很感谢他们                                 ;
;最终版本由 “赵宇航”/“糖鸭君”/“糖鸭”/“唐雅”/“wangwenx190” 修改得到                                  ;
;欢迎大家传播和完善此脚本                                                                           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IF VER < EncodeVer(5,5,0)
  #error Please upgrade your Inno Setup to at least V5.5.0 !!!
#endif

#ifndef UNICODE
  #error Please use **UNICODE** edition of Inno Setup !!!
#endif

;指定是否为64位安装程序
;#define x64Build

;指定是否只能在 Windows 7 SP1 及更新版本的操作系统上安装
;#define Windows7AndNewer

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
OutputDir=.\{output}
SetupIconFile=.\MySetup.ico
Compression=lzma2/ultra64
InternalCompressLevel=ultra64
SolidCompression=yes
DisableProgramGroupPage=yes
DisableDirPage=yes
DisableReadyMemo=yes
DisableReadyPage=yes
TimeStampsInUTC=yes
#IF VER >= EncodeVer(5,5,9)
SetupMutex={{#MyAppID}Installer,Global\{{#MyAppID}Installer
AppMutex={#MyAppMutex}
#endif
LanguageDetectionMethod=uilanguage
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
#ifdef Windows7AndNewer
MinVersion=0,6.1.7600
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
Name: "afrikaans"; MessagesFile: ".\{lang}\Afrikaans.isl"
Name: "albanian"; MessagesFile: ".\{lang}\Albanian.isl"
Name: "arabic"; MessagesFile: ".\{lang}\Arabic.isl"
Name: "armenian"; MessagesFile: ".\{lang}\Armenian.islu"
Name: "asturian"; MessagesFile: ".\{lang}\Asturian.isl"
Name: "basque"; MessagesFile: ".\{lang}\Basque.isl"
Name: "belarusian"; MessagesFile: ".\{lang}\Belarusian.isl"
Name: "bengali"; MessagesFile: ".\{lang}\Bengali.islu"
Name: "bosnian"; MessagesFile: ".\{lang}\Bosnian.isl"
Name: "brazilianportuguese"; MessagesFile: ".\{lang}\BrazilianPortuguese.isl"
Name: "bulgarian"; MessagesFile: ".\{lang}\Bulgarian.isl"
Name: "catalan"; MessagesFile: ".\{lang}\Catalan.isl"
Name: "chinesesimplified"; MessagesFile: ".\{lang}\ChineseSimplified.isl"
Name: "chinesetraditional"; MessagesFile: ".\{lang}\ChineseTraditional.isl"
Name: "corsican"; MessagesFile: ".\{lang}\Corsican.isl"
Name: "croatian"; MessagesFile: ".\{lang}\Croatian.isl"
Name: "czech"; MessagesFile: ".\{lang}\Czech.isl"
Name: "danish"; MessagesFile: ".\{lang}\Danish.isl"
Name: "dutch"; MessagesFile: ".\{lang}\Dutch.isl"
Name: "english"; MessagesFile: ".\{lang}\English.isl"
Name: "englishbritish"; MessagesFile: ".\{lang}\EnglishBritish.isl"
Name: "esperanto"; MessagesFile: ".\{lang}\Esperanto.isl"
Name: "estonian"; MessagesFile: ".\{lang}\Estonian.isl"
Name: "farsi"; MessagesFile: ".\{lang}\Farsi.isl"
Name: "finnish"; MessagesFile: ".\{lang}\Finnish.isl"
Name: "french"; MessagesFile: ".\{lang}\French.isl"
Name: "galician"; MessagesFile: ".\{lang}\Galician.isl"
Name: "georgian"; MessagesFile: ".\{lang}\Georgian.islu"
Name: "german"; MessagesFile: ".\{lang}\German.isl"
Name: "greek"; MessagesFile: ".\{lang}\Greek.isl"
Name: "hebrew"; MessagesFile: ".\{lang}\Hebrew.isl"
Name: "hindi"; MessagesFile: ".\{lang}\Hindi.islu"
Name: "hungarian"; MessagesFile: ".\{lang}\Hungarian.isl"
Name: "icelandic"; MessagesFile: ".\{lang}\Icelandic.isl"
Name: "indonesian"; MessagesFile: ".\{lang}\Indonesian.isl"
Name: "italian"; MessagesFile: ".\{lang}\Italian.isl"
Name: "japanese"; MessagesFile: ".\{lang}\Japanese.isl"
Name: "kazakh"; MessagesFile: ".\{lang}\Kazakh.islu"
Name: "korean"; MessagesFile: ".\{lang}\Korean.isl"
Name: "kurdish"; MessagesFile: ".\{lang}\Kurdish.isl"
Name: "latvian"; MessagesFile: ".\{lang}\Latvian.isl"
Name: "ligurian"; MessagesFile: ".\{lang}\Ligurian.isl"
Name: "lithuanian"; MessagesFile: ".\{lang}\Lithuanian.isl"
Name: "luxemburgish"; MessagesFile: ".\{lang}\Luxemburgish.isl"
Name: "macedonian"; MessagesFile: ".\{lang}\Macedonian.isl"
Name: "malaysian"; MessagesFile: ".\{lang}\Malaysian.isl"
Name: "mongolian"; MessagesFile: ".\{lang}\Mongolian.isl"
Name: "montenegrian"; MessagesFile: ".\{lang}\Montenegrian.isl"
Name: "nepali"; MessagesFile: ".\{lang}\Nepali.islu"
Name: "norwegian"; MessagesFile: ".\{lang}\Norwegian.isl"
Name: "norwegiannynorsk"; MessagesFile: ".\{lang}\NorwegianNynorsk.isl"
Name: "occitan"; MessagesFile: ".\{lang}\Occitan.isl"
Name: "polish"; MessagesFile: ".\{lang}\Polish.isl"
Name: "portuguese"; MessagesFile: ".\{lang}\Portuguese.isl"
Name: "romanian"; MessagesFile: ".\{lang}\Romanian.isl"
Name: "russian"; MessagesFile: ".\{lang}\Russian.isl"
Name: "scottishgaelic"; MessagesFile: ".\{lang}\ScottishGaelic.isl"
Name: "serbiancyrillic"; MessagesFile: ".\{lang}\SerbianCyrillic.isl"
Name: "serbianlatin"; MessagesFile: ".\{lang}\SerbianLatin.isl"
Name: "slovak"; MessagesFile: ".\{lang}\Slovak.isl"
Name: "slovenian"; MessagesFile: ".\{lang}\Slovenian.isl"
Name: "spanish"; MessagesFile: ".\{lang}\Spanish.isl"
Name: "swedish"; MessagesFile: ".\{lang}\Swedish.isl"
Name: "tatar"; MessagesFile: ".\{lang}\Tatar.isl"
Name: "thai"; MessagesFile: ".\{lang}\Thai.isl"
Name: "turkish"; MessagesFile: ".\{lang}\Turkish.isl"
Name: "ukrainian"; MessagesFile: ".\{lang}\Ukrainian.isl"
Name: "uzbek"; MessagesFile: ".\{lang}\Uzbek.isl"
Name: "valencian"; MessagesFile: ".\{lang}\Valencian.isl"
Name: "vietnamese"; MessagesFile: ".\{lang}\Vietnamese.isl"

[Files]
;包含项目文件
Source: ".\{app}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;包含所有临时资源文件
Source: ".\{tmp}\*"; DestDir: "{tmp}"; Flags: dontcopy solidbreak; Attribs: hidden system

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
type
  TBtnEventProc = procedure(h : hwnd);
  TPBProc = function(h : hwnd; Msg, wParam, lParam : longint) : longint;
  Win7TTimerProc = procedure(HandleW, Msg, idEvent, TimeSys: longword);
//  TTimerProc = procedure (h: Longword; msg: Longword; idevent: Longword; dwTime: Longword);

function ImgLoad(h : hwnd; FileName : PAnsiChar; Left, Top, Width, Height : integer; Stretch, IsBkg : boolean) : longint; external 'ImgLoad@files:botva2.dll stdcall delayload';
procedure ImgSetVisibility(img : longint; Visible : boolean); external 'ImgSetVisibility@files:botva2.dll stdcall delayload';
procedure ImgApplyChanges(h : hwnd); external 'ImgApplyChanges@files:botva2.dll stdcall delayload';
procedure ImgSetPosition(img : longint; NewLeft, NewTop, NewWidth, NewHeight : integer); external 'ImgSetPosition@files:botva2.dll stdcall delayload';
procedure ImgRelease(img : longint); external 'ImgRelease@files:botva2.dll stdcall delayload';
procedure CreateFormFromImage(h : hwnd; FileName : PAnsiChar); external 'CreateFormFromImage@files:botva2.dll stdcall delayload';
procedure gdipShutdown();  external 'gdipShutdown@files:botva2.dll stdcall delayload';
function WrapBtnCallback(Callback : TBtnEventProc; ParamCount : integer) : longword; external 'wrapcallback@files:innocallback.dll stdcall delayload';
function BtnCreate(hParent : hwnd; Left, Top, Width, Height : integer; FileName : PAnsiChar; ShadowWidth : integer; IsCheckBtn : boolean) : hwnd;  external 'BtnCreate@files:botva2.dll stdcall delayload';
procedure BtnSetVisibility(h : hwnd; Value : boolean); external 'BtnSetVisibility@files:botva2.dll stdcall delayload';
procedure BtnSetEvent(h : hwnd; EventID : integer; Event : longword); external 'BtnSetEvent@files:botva2.dll stdcall delayload';
procedure BtnSetEnabled(h : hwnd; Value : boolean); external 'BtnSetEnabled@files:botva2.dll stdcall delayload';
function BtnGetChecked(h : hwnd) : boolean; external 'BtnGetChecked@files:botva2.dll stdcall delayload';
procedure BtnSetChecked(h : hwnd; Value : boolean); external 'BtnSetChecked@files:botva2.dll stdcall delayload';
procedure BtnSetPosition(h : hwnd; NewLeft, NewTop, NewWidth, NewHeight : integer);  external 'BtnSetPosition@files:botva2.dll stdcall delayload';
function PBCallBack(P : TPBProc; ParamCount : integer) : longword; external 'wrapcallback@files:innocallback.dll stdcall delayload';
procedure ImgSetVisiblePart(img : longint; NewLeft, NewTop, NewWidth, NewHeight : integer); external 'ImgSetVisiblePart@files:botva2.dll stdcall delayload';
function WrapTimerProc(Callback: Win7TTimerProc; ParamCount: integer): longword; external 'wrapcallback@files:InnoCallback.dll stdcall delayload';
//Windows API
function CreateRoundRectRgn(p1, p2, p3, p4, p5, p6 : integer) : THandle; external 'CreateRoundRectRgn@gdi32.dll stdcall';
function SetWindowRgn(h : hwnd; hRgn : THandle; bRedraw : boolean) : integer; external 'SetWindowRgn@user32.dll stdcall';
function ReleaseCapture() : longint; external 'ReleaseCapture@user32.dll stdcall';
function CallWindowProc(lpPrevWndFunc : longint; h : hwnd; Msg : UINT; wParam, lParam : longint) : longint; external 'CallWindowProcA@user32.dll stdcall';
function SetWindowLong(h : hwnd; Index : integer; NewLong : longint) : longint; external 'SetWindowLongA@user32.dll stdcall';
function GetDC(hWnd: HWND): longword; external 'GetDC@user32.dll stdcall';
function BitBlt(DestDC: longword; X, Y, Width, Height: integer; SrcDC: longword; XSrc, YSrc: integer; Rop: DWORD): BOOL; external 'BitBlt@gdi32.dll stdcall';
function ReleaseDC(hWnd: HWND; hDC: longword): integer; external 'ReleaseDC@user32.dll stdcall';
function Win7_SetTimer(hWnd, nIDEvent, uElapse, lpTimerFunc: longword): longword; external 'SetTimer@user32.dll stdcall';
function Win7_KillTimer(hWnd, nIDEvent: longword): longword; external 'KillTimer@user32.dll stdcall';

const
  PRODUCT_REGISTRY_KEY_32 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppID}_is1';
  PRODUCT_REGISTRY_KEY_64 = 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppID}_is1';
  WM_SYSCOMMAND = $0112;
  ID_BUTTON_ON_CLICK_EVENT = 1;
  WIZARDFORM_WIDTH_NORMAL = 600;
  WIZARDFORM_HEIGHT_NORMAL = 400;
  WIZARDFORM_HEIGHT_MORE = 503;

var
  label_wizardform_main, label_messagebox_main, label_wizardform_more_product_already_installed, label_messagebox_information, label_messagebox_title, label_wizardform_title, label_install_progress : TLabel;
  image_wizardform_background, image_messagebox_background, image_progressbar_background, image_progressbar_foreground, PBOldProc : longint;
  button_license, button_minimize, button_close, button_browse, button_setup_or_next, button_customize_setup, button_uncustomize_setup, checkbox_license, checkbox_setdefault, button_messagebox_close, button_messagebox_ok, button_messagebox_cancel : hwnd;
  is_wizardform_show_normal, is_installer_initialized, is_platform_windows_7, is_wizardform_released, can_exit_setup, need_to_change_associations : boolean;
  edit_target_path : TEdit;
  version_installed_before : string;
  messagebox_close : TSetupForm;
  Taskbar_Timer : longword;
  boxFORM : TMainForm;

//判断系统版本，这个是决定是否要显示任务栏缩略图的依据
function isWin7 : boolean;
var
  ver : TWindowsVersion;
begin
  GetWindowsVersionEx(ver);
  if (ver.Major < 6) then
  begin
    Result := False;
  end else
  begin
    Result := True;
  end;
end;

//将窗口画面画到准备的窗口上，用来实现Win7及更新的系统的任务栏缩略图的效果
procedure update_img(HandleW, Msg, idEvent, TimeSys: longword);
var
  FormDC, DC: longword;
begin
  boxFORM.ClientWidth := WizardForm.ClientWidth;
  boxFORM.ClientHeight := WizardForm.ClientHeight;
  DC := GetDC(boxFORM.Handle);
  FormDC := GetDC(WizardForm.Handle);
  BitBlt(DC, 0, 0, boxFORM.ClientWidth, boxFORM.ClientHeight, FormDC, 0, 0, $00CC0020);
  ReleaseDC(boxFORM.Handle, DC);
  ReleaseDC(WizardForm.Handle, FormDC);
end;

//初始化任务栏缩略图
procedure init_taskbar;
begin
  boxFORM := TMainForm.Create(nil);
  if isWin7 then
  begin
    boxFORM.ClientWidth := WizardForm.ClientWidth;
    boxFORM.ClientHeight := WizardForm.ClientHeight;
    //boxFORM.Left := WizardForm.Left - 40;
    boxFORM.top := WizardForm.top - 4000;
    boxFORM.show;
    Taskbar_Timer := Win7_SetTimer(0, 0, 500, WrapTimerProc(@Update_Img, 4));
  end;
end;

//销毁任务栏缩略图定时器
procedure deinit_taskbar;
begin
  if isWin7 then
  begin
    Win7_KillTimer(0, Taskbar_Timer);
  end;
end;

//调用这个函数可以使矩形窗口转变为圆角矩形窗口
procedure shape_form_round(aForm : TForm; edgeSize : integer);
var
  FormRegion : longword;
begin
  FormRegion := CreateRoundRectRgn(0, 0, aForm.Width, aForm.Height, edgeSize, edgeSize);
  SetWindowRgn(aForm.Handle, FormRegion, True);
end;

//这个函数的作用是判断是否已经安装了将要安装的产品，若已经安装，则返回TRUE，否则返回FALSE
function is_installed_before() : boolean;
begin
#ifndef x64Build
  if is_platform_windows_7 then
  begin
    if IsWin64 then
    begin
      if RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64) then
      begin
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'DisplayVersion', version_installed_before);
        Result := True;
      end else
      begin
        version_installed_before := '0.0.0';
        Result := False;
      end;
    end else
    begin
      if RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) then
      begin
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'DisplayVersion', version_installed_before);
        Result := True;
      end else
      begin
        version_installed_before := '0.0.0';
        Result := False;
      end;
    end;
  end else
  begin
    if RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) then
      begin
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'DisplayVersion', version_installed_before);
        Result := True;
      end else
      begin
        version_installed_before := '0.0.0';
        Result := False;
      end;
  end;
#else
  if RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) then
  begin
    RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'DisplayVersion', version_installed_before);
    Result := True;
  end else
  begin
    version_installed_before := '0.0.0';
    Result := False;
  end;
#endif
end;

//这个函数的作用是判断是否正在安装旧版本（若系统中已经安装了将要安装的产品），是则返回TRUE，否则返回FALSE
function is_installing_older_version() : boolean;
var
  installedVer : array[1..10] of longint;
  installingVer : array[1..10] of longint;
  oldVer, nowVer, version_installing_now : string;
  i, oldTotal, nowTotal, total : integer;
begin
  oldTotal := 1;
  while (Pos('.', version_installed_before) > 0) do
  begin
    oldVer := version_installed_before;
    Delete(oldVer, Pos('.', oldVer), ((Length(oldVer) - Pos('.', oldVer)) + 1));
    installedVer[oldTotal] := StrToIntDef(oldVer, 0);
    oldTotal := oldTotal + 1;
    version_installed_before := Copy(version_installed_before, (Pos('.', version_installed_before) + 1), (Length(version_installed_before) - Pos('.', version_installed_before)));
  end;
  if (version_installed_before <> '') then
  begin
    installedVer[oldTotal] := StrToIntDef(version_installed_before, 0);
  end else
  begin
    oldTotal := oldTotal - 1;
  end;
  version_installing_now := '{#MyAppVersion}';
  nowTotal := 1;
  while (Pos('.', version_installing_now) > 0) do
  begin
    nowVer := version_installing_now;
    Delete(nowVer, Pos('.', nowVer), ((Length(nowVer) - Pos('.', nowVer)) + 1));
    installingVer[nowTotal] := StrToIntDef(nowVer, 0);
    nowTotal := nowTotal + 1;
    version_installing_now := Copy(version_installing_now, (Pos('.', version_installing_now) + 1), (Length(version_installing_now) - Pos('.', version_installing_now)));
  end;
  if (version_installing_now <> '') then
  begin
    installingVer[nowTotal] := StrToIntDef(version_installing_now, 0);
  end else
  begin
    nowTotal := nowTotal - 1;
  end;
  if (oldTotal < nowTotal) then
  begin
    for i := (oldTotal + 1) to nowTotal do
    begin
      installedVer[i] := 0;
      total := nowTotal;
    end;
  end else if (oldTotal > nowTotal) then
  begin
    for i := (nowTotal + 1) to oldTotal do
    begin
      installingVer[i] := 0;
      total := oldTotal;
    end;
  end else
  begin
    total := nowTotal;
  end;
  for i := 1 to total do
  begin
    if (installedVer[i] > installingVer[i]) then
    begin
      Result := True;
      Exit;
    end else if (installedVer[i] < installingVer[i]) then
    begin
      Result := False;
      Exit;
    end else
    begin
      Continue;
    end;
  end;
  Result := False;
end;

//主界面关闭按钮按下时执行的脚本
procedure button_close_on_click(hBtn : hwnd);
begin
  WizardForm.CancelButton.OnClick(WizardForm);
end;

//主界面最小化按钮按下时执行的脚本
procedure button_minimize_on_click(hBtn : hwnd);
begin
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, 61472, 0);
end;

//主界面自定义安装按钮按下时执行的脚本
procedure button_customize_setup_on_click(hBtn : hwnd);
begin
  if is_wizardform_show_normal then
  begin
    WizardForm.Height := WIZARDFORM_HEIGHT_MORE;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_welcome_more.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_MORE, False, True);
    edit_target_path.Show();
    BtnSetVisibility(button_browse, True);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, True);
#endif
    BtnSetVisibility(button_customize_setup, False);
    BtnSetVisibility(button_uncustomize_setup, True);
#ifndef PortableBuild
    if is_installed_before() then
    begin
      edit_target_path.Enabled := False;
      BtnSetEnabled(button_browse, False);
      label_wizardform_more_product_already_installed.Show();
    end;
#endif
    is_wizardform_show_normal := False;
  end else
  begin
    edit_target_path.Hide();
    label_wizardform_more_product_already_installed.Hide();
    BtnSetVisibility(button_browse, False);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, False);
#endif
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_welcome.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, False, True);
    BtnSetVisibility(button_customize_setup, True);
    BtnSetVisibility(button_uncustomize_setup, False);
    is_wizardform_show_normal := True;
  end;
  ImgApplyChanges(WizardForm.Handle);
end;

//主界面浏览按钮按下时执行的脚本
procedure button_browse_on_click(hBtn : hwnd);
begin
  WizardForm.DirBrowseButton.OnClick(WizardForm);
  edit_target_path.Text := WizardForm.DirEdit.Text;
end;

//路径输入框文本变化时执行的脚本
procedure edit_target_path_on_change(Sender : TObject);
begin
  WizardForm.DirEdit.Text := edit_target_path.Text;
end;

//同意许可协议的复选框被点击时执行的脚本
procedure checkbox_license_on_click(hBtn : hwnd);
begin
    if BtnGetChecked(checkbox_license) then
    begin
      BtnSetEnabled(button_setup_or_next, True);
    end else
    begin
      BtnSetEnabled(button_setup_or_next, False);
    end;
end;

//设为默认软件的复选框被点击时执行的脚本
procedure checkbox_setdefault_on_click(hBtn : hwnd);
begin
  if BtnGetChecked(checkbox_setdefault) then
  begin
    need_to_change_associations := True;  
  end else
  begin
    need_to_change_associations := False;
  end;
end;

//返回设为默认软件复选框的状态，已勾选则返回TRUE，否则返回FALSE
function is_setdefault_checkbox_checked() : boolean;
begin
  Result := need_to_change_associations;
end;

//若设为默认软件的复选框被勾选，则会在文件复制结束时执行此段脚本
procedure check_if_need_change_associations();
begin
  if is_setdefault_checkbox_checked() then
  begin
    //TODO
    MsgBox('此处执行注册文件后缀名的操作。', mbInformation, MB_OK);
  end;
end;

//主界面安装按钮按下时执行的脚本
procedure button_setup_or_next_on_click(hBtn : hwnd);
begin
  WizardForm.NextButton.OnClick(WizardForm);
end;

//复制文件时执行的脚本，每复制1%都会被调用一次，若要调整进度条或进度提示请在此段修改
function PBProc(h : hWnd; Msg, wParam, lParam : longint) : longint;
var
  pr, i1, i2 : EXTENDED;
  w : integer;
begin
  Result := CallWindowProc(PBOldProc, h, Msg, wParam, lParam);
  if ((Msg = $402) and (WizardForm.ProgressGauge.Position > WizardForm.ProgressGauge.Min)) then
  begin
    i1 := WizardForm.ProgressGauge.Position - WizardForm.ProgressGauge.Min;
    i2 := WizardForm.ProgressGauge.Max - WizardForm.ProgressGauge.Min;
    pr := (i1 * 100) / i2;
    label_install_progress.Caption := Format('%d', [Round(pr)]) + '%';
    w := Round((560 * pr) / 100);
    ImgSetPosition(image_progressbar_foreground, 20, 374, w, 6);
    ImgSetVisiblePart(image_progressbar_foreground, 0, 0, w, 6);
    ImgApplyChanges(WizardForm.Handle);
  end;
end;

//阅读许可协议的按钮按下时执行的脚本
procedure button_license_on_click(hBtn : hwnd);
var
  ErrorCode : integer;
begin
  ShellExec('', '{#MyAppLicenseURL}', '', '', SW_SHOW, ewNoWait, ErrorCode);
end;

//取消安装弹框的确定按钮按下时执行的脚本
procedure button_messagebox_ok_on_click(hBtn : hwnd);
begin
  can_exit_setup := True;
  messagebox_close.Close();
end;

//取消安装弹框的取消按钮按下时执行的脚本
procedure button_messagebox_cancel_on_click(hBtn : hwnd);
begin
  can_exit_setup := False;
  messagebox_close.Close();
end;

//主界面被点住就随鼠标移动的脚本
procedure wizardform_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer);
begin
  ReleaseCapture();
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, $F012, 0);
end;

//取消弹框被点住就随鼠标移动的脚本
procedure messagebox_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : integer);
begin
  ReleaseCapture();
  SendMessage(messagebox_close.Handle, WM_SYSCOMMAND, $F012, 0);
end;

//判断系统是否为Win7，是则返回TRUE，否则返回FALSE
procedure determine_wether_is_windows_7_or_not();
var
  sysVersion : TWindowsVersion;
begin
  GetWindowsVersionEx(sysVersion);
  if sysVersion.NTPlatform and (sysVersion.Major = 6) and (sysVersion.Minor = 1) then
  begin
    is_platform_windows_7 := True;
  end else
  begin
    is_platform_windows_7 := False;
  end;
end;

//创建取消弹框的脚本
procedure messagebox_close_create();
begin
  messagebox_close := CreateCustomForm();
  WITH messagebox_close do
  begin
    BorderStyle := bsNone;
    ClientWidth := 380;
    ClientHeight := 190;
    Color := clWhite;
    Caption := '';
  end;
  label_messagebox_title := TLabel.Create(messagebox_close);
  WITH label_messagebox_title do
  begin
    Parent := messagebox_close;
    AutoSize := False;
    Left := 30;
    Top := 5;
    ClientWidth := 400;
    ClientHeight := 20;
    Font.Size := 10;
    Font.Color := clWhite;
    Caption := '{#MyAppName} 安装';
    Transparent := True;
    OnMouseDown := @messagebox_on_mouse_down;
  end;
  label_messagebox_information := TLabel.Create(messagebox_close);
  WITH label_messagebox_information do
  begin
    Parent := messagebox_close;
    AutoSize := False;
    Left := 70;
    Top := 64;
    Width := 400;
    Height := 20;
    Font.Size := 10;
    Font.Color := clBlack;
    Caption := '您确定要退出“{#MyAppName}”安装程序？';
    Transparent := True;
    OnMouseDown := @messagebox_on_mouse_down;
  end;
  label_messagebox_main := TLabel.Create(messagebox_close);
  WITH label_messagebox_main do
  begin
    Parent := messagebox_close;
    AutoSize := False;
    Left := 0;
    Top := 0;
    Width := messagebox_close.Width;
    Height := messagebox_close.Height;
    Caption := '';
    Transparent := True;
    OnMouseDown := @messagebox_on_mouse_down;
  end;
  image_messagebox_background := ImgLoad(messagebox_close.Handle, ExpandConstant('{tmp}\background_messagebox.png'), 0, 0, 380, 190, False, True);
  button_messagebox_close := BtnCreate(messagebox_close.Handle, 350, 0, 30, 30, ExpandConstant('{tmp}\button_close.png'), 0, False);
  BtnSetEvent(button_messagebox_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_cancel_on_click, 1));
  button_messagebox_ok := BtnCreate(messagebox_close.Handle, 206, 150, 76, 28, ExpandConstant('{tmp}\button_ok.png'), 0, False);
  BtnSetEvent(button_messagebox_ok, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_ok_on_click, 1));
  button_messagebox_cancel := BtnCreate(messagebox_close.Handle, 293, 150, 76, 28, ExpandConstant('{tmp}\button_cancel.png'), 0, False);
  BtnSetEvent(button_messagebox_cancel, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_cancel_on_click, 1));
  ImgApplyChanges(messagebox_close.Handle);
end;

//释放安装程序时调用的脚本
procedure release_installer();
begin
  deinit_taskbar;
  gdipShutdown();
  messagebox_close.Release();
  WizardForm.Release();
end;

//在初始化之后释放安装程序的脚本
procedure release_installer_after_init();
begin
  messagebox_close.Release();
  WizardForm.Release();
end;

//释放需要的临时资源文件
procedure extract_temp_files();
begin
  ExtractTemporaryFile('button_customize_setup.png');
  ExtractTemporaryFile('button_uncustomize_setup.png');
  ExtractTemporaryFile('button_finish.png');
  ExtractTemporaryFile('button_setup_or_next.png');
  ExtractTemporaryFile('background_welcome.png');
  ExtractTemporaryFile('background_welcome_more.png');
  ExtractTemporaryFile('button_browse.png');
  ExtractTemporaryFile('progressbar_background.png');
  ExtractTemporaryFile('progressbar_foreground.png');
  ExtractTemporaryFile('button_license.png');
  ExtractTemporaryFile('checkbox_license.png');
#ifdef RegisteAssociations
  ExtractTemporaryFile('checkbox_setdefault.png');
#endif
  ExtractTemporaryFile('background_installing.png');
  ExtractTemporaryFile('background_finish.png');
  ExtractTemporaryFile('button_close.png');
  ExtractTemporaryFile('button_minimize.png');
  ExtractTemporaryFile('background_messagebox.png');
  ExtractTemporaryFile('button_cancel.png');
  ExtractTemporaryFile('button_ok.png');
end;

//重载主界面取消按钮被按下后的处理过程
procedure CancelButtonClick(CurPageID : integer; var Cancel, Confirm: boolean);
begin
  Confirm := False;
  messagebox_close.Center();
  messagebox_close.ShowModal();
  if can_exit_setup then
  begin
    release_installer();
    Cancel := True;
  end else
  begin
    Cancel := False;
  end;
end;

//重载安装程序初始化函数，判断是否已经安装新版本，是则禁止安装
function InitializeSetup() : boolean;
begin
#ifndef PortableBuild
#ifdef OnlyInstallNewVersion
  if is_installed_before() then
  begin
    if is_installing_older_version() then
    begin
      MsgBox('您已安装更新版本的“{#MyAppName}”，不允许使用旧版本替换新版本，请单击“确定”按钮退出此安装程序。', mbInformation, MB_OK);
      Result := False;
    end else
    begin
      Result := True;
    end;
  end else
  begin
    Result := True;
  end;
#else
  Result := True;
#endif
#else
  Result := True;
#endif
end;

//重载安装程序初始化函数（和上边那个不一样），进行初始化操作
procedure InitializeWizard();
begin
  is_installer_initialized := True;
  is_wizardform_show_normal := True;
  is_wizardform_released := False;
  need_to_change_associations := True;
  determine_wether_is_windows_7_or_not();
  extract_temp_files();
  WizardForm.InnerNotebook.Hide();
  WizardForm.OuterNotebook.Hide();
  WizardForm.Bevel.Hide();
  WITH WizardForm do
  begin
    BorderStyle := bsNone;
    Position := poDesktopCenter;
    ClientWidth := WIZARDFORM_WIDTH_NORMAL;
    ClientHeight := WIZARDFORM_HEIGHT_MORE;
    Color := clWhite;
    NextButton.Height := 0;
    CancelButton.Height := 0;
    BackButton.Visible := False;
  end;
  label_wizardform_title := TLabel.Create(WizardForm);
  WITH label_wizardform_title do
  begin
    Parent := WizardForm;
    AutoSize := False;
    Left := 10;
    Top := 5;
    Width := 200;
    Height := 20;
    Font.Size := 9;
    Font.Color := clWhite;
    Caption := '{#MyAppName} V{#MyAppVersion} 安装';
    Transparent := True;
    OnMouseDown := @wizardform_on_mouse_down;
  end;
  label_wizardform_more_product_already_installed := TLabel.Create(WizardForm);
  WITH label_wizardform_more_product_already_installed do
  begin
    Parent := WizardForm;
    AutoSize := False;
    Left := 85;
    Top := 449;
    Width := 200;
    Height := 20;
    Font.Size := 9;
    Font.Color := clGray;
    Caption := '软件已经安装，不允许更换目录。';
    Transparent := True;
    OnMouseDown := @wizardform_on_mouse_down;
  end;
  label_wizardform_more_product_already_installed.Hide();
  label_wizardform_main := TLabel.Create(WizardForm);
  WITH label_wizardform_main do
  begin
    Parent := WizardForm;
    AutoSize := False;
    Left := 0;
    Top := 0;
    Width := WizardForm.Width;
    Height := WizardForm.Height;
    Caption := '';
    Transparent := True;
    OnMouseDown := @wizardform_on_mouse_down;
  end;
  edit_target_path:= TEdit.Create(WizardForm);
  WITH edit_target_path do
  begin
    Parent := WizardForm;
    Text := WizardForm.DirEdit.Text;
    Font.Size := 9;
    BorderStyle := bsNone;
    SetBounds(91,423,402,20);
    OnChange := @edit_target_path_on_change;
    Color := clWhite;
    TabStop := False;
  end;
  edit_target_path.Hide();
  button_close := BtnCreate(WizardForm.Handle, 570, 0, 30, 30, ExpandConstant('{tmp}\button_close.png'), 0, False);
  BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_close_on_click, 1));
  button_minimize := BtnCreate(WizardForm.Handle, 540, 0, 30, 30, ExpandConstant('{tmp}\button_minimize.png'), 0, False);
  BtnSetEvent(button_minimize, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_minimize_on_click, 1));
  button_setup_or_next := BtnCreate(WizardForm.Handle, 211, 305, 178, 43, ExpandConstant('{tmp}\button_setup_or_next.png'), 0, False);
  BtnSetEvent(button_setup_or_next, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_setup_or_next_on_click, 1));
  button_browse := BtnCreate(WizardForm.Handle, 506, 420, 75, 24, ExpandConstant('{tmp}\button_browse.png'), 0, False);
  BtnSetEvent(button_browse, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_browse_on_click, 1));
  BtnSetVisibility(button_browse, False);
  button_customize_setup := BtnCreate(WizardForm.Handle, 511, 374, 78, 14, ExpandConstant('{tmp}\button_customize_setup.png'), 0, False);
  BtnSetEvent(button_customize_setup, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_customize_setup_on_click, 1));
  button_uncustomize_setup := BtnCreate(WizardForm.Handle, 511, 374, 78, 14, ExpandConstant('{tmp}\button_uncustomize_setup.png'), 0, False);
  BtnSetEvent(button_uncustomize_setup, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_customize_setup_on_click, 1));
  BtnSetVisibility(button_uncustomize_setup, False);
  PBOldProc := SetWindowLong(WizardForm.ProgressGauge.Handle, -4, PBCallBack(@PBProc, 4));
  ImgApplyChanges(WizardForm.Handle);
  messagebox_close_create();
  init_taskbar;
end;

//安装程序销毁时会调用这个函数
procedure DeinitializeSetup();
begin
  if ((is_wizardform_released = False) and (can_exit_setup = False)) then
  begin
    deinit_taskbar;
    gdipShutdown();
    if is_installer_initialized then
    begin
      release_installer_after_init();
    end;
  end;
end;

//安装页面改变时会调用这个函数
procedure CurPageChanged(CurPageID : integer);
begin
  if (CurPageID = wpWelcome) then
  begin
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_welcome.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, False, True);
    button_license := BtnCreate(WizardForm.Handle, 110, 376, 96, 12, ExpandConstant('{tmp}\button_license.png'), 0, False);
    BtnSetEvent(button_license, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_license_on_click, 1));
    checkbox_license := BtnCreate(WizardForm.Handle, 11, 374, 93, 17, ExpandConstant('{tmp}\checkbox_license.png'), 0, True);
    BtnSetEvent(checkbox_license, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@checkbox_license_on_click, 1));
    BtnSetChecked(checkbox_license, True);
#ifdef RegisteAssociations
    checkbox_setdefault := BtnCreate(WizardForm.Handle, 85, 470, 92, 17, ExpandConstant('{tmp}\checkbox_setdefault.png'), 0, True);
    BtnSetEvent(checkbox_setdefault, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@checkbox_setdefault_on_click, 1));
    BtnSetChecked(checkbox_setdefault, True);
    BtnSetVisibility(checkbox_setdefault, False);
#endif
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    ImgApplyChanges(WizardForm.Handle);
  end;
  if (CurPageID = wpInstalling) then
  begin
    edit_target_path.Hide();
    label_wizardform_more_product_already_installed.Hide();
    BtnSetVisibility(button_browse, False);
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    is_wizardform_show_normal := True;
    BtnSetVisibility(button_customize_setup, False);
    BtnSetVisibility(button_uncustomize_setup, False);
    BtnSetVisibility(button_close, False);
    BtnSetPosition(button_minimize, 570, 0, 30, 30);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, False);
#endif
    BtnSetVisibility(button_license, False);
    BtnSetVisibility(checkbox_license, False);
    label_install_progress := TLabel.Create(WizardForm);
    WITH label_install_progress do
    begin
      Parent := WizardForm;
      AutoSize := False;
      Left := 547;
      Top := 349;
      Width := 30;
      Height := 30;
      Font.Size := 10;
      Font.Color := clBlack;
      Caption := '';
      Transparent := True;
      Alignment := taRightJustify;
      OnMouseDown := @wizardform_on_mouse_down;
    end;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_installing.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, False, True);
    image_progressbar_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\progressbar_background.png'), 20, 374, 560, 6, False, True);
    image_progressbar_foreground := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\progressbar_foreground.png'), 20, 374, 0, 0, True, True);
    BtnSetVisibility(button_setup_or_next, False);
    ImgApplyChanges(WizardForm.Handle);
  end;
  if (CurPageID = wpFinished) then
  begin
    label_install_progress.Caption := '';
    label_install_progress.Visible := False;
    ImgSetVisibility(image_progressbar_background, False);
    ImgSetVisibility(image_progressbar_foreground, False);
    BtnSetPosition(button_minimize, 540, 0, 30, 30);
    BtnSetVisibility(button_close, True);
    button_setup_or_next := BtnCreate(WizardForm.Handle, 214, 305, 180, 44, ExpandConstant('{tmp}\button_finish.png'), 0, False);
    BtnSetEvent(button_setup_or_next, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_setup_or_next_on_click, 1));
    BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_setup_or_next_on_click, 1));
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_finish.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, False, True);
    ImgApplyChanges(WizardForm.Handle);
  end;
end;

//安装步骤改变时会调用这个函数
procedure CurStepChanged(CurStep : TSetupStep);
begin
  if (CurStep = ssPostInstall) then
  begin
#ifdef RegisteAssociations
    check_if_need_change_associations();
#endif
    //and do OTHER THINGS
  end;
  if (CurStep = ssDone) then
  begin
    is_wizardform_released := True;
    release_installer();
  end;
end;

//指定跳过哪些标准页面
function ShouldSkipPage(PageID : integer) : boolean;
begin
  if (PageID = wpLicense) then Result := True;
  if (PageID = wpPassword) then Result := True;
  if (PageID = wpInfoBefore) then Result := True;
  if (PageID = wpUserInfo) then Result := True;
  if (PageID = wpSelectDir) then Result := True;
  if (PageID = wpSelectComponents) then Result := True;
  if (PageID = wpSelectProgramGroup) then Result := True;
  if (PageID = wpSelectTasks) then Result := True;
  if (PageID = wpReady) then Result := True;
  if (PageID = wpPreparing) then Result := True;
  if (PageID = wpInfoAfter) then Result := True;
end;

