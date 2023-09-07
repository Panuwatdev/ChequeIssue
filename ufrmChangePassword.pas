unit ufrmChangePassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, RzGroupBar, RzPanel, StdCtrls, Mask, RzEdit,
  RzLabel, DB, ADODB, LbCipher, LbClass, ImgList;
type TfCHPass = (cpChange, cpCancel) ;
type
  TfrmChangePassword = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    RzLabel5: TRzLabel;
    edtOldPass: TRzEdit;
    RzLabel1: TRzLabel;
    edtNewPass: TRzEdit;
    RzLabel2: TRzLabel;
    edtConfirmNewPass: TRzEdit;
    RzPanel2: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    Lb3DES1: TLb3DES;
    ImageList2: TImageList;
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    fUserID : String ;
    fOldPassword : String ;
    fNewPassword : String ;
    fPassMin : Integer ;
    fReUsed  : Integer ;
    fCHPass : TfCHPass ;
    Procedure GetstartChange(inUserID : string) ;
    Procedure LoadADVConfig() ;
    Function CheckHist(inUserID : string) : Integer ;

  public
    { Public declarations }

  Published
    Property UserID : String Read fUserID write GetstartChange ;
    Property ChPass : TfCHPass Read fCHPass Default cpCancel ;

  end;

var
  frmChangePassword: TfrmChangePassword;
  Key128     : TKey128;

implementation
uses ufrmDatacenter, LbString ;

{$R *.dfm}

Procedure TfrmChangePassword.LoadADVConfig();
var DBCfg : TADOQuery ;
begin
   DBCfg := TADOQuery.Create(nil);
     with DBCfg do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear;
         SQL.Text := ' Select * from DBAdvanceConfig ' ;
         Active := true ;
         if(Recordcount <= 0) then
           begin
            fPassMin := 0 ;
            fReUsed  := 0 ;
           end else
           begin
            fPassMin := FieldByName('ADV_PassMin').AsInteger ;
            fReUsed  := FieldByName('ADV_ReturnLog').AsInteger ;
           end;
          Active := false ;
          Free ; 
       end;
end;


Procedure TfrmChangePassword.GetstartChange(inUserID : string);
var DBCH : TADOQuery ;
begin
   fUserID := inUserID ;
   LoadADVConfig();
   DBCH := TADOQuery.Create(nil);
     with DBCH do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBUserMaster '+
                     ' Where USE_ID = '+QuotedStr(TripleDESEncryptStringEx(fUserID,Key128,true)) ;
         Active := true ;
         fOldPassword := trim(FieldByname('USE_PassKey').AsString) ;
         Active := false ;
         Free ;
       end;
end;

Function TfrmChangePassword.CheckHist(inUserID : String) : Integer ;
var DBHit : TADOQuery ;
Begin
   DBHit := TADOQuery.Create(nil);
     with DBHit do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBHistoryLogin '+
                     ' where HLG_PassKey = '+QuotedStr(inUserID) ;
         Active := true ;
         CheckHist := RecordCount ;
         Active := false ;
         Free ;            
       end;
end;

procedure TfrmChangePassword.RzGroup1Items0Click(Sender: TObject);
var DBCH : TADOQuery ;
    CurrPass : String ;
    comfPass : String ;
begin
   if(trim(edtOldPass.Text) = '') or (trim(edtNewPass.Text) = '') or (trim(edtConfirmNewPass.Text) = '')then
     begin
       MessageDlg('ใส่ข้อมูลไม่ถูกต้อง',mtWarning,[mbOk],0) ;
       edtOldPass.SetFocus ; Exit ;
     end;

   if(fPassMin <> 0) then
     begin
       if(Length(trim(edtNewPass.Text)) < fPassMin) then
         begin
           MessageDlg('จำนวนรหัสผ่านไม่ถูกต้อง',mtWarning,[mbOk],0) ;
           edtNewPass.SetFocus ; Exit ;
         end;
     end;

     if(fReUsed > 0) then
       begin
         if(CheckHist(TripleDESEncryptStringEx(fUserID,Key128,true)) > fReUsed) then
           begin
             MessageDlg('รหัสผ่านถูกสุ่มใช้มากกว่าที่กำหนด',mtWarning,[mbOk],0) ;
             edtNewPass.SetFocus ; Exit ;
           end;
       end;
      CurrPass     := TripleDESEncryptStringEx(edtOldPass.Text,Key128,true) ;
      fNewPassword := TripleDESEncryptStringEx(edtNewPass.Text,Key128,true) ;
      comfPass     := TripleDESEncryptStringEx(edtConfirmNewPass.Text,Key128,true) ;


   if(fOldPassword <> CurrPass) then
     begin
       MessageDlg('รหัสผ่านไม่ถูกต้อง',mtWarning,[mbOk],0) ;
       edtOldPass.SetFocus ; Exit ;
     end ;

   if(fNewPassword <> comfPass) then
     begin
       MessageDlg('การยืนยันรหัสผ่านไม่ถูกต้อง',mtWarning,[mbOk],0) ;
       edtConfirmNewPass.SetFocus ; Exit ;
     end;

    DBCH := TADOQuery.Create(nil);
      with DBCH do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Update DBUserMaster '+
                      ' Set '+
                      ' USE_PassKey = '+QuotedStr(fNewPassword) +
                      ' Where USE_ID = '+QuotedStr(TripleDESEncryptStringEx(fUserID,Key128,true)) ;
                      //' Where USE_ID = '+QuotedStr(TripleDESEncryptStringEx(CurrPass,Key128,true)) ;
          //ShowMessage(SQL.Text);
          ExecSQL ;
          Free ;
        end;
     fCHPass := cpChange ;
     frmChangePassword.Close ;
end;

procedure TfrmChangePassword.RzGroup1Items1Click(Sender: TObject);
begin
  fCHPass := cpCancel ;
  frmChangePassword.Close ;
end;

procedure TfrmChangePassword.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmDataCenter.SaveHistoryUsed(trim(fUserID),'Login','ออกจากการใช้งานเเปลี่ยนรหัสผ่าน','สำเร็จ');
  Action := caFree ;
end;

procedure TfrmChangePassword.FormActivate(Sender: TObject);
begin
 frmDataCenter.SaveHistoryUsed(trim(fUserID),'Login',' เข้าใช้งานเเปลี่ยนรหัสผ่าน','สำเร็จ');
 fCHPass := cpCancel ;
end;

end.
