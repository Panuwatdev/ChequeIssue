unit ufrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, RzPanel, StdCtrls, Mask, RzEdit, RzLabel,
  SUIButton, DB, ADODB, LbCipher, LbClass;

type
  TfrmLogin = class(TForm)
    suiForm1: TsuiForm;
    RzLabel5: TRzLabel;
    edtUserID: TRzEdit;
    edtPassKey: TRzEdit;
    RzLabel1: TRzLabel;
    RzPanel2: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    suiButton1: TsuiButton;
    Lb3DES1: TLb3DES;
    procedure edtUserIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure suiButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
        fNeverUser : Boolean ;
        fUserStart : TDateTime ;
        fUserEnd   : TDateTime ;
        fNeverPass : Boolean ;
        fPassStart : TDateTime ;
        fPassEnd   : TDateTime ;
        fCanChangePass : Boolean ;
        fLock      : Boolean ;
        fChangeFirst : Boolean ;

        fLoginLimit : Integer ;
        fAlert      : Integer ;
        fLockNoUsd  : Integer ;
        fDisableNoUsd : Integer ;




    Function CheckLogin(): Boolean ;
    Procedure CheckAndLock();
    Procedure LoadADVConfig() ;
    Procedure DisableFirstLogin(inUserID : string) ;
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;
  Key128  : TKey128;

implementation
uses ufrmStartPage, ufrmDatacenter, LbString , DateUtils, ufrmMainmenu,
  ufrmChangePassword;

{$R *.dfm}


Procedure TfrmLogin.LoadADVConfig();
var DBCfg : TADOQuery ;
begin
   DBCfg := TADOQuery.Create(nil);
     with DBCfg do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear;
         SQL.Text := ' Select * from DBAdvanceConfig ' ;
         Active := true ;
         if(Recordcount < 0) then
           begin
            fLoginLimit := 0 ;
            fAlert      := 0 ;
            fLockNoUsd  := 0 ;
            fDisableNoUsd := 0 ;
           end else
           begin
            fLoginLimit := FieldByName('ADV_LoginLimited').AsInteger ;
            fAlert      := FieldByName('ADV_ExpireAlert').AsInteger ;
            fLockNoUsd  := FieldByName('ADV_UserLock').AsInteger ;
            fDisableNoUsd := FieldByName('ADV_Disable').AsInteger ;
           end;
          Active := false ;
          Free ; 
       end;
end;

procedure TfrmLogin.edtUserIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true) ;
end;

procedure TfrmLogin.suiButton1Click(Sender: TObject);
begin
  if(trim(edtUserID.Text) = '') or (trim(edtPassKey.Text) = '') then
    begin
      MessageDlg('ข้อมูลไม่ถูกต้อง',mtError,[mbOk],0) ;
      edtUserID.SetFocus ; Exit ;
    end ;

  if(not CheckLogin) then
    begin
      MessageDlg('ผู้ใช้งานไม่ถูกต้อง',mtWarning,[mbOk],0) ;
      frmDataCenter.SaveHistoryLogin(trim(edtUserID.Text),Trim(edtPassKey.Text));
      CheckAndLock ;
      edtUserID.SetFocus ; Exit ;
    end;

    if(not fNeverUser) then
      begin
        if(fUserStart < Date) and (fUserEnd > Date) then
          begin

            MessageDlg('รหัสผู้ใช้ยังไม่ถูกเปิดใช้งานหรืออาจหมดอายุ',mtWarning,[mbOk],0) ;
            Exit ;
          end;

          if(DaysBetween(Date,fUserEnd) <= fAlert) then
             begin
               MessageDlg('คุณเหลือการใช้งาน ผู้ใช้งาน '+IntTostr(DaysBetween(Date,fUserEnd))+' วัน'  ,mtWarning,[mbOk],0);

             end;
      end;

    if(not fNeverPass) then
      begin
        if(fPassStart < Date) and (fPassEnd > Date) then
          begin
            MessageDlg('รหัสผ่านยังไม่ถูกเปืดใช้งานหรืออาจหมดอายุ',mtWarning,[mbOk],0) ;
            Exit ;
          end;

        if(DaysBetween(Date,fUserEnd) <= fAlert) then
          begin
            MessageDlg('คุณเหลือการใช้งาน รหัสผ่าน '+IntTostr(DaysBetween(Date,fUserEnd))+' วัน'  ,mtWarning,[mbOk],0);
          end;

      end;

      if(fLock) then
        begin
            MessageDlg('รหัสผู้ใช้ถูกระงับชั่วคราว',mtWarning,[mbOk],0) ;
            Exit ;
        end;

    if(fChangeFirst) then
      begin
        if(not fCanChangePass) then
          begin
            MessageDlg('คุณไม่มีสิทธืเปลี่ยนรหัสผ่าน',mtWarning,[mbOk],0);
            edtUserID.SetFocus ; Exit ;
          end;

        if(frmChangePassword = nil) then Application.CreateForm(TfrmChangePassword,frmChangePassword) else
           frmChangePassword := TfrmChangePassword.Create(nil);
           frmChangePassword.UserID := trim(edtUserID.Text) ;
           frmChangePassword.ShowModal ;
           if(frmChangePassword.ChPass = cpCancel) then Exit ;
           if(frmChangePassword.ChPass = cpChange) then DisableFirstLogin(trim(edtUserID.Text));
      end;


           frmDataCenter.SaveHistoryUsed(trim(edtUserID.Text),'Login',' เข้าใช้งาน','สำเร็จ');
           frmDataCenter.UserID := trim(edtUserID.Text) ;
           if(frmMainMenu = nil) then Application.CreateForm(TfrmMainMenu,frmMainMenu) else
              frmMainMenu := TfrmMainMenu.Create(nil);
              frmMainMenu.ShowModal ;



end;

Function TfrmLogin.CheckLogin() : Boolean ;
var DBChk : TADOQuery ;
    fUser, fPass : String ;
begin
   fUser := TripleDESEncryptStringEx(trim(edtUserID.Text),Key128,true) ;
   fPass := TripleDESEncryptStringEx(trim(edtPassKey.Text),Key128,true) ;
   DBChk := TADOQuery.Create(nil);
     with DBChk do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBUserMaster '+
                     ' Where USE_ID = '+QuotedStr(fUser)+
                     ' and USE_Passkey = '+QuotedStr(fPass) ;
        Active := true ;
        if(RecordCount > 0) then
          begin
            fNeverUser := FieldByName('USE_UserNeverUsed').AsBoolean ;
            fUserStart := FieldByName('USE_UserStart').AsDateTime ;
            fUserEnd   := FieldByName('USE_UserEnd').AsDateTime ;
            fNeverPass := FieldByName('USE_PassNeverUsed').AsBoolean ;
            fPassStart := FieldByName('USE_PassStart').AsDateTime ;
            fPassEnd   := FieldByName('USE_PassEnd').AsDateTime ;
            fCanChangePass := FieldByName('USE_CanChangePass').AsBoolean ;
            fLock      := FieldByName('USE_Lock').AsBoolean ;
            fChangeFirst := FieldByName('USE_ChangeStart').AsBoolean ;
            CheckLogin := true ;
          end else
          begin
            CheckLogin := false ;
          end;
         Active := false ;
         Free ;
       end;


end;

Procedure TfrmLogin.DisableFirstLogin(inUserID : String);
var DBCH : TADOQuery ;
begin
  DBCH := TADOQuery.Create(nil);
    with DBCH do
      begin
       Connection := frmDataCenter.ADOConnection1 ;
       SQL.Clear ;
       SQL.Text := ' UpDate DBUserMaster '+
                   ' Set '+
                   ' USE_ChangeStart = 0 ' +
                   ' Where USE_ID = '+QuotedStr(TripleDESEncryptStringEx(inUserID,Key128,true)) ;
       ExecSQL ;            
      end;
end;

procedure TfrmLogin.CheckAndLock();
var DBHL : TADOQuery ;
    RecCount : Integer ;
begin

   DBHL := TADOQuery.Create(nil);
     with DBHL do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBHistoryLogin '+
                     ' Where HLG_User = '+QuotedStr(TripleDESEncryptStringEx(trim(edtUserID.Text),Key128,true))+
                     ' and HLG_Check = 0 ' ;
         Active := true ;
         RecCount := RecordCount ;
         Active := false ;
//         Free ;
       end;

       if(fLoginLimit = 0) then Exit ;

       if(RecCount > fLoginLimit) then
         begin
           with DBHL do
             begin
               Connection := frmDataCenter.ADOConnection1 ;
               SQL.Clear ;
               SQL.Text := ' Update DBUserMaster '+
                           ' Set USE_Lock = 1,'+
                           ' Where USE_ID = '+QuotedStr(TripleDESEncryptStringEx(trim(edtUserID.Text),Key128,true)) +

                           ' update DBHistoryLogin '+
                           ' Set HLG_Check = 1 ' +
                           ' Where HLG_User = '+QuotedStr(TripleDESEncryptStringEx(trim(edtUserID.Text),Key128,true)) ;
               ExecSQL ;
               Free ;
             end;
         end;
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
 LoadADVConfig() ;
 frmStartPage.Hide ;
//   DispName.Caption := IntToStr(DaysBetween(Date, Date + 5)) ;
//  DispName :=
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
// frmStartPage.Close ;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
