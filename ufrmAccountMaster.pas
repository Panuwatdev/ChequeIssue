unit ufrmAccountMaster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, ComCtrls, SUIListView, RzPanel, ImgList,
  Menus, SUIPopupMenu, DB, ADODB, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxImageComboBox,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, cxCheckBox, SUIButton,
  StdCtrls, SUIEdit ;

type
  TfrmAccountMaster = class(TForm)
    suiForm1: TsuiForm;
    ViewBRN: TsuiListView;
    ViewBank: TsuiListView;
    RzPanel1: TRzPanel;
    ViewAcc: TsuiListView;
    ImageList1: TImageList;
    suiPopupMenu1: TsuiPopupMenu;
    suiPopupMenu2: TsuiPopupMenu;
    suiPopupMenu3: TsuiPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    ViewAcc2: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    DBACCL: TADOQuery;
    ViewAcc2ACC_ID: TcxGridDBColumn;
    ViewAcc2ACC_Description: TcxGridDBColumn;
    ViewAcc2DBColumn1: TcxGridDBColumn;
    Commission1: TMenuItem;
    Panel1: TPanel;
    edtAccountID: TsuiEdit;
    btSerch: TsuiButton;
    procedure N1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ViewBankDblClick(Sender: TObject);
    procedure ViewBankClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure ViewBRNDblClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure ViewBRNClick(Sender: TObject);
    procedure ViewBRNSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure ViewBRNChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure Commission1Click(Sender: TObject);
    procedure edtAccountIDChange(Sender: TObject);
    procedure btSerchClick(Sender: TObject);
  private
    { Private declarations }
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

    Procedure ListBank() ;
    Procedure ListBranches();
    Procedure ListAccount();

    Procedure ListAccount2();

    Function CheckBranch() : Boolean ;
    Function CheckDefault(inBankID : String) : Boolean ;
    Function CheckBRNDefault(inBRNID : String) : Boolean ;
    Procedure ChangetoDefault(inBankID : String) ;
//    Procedure ChangeBRNtoDefault(inBRNID : String) ;
    Procedure ChangeIcons(inBankID : String);
    Procedure ChangeBRNIcons(inBRNID : String);
    Function CheckHaveunt() : Boolean ;
    procedure LoadPermission();



  public
    { Public declarations }
  end;

type TfListAccTR = Class(TThread)
  Private
     inDataOBJ : TStringList ;
     inViewOBJ : TsuiListView ;
  Protected
    procedure Execute; override ;

  Public
    Constructor Create(ViewOBJ : TsuiListView) ;
end;

var
  frmAccountMaster: TfrmAccountMaster;

implementation

uses ufrmDatacenter,ufrmAccountProperties, ufrmOfficeProperties,
  ufrmBaranchProperties, ufrmImportAccount, UUpdCmms;

{$R *.dfm}

procedure TfrmAccountMaster.LoadPermission();
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

Constructor TfListAccTR.Create(ViewOBJ : TsuiListView);
begin
//   inDataOBJ := DataOBJ ;
   inViewOBJ := ViewOBJ ;
   FreeOnTerminate := true ;
   inherited Create(false);
end;

Procedure TfListAccTR.Execute();
var DBAcc : TADOQuery ;
    Aitem : TListItem ;
begin
//  inViewOBJ := TsuiListView.Create(nil);
  inViewOBJ.Items.Clear ;
  DBAcc := TADOQuery.Create(nil);
    with DBAcc do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBAccountMaster '+
                    ' Where ACC_Office = '+QuotedStr(Copy(frmAccountMaster.ViewBank.Selected.Caption,1,3)) +
                    ' and '+
                    ' ACC_Branch = '+QuotedStr(Copy(frmAccountMaster.ViewBRN.Selected.Caption,1,4)) ;
        Active := true ;
         while not eof do
           begin
             AItem := inViewOBJ.Items.Add ;
             AItem.Caption := trim(FieldByname('ACC_ID').AsString)+#10#13+trim(FieldByname('ACC_Description').AsString) ;
             AItem.ImageIndex := 6 ;
             AItem.Selected := true ;
            // Application.ProcessMessages ;
             Next ;
           end;
         Active := false ;
         Free ;
      end;
end;

Procedure TfrmAccountMaster.ListBank();
var DBList : TADOQuery ;
    items1 : TListItem ;
begin
   DBList := TADOQuery.Create(nil);
   ViewBank.Items.Clear ;
     with DBList do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select HOF_ID,HOF_LocalDescr,HOF_Onwer from DBOfficeMaster ' ;
        Active := true ;
        while not eof do
          begin

            items1 := ViewBank.Items.Add ;

//            items1.Checked := true ;
            items1.Caption := trim(FieldByname('HOF_ID').AsString) +#10#13+ trim(FieldByname('HOF_LocalDescr').AsString) ;
            if(FieldByname('HOF_Onwer').AsInteger = 0) then
               begin
                items1.ImageIndex := 0 ;
               end else
               begin
                items1.ImageIndex := 1 ;

               end;
               items1.Selected := true ;
            Next ;
          end;
        Active := false ;
        Free ;
      end;
end;

Procedure TfrmAccountMaster.ListBranches();
var DBBRNList : TADOQuery ;
    IBRN : TListItem  ;
    Default : Integer ;
    Rec : Integer ;
begin
   ViewBRN.Items.Clear ;
   REc := 1 ;
   DBBRNList := TADOQuery.Create(nil);
     with DBBRNList do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQl.Clear  ;
        SQL.Text := ' Select * from DBBranchesMaster '+
                    ' Where BOF_OnwerOffice = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3))  ;
        Active := true ;
         while not eof do
           begin
              IBRN := ViewBRN.Items.Add ;
              IBRN.Caption := trim(FieldByName('BOF_ID').AsString)+#10#13+trim(FieldByName('BOF_LocalDescr').AsString) ;

              if(FieldByname('BOF_Onwer').AsInteger = 0) then IBRN.ImageIndex := 2 else
              if(FieldByname('BOF_Onwer').AsInteger = 1) then
                begin
                 IBRN.ImageIndex := 3  ;
                 Default := Rec ;
                end;
                Rec := Rec + 1 ;
                IBRN.Selected := true ;
             Next ;
           end;
        Active := false ;
        Free ;
      end;
     // if() ViewBRN.Items.Item[Default].Selected := true ;
end;

procedure TfrmAccountMaster.N1Click(Sender: TObject);
begin
   if(not fCreateBank) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้สร้างธนาคารได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
   if(frmOfficeProperties = nil) then Application.CreateForm(TfrmOfficeProperties,frmOfficeProperties) else
      frmOfficeProperties := TfrmOfficeProperties.Create(nil);
      frmOfficeProperties.OfficeID := '' ;
      frmOfficeProperties.ShowModal ;

      if(frmOfficeProperties.OfficeResult = orAccept) then
        begin
          ViewBank.Items.Add ;
          ViewBank.Items.Item[ViewBank.Items.Count-1].Caption := frmOfficeProperties.OfficeID ;
          ViewBank.Items.Item[ViewBank.Items.Count-1].ImageIndex := 0 ;

        end;
      if(CheckDefault(frmOfficeProperties.OfficeID)) then ChangeIcons(frmOfficeProperties.OfficeID);
end;

procedure TfrmAccountMaster.FormActivate(Sender: TObject);
var Rec : Integer ;
begin
// if()
  ListBank ;
  LoadPermission() ;


  if(ViewBank.Items.Count > 0) then
    begin
      for Rec := 0 to ViewBank.Items.Count-1 do
        begin
          if(ViewBank.Items.Item[Rec].ImageIndex = 1) then
            begin
              ViewBank.Items.Item[Rec].Selected := true ;
              ListBranches ;
              Break ;
            end;
        end;
    end;

  if(ViewBRN.Items.Count > 0) then
    begin
      for Rec := 0 to ViewBRN.Items.Count-1 do
        begin
          if(ViewBRN.Items.Item[Rec].ImageIndex = 3) then
            begin
              ViewBRN.Items.Item[Rec].Selected := true ;
              ListAccount ;
              Break ;
            end;
        end;
    end;


end;

procedure TfrmAccountMaster.N2Click(Sender: TObject);
begin
   if(not fAccessBank) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าถึงธนาคารได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
    
   if(frmOfficeProperties = nil) then Application.CreateForm(TfrmOfficeProperties,frmOfficeProperties) else
      frmOfficeProperties := TfrmOfficeProperties.Create(nil);

      if(ViewBank.Selected <> nil) then
      begin
        frmOfficeProperties.OfficeID := Copy(ViewBank.Selected.Caption,1,3) ;
        frmOfficeProperties.ShowModal ;
      end
      else
      ShowMessage('Please select Bank');  


end;

procedure TfrmAccountMaster.N3Click(Sender: TObject);
var DBDel : TADOQuery ;
begin
   if(not fDeleteBank) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้ลบธนาคารได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
  if(ViewBank.Selected = nil) then Exit ;
  if(MessageDlg('ต้องการลบ ธนาคาร '+ViewBank.Selected.Caption,mtConfirmation,[mbYes,mbNo],0) = mrNo) then Exit ;
  if(CheckBranch()) then
    begin
     MessageDlg('ไม่สามารถลบได้ เพราะมีสาขาอยู่',mtConfirmation,[mbOk],0);
     Exit ;
    end;

   DBDel := TADOQuery.Create(nil);
     with DBDel do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear  ;
         SQL.Text := ' Delete DBOfficeMaster ' +
                     ' Where HOF_ID = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3));
         ExecSQL ;
         Free ;
       end;
       ViewBank.Selected.Delete ;
end;

Function TfrmAccountMaster.CheckBranch() : Boolean ;
var DBBRN : TADOQuery ;
begin
   DBBRN := TADOQuery.Create(nil);
     with DBBRN do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBBranchesMaster '+
                    ' Where BOF_OnwerOffice = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3)) ;
        Active := true ;
        if(RecordCount > 0) then CheckBranch := true else CheckBranch := false ;
        Active := false ;
        Free ;
      end ;
end;

Function TfrmAccountMaster.CheckDefault(inBankID : String) : Boolean ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBOfficeMaster ' +
                    ' Where HOF_ID = '+QuotedStr(inBankID)+' and HOF_Onwer = 1 ';
        Active := true ;
        if(RecordCount <=0 ) then CheckDefault := false else CheckDefault := true ;
        Active := false ;
        Free ;
      end;
end;


Function TfrmAccountMaster.CheckBRNDefault(inBRNID : String) : Boolean ;
var DBID : TADOQuery ;
begin
  DBID := TADOQuery.Create(nil);
    with DBID do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBBranchesMaster ' +
                    ' Where BOF_ID = '+QuotedStr(inBRNID)+' and BOF_OnwerOffice = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3))+' and HOF_Onwer = 1 ' ;

        Active := true ;
        if(RecordCount <=0 ) then CheckBRNDefault := false else CheckBRNDefault := true ;
        Active := false ;
        Free ;
      end;
end;




Procedure TfrmAccountMaster.ChangetoDefault(inBankID : String) ;
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

{
Procedure TfrmAccountMaster.ChangeBRNtoDefault(inBankID : String) ;
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

}


procedure TfrmAccountMaster.N4Click(Sender: TObject);
begin
 if(ViewBank.Selected = nil) then Exit ;
 if(CheckDefault(Copy(ViewBank.Selected.Caption,1,3))) then
   begin
     MessageDlg('ธนาคารที่เลือกถูกตั้งค่าไว้แล้ว',mtInformation,[mbOk],0) ;
     Exit ;
   end;

 if(MessageDlg('การเปลี่ยนธนาคารทำงาน'+#10#13+'มีผลทำให้ข้อมูลการทำงานเปลี่ยนไปด้วย'+#10#13+'คุณต้องการยืนยันการเปลี่ยน',mtConfirmation,[mbYes, mbNo],0) = mrNo) then Exit ;
    ChangetoDefault(Copy(ViewBank.Selected.Caption,1,3));
    ChangeIcons(Copy(ViewBank.Selected.Caption,1,3));
end;

Procedure TfrmAccountMaster.ChangeIcons(inBankID : String);
var REC : Integer ;
begin
  for Rec := 0 to  ViewBank.Items.Count-1 do
    begin
      if(ViewBank.Items.Item[Rec].ImageIndex = 1) then  ViewBank.Items.Item[Rec].ImageIndex := 0 ;
    end;
    ViewBank.Selected.ImageIndex := 1 ;
end;

procedure TfrmAccountMaster.N5Click(Sender: TObject);
begin
  frmAccountMaster.Close ;
end;

procedure TfrmAccountMaster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree ;
end;

procedure TfrmAccountMaster.ViewBankDblClick(Sender: TObject);
begin
   if(ViewBank.Selected <> nil) then
   begin
     if(frmOfficeProperties = nil) then Application.CreateForm(TfrmOfficeProperties,frmOfficeProperties) else
        frmOfficeProperties := TfrmOfficeProperties.Create(nil);
        frmOfficeProperties.OfficeID := Copy(ViewBank.Selected.Caption,1,3) ;
        frmOfficeProperties.ShowModal ;
   end;     
end;

procedure TfrmAccountMaster.ViewBankClick(Sender: TObject);
var REC : Integer ;
begin
 if(ViewBank.Selected <> nil) then
  begin
   ListBranches() ;
    if(ViewBRN.Items.Count <= 0) then ViewAcc.Items.Clear ;
    if(ViewBRN.Selected <> nil) then
      begin
        ListAccount ;
      end;

  end; 
end;

procedure TfrmAccountMaster.N6Click(Sender: TObject);
begin

    if(ViewBank.Selected = nil) then Exit ;

   if(not fCreateBRN) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้สร้างสาขาได้',mtWarning,[mbOk],0) ;
      exit ;
    end;


    if(frmBranchProperties = nil) then Application.CreateForm(TfrmBranchProperties,frmBranchProperties) else
      frmBranchProperties := TfrmBranchProperties.Create(nil);
      frmBranchProperties.BRNID  := '' ;
      frmBranchProperties.BRNOnwer := Copy(ViewBank.Selected.Caption,1,3) ;
      frmBranchProperties.ShowModal ;
      if(frmBranchProperties.BRNResult = brAccept) then
        begin
          ViewBRN.Items.Add ;
          ViewBRN.Items.Item[ViewBRN.Items.Count-1].Caption := frmBranchProperties.BRNID ;
          ViewBRN.Items.Item[ViewBRN.Items.Count-1].ImageIndex := 2 ;
        end;
end;

procedure TfrmAccountMaster.N7Click(Sender: TObject);
begin
   if(not fAccessBRN) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าถึงสาขาได้',mtWarning,[mbOk],0) ;
      exit ;
    end;

    if(ViewBank.Selected = nil) then Exit ;
    if(frmBranchProperties = nil) then Application.CreateForm(TfrmBranchProperties,frmBranchProperties) else
      frmBranchProperties := TfrmBranchProperties.Create(nil);


      if(ViewBRN.Selected <> nil) then
      begin
         frmBranchProperties.BRNOnwer := Copy(ViewBank.Selected.Caption,1,3) ;
         frmBranchProperties.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
         frmBranchProperties.ShowModal ;

      end
      else
      ShowMessage('Please select Branch');



end;

procedure TfrmAccountMaster.ViewBRNDblClick(Sender: TObject);
begin
  if(ViewBRN.Selected <> nil) then
    begin
      if(frmBranchProperties = nil) then Application.CreateForm(TfrmBranchProperties,frmBranchProperties) else
         frmBranchProperties := TfrmBranchProperties.Create(nil);
         frmBranchProperties.BRNOnwer := Copy(ViewBank.Selected.Caption,1,3) ;
         frmBranchProperties.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
         frmBranchProperties.ShowModal ;
     end;    
end;

Function TfrmAccountMaster.CheckHaveunt() : Boolean ;
var DBHave : TADOQuery ;
begin
  DBHave := TADOQuery.Create(nil);
    with DBHave do
     begin
       Connection := frmDataCenter.ADOConnection1 ;
       SQL.Text := ' Select * from DBAccountMaster '+
                   ' Where ACC_Office = '+Copy(ViewBank.Selected.Caption,1,3)+
                   ' and '+
                   ' ACC_Branch = '+Copy(ViewBRN.Selected.Caption,1,4)  ;
       Active := true ;
       if(RecordCount > 0) then CheckHaveunt := true else CheckHaveunt := false ;
       Active := false ;
       Free ;
     end;
end;

procedure TfrmAccountMaster.N8Click(Sender: TObject);
var DBDel : TADOQuery ;
begin

   if(not fDeleteBRN) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้ลบสาขาได้',mtWarning,[mbOk],0) ;
      exit ;
    end;

  if(ViewBRN.Selected = nil) then Exit ;
  if(MessageDlg('ต้องการลบสาขา '+ViewBRN.Selected.Caption,mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin
      if(CheckHaveunt) then
        begin
          MessageDlg('มีผู้เปิดบัญชีสาขานี้อยู่',mtWarning,[mbOk],0) ;
          Exit ;
        end;

        DBDel :=  TADOQuery.Create(nil);
          with DBDel do
            begin
              Connection := frmDataCenter.ADOConnection1 ;
              SQL.Clear ;
              SQL.Text := ' Delete from DBBranchesMaster ' +
                          ' Where BOF_ID = '+Copy(ViewBRN.Selected.Caption,1,4)+
                          ' and '+
                          ' BOF_OnwerOffice = '+Copy(ViewBank.Selected.Caption,1,3) ;
              ExecSQL ;
              Free ;
            end;
            ViewBRN.Selected.Delete ;
    end;
end;

Procedure TfrmAccountMaster.ChangeBRNIcons(inBRNID : String);
begin

  if(CheckBRNDefault(Copy(ViewBRN.Selected.Caption,1,4))) then
   begin
     MessageDlg('สาขาที่เลือกถูกตั้งค่าไว้แล้ว',mtInformation,[mbOk],0) ;
     Exit ;
   end;

 if(MessageDlg('การเปลี่ยนสาขาทำงาน'+#10#13+'มีผลทำให้ข้อมูลการทำงานเปลี่ยนไปด้วย'+#10#13+'คุณต้องการยืนยันการเปลี่ยน',mtConfirmation,[mbYes, mbNo],0) = mrNo) then Exit ;
    ChangetoDefault(Copy(ViewBank.Selected.Caption,1,3));
    ChangeIcons(Copy(ViewBank.Selected.Caption,1,3));
end;

Procedure TfrmAccountMaster.ListAccount();
var DBAcc : TADOQuery ;
    AItem : TListItem ;
begin
  if(ViewBRN.Selected = nil) then
   begin
     ViewAcc.Items.Clear ;
     Exit ;
   end;
     if(DBACCL.Active) then DBACCL.Active := false ;
//    DBAcc := TADOQuery.Create(nil);
    with DBACCL do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBAccountMaster '+
                    ' Where ACC_Office = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3)) +
                    ' and '+
                    ' ACC_Branch = '+QuotedStr(Copy(ViewBRN.Selected.Caption,1,4)) ;
        Active := true ;

      end;


//   TfListAccTR.Create(ViewAcc);

//   ViewAcc.Items.
{
  ViewAcc.Items.Clear ;

  DBAcc := TADOQuery.Create(nil);
    with DBAcc do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBAccountMaster '+
                    ' Where ACC_Office = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3)) +
                    ' and '+
                    ' ACC_Branch = '+QuotedStr(Copy(ViewBRN.Selected.Caption,1,4)) ;
        Active := true ;
         while not eof do
           begin
             AItem := ViewAcc.Items.Add ;
             AItem.Caption := trim(FieldByname('ACC_ID').AsString)+#10#13+trim(FieldByname('ACC_Description').AsString) ;
             AItem.ImageIndex := 6 ;
             AItem.Selected := true ;
             Application.ProcessMessages ;
             Next ;
           end;
         Active := false ;
         Free ;
      end;
    }
end;

//-----
Procedure TfrmAccountMaster.ListAccount2();
var DBAcc : TADOQuery ;
    AItem : TListItem ;
begin
  if(ViewBRN.Selected = nil) then
   begin
     ViewAcc.Items.Clear ;
     Exit ;
   end;
     if(DBACCL.Active) then DBACCL.Active := false ;
//    DBAcc := TADOQuery.Create(nil);
    with DBACCL do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        {SQL.Text := ' Select * from DBAccountMaster '+
                    ' Where ACC_Office = '+QuotedStr(Copy(ViewBank.Selected.Caption,1,3)) +
                    ' and '+
                    ' ACC_Branch = '+QuotedStr(Copy(ViewBRN.Selected.Caption,1,4)) ;
        Active := true ; }
        //-----
        SQL.Text := ' Select * from DBAccountMaster '+
                      ' Where '+
                      ' ACC_ID like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Description like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Address1 like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Address2 like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Mobile like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Tel like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_EMail like '+QuotedStr('%'+trim(edtAccountID.Text)+'%');// +
                      {' and '+
                      ' ACC_Office	= '+QuotedStr(fBank)+
                      ' and '+
                      ' ACC_Branch	= '+QuotedStr(fBrn) ;  }
          Active := true ;
        //-----

      end;
end;

//-----






procedure TfrmAccountMaster.N11Click(Sender: TObject);
var AItem : TListItem ;
begin
   if(not fCreateAccount) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้สร้าง บัญชีได้',mtWarning,[mbOk],0) ;
      exit ;
    end;

    if(ViewBRN.Selected = nil) then Exit ;
    if(frmAccountProperties = nil) then Application.CreateForm(TfrmAccountProperties,frmAccountProperties) else
      frmAccountProperties := TfrmAccountProperties.Create(nil);
      frmAccountProperties.BankID := Copy(ViewBank.Selected.Caption,1,3) ;
      frmAccountProperties.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
      frmAccountProperties.AccountID := '' ;

      frmAccountProperties.ShowModal ;

      if(frmAccountProperties.AccResult = arAccept) then
        begin
        ListAccount ;
         // ad
//          AItem := ViewAcc.Items.Add ;
//          AItem.Caption := frmAccountProperties.AccountID ;
//          AItem.ImageIndex := 6 ;
//          AItem.Selected := true ;
        end;

end;

procedure TfrmAccountMaster.ViewBRNClick(Sender: TObject);
begin

 if(ViewBRN.Selected <> nil) then ListAccount ;
end;

procedure TfrmAccountMaster.ViewBRNSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
 // ListAccount ;
end;

procedure TfrmAccountMaster.N12Click(Sender: TObject);
begin
   // ViewAcc2.
//    if(ViewAcc2.ViewData.s = nil) then Exit ;
   if(not fAccessAccount) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าถึง บัญชีได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
    if(frmAccountProperties = nil) then Application.CreateForm(TfrmAccountProperties,frmAccountProperties) else
      frmAccountProperties := TfrmAccountProperties.Create(nil);
      frmAccountProperties.BankID := Copy(ViewBank.Selected.Caption,1,3) ;
      frmAccountProperties.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
      frmAccountProperties.AccountID :=  trim(ViewAcc2.DataController.DataSet.FieldByName('ACC_ID').AsString) ;//Copy(ViewAcc.Selected.Caption,1,10) ;

      frmAccountProperties.ShowModal ;

      if frmAccountProperties.ModalResult = 1 then
         ListAccount2();
end;

procedure TfrmAccountMaster.N13Click(Sender: TObject);
//var DBDel : TADOQuery ;
begin
//   if(ViewAcc.Selected = nil) then Exit ;
   if(not fDeleteAccount) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้ลบ บัญชีได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
   if(MessageDlg('ต้องการลบบัญชี '+ViewAcc2.DataController.DataSet.FieldByName('ACC_ID').AsString+' '+ViewAcc2.DataController.DataSet.FieldByName('ACC_Description').AsString,mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin
        ViewAcc2.DataController.DataSet.Delete ;
{
        DBDel :=  TADOQuery.Create(nil);
          with DBDel do
            begin
              Connection := frmDataCenter.ADOConnection1 ;
              SQL.Clear ;
              SQL.Text := ' Delete from DBAccountMaster ' +
                          ' Where ACC_ID = '+trim(ViewAcc2.DataController.DataSet.FieldByName('ACC_ID').AsString)+
                          ' and '+
                          ' ACC_Office = '+Copy(ViewBank.Selected.Caption,1,3) +
                          ' and '+
                          ' ACC_Branch = '+Copy(ViewBRN.Selected.Caption,1,4) ;

              ExecSQL ;
              Free ;
            end;
            Viewacc.Selected.Delete ;
}
    end;
end;

procedure TfrmAccountMaster.N9Click(Sender: TObject);
begin
   if(not fEditBRN) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้แก้ไขสาขาได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
  if(ViewBRN.Selected = nil) then Exit ;
end;

procedure TfrmAccountMaster.N15Click(Sender: TObject);
begin

   if(not fCreateAccount) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้นำเข้า บัญชีได้',mtWarning,[mbOk],0) ;
      exit ;
    end;

    if(ViewBRN.Selected = nil) then Exit ;
    if(frmImportAccount = nil) then Application.CreateForm(TfrmImportAccount,frmImportAccount) else
       frmImportAccount := TfrmImportAccount.Create(nil);
       frmImportAccount.BankID := Copy(ViewBank.Selected.Caption,1,3) ;
       frmImportAccount.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
       frmImportAccount.ShowModal ;
end;

procedure TfrmAccountMaster.ViewBRNChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
// ListAccount ;
end;

procedure TfrmAccountMaster.Commission1Click(Sender: TObject);
begin
   if(not fAccessAccount) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าถึง บัญชีได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
    if(frmUpdCmms = nil) then Application.CreateForm(TfrmUpdCmms,frmUpdCmms) else
      frmUpdCmms := TfrmUpdCmms.Create(nil);
      //frmAccountProperties.BankID := Copy(ViewBank.Selected.Caption,1,3) ;
      //frmAccountProperties.BRNID  := Copy(ViewBRN.Selected.Caption,1,4) ;
      //frmAccountProperties.AccountID :=  trim(ViewAcc2.DataController.DataSet.FieldByName('ACC_ID').AsString) ;//Copy(ViewAcc.Selected.Caption,1,10) ;

      frmUpdCmms.ShowModal ;
end;

procedure TfrmAccountMaster.edtAccountIDChange(Sender: TObject);
begin
   //ListAccount2();
end;

procedure TfrmAccountMaster.btSerchClick(Sender: TObject);
begin
   ListAccount2();
end;

end.

