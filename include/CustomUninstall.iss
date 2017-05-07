[Code]
TYPE
  TBtnEventProc = PROCEDURE(h : HWND);
  TPBProc = FUNCTION(h : hWnd; Msg, wParam, lParam : LONGINT) : LONGINT;

FUNCTION  ImgLoad(h : HWND; FileName : PAnsiChar; Left, Top, Width, Height : INTEGER; Stretch, IsBkg : BOOLEAN) : LONGINT; EXTERNAL 'ImgLoad@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgSetVisibility(img : LONGINT; Visible : BOOLEAN); EXTERNAL 'ImgSetVisibility@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgApplyChanges(h : HWND); EXTERNAL 'ImgApplyChanges@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgSetPosition(img : LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetPosition@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE ImgRelease(img : LONGINT); EXTERNAL 'ImgRelease@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE CreateFormFromImage(h : HWND; FileName : PAnsiChar); EXTERNAL 'CreateFormFromImage@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE gdipShutdown();  EXTERNAL 'gdipShutdown@{tmp}\botva2.dll STDCALL DELAYLOAD';
FUNCTION  WrapBtnCallback(Callback : TBtnEventProc; ParamCount : INTEGER) : LONGWORD; EXTERNAL 'wrapcallback@{tmp}\innocallback.dll STDCALL DELAYLOAD';
FUNCTION  BtnCreate(hParent : HWND; Left, Top, Width, Height : INTEGER; FileName : PAnsiChar; ShadowWidth : INTEGER; IsCheckBtn : BOOLEAN) : HWND;  EXTERNAL 'BtnCreate@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetVisibility(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetVisibility@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetEvent(h : HWND; EventID : INTEGER; Event : LONGWORD); EXTERNAL 'BtnSetEvent@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetEnabled(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetEnabled@{tmp}\botva2.dll STDCALL DELAYLOAD';
FUNCTION  BtnGetChecked(h : HWND) : BOOLEAN; EXTERNAL 'BtnGetChecked@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetChecked(h : HWND; Value : BOOLEAN); EXTERNAL 'BtnSetChecked@{tmp}\botva2.dll STDCALL DELAYLOAD';
PROCEDURE BtnSetPosition(h : HWND; NewLeft, NewTop, NewWidth, NewHeight : INTEGER);  EXTERNAL 'BtnSetPosition@{tmp}\botva2.dll STDCALL DELAYLOAD';
FUNCTION  SetWindowLong(h : HWnd; Index : INTEGER; NewLong : LONGINT) : LONGINT; EXTERNAL 'SetWindowLongA@user32.dll STDCALL';
FUNCTION  PBCallBack(P : TPBProc; ParamCount : INTEGER) : LONGWORD; EXTERNAL 'wrapcallback@{tmp}\innocallback.dll STDCALL DELAYLOAD';
FUNCTION  CallWindowProc(lpPrevWndFunc : LONGINT; h : HWND; Msg : UINT; wParam, lParam : LONGINT) : LONGINT; EXTERNAL 'CallWindowProcA@user32.dll STDCALL';
PROCEDURE ImgSetVisiblePart(img : LONGINT; NewLeft, NewTop, NewWidth, NewHeight : INTEGER); EXTERNAL 'ImgSetVisiblePart@{tmp}\botva2.dll STDCALL DELAYLOAD';
FUNCTION  ReleaseCapture() : LONGINT; EXTERNAL 'ReleaseCapture@user32.dll STDCALL';
FUNCTION  CreateRoundRectRgn(p1, p2, p3, p4, p5, p6 : INTEGER) : THandle; EXTERNAL 'CreateRoundRectRgn@gdi32.dll STDCALL';
FUNCTION  SetWindowRgn(h : HWND; hRgn : THandle; bRedraw : BOOLEAN) : INTEGER; EXTERNAL 'SetWindowRgn@user32.dll STDCALL';

CONST
  WM_SYSCOMMAND = $0112;
  WIZARDFORM_UNINSTALL_WIDTH_NORMAL = 506;
  WIZARDFORM_UNINSTALL_HEIGHT_NORMAL = 320;

VAR
  label_wizardform_uninstall_main : TLabel;
  image_wizardform_uninstall_background, image_progressbar_uninstall_foreground, image_progressbar_uninstall_background, UninstPBOldProc : LONGINT;

PROCEDURE uninstallwizardform_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(UninstallProgressForm.Handle, WM_SYSCOMMAND, $F012, 0);
END;

FUNCTION UninstPBProc(h : hWnd; Msg, wParam, lParam : LONGINT) : LONGINT;
VAR
  pr, i1, i2 : EXTENDED;
  w : INTEGER;
BEGIN
  Result := CallWindowProc(UninstPBOldProc, h, Msg, wParam, lParam);
  IF ((Msg = $402) AND (UninstallProgressForm.ProgressBar.Position > UninstallProgressForm.ProgressBar.Min)) THEN
  BEGIN
    i1 := UninstallProgressForm.ProgressBar.Position - UninstallProgressForm.ProgressBar.Min;
    i2 := UninstallProgressForm.ProgressBar.Max - UninstallProgressForm.ProgressBar.Min;
    pr := (i1 * 100) / i2;
    w := Round((460 * pr) / 100);
    ImgSetPosition(image_progressbar_uninstall_foreground, 23, 294, w, 4);
    ImgApplyChanges(UninstallProgressForm.Handle);
  END;
END;

FUNCTION InitializeUninstall() : BOOLEAN;
BEGIN
  FileCopy(ExpandConstant('{app}\Uninstaller\botva2.dll'), ExpandConstant('{tmp}\botva2.dll'), FALSE);
  FileCopy(ExpandConstant('{app}\Uninstaller\InnoCallback.dll'), ExpandConstant('{tmp}\InnoCallback.dll'), FALSE);
  FileCopy(ExpandConstant('{app}\Uninstaller\background_uninstalling.png'), ExpandConstant('{tmp}\background_uninstalling.png'), FALSE);
  FileCopy(ExpandConstant('{app}\Uninstaller\progressbar_uninstall_background.png'), ExpandConstant('{tmp}\progressbar_uninstall_background.png'), FALSE);
  FileCopy(ExpandConstant('{app}\Uninstaller\progressbar_uninstall_foreground.png'), ExpandConstant('{tmp}\progressbar_uninstall_foreground.png'), FALSE);
  Result := TRUE;
END;

PROCEDURE InitializeUninstallProgressForm();
BEGIN
  WITH UninstallProgressForm DO
  BEGIN
    Bevel.Hide();
    InnerNotebook.Hide();
    OuterNotebook.Hide();
    Width := WIZARDFORM_UNINSTALL_WIDTH_NORMAL;
    Height := WIZARDFORM_UNINSTALL_HEIGHT_NORMAL;
    BorderStyle := bsNone;
    Position := poDesktopCenter;
    CancelButton.Visible := FALSE;
  END;
  label_wizardform_uninstall_main := TLabel.Create(UninstallProgressForm);
  WITH label_wizardform_uninstall_main DO
  BEGIN
    Parent := UninstallProgressForm;
    AutoSize := FALSE;
    Left := 0;
    Top := 0;
    Width := UninstallProgressForm.Width;
    Height := UninstallProgressForm.Height;
    Caption := '';
    Transparent := TRUE;
    OnMouseDown := @uninstallwizardform_on_mouse_down;
  END;
  image_wizardform_uninstall_background := ImgLoad(UninstallProgressForm.Handle, ExpandConstant('{tmp}\background_uninstalling.png'), 0, 0, WIZARDFORM_UNINSTALL_WIDTH_NORMAL, WIZARDFORM_UNINSTALL_HEIGHT_NORMAL, FALSE, TRUE);
  image_progressbar_uninstall_background := ImgLoad(UninstallProgressForm.Handle, ExpandConstant('{tmp}\progressbar_uninstall_background.png'), 23, 294, 460, 2, FALSE, TRUE);
  image_progressbar_uninstall_foreground := ImgLoad(UninstallProgressForm.Handle, ExpandConstant('{tmp}\progressbar_uninstall_foreground.png'), 23, 294, 0, 0, TRUE, TRUE);
  UninstPBOldProc := SetWindowLong(UninstallProgressForm.ProgressBar.Handle, -4, PBCallBack(@UninstPBProc, 4));
  ImgApplyChanges(UninstallProgressForm.Handle);
END;

PROCEDURE CurUninstallStepChanged(CurUninstallStep : TUninstallStep);
BEGIN
  IF (CurUninstallStep = usDone) THEN
  BEGIN
    IF FileExists(ExpandConstant('{app}\Uninstall.exe')) THEN
    BEGIN
      DeleteFile(ExpandConstant('{app}\Uninstall.exe'));
      DelTree(ExpandConstant('{app}'), TRUE, TRUE, TRUE);
    END;
  END;  
END;

PROCEDURE DeinitializeUninstall();
BEGIN
  gdipShutdown();
END;