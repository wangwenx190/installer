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

#define MyAppVersion "1.0.0"
;编译器常量“MyAppVersionFlag”是安装程序判断是否已经安装新版本的判断依据，
;其值为去掉所有的点的点分十进制的版本号，
;必须是一个正整数，不能有除数字以外的任何字符（包括但不限于空格），
;首位不能为零，若版本号以零开头，则省略第一个不为零的数字前的所有的零，
;末尾的零不要省略，仅可省略开头的零，
;一定要保证此值新版本大于或等于旧版本。
#define MyAppVersionFlag "100"
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
Name: "zh_CN"; MessagesFile: ".\lang\zh-CN.isl"

[Files]
Source: ".\app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: ".\tmp\botva2.dll"; DestDir: "{tmp}\botva2.dll"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\InnoCallback.dll"; DestDir: "{tmp}\InnoCallback.dll"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_finish.png"; DestDir: "{tmp}\background_finish.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_installing.png"; DestDir: "{tmp}\background_installing.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_messagebox.png"; DestDir: "{tmp}\background_messagebox.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_welcome.png"; DestDir: "{tmp}\background_welcome.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\background_welcome_more.png"; DestDir: "{tmp}\background_welcome_more.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_browse.png"; DestDir: "{tmp}\button_browse.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_cancel.png"; DestDir: "{tmp}\button_cancel.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_close.png"; DestDir: "{tmp}\button_close.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_customize_setup.png"; DestDir: "{tmp}\button_customize_setup.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_finish.png"; DestDir: "{tmp}\button_finish.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_license.png"; DestDir: "{tmp}\button_license.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_minimize.png"; DestDir: "{tmp}\button_minimize.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_ok.png"; DestDir: "{tmp}\button_ok.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_setup_or_next.png"; DestDir: "{tmp}\button_setup_or_next.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\button_uncustomize_setup.png"; DestDir: "{tmp}\button_uncustomize_setup.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\checkbox_license.png"; DestDir: "{tmp}\checkbox_license.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
#ifdef RegisteAssociations
Source: ".\tmp\checkbox_setdefault.png"; DestDir: "{tmp}\checkbox_setdefault.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
#endif
Source: ".\tmp\progressbar_background.png"; DestDir: "{tmp}\progressbar_background.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\tmp\progressbar_foreground.png"; DestDir: "{tmp}\progressbar_foreground.png"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system

#ifndef PortableBuild
[Dirs]
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
Filename: "{app}\{#MyAppExeName}"; Parameters: "--uninstall"; WorkingDir: "{app}"; Flags: waituntilterminated skipifdoesntexist
#endif

#ifndef PortableBuild
[UninstallDelete]
Type: filesandordirs; Name: "{app}"
#endif

[Code]
CONST
  PRODUCT_REGISTRY_KEY_32 = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppID}_is1';
  PRODUCT_REGISTRY_KEY_64 = 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{#MyAppID}_is1';
  WM_SYSCOMMAND = $0112;
  ID_BUTTON_ON_CLICK_EVENT = 1;
  WIZARDFORM_WIDTH_NORMAL = 600;
  WIZARDFORM_HEIGHT_NORMAL = 400;
  WIZARDFORM_HEIGHT_MORE = 503;

VAR
  label_wizardform_main, label_messagebox_main, label_wizardform_more_product_already_installed, label_messagebox_information, label_messagebox_title, label_wizardform_title, label_install_progress : TLabel;
  image_wizardform_background, image_messagebox_background, image_progressbar_background, image_progressbar_foreground, PBOldProc : LONGINT;
  button_license, button_minimize, button_close, button_browse, button_setup_or_next, button_customize_setup, button_uncustomize_setup, checkbox_license, checkbox_setdefault, button_messagebox_close, button_messagebox_ok, button_messagebox_cancel : HWND;
  is_wizardform_show_normal, is_installer_initialized, is_platform_windows_7, is_wizardform_released, can_exit_setup, need_to_change_associations : BOOLEAN;
  edit_target_path : TEdit;
  version_installed_before : LONGINT;
  messagebox_close : TSetupForm;

TYPE
  TBtnEventProc = PROCEDURE(h : HWND);
  TPBProc = FUNCTION(h : hWnd; Msg, wParam, lParam : LONGINT) : LONGINT;

FUNCTION  ImgLoad(h : HWND; FileName : PAnsiChar; Left, Top, Width, Height : INTEGER; Stretch, IsBkg : BOOLEAN) : LONGINT; EXTERNAL 'ImgLoad@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgSetVisibility(img : LONGINT; Visible : BOOLEAN); EXTERNAL 'ImgSetVisibility@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgApplyChanges(h : HWND); EXTERNAL 'ImgApplyChanges@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgSetPosition(img : LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetPosition@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgRelease(img : LONGINT); EXTERNAL 'ImgRelease@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE CreateFormFromImage(h : HWND; FileName : PAnsiChar); EXTERNAL 'CreateFormFromImage@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE gdipShutdown();  EXTERNAL 'gdipShutdown@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  WrapBtnCallback(Callback : TBtnEventProc; ParamCount : INTEGER) : LONGWORD; EXTERNAL 'wrapcallback@files:innocallback.dll STDCALL DELAYLOAD';
FUNCTION  BtnCreate(hParent : HWND; Left, Top, Width, Height : INTEGER; FileName : PAnsiChar; ShadowWidth : INTEGER; IsCheckBtn : BOOLEAN) : HWND;  EXTERNAL 'BtnCreate@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetVisibility(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetVisibility@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetEvent(h : HWND; EventID : INTEGER; Event : LONGWORD); EXTERNAL 'BtnSetEvent@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetEnabled(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetEnabled@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  BtnGetChecked(h : HWND) : BOOLEAN; EXTERNAL 'BtnGetChecked@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetChecked(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetChecked@files:botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetPosition(h : HWND; NewLeft, NewTop, NewWidth, NewHeight : INTEGER);  EXTERNAL 'BtnSetPosition@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  SetWindowLong(h : HWnd; Index : INTEGER; NewLong : LONGINT) : LONGINT; EXTERNAL 'SetWindowLongA@user32.dll STDCALL';
FUNCTION  PBCallBack(P : TPBProc; ParamCount : INTEGER) : LONGWORD; EXTERNAL 'wrapcallback@files:innocallback.dll STDCALL DELAYLOAD';
FUNCTION  CallWindowProc(lpPrevWndFunc : LONGINT; h : HWND; Msg : UINT; wParam, lParam : LONGINT) : LONGINT; EXTERNAL 'CallWindowProcA@user32.dll STDCALL';
PROCEDURE ImgSetVisiblePart(img : LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetVisiblePart@files:botva2.dll STDCALL DELAYLOAD';
FUNCTION  ReleaseCapture() : LONGINT; EXTERNAL 'ReleaseCapture@user32.dll STDCALL';
FUNCTION  CreateRoundRectRgn(p1, p2, p3, p4, p5, p6 : INTEGER) : THandle; EXTERNAL 'CreateRoundRectRgn@gdi32 STDCALL';
FUNCTION  SetWindowRgn(h : HWND; hRgn : THandle; bRedraw : BOOLEAN) : INTEGER; EXTERNAL 'SetWindowRgn@user32 STDCALL';

//调用这个函数可以使矩形窗口转变为圆角矩形窗口
PROCEDURE shape_form_round(aForm : TForm; edgeSize : INTEGER);
VAR
  FormRegion : LONGWORD;
BEGIN
  FormRegion := CreateRoundRectRgn(0, 0, aForm.Width, aForm.Height, edgeSize, edgeSize);
  SetWindowRgn(aForm.Handle, FormRegion, TRUE);
END;

FUNCTION is_installed_before() : BOOLEAN;
VAR
  oldVersion : STRING;
BEGIN
#ifndef x64Build
  IF is_platform_windows_7 THEN
  BEGIN
    IF IsWin64 THEN
    BEGIN
      IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64) THEN
      BEGIN
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'VersionFlag', oldVersion);
        version_installed_before := StrToIntDef(oldVersion, 0);
        Result := TRUE;
      END ELSE
      BEGIN
        version_installed_before := 0;
        Result := FALSE;
      END;
    END ELSE
    BEGIN
      IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) THEN
      BEGIN
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag', oldVersion);
        version_installed_before := StrToIntDef(oldVersion, 0);
        Result := TRUE;
      END ELSE
      BEGIN
        version_installed_before := 0;
        Result := FALSE;
      END;
    END;
  END ELSE
  BEGIN
    IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) THEN
      BEGIN
        RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag', oldVersion);
        version_installed_before := StrToIntDef(oldVersion, 0);
        Result := TRUE;
      END ELSE
      BEGIN
        version_installed_before := 0;
        Result := FALSE;
      END;
  END;
#else
  IF RegKeyExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32) THEN
  BEGIN
    RegQueryStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag', oldVersion);
    version_installed_before := StrToIntDef(oldVersion, 0);
    Result := TRUE;
  END ELSE
  BEGIN
    version_installed_before := 0;
    Result := FALSE;
  END;
#endif
END;

FUNCTION is_installing_older_version() : BOOLEAN;
(*//CONST
//  maxVerLen : INTEGER = 10;
VAR
  installedVer : ARRAY[1..10] OF INTEGER;
  installingVer : ARRAY[1..10] OF INTEGER;
  i, totalSeparator, installedLen, installingLen : INTEGER;
  version_installing_now, installedStr, installingStr, str : STRING;*)
BEGIN
  (*version_installing_now := '{#MyAppVersion}';
  totalSeparator := 0;
  installedLen := Length(version_installed_before);
  FOR i := 1 TO installedLen DO
  BEGIN
    IF (version_installed_before[i] = '.') THEN
    BEGIN
      totalSeparator := totalSeparator + 1;
    END;  
  END;
  installedStr := version_installed_before;
  str := '';
  FOR i := 1 TO (totalSeparator + 1) DO
  BEGIN
    IF (i > 1) THEN
    BEGIN
      installedStr = Copy(installedStr, (Pos('.', installedStr) + 1), (installedLen - Pos('.', installedStr)));
    END;
    str := installedStr;
    Delete(str, Pos('.', str), ((installedLen - Pos('.', str)) + 1)); 
    installedVer[i] := StrToInt(str);
  END;
  installingLen := Length(version_installing_now);
  installingStr := version_installing_now;
  str := '';
  FOR i := 1 TO (totalSeparator + 1) DO
  BEGIN
    IF (i > 1) THEN
    BEGIN
      installingStr = Copy(installingStr, (Pos('.', installingStr) + 1), (installingLen - Pos('.', installingStr)));
    END;
    str := installingStr;
    Delete(str, Pos('.', str), ((installingLen - Pos('.', str)) + 1)); 
    installingVer[i] := StrToInt(str);
  END;
  FOR i := 1 TO (totalSeparator + 1) DO
  BEGIN
    IF (installingVer[i] < installedVer[i]) THEN
    BEGIN
      Result := TRUE;
      Exit;
    END ELSE IF (installingVer[i] > installedVer[i]) THEN 
    BEGIN
      Result := FALSE;
      Exit;
    END ELSE
    BEGIN
      Continue;
    END;
  END;
  Result := FALSE;*)
  IF (version_installed_before > StrToIntDef('{#MyAppVersionFlag}', 0)) THEN
  BEGIN
    Result := TRUE;
  END ELSE
  BEGIN
    Result := FALSE;
  END;   
END;

PROCEDURE button_close_on_click(hBtn : HWND);
BEGIN
  WizardForm.CancelButton.OnClick(WizardForm);
END;

PROCEDURE button_minimize_on_click(hBtn : HWND);
BEGIN
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, 61472, 0);
END;

PROCEDURE button_customize_setup_on_click(hBtn : HWND);
BEGIN
  IF is_wizardform_show_normal THEN
  BEGIN
    WizardForm.Height := WIZARDFORM_HEIGHT_MORE;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_welcome_more.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_MORE, FALSE, TRUE);
    edit_target_path.Show();
    BtnSetVisibility(button_browse, TRUE);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, TRUE);
#endif
    BtnSetVisibility(button_customize_setup, FALSE);
    BtnSetVisibility(button_uncustomize_setup, TRUE);
#ifndef PortableBuild
    IF is_installed_before() THEN
    BEGIN
      edit_target_path.Enabled := FALSE;
      BtnSetEnabled(button_browse, FALSE);
      label_wizardform_more_product_already_installed.Show();
    END;
#endif
    is_wizardform_show_normal := FALSE;
  END ELSE
  BEGIN
    edit_target_path.Hide();
    label_wizardform_more_product_already_installed.Hide();
    BtnSetVisibility(button_browse, FALSE);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, FALSE);
#endif
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_welcome.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    BtnSetVisibility(button_customize_setup, TRUE);
    BtnSetVisibility(button_uncustomize_setup, FALSE);
    is_wizardform_show_normal := TRUE;
  END;
  ImgApplyChanges(WizardForm.Handle);
END;

PROCEDURE button_browse_on_click(hBtn : HWND);
BEGIN
  WizardForm.DirBrowseButton.OnClick(WizardForm);
  edit_target_path.Text := WizardForm.DirEdit.Text;
END;

PROCEDURE edit_target_path_on_change(Sender : TObject);
BEGIN
  WizardForm.DirEdit.Text := edit_target_path.Text;
END;

PROCEDURE checkbox_license_on_click(hBtn : HWND);
BEGIN
    IF BtnGetChecked(checkbox_license) THEN
    BEGIN
      BtnSetEnabled(button_setup_or_next, TRUE);
    END ELSE
    BEGIN
      BtnSetEnabled(button_setup_or_next, FALSE);
    END;
END;

PROCEDURE checkbox_setdefault_on_click(hBtn : HWND);
BEGIN
  IF BtnGetChecked(checkbox_setdefault) THEN
  BEGIN
    need_to_change_associations := TRUE;  
  END ELSE
  BEGIN
    need_to_change_associations := FALSE;
  END;
END;

FUNCTION is_setdefault_checkbox_checked() : BOOLEAN;
BEGIN
  Result := need_to_change_associations;
END;

PROCEDURE check_if_need_change_associations();
BEGIN
  IF is_setdefault_checkbox_checked() THEN
  BEGIN
    //TODO
    MsgBox('此处执行注册文件后缀名的操作。', mbInformation, MB_OK);
  END;
END;

PROCEDURE button_setup_or_next_on_click(hBtn : HWND);
BEGIN
  WizardForm.NextButton.OnClick(WizardForm);
END;

FUNCTION PBProc(h : hWnd; Msg, wParam, lParam : LONGINT) : LONGINT;
VAR
  pr, i1, i2 : EXTENDED;
  pr2, w : INTEGER;
  p : STRING;
BEGIN
  Result := CallWindowProc(PBOldProc, h, Msg, wParam, lParam);
  IF ((Msg = $402) AND (WizardForm.ProgressGauge.Position > WizardForm.ProgressGauge.Min)) THEN
  BEGIN
    i1 := WizardForm.ProgressGauge.Position - WizardForm.ProgressGauge.Min;
    i2 := WizardForm.ProgressGauge.Max - WizardForm.ProgressGauge.Min;
    pr := (i1 * 100) / i2;
    pr2 := Round(pr);
    p := Format('%d', [pr2]) + '%';
    IF (pr2 < 10) THEN
    BEGIN
      p := '  ' + Trim(p);
    END
    ELSE IF ((pr2 >= 10) AND (pr2 < 100)) THEN
    BEGIN
      p := ' ' + Trim(p);
    END ELSE
    BEGIN
      p := Trim(p);
    END;
    label_install_progress.Caption := p;
    w := Round((560 * pr) / 100);
    ImgSetPosition(image_progressbar_foreground, 20, 374, w, 6);
    ImgSetVisiblePart(image_progressbar_foreground, 0, 0, w, 6);
    ImgApplyChanges(WizardForm.Handle);
  END;
END;

PROCEDURE button_license_on_click(hBtn : HWND);
VAR
  ErrorCode : INTEGER;
BEGIN
  ShellExec('', '{#MyAppLicenseURL}', '', '', SW_SHOW, ewNoWait, ErrorCode);
END;

PROCEDURE button_messagebox_ok_on_click(hBtn : HWND);
BEGIN
  can_exit_setup := TRUE;
  messagebox_close.Close();
END;

PROCEDURE button_messagebox_cancel_on_click(hBtn : HWND);
BEGIN
  can_exit_setup := FALSE;
  messagebox_close.Close();
END;

PROCEDURE wizardform_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, $F012, 0);
END;

PROCEDURE messagebox_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(messagebox_close.Handle, WM_SYSCOMMAND, $F012, 0);
END;

PROCEDURE determine_wether_is_windows_7_or_not();
VAR
  sysVersion : TWindowsVersion;
BEGIN
  GetWindowsVersionEx(sysVersion);
  IF sysVersion.NTPlatform AND (sysVersion.Major = 6) AND (sysVersion.Minor = 1) THEN
  BEGIN
    is_platform_windows_7 := TRUE;
  END ELSE
  BEGIN
    is_platform_windows_7 := FALSE;
  END;
END;

PROCEDURE messagebox_close_create();
BEGIN
  messagebox_close := CreateCustomForm();
  WITH messagebox_close DO
  BEGIN
    BorderStyle := bsNone;
    Width := 380;
    Height := 190;
    Color := clWhite;
    Caption := '';
  END;
  label_messagebox_title := TLabel.Create(messagebox_close);
  WITH label_messagebox_title DO
  BEGIN
    Parent := messagebox_close;
    AutoSize := FALSE;
    Left := 30;
    Top := 5;
    Width := 400;
    Height := 20;
    Font.Name := 'Microsoft YaHei';
    Font.Size := 10;
    Font.Color := clWhite;
    Caption := '{#MyAppName} 安装';
    Transparent := TRUE;
    OnMouseDown := @messagebox_on_mouse_down;
  END;
  label_messagebox_information := TLabel.Create(messagebox_close);
  WITH label_messagebox_information DO
  BEGIN
    Parent := messagebox_close;
    AutoSize := FALSE;
    Left := 70;
    Top := 64;
    Width := 400;
    Height := 20;
    Font.Name := 'Microsoft YaHei';
    Font.Size := 10;
    Font.Color := clBlack;
    Caption := '您确定要退出“{#MyAppName}”安装程序？';
    Transparent := TRUE;
    OnMouseDown := @messagebox_on_mouse_down;
  END;
  label_messagebox_main := TLabel.Create(messagebox_close);
  WITH label_messagebox_main DO
  BEGIN
    Parent := messagebox_close;
    AutoSize := FALSE;
    Left := 0;
    Top := 0;
    Width := messagebox_close.Width;
    Height := messagebox_close.Height;
    Caption := '';
    Transparent := TRUE;
    OnMouseDown := @messagebox_on_mouse_down;
  END;
  image_messagebox_background := ImgLoad(messagebox_close.Handle, ExpandConstant('{tmp}\background_messagebox.png'), 0, 0, 380, 190, FALSE, TRUE);
  button_messagebox_close := BtnCreate(messagebox_close.Handle, 350, 0, 30, 30, ExpandConstant('{tmp}\button_close.png'), 0, FALSE);
  BtnSetEvent(button_messagebox_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_cancel_on_click, 1));
  button_messagebox_ok := BtnCreate(messagebox_close.Handle, 206, 150, 76, 28, ExpandConstant('{tmp}\button_ok.png'), 0, FALSE);
  BtnSetEvent(button_messagebox_ok, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_ok_on_click, 1));
  button_messagebox_cancel := BtnCreate(messagebox_close.Handle, 293, 150, 76, 28, ExpandConstant('{tmp}\button_cancel.png'), 0, FALSE);
  BtnSetEvent(button_messagebox_cancel, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_messagebox_cancel_on_click, 1));
  ImgApplyChanges(messagebox_close.Handle);
END;

PROCEDURE CancelButtonClick(CurPageID : INTEGER; VAR Cancel, Confirm: BOOLEAN);
BEGIN
  Confirm := FALSE;
  messagebox_close.Center();
  messagebox_close.ShowModal();
  IF can_exit_setup THEN
  BEGIN
    ImgRelease(image_wizardform_background);
    ImgRelease(image_progressbar_background);
    ImgRelease(image_progressbar_foreground);
    ImgRelease(image_messagebox_background);
    gdipShutdown();
    messagebox_close.Release();
    WizardForm.Release();
    Cancel := TRUE;
  END ELSE
  BEGIN
    Cancel := FALSE;
  END;
END;

FUNCTION InitializeSetup() : BOOLEAN;
BEGIN
#ifndef PortableBuild
  IF is_installed_before() THEN
  BEGIN
    IF is_installing_older_version() THEN
    BEGIN
      MsgBox('您已安装更新版本的“{#MyAppName}”，不允许使用旧版本替换新版本，请单击“确定”按钮退出此安装程序。', mbInformation, MB_OK);
      Result := FALSE;
    END ELSE
    BEGIN
      Result := TRUE;
    END;
  END ELSE
  BEGIN
    Result := TRUE;
  END;
#else
  Result := TRUE;
#endif
END;

PROCEDURE InitializeWizard();
BEGIN
  is_installer_initialized := TRUE;
  is_wizardform_show_normal := TRUE;
  is_wizardform_released := FALSE;
  need_to_change_associations := TRUE;
  determine_wether_is_windows_7_or_not();
  WizardForm.InnerNotebook.Hide();
  WizardForm.OuterNotebook.Hide();
  WizardForm.Bevel.Hide();
  WITH WizardForm DO
  BEGIN
    BorderStyle := bsNone;
    Position := poDesktopCenter;
    Width := WIZARDFORM_WIDTH_NORMAL;
    Height := WIZARDFORM_HEIGHT_MORE;
    Color := clWhite;
    NextButton.Height := 0;
    CancelButton.Height := 0;
    BackButton.Visible := FALSE;
  END;
  label_wizardform_title := TLabel.Create(WizardForm);
  WITH label_wizardform_title DO
  BEGIN
    Parent := WizardForm;
    AutoSize := FALSE;
    Left := 10;
    Top := 5;
    Width := 200;
    Height := 20;
    Font.Name := 'Microsoft YaHei';
    Font.Size := 9;
    Font.Color := clWhite;
    Caption := '{#MyAppName} V{#MyAppVersion} 安装';
    Transparent := TRUE;
    OnMouseDown := @wizardform_on_mouse_down;
  END;
  label_wizardform_more_product_already_installed := TLabel.Create(WizardForm);
  WITH label_wizardform_more_product_already_installed DO
  BEGIN
    Parent := WizardForm;
    AutoSize := FALSE;
    Left := 85;
    Top := 449;
    Width := 200;
    Height := 20;
    Font.Name := 'Microsoft YaHei';
    Font.Size := 9;
    Font.Color := clGray;
    Caption := '软件已经安装，不允许更换目录。';
    Transparent := TRUE;
    OnMouseDown := @wizardform_on_mouse_down;
  END;
  label_wizardform_more_product_already_installed.Hide();
  label_wizardform_main := TLabel.Create(WizardForm);
  WITH label_wizardform_main DO
  BEGIN
    Parent := WizardForm;
    AutoSize := FALSE;
    Left := 0;
    Top := 0;
    Width := WizardForm.Width;
    Height := WizardForm.Height;
    Caption := '';
    Transparent := TRUE;
    OnMouseDown := @wizardform_on_mouse_down;
  END;
  edit_target_path:= TEdit.Create(WizardForm);
  WITH edit_target_path DO
  BEGIN
    Parent := WizardForm;
    Text := WizardForm.DirEdit.Text;
    Font.Name := 'Microsoft YaHei';
    Font.Size := 9;
    BorderStyle := bsNone;
    SetBounds(91,423,402,20);
    OnChange := @edit_target_path_on_change;
    Color := clWhite;
    TabStop := FALSE;
  END;
  edit_target_path.Hide();
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
  button_close := BtnCreate(WizardForm.Handle, 570, 0, 30, 30, ExpandConstant('{tmp}\button_close.png'), 0, FALSE);
  BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_close_on_click, 1));
  button_minimize := BtnCreate(WizardForm.Handle, 540, 0, 30, 30, ExpandConstant('{tmp}\button_minimize.png'), 0, FALSE);
  BtnSetEvent(button_minimize, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_minimize_on_click, 1));
  button_setup_or_next := BtnCreate(WizardForm.Handle, 211, 305, 178, 43, ExpandConstant('{tmp}\button_setup_or_next.png'), 0, FALSE);
  BtnSetEvent(button_setup_or_next, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_setup_or_next_on_click, 1));
  button_browse := BtnCreate(WizardForm.Handle, 506, 420, 75, 24, ExpandConstant('{tmp}\button_browse.png'), 0, FALSE);
  BtnSetEvent(button_browse, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_browse_on_click, 1));
  BtnSetVisibility(button_browse, FALSE);
  button_customize_setup := BtnCreate(WizardForm.Handle, 511, 374, 78, 14, ExpandConstant('{tmp}\button_customize_setup.png'), 0, FALSE);
  BtnSetEvent(button_customize_setup, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_customize_setup_on_click, 1));
  button_uncustomize_setup := BtnCreate(WizardForm.Handle, 511, 374, 78, 14, ExpandConstant('{tmp}\button_uncustomize_setup.png'), 0, FALSE);
  BtnSetEvent(button_uncustomize_setup, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_customize_setup_on_click, 1));
  BtnSetVisibility(button_uncustomize_setup, FALSE);
  PBOldProc := SetWindowLong(WizardForm.ProgressGauge.Handle, -4, PBCallBack(@PBProc, 4));
  ImgApplyChanges(WizardForm.Handle);
  messagebox_close_create();
END;

PROCEDURE DeinitializeSetup();
BEGIN
  IF ((is_wizardform_released = FALSE) AND (can_exit_setup = FALSE)) THEN
  BEGIN
    gdipShutdown();
    IF is_installer_initialized THEN
    BEGIN
      ImgRelease(image_wizardform_background);
      ImgRelease(image_progressbar_background);
      ImgRelease(image_progressbar_foreground);
      ImgRelease(image_messagebox_background);
      gdipShutdown();
      messagebox_close.Release();
      WizardForm.Release();
    END;
  END;
END;

PROCEDURE CurPageChanged(CurPageID : INTEGER);
BEGIN
  IF (CurPageID = wpWelcome) THEN
  BEGIN
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_welcome.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    button_license := BtnCreate(WizardForm.Handle, 110, 376, 96, 12, ExpandConstant('{tmp}\button_license.png'), 0, FALSE);
    BtnSetEvent(button_license, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_license_on_click, 1));
    checkbox_license := BtnCreate(WizardForm.Handle, 11, 374, 93, 17, ExpandConstant('{tmp}\checkbox_license.png'), 0, TRUE);
    BtnSetEvent(checkbox_license, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@checkbox_license_on_click, 1));
    BtnSetChecked(checkbox_license, TRUE);
#ifdef RegisteAssociations
    checkbox_setdefault := BtnCreate(WizardForm.Handle, 85, 470, 92, 17, ExpandConstant('{tmp}\checkbox_setdefault.png'), 0, TRUE);
    BtnSetEvent(checkbox_setdefault, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@checkbox_setdefault_on_click, 1));
    BtnSetChecked(checkbox_setdefault, TRUE);
    BtnSetVisibility(checkbox_setdefault, FALSE);
#endif
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    ImgApplyChanges(WizardForm.Handle);
  END;
  IF (CurPageID = wpInstalling) THEN
  BEGIN
    edit_target_path.Hide();
    label_wizardform_more_product_already_installed.Hide();
    BtnSetVisibility(button_browse, FALSE);
    WizardForm.Height := WIZARDFORM_HEIGHT_NORMAL;
    is_wizardform_show_normal := TRUE;
    BtnSetVisibility(button_customize_setup, FALSE);
    BtnSetVisibility(button_uncustomize_setup, FALSE);
    BtnSetVisibility(button_close, FALSE);
    BtnSetPosition(button_minimize, 570, 0, 30, 30);
#ifdef RegisteAssociations
    BtnSetVisibility(checkbox_setdefault, FALSE);
#endif
    BtnSetVisibility(button_license, FALSE);
    BtnSetVisibility(checkbox_license, FALSE);
    label_install_progress := TLabel.Create(WizardForm);
    WITH label_install_progress DO
    BEGIN
      Parent := WizardForm;
      AutoSize := FALSE;
      Left := 547;
      Top := 349;
      Width := 100;
      Height := 30;
      Font.Name := 'Microsoft YaHei';
      Font.Size := 10;
      Font.Color := clBlack;
      Caption := '';
      Transparent := TRUE;
      OnMouseDown := @wizardform_on_mouse_down;
    END;
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_installing.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    image_progressbar_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\progressbar_background.png'), 20, 374, 560, 6, FALSE, TRUE);
    image_progressbar_foreground := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\progressbar_foreground.png'), 20, 374, 0, 0, TRUE, TRUE);
    BtnSetVisibility(button_setup_or_next, FALSE);
    ImgApplyChanges(WizardForm.Handle);
  END;
  IF (CurPageID = wpFinished) THEN
  BEGIN
    label_install_progress.Caption := '';
    label_install_progress.Visible := FALSE;
    ImgSetVisibility(image_progressbar_background, FALSE);
    ImgSetVisibility(image_progressbar_foreground, FALSE);
    BtnSetPosition(button_minimize, 540, 0, 30, 30);
    BtnSetVisibility(button_close, TRUE);
    button_setup_or_next := BtnCreate(WizardForm.Handle, 214, 305, 180, 44, ExpandConstant('{tmp}\button_finish.png'), 0, FALSE);
    BtnSetEvent(button_setup_or_next, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_setup_or_next_on_click, 1));
    BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_setup_or_next_on_click, 1));
    image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_finish.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
    ImgApplyChanges(WizardForm.Handle);
  END;
END;

PROCEDURE CurStepChanged(CurStep : TSetupStep);
BEGIN
  IF (CurStep = ssPostInstall) THEN
  BEGIN
#ifdef RegisteAssociations
    check_if_need_change_associations();
#endif
    //AND DO OTHER THINGS
  END;
  IF (CurStep = ssDone) THEN
  BEGIN
#ifndef PortableBuild
    IF is_platform_windows_7 THEN
    BEGIN
      IF IsWin64 THEN
      BEGIN
        IF RegValueExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'VersionFlag') THEN
        BEGIN
          RegDeleteValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'VersionFlag');
        END;
        RegWriteStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'VersionFlag', '{#MyAppVersionFlag}');
      END ELSE
      BEGIN
        IF RegValueExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag') THEN
        BEGIN
          RegDeleteValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag');
        END;
        RegWriteStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag', '{#MyAppVersionFlag}');
      END;
    END ELSE
    BEGIN
      IF RegValueExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag') THEN
      BEGIN
        RegDeleteValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag');
      END;
      RegWriteStringValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag', '{#MyAppVersionFlag}');
    END;
#endif
    is_wizardform_released := TRUE;
    ImgRelease(image_wizardform_background);
    ImgRelease(image_progressbar_background);
    ImgRelease(image_progressbar_foreground);
    ImgRelease(image_messagebox_background);
    gdipShutdown();
    messagebox_close.Release();
    WizardForm.Release();
  END;
END;

FUNCTION ShouldSkipPage(PageID : INTEGER) : BOOLEAN;
BEGIN
  IF (PageID = wpLicense) THEN Result := TRUE;
  IF (PageID = wpPassword) THEN Result := TRUE;
  IF (PageID = wpInfoBefore) THEN Result := TRUE;
  IF (PageID = wpUserInfo) THEN Result := TRUE;
  IF (PageID = wpSelectDir) THEN Result := TRUE;
  IF (PageID = wpSelectComponents) THEN Result := TRUE;
  IF (PageID = wpSelectProgramGroup) THEN Result := TRUE;
  IF (PageID = wpSelectTasks) THEN Result := TRUE;
  IF (PageID = wpReady) THEN Result := TRUE;
  IF (PageID = wpPreparing) THEN Result := TRUE;
  IF (PageID = wpInfoAfter) THEN Result := TRUE;
END;

PROCEDURE CurUninstallStepChanged(CurUninstallStep : TUninstallStep);
BEGIN
  IF (CurUninstallStep = usAppMutexCheck) THEN
  BEGIN
    //此阶段为检查应用程序互斥的阶段，请在此进行互斥操作
  END;
  IF (CurUninstallStep = usUninstall) THEN
  BEGIN
#ifndef PortableBuild
    IF is_platform_windows_7 THEN
    BEGIN
      IF IsWin64 THEN
      BEGIN
        IF RegValueExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'VersionFlag') THEN
        BEGIN
          RegDeleteValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_64, 'VersionFlag');
        END;
      END ELSE
      BEGIN
        IF RegValueExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag') THEN
        BEGIN
          RegDeleteValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag');
        END;
      END;
    END ELSE
    BEGIN
      IF RegValueExists(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag') THEN
      BEGIN
        RegDeleteValue(HKEY_LOCAL_MACHINE, PRODUCT_REGISTRY_KEY_32, 'VersionFlag');
      END;
    END;
#endif
  END;
END;

