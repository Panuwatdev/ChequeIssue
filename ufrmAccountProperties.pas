unit ufrmAccountProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SUIButton, StdCtrls, RzLabel, Mask, RzEdit, SUIForm, RzGroupBar,
  ExtCtrls, RzPanel, ImgList, DB, ADODB ;
type TfAccResult = (arAccept, arCancel);
type
  TfrmAccountProperties = class(TForm)
    RzPanel1: TRzPanel;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    RzPanel2: TRzPanel;
    suiForm1: TsuiForm;
    edtAccountNo: TRzEdit;
    RzLabel5: TRzLabel;
    RzLabel1: TRzLabel;
    edtAccountName: TRzEdit;
    RzLabel2: TRzLabel;
    edtAccountAddr1: TRzEdit;
    edtAccountAddr2: TRzEdit;
    edtAccountTel: TRzEdit;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    edtAccountMobile: TRzEdit;
    RzLabel6: TRzLabel;
    edtAccountEmail: TRzEdit;
    cbAmountDisCount: TsuiCheckBox;
    cbPersentDiscount: TsuiCheckBox;
    RzPanel3: TRzPanel;
    Image1: TImage;
    ImageList1: TImageList;
    RzLabel7: TRzLabel;
    EdCmf: TRzEdit;
    EdCcy: TRzEdit;
    RzLabel8: TRzLabel;
    procedure edtAccountNoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAccountNoKeyPress(Sender: TObject; var Key: Char);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    fMode : String ;
    fAccountID : String ;  
    fBankID : String ;
    fBRNID : String ;
    fAccResult : TfAccResult ;

    fAccessBank      : Boolean ;
    fAccessBRN       : Boolean ;
    fAccessAccount   : Boolean ;


    fCreateBank      : Boolean ;
    fCreateBRN       : Boolean ;
    fCreateAccount   : Boolean ;

    fEditBank      : Boolean ;
    fEditBRN       : Boolean ;
    fEditAccount   : Boolean ;

    fDeleteBank      : Boolean ;
    fDeleteBRN       : Boolean ;
    fDeleteAccount   : Boolean ;

    Procedure StartAccount(inAccID : string) ;
    Procedure ShowScreen() ;
    Procedure ClearScreen();

    procedure LoadPermission();
  public
    { Public declarations }
  Published
    Property AccountID : String Read fAccountID Write StartAccount ;
    Property BankID : String Read fBankID Write fBankID ;
    Property BRNID  : String Read fBRNID Write fBRNID ;
    Property AccResult : TfAccResult read fAccResult ;

  end;

var
  frmAccountProperties: TfrmAccountProperties;

implementation
uses ufrmDatacenter , ufrmImportAccount, ufrmAccountMaster;

{$R *.dfm}

procedure TfrmAccountProperties.edtAccountNoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = Vk_return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmAccountProperties.edtAccountNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

Procedure TfrmAccountProperties.StartAccount(inAccID : String);
begin

  fAccountID := inAccID ;
  fAccResult := arCancel ;
  if(Trim(inAccID) = '') then
    begin
      fMode := 'NEW' ;
      ClearScreen ;
      edtAccountNo.ReadOnly := false ;
    end else
    begin
      fMode := 'EDIT' ;
      ShowScreen ;
      edtAccountNo.ReadOnly := true ;
    end ;
end;

Procedure TfrmAccountProperties.ShowScreen();
var DBAcc : TADOQuery ;
begin
   DBAcc := TADOQuery.Create(nil);
     with DBAcc do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBAccountMaster '+
                     ' Where ACC_ID = '+QuotedStr(fAccountID) +
                     ' and '+
                     ' ACC_Office = '+QuotedStr(fBankID)+
                     ' and '+
                     ' ACC_Branch = '+QuotedStr(fBRNID) ;
        Active := true ;

        edtAccountNo.Text      := trim(FieldByname('ACC_ID').AsString) ;
        edtAccountName.Text    := trim(FieldByname('ACC_Description').AsString) ;
        edtAccountAddr1.Text   := trim(FieldByname('ACC_Address1').AsString) ;
        edtAccountAddr2.Text   := trim(FieldByname('ACC_Address2').AsString) ;
        edtAccountTel.Text     := trim(FieldByname('ACC_Tel').AsString) ;
        edtAccountMobile.Text  := trim(FieldByname('ACC_Mobile').AsString) ;
        edtAccountEmail.Text   := trim(FieldByname('ACC_EMail').AsString) ;
        EdCmf.Text             := trim(FieldByname('ACC_Cmf').AsString) ;
        EdCcy.Text             := trim(FieldByname('ACC_Ccy').AsString) ;

        if(trim(FieldByname('ACC_Discount').AsString) = 'P') then cbPersentDiscount.Checked := true else
        if(trim(FieldByname('ACC_Discount').AsString) = 'A') then cbAmountDisCount.Checked  := true ;

       end;
end ;

Procedure TfrmAccountProperties.ClearScreen();
begin
    edtAccountNo.Text      := '' ;
    edtAccountName.Text    := '' ;
    edtAccountAddr1.Text   := '' ;
    edtAccountAddr2.Text   := '' ;
    edtAccountTel.Text     := '' ;
    edtAccountMobile.Text  := '' ;
    edtAccountEmail.Text   := '' ;
    cbPersentDiscount.Checked := false ;
    cbAmountDisCount.Checked  := false ;

end;
procedure TfrmAccountProperties.RzGroup1Items0Click(Sender: TObject);
var DBAcc : TADOQuery ;
begin
  if(trim(edtAccountNo.Text) = '') then
    begin
      MessageDlg('เลขที่บัญชีเป็นช่องว่าง',mtWarning,[mbOk],0);
      edtAccountNo.SetFocus ; Exit ;
    end;

  if(trim(edtAccountNo.Text) = '') then
    begin
      MessageDlg('ชื่อบัญชีเป็นช่องว่าง',mtWarning,[mbOk],0);
      edtAccountName.SetFocus ; Exit ;
    end;
    DBAcc := TADOQuery.Create(nil);
    if(fMode = 'NEW') then
     begin
      with DBAcc do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Insert into DBAccountMaster ' +
                      ' ( '+
                      ' ACC_ID, ACC_Description, ACC_Address1, ACC_Address2, '+
                      ' ACC_Mobile,	ACC_Tel, ACC_EMail, ACC_Cmf, ACC_Ccy,	ACC_Office, ACC_Branch, '+
                      ' ACC_Discount '+
                      ' ) '+
                      ' Values '+
                      ' ( '+
                      QuotedStr(trim(edtAccountNo.Text))+','+
                      QuotedStr(trim(edtAccountName.Text))+','+
                      QuotedStr(trim(edtAccountAddr1.Text))+','+
                      QuotedStr(trim(edtAccountAddr2.Text))+','+
                      QuotedStr(trim(edtAccountMobile.Text))+','+
                      QuotedStr(trim(edtAccountTel.Text))+','+
                      QuotedStr(trim(edtAccountEmail.Text))+','+
                      QuotedStr(trim(EdCmf.Text))+','+
                      QuotedStr(trim(EdCcy.Text))+','+
                      QuotedStr(trim(fBankID))+','+
                      QuotedStr(trim(fBRNID))+',' ;
                      if(not cbAmountDisCount.Checked) and (not cbPersentDiscount.Checked) then SQL.Text := SQL.Text + QuotedStr('N') else
                      if(cbAmountDisCount.Checked) and (not cbPersentDiscount.Checked) then SQL.Text := SQL.Text + QuotedStr('A') else
                      if(not cbAmountDisCount.Checked) and(cbPersentDiscount.Checked) then SQL.Text := SQL.Text + QuotedStr('P') ;
                     SQL.Text := SQL.Text + ' ) ' ;
 //                    showmessage(SQL.text) ;
          ExecSQL ;
          Free ;
        end;
      end else if(fMode = 'EDIT') then
      begin
        with DBAcc do
          begin
            Connection := frmDataCenter.ADOConnection1 ;
            SQL.Clear ;
            SQL.Text := ' update DBAccountMaster ' +
                        ' Set '+
                        ' ACC_Description = '+QuotedStr(trim(edtAccountName.Text))+','+
                        ' ACC_Address1 = '+QuotedStr(trim(edtAccountAddr1.Text))+','+
                        ' ACC_Address2 = '+QuotedStr(trim(edtAccountAddr2.Text))+','+
                        ' ACC_Mobile = '+QuotedStr(trim(edtAccountMobile.Text))+','+
                        '	ACC_Tel = '+QuotedStr(trim(edtAccountTel.Text))+','+
                        ' ACC_EMail = '+QuotedStr(trim(edtAccountEmail.Text))+','+
                        ' ACC_Cmf = '+QuotedStr(trim(EdCmf.Text))+','+ 
                        ' ACC_Ccy = '+QuotedStr(trim(EdCcy.Text))+',' ;
                        if(not cbAmountDisCount.Checked) and (not cbPersentDiscount.Checked) then SQL.Text := SQL.Text + 'ACC_Discount ='+QuotedStr('N') else
                        if(cbAmountDisCount.Checked) and (not cbPersentDiscount.Checked) then SQL.Text := SQL.Text + 'ACC_Discount ='+QuotedStr('A') else
                        if(not cbAmountDisCount.Checked) and (cbPersentDiscount.Checked) then SQL.Text := SQL.Text + 'ACC_Discount ='+QuotedStr('P') ;
                        SQL.Text := SQL.Text +
                        ' Where ACC_ID = '+QuotedStr(fAccountID) +
                        ' and '+
                        ' ACC_Office = '+QuotedStr(fBankID) +
                        ' and '+
                        ' ACC_Branch = '+QuotedStr(fBRNID) ;

             ExecSQL ;
             Free;
        end;
      end;
     fAccResult := arAccept ;
     fAccountID := trim(edtAccountNo.Text)+' '+trim(edtAccountName.Text)  ;
     frmAccountProperties.Close ;

     //ListAccount2();
    //frmAccountMaster.ListAccount2();
end;

procedure TfrmAccountProperties.RzGroup1Items2Click(Sender: TObject);
begin
  fAccResult := arCancel ;
  frmAccountProperties.Close ;
end;

procedure TfrmAccountProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

procedure TfrmAccountProperties.RzGroup1Items1Click(Sender: TObject);
begin
   if(not fCreateAccount) then
    begin
      MessageDlg('xxxxxxx',mtWarning,[mbOk],0) ;
      exit ;
    end;

    //if(ViewBRN.Selected = nil) then Exit ;
    if(frmImportAccount = nil) then Application.CreateForm(TfrmImportAccount,frmImportAccount) else
      frmImportAccount := TfrmImportAccount.Create(nil);
      //frmAccountProperties.BankID := Copy(ViewBank.Selected.Caption,1,3) ;
      //frmAccountProperties.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
      //frmAccountProperties.AccountID := '' ;

      frmAccountProperties.Close ;

      frmImportAccount.ShowModal ;

end;

procedure TfrmAccountProperties.FormActivate(Sender: TObject);
begin
   LoadPermission() ;
end;

procedure TfrmAccountProperties.LoadPermission();
var DBPer : TADOQuery ;
begin
   DBPer := TADOQuery.Create(nil);
     with DBPer do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBUserPermission '+
                     ' Where PER_UserID = '+QuotedStr(frmDataCenter.UserID);
         Active := true ;
          while not eof do
            begin
              if(trim(FieldByName('PER_Appication').AsString) = 'Bank Data') then
                begin
                   fAccessBank         := FieldByName('PER_Access').AsBoolean  ;
                   fCreateBank         := FieldByName('PER_Create').AsBoolean  ;
                   fEditBank           := FieldByName('PER_Modify').AsBoolean  ;
                   fDeleteBank         := FieldByName('PER_Delete').AsBoolean  ;
                end else
              if(trim(FieldByName('PER_Appication').AsString) = 'BRN Data') then
                  begin
                   fAccessBRN          := FieldByName('PER_Access').AsBoolean  ;
                   fCreateBRN          := FieldByName('PER_Create').AsBoolean  ;
                   fEditBRN            := FieldByName('PER_Modify').AsBoolean  ;
                   fDeleteBRN          := FieldByName('PER_Delete').AsBoolean  ;
                  end else
              if(trim(FieldByName('PER_Appication').AsString) = 'Account Data') then
                 begin
                   fAccessAccount          := FieldByName('PER_Access').AsBoolean  ;
                   fCreateAccount          := FieldByName('PER_Create').AsBoolean  ;
                   fEditAccount            := FieldByName('PER_Modify').AsBoolean  ;
                   fDeleteAccount          := FieldByName('PER_Delete').AsBoolean  ;
                 end ;


              Next ;
           end ;
         Active := false ;
         Free ;
       end;

end;

end.
