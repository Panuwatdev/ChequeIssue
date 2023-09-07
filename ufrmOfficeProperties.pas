unit ufrmOfficeProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SUIForm, RzGroupBar, ExtCtrls, RzPanel, StdCtrls, Mask, RzEdit,
  RzLabel, SUIButton, ImgList, DB, ADODB;
type TfOfficeResult = (orAccept, orCancel) ;
type
  TfrmOfficeProperties = class(TForm)
    RzPanel1: TRzPanel;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    RzLabel5: TRzLabel;
    edtBankID: TRzEdit;
    edtBankThaiDescr: TRzEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    edtBankEngDescr: TRzEdit;
    RzLabel3: TRzLabel;
    edtBankAddr1: TRzEdit;
    edtBankAddr2: TRzEdit;
    cbDefault: TsuiCheckBox;
    RzPanel2: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    ImageList1: TImageList;
    procedure edtBankIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBankIDKeyPress(Sender: TObject; var Key: Char);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure cbDefaultClick(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fOfficeID : String ;
    fMode : String ;
    fOfficeResult : TfOfficeResult ;
    fCreateBank    : Boolean ;
    fEditBank      : Boolean ;

    Procedure StartOffice(inOfficeID : String) ;
    Procedure ClearScreen();
    Procedure ShowScreen();
    Function CheckBankID(inBankID : String) : Boolean ;
    Function CheckDefault(inBankID : String) : Boolean ;
    Procedure ChangetoDefault(inBankID : String) ;
    procedure LoadPermission();

  public
    { Public declarations }
  Published
    Property OfficeID : String Read fOfficeID write StartOffice ;
    Property OfficeResult : TfOfficeResult read  fOfficeResult ;
  end;

var
  frmOfficeProperties: TfrmOfficeProperties;

implementation
uses ufrmDatacenter ;

{$R *.dfm}

procedure TfrmOfficeProperties.LoadPermission();
var DBPer : TADOQuery ;
begin
   DBPer := TADOQuery.Create(nil);
     with DBPer do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBUserPermission '+
                     ' Where PER_UserID = '+QuotedStr(frmDataCenter.UserID) +
                     ' and PER_Appication = '+QuotedStr('Bank Data')  ;
         Active := true ;

                fCreateBank         := FieldByName('PER_Create').AsBoolean  ;
                fEditBank           := FieldByName('PER_Modify').AsBoolean  ;
         Active := false ;
         Free ;
       end;

end;


Function TfrmOfficeProperties.CheckBankID(inBankID : String) : Boolean ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBOfficeMaster ' +
                    ' Where HOF_ID = '+QuotedStr(inBankID) ;
        Active := true ;
        if(RecordCount <=0 ) then CheckBankID := false else CheckBankID := true ;
        Active := false ;
        Free ;
      end;
end;

Function TfrmOfficeProperties.CheckDefault(inBankID : String) : Boolean ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBOfficeMaster ' +
                    ' Where HOF_Onwer = 1' ;
        Active := true ;
        if(RecordCount <=0 ) then CheckDefault := false else CheckDefault := true ;
        Active := false ;
        Free ;
      end;
end;

Procedure TfrmOfficeProperties.ChangetoDefault(inBankID : String) ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' update DBOfficeMaster ' +
                    ' Set HOF_Onwer = 0 ' +
                    ' update DBOfficeMaster ' +
                    ' Set HOF_Onwer = 1 ' +

                    ' Where HOF_ID = '+QuotedStr(inBankID) ;
        ExecSQL ;
        Free ;
      end;
end;



Procedure TfrmOfficeProperties.StartOffice(inOfficeID : String);
begin
  fOfficeID := inOfficeID ;
  LoadPermission() ;
  if(trim(inOfficeID) = '') then
    begin
      fMode := 'NEW' ;
      DispName.Caption := 'New Bank';
      edtBankID.ReadOnly := false ;
      ClearScreen();
    end else
    begin
      fMode := 'EDIT' ;
      edtBankID.ReadOnly := true ;

      ShowScreen();
    end;
end;

Procedure TfrmOfficeProperties.ClearScreen();
begin
  edtBankID.Text        := '' ;
  edtBankThaiDescr.Text := '' ;
  edtBankEngDescr.Text  := '' ;
  edtBankAddr1.Text     := '' ;
  edtBankAddr2.Text     := '' ;
  cbDefault.Checked := false ;
end;

Procedure TfrmOfficeProperties.ShowScreen();
var DBShow : TADOQuery ;
begin
    cbDefault.OnClick := nil ;
    DBShow := TADOQuery.Create(nil);
      with DBShow do
        begin
           Connection := frmDataCenter.ADOConnection1 ;
           SQL.Clear ;
           SQL.Text := ' Select * from DBOfficeMaster '+
                       ' Where HOF_ID = '+QuotedStr(fOfficeID) ;
           Active := true ;
             edtBankID.Text         := trim(FieldByname('HOF_ID').AsString) ;
             edtBankThaiDescr.Text  := trim(FieldByname('HOF_LocalDescr').AsString) ;
             edtBankEngDescr.Text   := trim(FieldByname('HOF_InternationsDescr').AsString) ;
             edtBankAddr1.Text      := trim(FieldByname('HOF_Address1').AsString) ;
             edtBankAddr2.Text      := trim(FieldByname('HOF_Address2').AsString) ;
             if(FieldByname('HOF_Onwer').AsInteger = 1) then  cbDefault.Checked := true else cbDefault.Checked := false ;
             DispName.Caption := trim(FieldByname('HOF_ID').AsString) +' '+trim(FieldByname('HOF_LocalDescr').AsString) ;
             Active := false ;
             Free ;

            cbDefault.OnClick := cbDefaultClick ;

        end;
end;

procedure TfrmOfficeProperties.edtBankIDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_Return) then SelectNext(ActiveControl,true,true) ;
end;

procedure TfrmOfficeProperties.edtBankIDKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmOfficeProperties.RzGroup1Items0Click(Sender: TObject);
var DBSave : TADOQuery ;
begin
//
//   if(fMode = 'NEW') and fCreateBank then
//     begin
//       MessageDlg('ต้องใส่รหัสธนาคาร จำนวน 4 หลัก',mtError,[mbOk],0) ;
//     end;


   if(trim(edtBankID.Text) = '' ) or (Length(edtBankID.Text) < 3) then
     begin
       MessageDlg('ต้องใส่รหัสธนาคาร จำนวน 4 หลัก',mtError,[mbOk],0) ;
       edtBankID.SetFocus ; Exit ;
     end;
   if(fMode = 'NEW') then
     begin
       if(CheckBankID(trim(edtBankID.Text))) then
         begin
           MessageDlg('มีการใช้รหัสนี้แล้ว',mtError,[mbOk],0)  ;
           edtBankID.SetFocus ; Exit ;
         end;
           DBSave := TADOQuery.Create(nil);
            with DBSave do
              begin
                Connection := frmDataCenter.ADOConnection1 ;
                SQL.Clear ;
                SQL.Text := ' Insert into DBOfficeMaster '+
                            ' ( ' +
                            ' HOF_ID, HOF_InternationsDescr, HOF_LocalDescr, HOF_Address1, HOF_Address2, '+
                            ' HOF_Region, HOF_City, HOF_Onwer '+
                            ' ) '+
                            ' Values ( '+
                            QuotedStr(trim(edtBankID.Text))+',' +
                            QuotedStr(trim(edtBankEngDescr.Text))+',' +
                            QuotedStr(trim(edtBankThaiDescr.Text))+',' +
                            QuotedStr(trim(edtBankAddr1.Text))+',' +
                            QuotedStr(trim(edtBankAddr2.Text))+',' +
                            QuotedStr('')+',' +
                            QuotedStr('')+',' ;

                            if(cbDefault.Checked) then
                              begin
                                SQL.Text := SQL.Text + '1' ;
                                ChangetoDefault(trim(edtBankID.Text))   ;
                              end else
                              begin
                                SQL.Text := SQL.Text + '0' ;
                              end ;

                              SQL.Text := SQL.Text + ')' ;
                     ExecSQL ;
                     Free ;
              end;
     end  else if(fMode = 'EDIT') then
     begin
           DBSave := TADOQuery.Create(nil);
            with DBSave do
              begin
                Connection := frmDataCenter.ADOConnection1 ;
                SQL.Clear ;
                SQL.Text := ' Update DBOfficeMaster '+
                            ' Set  ' +
                            ' HOF_InternationsDescr = '+QuotedStr(trim(edtBankEngDescr.Text))+',' +
                            ' HOF_LocalDescr = '+QuotedStr(trim(edtBankThaiDescr.Text))+',' +
                            ' HOF_Address1 = '+QuotedStr(trim(edtBankAddr1.Text))+',' +
                            ' HOF_Address2 = '+QuotedStr(trim(edtBankAddr2.Text))+',' +
                            ' HOF_Region = '+  QuotedStr('')+',' +
                            ' HOF_City = '+ QuotedStr('')+',' ;

                            if(cbDefault.Checked) then
                              begin
                                SQL.Text := SQL.Text + ' HOF_Onwer = 1' ;
                                ChangetoDefault(trim(edtBankID.Text))   ;
                              end else
                              begin
                                SQL.Text := SQL.Text + ' HOF_Onwer = 0' ;
                              end ;
                            SQL.Text := SQL.Text + ' Where HOF_ID = '+QuotedStr(trim(edtBankID.Text)) ;

                     ExecSQL ;
                     Free ;
              end;
     end;
  fOfficeID := trim(edtBankID.Text)+#10#13+trim(edtBankThaiDescr.Text) ;
  fOfficeResult := orAccept ;
  frmOfficeProperties.Close ;


end;

procedure TfrmOfficeProperties.cbDefaultClick(Sender: TObject);
begin
  if(not cbDefault.Checked) then Exit ;
  if(MessageDlg('การเลือก Default จะมีผลให้ ธนาคารนี้เป็นธนาคารที่ท่านตั้งเป็นธนาคารทำการแทนธนาคารอื่น ๆ',mtConfirmation,[mbYes,MbNo],0) = mrYes) then
    begin
      cbDefault.Checked := true ;
    end else
    begin
      cbDefault.Checked := false ;
    end ;
end;

procedure TfrmOfficeProperties.RzGroup1Items1Click(Sender: TObject);
begin
   fOfficeResult := orCancel ;
   frmOfficeProperties.Close ;
end;

procedure TfrmOfficeProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

end.
