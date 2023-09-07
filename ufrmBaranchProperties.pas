unit ufrmBaranchProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, ExtCtrls, SUIForm, RzGroupBar, SUIButton, StdCtrls,
  Mask, RzEdit, RzLabel, ImgList, DB, ADODB;
type TfBRNResult = (brAccept, brCancel) ;
type
  TfrmBranchProperties = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    RzPanel1: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    RzLabel5: TRzLabel;
    edtBRNID: TRzEdit;
    RzLabel1: TRzLabel;
    edtBRNThaiDescr: TRzEdit;
    edtBRNEngDescr: TRzEdit;
    RzLabel2: TRzLabel;
    edtBRNAddr1: TRzEdit;
    RzLabel3: TRzLabel;
    edtBRNAddr2: TRzEdit;
    cbDefault: TsuiCheckBox;
    ImageList1: TImageList;
    ImageList2: TImageList;
    procedure edtBRNIDKeyPress(Sender: TObject; var Key: Char);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure cbDefaultClick(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtBRNIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fBRNID : String ;
    fMode : String ;
    fBRNResult : TfBRNResult ;
    fBRNOnwer   : String ;
    fCreateBRN    : Boolean ;
    fEditBRN      : Boolean ;
    Procedure StartBRN(inBRNID : String) ;
    Procedure ClearScreen();
    Procedure ShowScreen();
    Function CheckBRNID(inBRNID : String) : Boolean ;
    Function CheckDefault(inBRNID : String) : Boolean ;
    Procedure ChangetoDefault(inBRNID : String) ;
    procedure LoadPermission();
  public
    { Public declarations }
  Published
    Property BRNID : String Read fBRNID write StartBRN ;
    property BRNOnwer : String Read fBRNOnwer write fBRNOnwer ;
    Property BRNResult : TfBRNResult read  fBRNResult ;
  end;

var
  frmBranchProperties: TfrmBranchProperties;

implementation
uses ufrmDatacenter ;
{$R *.dfm}


procedure TfrmBranchProperties.LoadPermission();
var DBPer : TADOQuery ;
begin
   DBPer := TADOQuery.Create(nil);
     with DBPer do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBPermission '+
                     ' Where PER_UserID = '+QuotedStr(frmDataCenter.UserID) +
                     ' and PER_Application = '+QuotedStr('BRN Data')  ;
         Active := true ;

                fCreateBRN         := FieldByName('PER_Create').AsBoolean  ;
                fEditBRN           := FieldByName('PER_Modify').AsBoolean  ;
         Active := false ;
         Free ;
       end;

end;


Function TfrmBranchProperties.CheckBRNID(inBRNID : String) : Boolean ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBBranchesMaster ' +
                    ' Where BOF_ID = '+QuotedStr(inBRNID) +
                    ' and BOF_OnwerOffice = '+QuotedStr(fBRNOnwer);
        Active := true ;
        if(RecordCount <=0 ) then CheckBRNID := false else CheckBRNID := true ;
        Active := false ;
        Free ;
      end;
end;

Function TfrmBranchProperties.CheckDefault(inBRNID : String) : Boolean ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBBranchMaster ' +
                    ' Where BOF_Onwer = 1' +
                    ' and BOF_OnwerOffice = '+QuotedStr(fBRNOnwer);
        Active := true ;
        if(RecordCount <=0 ) then CheckDefault := false else CheckDefault := true ;
        Active := false ;
        Free ;
      end;
end;

Procedure TfrmBranchProperties.ChangetoDefault(inBRNID : String) ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' update DBBranchesMaster ' +
                    ' Set BOF_Onwer = 0 ' +
                    ' update DBBranchMaster ' +
                    ' Set BOF_Onwer = 1 ' +

                    ' Where BOF_ID = '+QuotedStr(inBRNID)+
                    ' and BOF_OnwerOffice = '+QuotedStr(fBRNOnwer); 
        ExecSQL ;
        Free ;
      end;
end;



Procedure TfrmBranchProperties.StartBRN(inBRNID : String);
begin
  fBRNID := inBRNID ;
  fBRNResult := brCancel ;
  if(trim(inBRNID) = '') then
    begin
      fMode := 'NEW' ;
      DispName.Caption := 'New Branch';
      edtBRNID.ReadOnly := false ;
      ClearScreen();
    end else
    begin
      fMode := 'EDIT' ;
      edtBRNID.ReadOnly := true ;

      ShowScreen();
    end;
end;

Procedure TfrmBranchProperties.ClearScreen();
begin
  edtBRNID.Text        := '' ;
  edtBRNThaiDescr.Text := '' ;
  edtBRNEngDescr.Text  := '' ;
  edtBRNAddr1.Text     := '' ;
  edtBRNAddr2.Text     := '' ;
  cbDefault.Checked := false ;
end;

Procedure TfrmBranchProperties.ShowScreen();
var DBShow : TADOQuery ;
begin
    cbDefault.OnClick := nil ;
    DBShow := TADOQuery.Create(nil);
      with DBShow do
        begin
           Connection := frmDataCenter.ADOConnection1 ;
           SQL.Clear ;
           SQL.Text := ' Select * from DBBranchesMaster '+
                       ' Where BOF_ID = '+QuotedStr(fBRNID)+
                       ' and BOF_OnwerOffice = '+QuotedStr(fBRNOnwer);
           Active := true ;
             edtBRNID.Text         := trim(FieldByname('BOF_ID').AsString) ;
             edtBRNThaiDescr.Text  := trim(FieldByname('BOF_LocalDescr').AsString) ;
             edtBRNEngDescr.Text   := trim(FieldByname('BOF_InterNationDescr').AsString) ;
             edtBRNAddr1.Text      := trim(FieldByname('BOF_Address1').AsString) ;
             edtBRNAddr2.Text      := trim(FieldByname('BOF_Address2').AsString) ;
             if(FieldByname('BOF_Onwer').AsInteger = 1) then  cbDefault.Checked := true else cbDefault.Checked := false ;
             DispName.Caption := trim(FieldByname('BOF_ID').AsString) +' '+trim(FieldByname('BOF_LocalDescr').AsString) ;
             Active := false ;
             Free ;

            cbDefault.OnClick := cbDefaultClick ;

        end;
end;



procedure TfrmBranchProperties.edtBRNIDKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmBranchProperties.RzGroup1Items0Click(Sender: TObject);
var DBSave : TADOQuery ;
begin
   if(trim(edtBRNID.Text) = '' ) or (Length(edtBRNID.Text) < 4) then
     begin
       MessageDlg('ต้องใส่รหัสธนาคาร จำนวน 4 หลัก',mtError,[mbOk],0) ;
       edtBRNID.SetFocus ; Exit ;
     end;
   if(fMode = 'NEW') then
     begin
       if(CheckBRNID(trim(edtBRNID.Text))) then
         begin
           MessageDlg('มีการใช้รหัสนี้แล้ว',mtError,[mbOk],0)  ;
           edtBRNID.SetFocus ; Exit ;
         end;
           DBSave := TADOQuery.Create(nil);
            with DBSave do
              begin
                Connection := frmDataCenter.ADOConnection1 ;
                SQL.Clear ;
                SQL.Text := ' Insert into DBBranchesMaster '+
                            ' ( ' +
                            ' BOF_ID, BOF_InterNationDescr, BOF_LocalDescr, BOF_Address1, BOF_Address2, '+
                            ' BOF_Region, BOF_City, BOF_Onwer, BOF_OnwerOffice '+
                            ' ) '+
                            ' Values ( '+
                            QuotedStr(trim(edtBRNID.Text))+',' +
                            QuotedStr(trim(edtBRNEngDescr.Text))+',' +
                            QuotedStr(trim(edtBRNThaiDescr.Text))+',' +
                            QuotedStr(trim(edtBRNAddr1.Text))+',' +
                            QuotedStr(trim(edtBRNAddr2.Text))+',' +
                            QuotedStr('')+',' +
                            QuotedStr('')+',' ;

                            if(cbDefault.Checked) then
                              begin
                                SQL.Text := SQL.Text + '1' ;
                                ChangetoDefault(trim(edtBRNID.Text))   ;
                              end else
                              begin
                                SQL.Text := SQL.Text + '0' ;
                              end ;
                              SQL.Text := SQL.Text + ','+QuotedStr(fBRNOnwer);
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
                SQL.Text := ' Update DBBranchesMaster '+
                            ' Set  ' +
                            ' BOF_InterNationDescr = '+QuotedStr(trim(edtBRNEngDescr.Text))+',' +
                            ' BOF_LocalDescr = '+QuotedStr(trim(edtBRNThaiDescr.Text))+',' +
                            ' BOF_Address1 = '+QuotedStr(trim(edtBRNAddr1.Text))+',' +
                            ' BOF_Address2 = '+QuotedStr(trim(edtBRNAddr2.Text))+',' +
                            ' BOF_Region = '+  QuotedStr('')+',' +
                            ' BOF_City = '+ QuotedStr('')+',' ;

                            if(cbDefault.Checked) then
                              begin
                                SQL.Text := SQL.Text + ' BOF_Onwer = 1' ;
                                ChangetoDefault(trim(edtBRNID.Text))   ;
                              end else
                              begin
                                SQL.Text := SQL.Text + ' BOF_Onwer = 0' ;
                              end ;
                            SQL.Text := SQL.Text + ' Where BOF_ID = '+QuotedStr(trim(edtBRNID.Text))+
                            ' and BOF_OnwerOffice = '+quotedStr(fBRNOnwer) ;

                     ExecSQL ;
                     Free ;
              end;
     end;
  fBRNID := trim(edtBRNID.Text)+#10#13+trim(edtBRNThaiDescr.Text) ;
  fBRNResult := brAccept ;
  frmBranchProperties.Close ;


end;

procedure TfrmBranchProperties.cbDefaultClick(Sender: TObject);
begin
  if(not cbDefault.Checked) then Exit ;
  if(MessageDlg('การเลือก Default จะมีผลให้ สาขานี้เป็นสาขาที่ท่านตั้งเป็นธนาคารทำการแทนธนาคารอื่น ๆ',mtConfirmation,[mbYes,MbNo],0) = mrYes) then
    begin
      cbDefault.Checked := true ;
    end else
    begin


      cbDefault.Checked := false ;
    end ;
end;

procedure TfrmBranchProperties.RzGroup1Items1Click(Sender: TObject);
begin
   fBRNResult := brCancel ;
   frmBranchProperties.Close ;
end;

procedure TfrmBranchProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

procedure TfrmBranchProperties.edtBRNIDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_Return) then SelectNext(ActiveControl,true,true) ;
end;

end.
