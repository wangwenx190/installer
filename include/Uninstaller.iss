#include ".\botva2.iss"

[Code]
CONST
  WM_SYSCOMMAND = $0112;
  ID_BUTTON_ON_CLICK_EVENT = 1;
  WIZARDFORM_WIDTH_NORMAL = 506;
  WIZARDFORM_HEIGHT_NORMAL = 320;

VAR
  label_wizardform_main : TLabel;
  image_wizardform_background : LONGINT;
  button_close, button_chat, button_uninstall, button_cancel, checkbox_delete_config_file : HWND;
  is_installer_initialized, is_wizardform_released, can_delete_config_file : BOOLEAN;

//主界面关闭按钮按下时执行的脚本
PROCEDURE button_close_on_click(hBtn : HWND);
BEGIN
  WizardForm.CancelButton.OnClick(WizardForm);
END;

PROCEDURE button_chat_on_click(hBtn : HWND);
VAR
  ErrorCode : INTEGER;
BEGIN
  ShellExec('', '{#MyAppURL}', '', '', SW_SHOW, ewNoWait, ErrorCode);
END;

PROCEDURE checkbox_delete_config_file_on_click(hBtn : HWND);
BEGIN
  can_delete_config_file := BtnGetChecked(checkbox_delete_config_file);  
END;

PROCEDURE button_uninstall_on_click(hBtn : HWND);
VAR
  ResultCode : INTEGER;
BEGIN
  Exec(ExpandConstant('{src}\Uninstaller\unins000.exe'), '/SILENT /NORESTART', '', SW_SHOW, ewNoWait, ResultCode);
  WizardForm.CancelButton.OnClick(WizardForm);
END;

//主界面被点住就随鼠标移动的脚本
PROCEDURE wizardform_on_mouse_down(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X, Y : INTEGER);
BEGIN
  ReleaseCapture();
  SendMessage(WizardForm.Handle, WM_SYSCOMMAND, $F012, 0);
END;

//释放安装程序时调用的脚本
PROCEDURE release_installer();
BEGIN
  gdipShutdown();
  WizardForm.Release();
END;

//在初始化之后释放安装程序的脚本
PROCEDURE release_installer_after_init();
BEGIN
  WizardForm.Release();
END;

//释放需要的临时资源文件
PROCEDURE extract_temp_files();
BEGIN
  ExtractTemporaryFile('background_uninstall_prepare.png');
  ExtractTemporaryFile('button_cancel.png');
  ExtractTemporaryFile('button_chat.png');
  ExtractTemporaryFile('button_close.png');
  ExtractTemporaryFile('button_uninstall.png');
  ExtractTemporaryFile('checkbox.png');
END;

//重载主界面取消按钮被按下后的处理过程
PROCEDURE CancelButtonClick(CurPageID : INTEGER; VAR Cancel, Confirm: BOOLEAN);
BEGIN
  Confirm := FALSE;
  Cancel := TRUE;
END;

//重载安装程序初始化函数（和上边那个不一样），进行初始化操作
PROCEDURE InitializeWizard();
BEGIN
  is_installer_initialized := TRUE;
  is_wizardform_released := FALSE;
  can_delete_config_file := FALSE;
  extract_temp_files();
  WizardForm.InnerNotebook.Hide();
  WizardForm.OuterNotebook.Hide();
  WizardForm.Bevel.Hide();
  WITH WizardForm DO
  BEGIN
    BorderStyle := bsNone;
    Position := poDesktopCenter;
    Width := WIZARDFORM_WIDTH_NORMAL;
    Height := WIZARDFORM_HEIGHT_NORMAL;
    Color := clWhite;
    NextButton.Height := 0;
    CancelButton.Height := 0;
    BackButton.Visible := FALSE;
  END;
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
  image_wizardform_background := ImgLoad(WizardForm.Handle, ExpandConstant('{tmp}\background_uninstall_prepare.png'), 0, 0, WIZARDFORM_WIDTH_NORMAL, WIZARDFORM_HEIGHT_NORMAL, FALSE, TRUE);
  button_close := BtnCreate(WizardForm.Handle, 480, 6, 19, 19, ExpandConstant('{tmp}\button_close.png'), 0, FALSE);
  BtnSetEvent(button_close, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_close_on_click, 1));
  button_chat := BtnCreate(WizardForm.Handle, 309, 159, 136, 27, ExpandConstant('{tmp}\button_chat.png'), 0, FALSE);
  BtnSetEvent(button_chat, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_chat_on_click, 1));
  button_uninstall := BtnCreate(WizardForm.Handle, 337, 273, 67, 28, ExpandConstant('{tmp}\button_uninstall.png'), 0, FALSE);
  BtnSetEvent(button_uninstall, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_uninstall_on_click, 1));
  button_cancel := BtnCreate(WizardForm.Handle, 410, 273, 67, 28, ExpandConstant('{tmp}\button_cancel.png'), 0, FALSE);
  BtnSetEvent(button_cancel, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@button_close_on_click, 1));
  checkbox_delete_config_file := BtnCreate(WizardForm.Handle, 20, 280, 16, 16, ExpandConstant('{tmp}\checkbox.png'), 0, TRUE);
  BtnSetEvent(checkbox_delete_config_file, ID_BUTTON_ON_CLICK_EVENT, WrapBtnCallback(@checkbox_delete_config_file_on_click, 1));
  BtnSetChecked(checkbox_delete_config_file, FALSE);
  ImgApplyChanges(WizardForm.Handle);
END;

//安装程序销毁时会调用这个函数
PROCEDURE DeinitializeSetup();
BEGIN
  IF (is_wizardform_released = FALSE) THEN
  BEGIN
    gdipShutdown();
    IF is_installer_initialized THEN
    BEGIN
      release_installer_after_init();
    END;
  END;
END;