//这里存放的是botva2的函数声明

[Code]
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
FUNCTION  CreateRoundRectRgn(p1, p2, p3, p4, p5, p6 : INTEGER) : THandle; EXTERNAL 'CreateRoundRectRgn@gdi32.dll STDCALL';
FUNCTION  SetWindowRgn(h : HWND; hRgn : THandle; bRedraw : BOOLEAN) : INTEGER; EXTERNAL 'SetWindowRgn@user32.dll STDCALL';