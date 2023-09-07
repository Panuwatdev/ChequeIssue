unit ufrmMainUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzGroupBar, ComCtrls, SUIListView, ExtCtrls, SUIForm, Menus,
  SUIPopupMenu, DB, ADODB, ImgList, LbCipher, LbClass, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxImageComboBox, cxLabel, SUIButton, StdCtrls, SUIEdit;

type
  TfrmMainUser = class(TForm)
    suiForm1: TsuiForm;
    suiPopupMenu1: TsuiPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Lb3DES1: TLb3DES;
    ImageList1: TImageList;
    N6: TMenuItem;
    ViewUser: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DataSource1: TDataSource;
    DBUser: TADOQuery;
    ViewUserUSE_Name: TcxGridDBColumn;
    ViewUserUSE_LastName: TcxGridDBColumn;
    ViewUserUSE_Lock: TcxGridDBColumn;
    ViewUserUSE_UserStart: TcxGridDBColumn;
    ViewUserUSE_UserEnd: TcxGridDBColumn;
    ViewUserUSE_PassStart: TcxGridDBColumn;
    ViewUserUSE_PassEnd: TcxGridDBColumn;
    ViewUserDBColumn1: TcxGridDBColumn;
    DBUserUSE_ID: TWideStringField;
    DBUserUSE_Name: TWideStringField;
    DBUserUSE_LastName: TWideStringField;
    DBUserUSE_Passkey: TWideStringField;
    DBUserUSE_UserNeverUsed: TBooleanField;
    DBUserUSE_PassNeverUsed: TBooleanField;
    DBUserUSE_CanChangePass: TBooleanField;
    DBUserUSE_CanCreateUser: TBooleanField;
    DBUserUSE_Activate: TBooleanField;
    DBUserUSE_Lock: TBooleanField;
    DBUserUSE_CanPermission: TBooleanField;
    DBUserUSE_UserStart: TDateTimeField;
    DBUserUSE_UserEnd: TDateTimeField;
    DBUserUSE_PassStart: TDateTimeField;
    DBUserUSE_PassEnd: TDateTimeField;
    DBUserUSE_ChangeStart: TBooleanField;
    DBUserUSE_SEX: TIntegerField;
    DBUserUSE_IDReal: TStringField;
    ViewUserDBColumn2: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    ViewUserDBColumn3: TcxGridDBColumn;
    N7: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure DBUserCalcFields(DataSet: TDataSet);
    procedure N7Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }

    fAccessUser : Boolean ;
    fCreateUser : Boolean ;
    fEditUser   : Boolean ;
    fDeleteuser : Boolean ;

    fAccessAdv  : Boolean ;
    fCreateAdv  : Boolean ;
    fEditAdv    : Boolean ;
    fDeleteAdv  : Boolean ;

    Procedure ListUser() ;
    procedure LoadPermission();
  public
    { Public declarations }
  end;

var
  frmMainUser: TfrmMainUser;
  Key128     : TKey128;

implementation

uses ufrmDatacenter, ufrmUserMaster, LbString, ufrmAdvanceConfig;

{$R *.dfm}

procedure TfrmMainUser.LoadPermission();
var DBPer : TADOQuery ;
begin
   DBPer := TADOQuery.Create(nil);
     with DBPer do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBUserPermission '+
                     ' Where PER_UserID = '+QuotedStr(frmDataCenter.UserID) +
                     ' and PER_Appication = '+QuotedStr('USER Data');
                     //' and PER_Appication = '+QuotedStr('Advance Setup')  ;
         Active := true ;
          while not eof do
            begin
              if(trim(FieldByName('PER_Appication').AsString) = 'USER Data') then
                begin
                   fAccessUser         := FieldByName('PER_Access').AsBoolean  ;
                   fCreateUser         := FieldByName('PER_Create').AsBoolean  ;
                   fEditUser           := FieldByName('PER_Modify').AsBoolean  ;
                   fDeleteuser         := FieldByName('PER_Delete').AsBoolean  ;
                end else
              if(trim(FieldByName('PER_Appication').AsString) = 'Advance Setup') then
                  begin
                   fAccessAdv          := FieldByName('PER_Access').AsBoolean  ;
                   fCreateAdv          := FieldByName('PER_Create').AsBoolean  ;
                   fEditAdv            := FieldByName('PER_Modify').AsBoolean  ;
                   fDeleteAdv          := FieldByName('PER_Delete').AsBoolean  ;
                  end ;
              Next ;
           end ;
         Active := false ;
         Free ;
       end;
end;


procedure TfrmMainUser.N1Click(Sender: TObject);
begin
   if(not fCreateUser) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้สร้างผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
   if(frmUserMaster = nil) then Application.CreateForm(TfrmUserMaster,frmUserMaster) else
      frmUserMaster := TfrmUserMaster.Create(nil);
      frmUserMaster.inUserID := '' ;
      frmUserMaster.ShowModal ;

      ListUser();
end;

procedure TfrmMainUser.ListUser();
{
var DBList : TADOQuery ;
    LID, LName, LLast : String ;
    LItem : TListItem ;
    LSex : Integer ;
}
begin

   if(DBUser.Active) then DBUser.Active := false ;
     with DBUser do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBUserMaster ' ;
        Active := true ;
      end;
{
  DBList := TADOQuery.Create(nil);
    with DBList do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBUserMaster ' ;
        Active := true ;
         while not eof do
           begin
             LID   := TripleDESEncryptStringEx(trim(FieldByName('USE_ID').AsString),Key128,false) ;
             LName := trim(FieldByName('USE_Name').AsString) ;
             LLast := trim(FieldByName('USE_LastName').AsString) ;
             LSex  := FieldByName('USE_SEX').AsInteger ;
             LItem := ViewUser.Items.Add ;
             LItem.Caption := LID ;
             LItem.ImageIndex := LSex ;
             LItem.Selected := true ;
             Next ;
           end;
         Active := false ;
         Free ;  
      end;
      }
end;

procedure TfrmMainUser.FormActivate(Sender: TObject);
begin
  ListUser();
  LoadPermission();
end;

procedure TfrmMainUser.N6Click(Sender: TObject);
begin
   if(not fAccessUser) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าดูผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;

   if(frmUserMaster = nil) then Application.CreateForm(TfrmUserMaster,frmUserMaster) else
      frmUserMaster := TfrmUserMaster.Create(nil);
      frmUserMaster.inUserID :=  trim(ViewUser.DataController.DataSet.FieldByName('USE_IDReal').AsString) ;  //ViewUser.Selected.Caption ;
      frmUserMaster.ShowModal ;
end;

procedure TfrmMainUser.DBUserCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('USE_IDReal').AsString := TripleDESEncryptStringEx(trim(DataSet.FieldByName('USE_ID').AsString),Key128,false) ;
end;

procedure TfrmMainUser.N7Click(Sender: TObject);
begin
   if(not fAccessAdv) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้แก้ไขผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
   if(frmAdvanceConfig = nil) then Application.CreateForm(TfrmAdvanceConfig,frmAdvanceConfig) else
      frmAdvanceConfig := TfrmAdvanceConfig.Create(nil);
      frmAdvanceConfig.ShowModal ;
end;

procedure TfrmMainUser.N2Click(Sender: TObject);
var dbUseDel : TADOQuery ;
    ConUser : String ;
begin
   if(not fDeleteuser) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้ลบผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
  ConUser := TripleDESEncryptStringEx(trim(ViewUser.DataController.DataSet.FieldByName('USE_ID').AsString),Key128,false) ;
  if(MessageDlg('ต้องการลบผู้ใช้งาน '+ConUser,mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin

        dbUseDel := TADOQuery.Create(nil);
          with dbUseDel do
            begin
              Connection :=frmDataCenter.ADOConnection1 ;
              SQL.Clear ;
              SQL.Text := ' Delete DBUserMaster '+
                          ' Where USE_ID = '+QuotedStr(trim(ViewUser.DataController.DataSet.FieldByname('USE_ID').AsString)) +
                          ' Delete DBUserPermission ' +
                          ' Where PER_UserID = '+QuotedStr(ConUser) ;
              ExecSQL ;
              Free ;
            end;

         ListUser();
    end;
end;

procedure TfrmMainUser.N3Click(Sender: TObject);
begin
   if(not fEditUser) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้แก้ไขผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
  if(MessageDlg('ต้องการระงับผู้ใช้งาน '+trim(ViewUser.DataController.DataSet.FieldByName('USE_IDReal').AsString),mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin
      ViewUser.DataController.DataSet.edit ;
      ViewUser.DataController.DataSet.FieldByName('USE_Activate').AsBoolean := false ;
    end;
end;

procedure TfrmMainUser.N4Click(Sender: TObject);
begin
   if(not fEditUser) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้แก้ไขผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
  if(MessageDlg('ต้องการยกเลิกระงับผู้ใช้งาน '+trim(ViewUser.DataController.DataSet.FieldByName('USE_IDReal').AsString),mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin
      ViewUser.DataController.DataSet.edit ;
      ViewUser.DataController.DataSet.FieldByName('USE_Activate').AsBoolean := true ;
    end;
end;

procedure TfrmMainUser.N5Click(Sender: TObject);
begin
   if(not fEditUser) then
    begin
      MessageDlg('คุณไม่ได้รับอนุญาติให้แก้ไขผู้ใช้งานได้',mtWarning,[mbOk],0) ;
      exit ;
    end;
  if(MessageDlg('ต้องการปลดล๊อคผู้ใช้งาน '+trim(ViewUser.DataController.DataSet.FieldByName('USE_IDReal').AsString),mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin
      ViewUser.DataController.DataSet.edit ;
      ViewUser.DataController.DataSet.FieldByName('USE_Activate').AsBoolean := true ;
    end;
end;

procedure TfrmMainUser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
