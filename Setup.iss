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

#IF VER < EncodeVer(5,5,9)
  #error 请升级您的 Inno Setup 编译器到 V5.5.9 或更新的版本
#endif

#ifndef UNICODE
  #error 请使用 Unicode 版 Inno Setup 编译器
#endif

#define MyAppName "My Program"
#define MyAppVersion "1.5"
#define MyAppPublisher "My Company, Inc."
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "MyProg.exe"

[Setup]
AppId={{751134E2-9659-4800-B491-787AF330DAED}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppComments=程序注释
AppContact=赵宇航
AppSupportPhone=13510102020
AppReadmeFile={#MyAppURL}
AppCopyright=版权所有 © {#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputBaseFilename={#MyAppName}_{#MyAppVersion}_Setup
VersionInfoDescription={#MyAppName} 安装程序
VersionInfoProductName={#MyAppName}
VersionInfoCompany={#MyAppPublisher}
VersionInfoCopyright=版权所有 © {#MyAppPublisher}
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
DisableReadyPage=yes
MinVersion=0,6.1.7601
TimeStampsInUTC=TRUE
;如果“PrivilegesRequired”权限设置成最低，安装程序将不会请求管理员权限，
;运行安装程序时不会弹出UAC窗口，但安装程序将无法向系统盘的“Program Files”文件夹中写入任何文件，
;若要写入注册表，也不能向“HKEY_LOCAL_MACHINE”下写入任何条目，只能向“HKEY_CURRENT_USER”下写入；
;如果“PrivilegesRequired”权限设置成管理员权限（或者干脆把“PrivilegesRequired=lowest”注释掉），
;安装程序在启动时将请求管理员权限，系统会弹出UAC窗口，此时安装程序有向任何文件夹中写入文件的权限，
;写入注册表也是向“HKEY_LOCAL_MACHINE”中写入，不再是向“HKEY_CURRENT_USER”中写入，
;请注意根据此项设置的不同，要及时修改[Code]段的“is_installed_before()”函数，
;因为若无管理员权限，安装程序只能向“HKEY_CURRENT_USER”下写入条目，
;而在管理员权限下则是向“HKEY_LOCAL_MACHINE”下写入条目（此处特指卸载条目），
;若您硬性指定条目路径，安装程序则会无视系统，向您指定的条目写入（如果权限足够的话）。
PrivilegesRequired=lowest
Uninstallable=no
;Uninstallable=yes
SetupMutex={#MyAppName},Global\{#MyAppName}
AppMutex={#MyAppName}
ShowLanguageDialog=no
;UninstallDisplayName={#MyAppName}
;UninstallDisplayIcon={uninstallexe}

[Languages]
Name: "default"; MessagesFile: ".\Languages\ChineseSimplified.isl"

[Files]
Source: ".\tmp\*"; DestDir: "{tmp}"; Flags: dontcopy solidbreak nocompression; Attribs: hidden system
Source: ".\app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

;[UninstallDelete]
;Type: filesandordirs; Name: "{app}"

[Code]
CONST appRegistryKey = 'SOFTWARE\Microsoft\windows\CurrentVersion\Uninstall\{751134E2-9659-4800-B491-787AF330DAED}_is1';

TYPE
  TBtnEventProc = PROCEDURE (h:HWND);
  TPBProc = FUNCTION(h:hWnd;Msg,wParam,lParam:LONGINT):LONGINT;

FUNCTION  ImgLoad(Wnd :HWND; FileName :PAnsiChar; Left, Top, Width, Height :INTEGER; Stretch, IsBkg :BOOLEAN) :LONGINT; EXTERNAL 'ImgLoad@files:botva2.dll stdcall delayload';
PROCEDURE ImgSetVisibility(img :LONGINT; Visible :BOOLEAN); EXTERNAL 'ImgSetVisibility@files:botva2.dll stdcall delayload';
PROCEDURE ImgApplyChanges(h:HWND); EXTERNAL 'ImgApplyChanges@files:botva2.dll stdcall delayload';
PROCEDURE ImgSetPosition(img :LONGINT; NewLeft, NewTop, NewWidth, NewHeight :INTEGER); EXTERNAL 'ImgSetPosition@files:botva2.dll stdcall delayload';
PROCEDURE gdipShutdown;  EXTERNAL 'gdipShutdown@files:botva2.dll stdcall delayload';
FUNCTION  WrapBtnCallback(Callback: TBtnEventProc; ParamCount: INTEGER): LONGWORD; EXTERNAL 'wrapcallback@files:innocallback.dll stdcall delayload';
FUNCTION  BtnCreate(hParent:HWND; Left,Top,Width,Height:INTEGER; FileName:PAnsiChar; ShadowWidth:INTEGER; IsCheckBtn:BOOLEAN):HWND;  EXTERNAL 'BtnCreate@files:botva2.dll stdcall delayload';
PROCEDURE BtnSetVisibility(h:HWND; Value:BOOLEAN); EXTERNAL 'BtnSetVisibility@files:botva2.dll stdcall delayload';
PROCEDURE BtnSetEvent(h:HWND; EventID:INTEGER; Event:LONGWORD); EXTERNAL 'BtnSetEvent@files:botva2.dll stdcall delayload';
PROCEDURE BtnSetEnabled(h:HWND; Value:BOOLEAN); EXTERNAL 'BtnSetEnabled@files:botva2.dll stdcall delayload';
FUNCTION  BtnGetChecked(h:HWND):BOOLEAN; EXTERNAL 'BtnGetChecked@files:botva2.dll stdcall delayload';
PROCEDURE BtnSetChecked(h:HWND; Value:BOOLEAN); EXTERNAL 'BtnSetChecked@files:botva2.dll stdcall delayload';
PROCEDURE BtnSetPosition(h:HWND; NewLeft, NewTop, NewWidth, NewHeight: INTEGER);  EXTERNAL 'BtnSetPosition@files:botva2.dll stdcall delayload';
FUNCTION  SetWindowLong(Wnd: HWnd; Index: INTEGER; NewLong: LONGINT): LONGINT; EXTERNAL 'SetWindowLongA@user32.dll stdcall';
FUNCTION  PBCallBack(P:TPBProc;ParamCount:INTEGER):LONGWORD; EXTERNAL 'wrapcallback@files:innocallback.dll stdcall delayload';
FUNCTION  CallWindowProc(lpPrevWndFunc: LONGINT; hWnd: HWND; Msg: UINT; wParam, lParam: LONGINT): LONGINT; EXTERNAL 'CallWindowProcA@user32.dll stdcall';
PROCEDURE ImgSetVisiblePart(img:LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetVisiblePart@files:botva2.dll stdcall delayload';
FUNCTION  ReleaseCapture(): LONGINT; EXTERNAL 'ReleaseCapture@user32.dll stdcall';

VAR
  label_wizardform_main : TLabel;
  image_wizardform_background,image_progressbar_background,image_progressbar_foreground,PBOldProc : LONGINT;
  button_license,button_minimize,button_close,button_browse,button_setup_or_next,button_customize_setup,button_uncustomize_setup,checkbox_license : HWND;
  isUnCustomize , isInited : BOOLEAN;
  edit_target_path : TEdit;

FUNCTION is_installed_before() : BOOLEAN;
VAR
  appInstallPath : STRING;
BEGIN
  appInstallPath := 'C:\Program Files\Company\Product';
  IF IsWin64 THEN
  BEGIN
    IF RegKeyExists(HKCU64, appRegistryKey) THEN
    BEGIN
      IF RegValueExists(HKCU64, appRegistryKey, 'InstallLocation') THEN
      BEGIN
        RegQueryStringValue(HKCU64, appRegistryKey, 'InstallLocation', appInstallPath);
        edit_target_path.Text := appInstallPath;
        Result := TRUE;
      END ELSE
      BEGIN
        Result := FALSE;
      END;
    END ELSE
    BEGIN
      Result := FALSE;
    END;
  END ELSE
  BEGIN
    IF RegKeyExists(HKEY_CURRENT_USER, appRegistryKey) THEN
    BEGIN
      IF RegValueExists(HKEY_CURRENT_USER, appRegistryKey, 'InstallLocation') THEN
      BEGIN
        RegQueryStringValue(HKEY_CURRENT_USER, appRegistryKey, 'InstallLocation', appInstallPath);
        edit_target_path.Text := appInstallPath;
        Result := TRUE;
      END ELSE
      BEGIN
        Result := FALSE;
      END;
    END ELSE
    BEGIN
      Result := FALSE;
    END;
  END;
END;

PROCEDURE button_close_on_click(hBtn : HWND);
BEGIN
  WizardForm.CancelButton.OnClick(WizardForm);
END;

PROCEDURE button_minimize_on_click(hBtn : HWND);
BEGIN
  SendMessage(WizardForm.Handle , $0112 , 61472 , 0);
END;

PROCEDURE button_customize_setup_on_click(hBtn : HWND);
BEGIN
  IF isUnCustomize THEN
  BEGIN
    WizardForm.Height := 464;
    image_wizardform_background:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\background_welcome_more.png'),0,0,600,464,FALSE,TRUE);
    edit_target_path.show;
    BtnSetVisibility(button_browse,TRUE);
    BtnSetVisibility(button_customize_setup,FALSE);
    BtnSetVisibility(button_uncustomize_setup,TRUE);
    isUnCustomize := FALSE;
  END ELSE
  BEGIN
    edit_target_path.Hide;
    BtnSetVisibility(button_browse,FALSE);
    WizardForm.Height := 400;
    image_wizardform_background:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\background_welcome.png'),0,0,600,400,FALSE,TRUE);
    BtnSetVisibility(button_customize_setup,TRUE);
    BtnSetVisibility(button_uncustomize_setup,FALSE);
    isUnCustomize := TRUE;
  END;
  ImgApplyChanges(WizardForm.Handle);
END;

PROCEDURE button_browse_on_click(hBtn:HWND);
BEGIN
  WizardForm.DirBrowseButton.OnClick(WizardForm);
  edit_target_path.text := WizardForm.DirEdit.text;
END;

PROCEDURE edit_target_path_on_change(Sender: TObject);
BEGIN
  WizardForm.DirEdit.text := edit_target_path.Text;
END;

PROCEDURE checkbox_license_on_click(hBtn:HWND);
BEGIN
    IF BtnGetChecked(checkbox_license)=TRUE THEN
    BEGIN
      BtnSetEnabled(button_setup_or_next,TRUE);
    END ELSE
    BEGIN
      BtnSetEnabled(button_setup_or_next,FALSE);
    END;
END;

PROCEDURE button_setup_or_next_on_click(hBtn:HWND);
BEGIN
  WizardForm.NextButton.OnClick(WizardForm);
END;

FUNCTION PBProc(h:hWnd;Msg,wParam,lParam:LONGINT):LONGINT;
VAR
  pr,i1,i2 : Extended;
  w : INTEGER;
BEGIN
  Result := CallWindowProc(PBOldProc,h,Msg,wParam,lParam);
  IF ((Msg=$402) and (WizardForm.ProgressGauge.Position>WizardForm.ProgressGauge.Min)) THEN
  BEGIN
    i1 := WizardForm.ProgressGauge.Position-WizardForm.ProgressGauge.Min;
    i2 := WizardForm.ProgressGauge.Max-WizardForm.ProgressGauge.Min;
    pr := i1*100/i2;
    w := Round(560*pr/100);
    ImgSetPosition(image_progressbar_foreground,20,374,w,6);
    ImgSetVisiblePart(image_progressbar_foreground,0,0,w,6);
    ImgApplyChanges(WizardForm.Handle);
  END;
END;

PROCEDURE button_license_on_click(hBtn:HWND);
VAR
  ErrorCode:INTEGER;
BEGIN
  ShellExec('', 'https://mit-license.org/','', '', SW_SHOW, ewNoWait, ErrorCode);
END;

PROCEDURE WizardFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
BEGIN
  ReleaseCapture;
  SendMessage(WizardForm.Handle, $0112, $F012, 0);
END;

PROCEDURE InitializeWizard();
BEGIN
  isInited := TRUE;
  WizardForm.OuterNotebook.hide;
  WizardForm.Bevel.Hide;
  WizardForm.BorderStyle := bsnone;
  WizardForm.Position := poDesktopCenter;
  WizardForm.Width := 600;
  WizardForm.Height := 464;
  WizardForm.Color := clWhite;
  WizardForm.NextButton.Height := 0;
  WizardForm.CancelButton.Height := 0;
  WizardForm.BackButton.Visible := FALSE;
  label_wizardform_main := TLabel.Create(WizardForm);
  label_wizardform_main.Parent := WizardForm;
  label_wizardform_main.AutoSize := FALSE;
  label_wizardform_main.Left := 0;
  label_wizardform_main.Top := 0;
  label_wizardform_main.Width := WizardForm.Width;
  label_wizardform_main.Height := WizardForm.Height;
  label_wizardform_main.Caption := '';
  label_wizardform_main.Transparent := TRUE;
  label_wizardform_main.OnMouseDown := @WizardFormMouseDown;
  isUnCustomize := TRUE;
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
  ExtractTemporaryFile('background_installing.png');
  ExtractTemporaryFile('background_finish.png');
  ExtractTemporaryFile('button_close.png');
  ExtractTemporaryFile('button_minimize.png');
  button_close:=BtnCreate(WizardForm.Handle,570,0,30,30,ExpandConstant('{tmp}\button_close.png'),0,FALSE);
  BtnSetEvent(button_close,1,WrapBtnCallback(@button_close_on_click,1));
  button_minimize:=BtnCreate(WizardForm.Handle,540,0,30,30,ExpandConstant('{tmp}\button_minimize.png'),0,FALSE);
  BtnSetEvent(button_minimize,1,WrapBtnCallback(@button_minimize_on_click,1));
  button_setup_or_next:=BtnCreate(WizardForm.Handle,211,305,178,43,ExpandConstant('{tmp}\button_setup_or_next.png'),0,FALSE);
  BtnSetEvent(button_setup_or_next,1,WrapBtnCallback(@button_setup_or_next_on_click,1));
  edit_target_path:= TEdit.Create(WizardForm);
  WITH edit_target_path DO
  BEGIN
    Parent := WizardForm;
    text := WizardForm.DirEdit.text;
    Font.Name := '微软雅黑';
    Font.Size := 9;
    BorderStyle := bsNone;
    SetBounds(91,423,402,20);
    OnChange:=@edit_target_path_on_change;
    Color := $FFFFFF;
    TabStop := FALSE;
  END;
  edit_target_path.Hide;
  button_browse:=BtnCreate(WizardForm.Handle,506,420,75,24,ExpandConstant('{tmp}\button_browse.png'),0,FALSE);
  BtnSetEvent(button_browse,1,WrapBtnCallback(@button_browse_on_click,1));
  BtnSetVisibility(button_browse,FALSE);
  button_customize_setup:=BtnCreate(WizardForm.Handle,511,374,78,14,ExpandConstant('{tmp}\button_customize_setup.png'),0,FALSE);
  BtnSetEvent(button_customize_setup,1,WrapBtnCallback(@button_customize_setup_on_click,1));
  button_uncustomize_setup:=BtnCreate(WizardForm.Handle,511,374,78,14,ExpandConstant('{tmp}\button_uncustomize_setup.png'),0,FALSE);
  BtnSetEvent(button_uncustomize_setup,1,WrapBtnCallback(@button_customize_setup_on_click,1));
  BtnSetVisibility(button_uncustomize_setup,FALSE);
  PBOldProc:=SetWindowLong(WizardForm.ProgressGauge.Handle,-4,PBCallBack(@PBProc,4));
  ImgApplyChanges(WizardForm.Handle);
END;

PROCEDURE DeinitializeSetup();
BEGIN
  gdipShutdown;
  IF isInited THEN
  BEGIN
    WizardForm.Release;
    WizardForm.Close;
  END;
END;

PROCEDURE CurPageChanged(CurPageID : INTEGER);
BEGIN
  IF (CurPageID = wpWelcome) THEN
  BEGIN
    image_wizardform_background := ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\background_welcome.png'),0,0,600,400,FALSE,TRUE);
    button_license := BtnCreate(WizardForm.Handle,110,376,96,12,ExpandConstant('{tmp}\button_license.png'),0,FALSE);
    BtnSetEvent(button_license,1,WrapBtnCallback(@button_license_on_click,1));
    checkbox_license := BtnCreate(WizardForm.Handle,11,374,93,17,ExpandConstant('{tmp}\checkbox_license.png'),0,TRUE);
    BtnSetEvent(checkbox_license,1,WrapBtnCallback(@checkbox_license_on_click,1));
    BtnSetChecked(checkbox_license,TRUE);
    WizardForm.Height := 400;
    IF is_installed_before THEN
    BEGIN
      edit_target_path.Enabled := FALSE;
      BtnSetEnabled(button_browse, FALSE);
    END;
    ImgApplyChanges(WizardForm.Handle);
  END;
  IF (CurPageID = wpInstalling) THEN
  BEGIN
    edit_target_path.Hide;
    BtnSetVisibility(button_browse,FALSE);
    WizardForm.Height := 400;
    isUnCustomize := TRUE;
    BtnSetVisibility(button_customize_setup,FALSE);
    BtnSetVisibility(button_uncustomize_setup,FALSE);
    BtnSetVisibility(button_license,FALSE);
    BtnSetVisibility(checkbox_license,FALSE);
    image_wizardform_background:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\background_installing.png'),0,0,600,400,FALSE,TRUE);
    image_progressbar_background:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\progressbar_background.png'),20,374,560,6,FALSE,TRUE);
    image_progressbar_foreground:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\progressbar_foreground.png'),20,374,0,0,TRUE,TRUE);
    BtnSetVisibility(button_setup_or_next,FALSE);
    ImgApplyChanges(WizardForm.Handle);
  END;
  IF (CurPageID = wpFinished) THEN
  BEGIN
    ImgSetVisibility(image_progressbar_background,FALSE);
    ImgSetVisibility(image_progressbar_foreground,FALSE);
    button_setup_or_next:=BtnCreate(WizardForm.Handle,214,305,180,44,ExpandConstant('{tmp}\button_finish.png'),0,FALSE);
    BtnSetEvent(button_setup_or_next,1,WrapBtnCallback(@button_setup_or_next_on_click,1));
    BtnSetEvent(button_close,1,WrapBtnCallback(@button_setup_or_next_on_click,1));
    image_wizardform_background:=ImgLoad(WizardForm.Handle,ExpandConstant('{tmp}\background_finish.png'),0,0,600,400,FALSE,TRUE);
    ImgApplyChanges(WizardForm.Handle);
  END;
END;

FUNCTION ShouldSkipPage(PageID: INTEGER): BOOLEAN;
BEGIN
  IF (PageID = wpLicense) THEN result := TRUE;
  IF (PageID = wpPassword) THEN result := TRUE;
  IF (PageID = wpInfoBefore) THEN result := TRUE;
  IF (PageID = wpUserInfo) THEN result := TRUE;
  IF (PageID = wpSelectDir) THEN result := TRUE;
  IF (PageID = wpSelectComponents) THEN result := TRUE;
  IF (PageID = wpSelectProgramGroup) THEN result := TRUE;
  IF (PageID = wpSelectTasks) THEN result := TRUE;
  IF (PageID = wpReady) THEN result := TRUE;
  IF (PageID = wpPreparing) THEN result := TRUE;
  IF (PageID = wpInfoAfter) THEN result := TRUE;
END;

