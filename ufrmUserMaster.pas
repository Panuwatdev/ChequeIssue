unit ufrmUserMaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, RzGroupBar, StdCtrls, Mask, RzEdit, RzLabel,
  RzPanel, SUIImagePanel, SUIGroupBox, SUIButton, DB, ADODB,
  Menus, SUIPopupMenu, RzShellDialogs, SUIRadioGroup, LbCipher, LbClass;

type
  TfrmUserMaster = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    RzPanel1: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    suiGroupBox1: TsuiGroupBox;
    RzLabel5: TRzLabel;
    edtUserID: TRzEdit;
    edtPass: TRzEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    edtConfirmPass: TRzEdit;
    suiGroupBox3: TsuiGroupBox;
    cbUserNever: TsuiCheckBox;
    cbPassNever: TsuiCheckBox;
    cbCanChangePass: TsuiCheckBox;
    cbCanCreateUser: TsuiCheckBox;
    edtPassStartDate: TRzDateTimeEdit;
    edtUserStartDate: TRzDateTimeEdit;
    cbUserLock: TsuiCheckBox;
    cbCanPermission: TsuiCheckBox;
    edtName: TRzEdit;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    edtLastName: TRzEdit;
    Image2: TImage;
    RzOpenDialog1: TRzOpenDialog;
    suiPopupMenu1: TsuiPopupMenu;
    LoadPicture1: TMenuItem;
    cbChangePassFirst: TsuiCheckBox;
    edtUserEndTime: TRzDateTimeEdit;
    edtPassEndDate: TRzDateTimeEdit;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    cbSex: TsuiRadioGroup;
    Lb3DES1: TLb3DES;
    procedure RzGroup1Items2Click(Sender: TObject);
    procedure edtUserIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbUserNeverClick(Sender: TObject);
    procedure cbPassNeverClick(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure RzGroup1Items3Click(Sender: TObject);
    procedure RzGroup1Items4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fMinDigitUser : Integer ;
    fMinDigitPass : Integer ;
    finUserID     : String ;
    fMode         : String ;

    procedure GetAdvanceUser() ;
    Procedure GetStartUser(inUser : String);
    Procedure ShowScreen() ;
    Procedure ClearScreen() ;
    Procedure SaveUser() ;
  public
    { Public declarations }
  Published
    Property inUserID : String Read finUserID Write GetStartUser ;

  end;

var
  frmUserMaster: TfrmUserMaster;
  Key128           : TKey128;

implementation

uses ufrmDatacenter,ufrmAdvanceConfig, ufrmChangePassword, LbString,
  ufrmPermission;
  //,ufrmMainUser;

{$R *.dfm}

Procedure TfrmUserMaster.GetStartUser(inUser : String);
begin
  finUserID := inUser ;
  if(trim(inUser) = '') then
   begin
     fMode := 'NEW' ;
     DispName.Caption := 'New User' ;
     edtUserID.ReadOnly := false ;
     ClearScreen ;
   end else
   begin
     fMode := 'EDIT' ;
     DispName.Caption := inUser ;
     edtUserID.ReadOnly := true ;
     ShowScreen ;
   end;
end;

procedure TfrmUserMaster.RzGroup1Items2Click(Sender: TObject);
begin
     if(frmPermission = nil) then Application.CreateForm(TfrmPermission,frmPermission) else
        frmPermission := TfrmPermission.Create(nil);
        frmPermission.UserID := finUserID ;
        frmPermission.ShowModal ;

      frmUserMaster.Close;  

end;

Procedure TfrmUserMaster.GetAdvanceUser() ;
Var DBADV : TADOQuery ;
begin
  DBADV := TADOQuery.Create(nil);
   with DBADV do
     begin
       Connection := frmDataCenter.ADOConnection1 ;
       SQL.Clear ;
       SQL.Text := ' Select ADV_UserMin,ADV_PassMin from DBAdvanceConfig ' ;
       Active := true ;
       if(RecordCount > 0) then
        begin
          fMinDigitUser := FieldByname('ADV_UserMin').AsInteger ;
          fMinDigitPass := FieldByname('ADV_PassMin').AsInteger ;
        end else
        begin
          fMinDigitUser := 0 ;
          fMinDigitPass := 0 ;
        end;
       Active := false ;
       Free ;
     end;
end;

Procedure TfrmUserMaster.ShowScreen();
var DBShow : TADOQuery ;
    UserIDCon : String ;
    UserPassCon : String ;
begin

//   GenerateLMDKey(Key128, SizeOf(Key128), edtUserID.Text);
   UserIDCon := TripleDESEncryptStringEx(trim(finUserID), Key128, true);
   DBShow := TADOQuery.Create(nil);
     with DBShow do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBUserMaster '+
                     ' Where USE_ID = '+QuotedStr(UserIDCon) ;
         Active := true ;
//         GenerateLMDKey(Key128, SizeOf(Key128), FieldByname('USE_ID').AsString);
         UserIDCon   := TripleDESEncryptStringEx(trim(FieldByname('USE_ID').AsString), Key128, False);
         UserPassCon := TripleDESEncryptStringEx(trim(FieldByname('USE_Passkey').AsString), Key128, False);
         edtUserID.Text            := finUserID ;
         edtName.Text              := trim(FieldByname('USE_Name').AsString) ;
         edtLastName.Text          := trim(FieldByname('USE_LastName').AsString) ;
         edtPass.Text              := UserPassCon  ;
         edtConfirmPass.Text       := UserPassCon  ;
         cbUserNever.Checked       := FieldByname('USE_UserNeverUsed').AsBoolean ;
         cbPassNever.Checked       := FieldByname('USE_PassNeverUsed').AsBoolean ;
         cbCanChangePass.Checked   := FieldByname('USE_CanChangePass').AsBoolean ;
         cbCanCreateUser.Checked   := FieldByname('USE_CanCreateUser').AsBoolean ;
         cbUserLock.Checked        := FieldByname('USE_Lock').AsBoolean ;
         cbCanPermission.Checked   := FieldByname('USE_CanPermission').AsBoolean ;
         cbChangePassFirst.Checked := FieldByname('USE_ChangeStart').AsBoolean ;
         edtUserStartDate.Date     := FieldByname('USE_UserStart').AsDateTime ;
         edtUserEndTime.Date       := FieldByname('USE_UserEnd').AsDateTime ;
         edtPassStartDate.Date     := FieldByname('USE_PassStart').AsDateTime ;
         edtPassEndDate.Date       := FieldByname('USE_PassEnd').AsDateTime ;
         cbSex.ItemIndex := FieldByname('USE_Sex').AsInteger ;

         Active := false ;
         Free ;
       end;

end;

Procedure TfrmUserMaster.ClearScreen() ;
begin
         edtUserID.Text            := '' ;
         edtName.Text              := '' ;
         edtLastName.Text          := '' ;
         edtPass.Text              := '' ;
         edtConfirmPass.Text       := '' ;
         cbUserNever.Checked       := False ;
         cbPassNever.Checked       := False ;
         cbCanChangePass.Checked   := False ;
         cbCanCreateUser.Checked   := False ;
         cbUserLock.Checked        := False ;
         cbCanPermission.Checked   := False ;
         cbChangePassFirst.Checked := False ;
         edtUserStartDate.Date     := Date ;
         edtUserEndTime.Date       := Date ;
         edtPassStartDate.Date     := Date ;
         edtPassEndDate.Date       := Date ;
end;

procedure TfrmUserMaster.edtUserIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_Return) then SelectNext(ActiveControl,true,true) ;
end;

procedure TfrmUserMaster.cbUserNeverClick(Sender: TObject);
begin
  if(cbUserNever.Checked) then
   begin
    edtUserStartDate.ReadOnly := true ;
    edtUserEndTime.ReadOnly   := true ;
   end else
   begin
     edtUserStartDate.ReadOnly := false ;
     edtUserEndTime.ReadOnly   := false ;
   end;
end;

procedure TfrmUserMaster.cbPassNeverClick(Sender: TObject);
begin
  if(cbPassNever.Checked) then
   begin
    edtPassStartDate.ReadOnly := true ;
    edtPassEndDate.ReadOnly := true ;
   end else
   begin
    edtUserStartDate.ReadOnly := false ;
    edtPassEndDate.ReadOnly := false ;
   end;
end;

procedure TfrmUserMaster.RzGroup1Items0Click(Sender: TObject);

begin
    SaveUser() ;
    frmUserMaster.Close;

end;

Procedure TfrmUserMaster.SaveUser();
var DBSave : TADOQuery ;
    Pass1, Pass2 : String ;
begin

  if(Length(trim(edtUserID.Text)) < fMinDigitUser) then
    begin
      MessageDlg('จำนวนตัวอักษรผู้ใช้น้อยกว่าที่กำหนด',mtWarning,[mbOk],0);
      edtUserID.SetFocus ; Exit ;
    end ;

  if(Length(trim(edtPass.Text)) < fMinDigitPass) then
    begin
      MessageDlg('จำนวนรหัสผ่านน้อยกว่าที่กำหนด',mtWarning,[mbOk],0);
      edtPass.SetFocus ; Exit ;
    end ;
     Pass1 := TripleDESEncryptStringEx(trim(edtPass.Text),Key128,true) ;
     Pass2 := TripleDESEncryptStringEx(trim(edtConfirmPass.Text),Key128,true) ;

   if(Pass1 <> Pass2) then
     begin
      MessageDlg('การยืนยันรหัสผ่านไม่ถูกต้อง',mtWarning,[mbOk],0);
      edtConfirmPass.SetFocus ; Exit ;
     end;

   if(edtUserEndTime.Date < edtUserStartDate.Date) then
     begin
      MessageDlg('วันที่สิ้นสุดไม่ถูกต้อง',mtWarning,[mbOk],0);
      edtUserEndTime.SetFocus ; Exit ;
     end;

   if(edtPassEndDate.Date < edtPassStartDate.Date) then
     begin
      MessageDlg('วันที่สิ้นสุดไม่ถูกต้อง',mtWarning,[mbOk],0);
      edtPassEndDate.SetFocus ; Exit ;
     end;


   DBSave := TADOQuery.Create(nil);
   if(fMode = 'NEW') then
     begin
        with DBSave do
          begin
            Connection := frmDataCenter.ADOConnection1 ;
            SQL.Clear ;
            SQL.Text := ' Insert into DBUserMaster '+
                        ' ( '+
                        ' USE_ID, USE_Name, USE_LastName, USE_Passkey, USE_UserNeverUsed, '+
                        ' USE_PassNeverUsed, USE_CanChangePass, USE_CanCreateUser,  USE_Lock, '+
                        ' USE_CanPermission, USE_ChangeStart, USE_UserStart, USE_UserEnd, USE_PassStart, USE_PassEnd, USE_SEX '+
                        ' ) '+
                        ' Values '+
                        ' ( '+
                        QuotedStr(TripleDESEncryptStringEx(trim(edtUserID.Text),Key128,true))+','+
                        QuotedStr(trim(edtName.Text))+','+
                        QuotedStr(trim(edtLastName.Text))+','+
                        QuotedStr(TripleDESEncryptStringEx(trim(edtPass.Text),Key128,true))+',' ;
                        if(cbUserNever.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
                        if(cbPassNever.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
                        if(cbCanChangePass.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
                        if(cbCanCreateUser.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
                        if(cbUserLock.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
                        if(cbCanPermission.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
                        if(cbChangePassFirst.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';
//                        if(cbChangePassFirst.Checked) then SQL.Text := SQL.Text+'1,' else SQL.Text := SQL.Text+'0,';

                        SQL.Text := SQL.Text+QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtUserStartDate.Date))+','+
                        QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtUserEndTime.Date))+','+
                        QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtPassStartDate.Date))+','+
                        QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtPassEndDate.Date))+','+
                        IntToStr(cbSex.ItemIndex)+
                        ' ) ' ;
                   ExecSQL ;
                   Free ;
 
          end;
     end else
     if(fMode = 'EDIT') then
     begin
        with DBSave do
          begin
            Connection := frmDataCenter.ADOConnection1 ;
            SQL.Clear ;
            SQL.Text := ' Update  DBUserMaster '+
                        ' Set '+
                        ' USE_Name = '+QuotedStr(trim(edtName.Text))+','+
                        ' USE_LastName = '+QuotedStr(trim(edtLastName.Text))+','+
                        ' USE_Passkey  = '+QuotedStr(TripleDESEncryptStringEx(trim(edtPass.Text),Key128,true))+',' ;

                        if(cbUserNever.Checked) then SQL.Text := SQL.Text+' USE_UserNeverUsed = 1,' else SQL.Text := SQL.Text+' USE_UserNeverUsed = 0,';
                        if(cbPassNever.Checked) then SQL.Text := SQL.Text+' USE_PassNeverUsed = 1,' else SQL.Text := SQL.Text+' USE_PassNeverUsed = 0,';
                        if(cbCanChangePass.Checked) then SQL.Text := SQL.Text+' USE_CanChangePass = 1,' else SQL.Text := SQL.Text+' USE_CanChangePass = 0,';
                        if(cbCanCreateUser.Checked) then SQL.Text := SQL.Text+'USE_CanCreateUser = 1,' else SQL.Text := SQL.Text+'USE_CanCreateUser = 0,';
                        if(cbUserLock.Checked) then SQL.Text := SQL.Text+'USE_Lock = 1,' else SQL.Text := SQL.Text+'USE_Lock = 0,';
                        if(cbCanPermission.Checked) then SQL.Text := SQL.Text+'USE_CanPermission = 1,' else SQL.Text := SQL.Text+'USE_CanPermission = 0,';
                        if(cbChangePassFirst.Checked) then SQL.Text := SQL.Text+'USE_ChangeStart = 1,' else SQL.Text := SQL.Text+'USE_ChangeStart = 0,';
                        SQL.Text := SQL.Text +
                        ' USE_UserStart = '+QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtUserStartDate.Date))+','+
                        ' USE_UserEnd = '+QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtUserEndTime.Date))+','+
                        ' USE_PassStart = '+QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtPassStartDate.Date))+','+
                        ' USE_PassEnd = '+QuotedStr(formatdatetime('yyyy-mm-dd 00:00',edtPassEndDate.Date))+','+
                        //' USE_SEX = '+IntToStr(cbSex.ItemIndex) ;

                        ' USE_SEX = '+IntToStr(cbSex.ItemIndex)+
                        ' Where USE_Name = ' +QuotedStr(trim(edtName.Text));

                   ExecSQL ;

          end;
     end;
end;



procedure TfrmUserMaster.RzGroup1Items1Click(Sender: TObject);
begin
   if(fMode = 'NEW') then Exit ;
   if(frmChangePassword = nil) then Application.CreateForm(TfrmChangePassword,frmChangePassword) else
      frmChangePassword := TfrmChangePassword.Create(nil);
      frmChangePassword.UserID := trim(edtUserID.Text) ;
      frmChangePassword.ShowModal ;
      ShowScreen ;
end;

procedure TfrmUserMaster.RzGroup1Items3Click(Sender: TObject);
begin
    if(frmAdvanceConfig = nil) then Application.CreateForm(TfrmAdvanceConfig,frmAdvanceConfig) else
      frmAdvanceConfig := TfrmAdvanceConfig.Create(nil);
      frmAdvanceConfig.ShowModal ;
end;

procedure TfrmUserMaster.RzGroup1Items4Click(Sender: TObject);
begin
   frmUserMaster.Close;
end;

procedure TfrmUserMaster.FormActivate(Sender: TObject);
begin
   GetAdvanceUser();
end;

procedure TfrmUserMaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
