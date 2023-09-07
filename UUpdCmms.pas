unit UUpdCmms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, DBClient, ADODB, RzLabel, StdCtrls,
  cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  RzButton, Mask, RzEdit, RzCmboBx, RzPanel, ExtCtrls, SUIForm, Provider,
  SUIButton, cxCheckBox, Grids, DBGrids;

type
  TfrmUpdCmms = class(TForm)
    suiForm1: TsuiForm;
    RzPanel1: TRzPanel;
    edtAccountID: TRzEdit;
    RzPanel2: TRzPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    RzLabel9: TRzLabel;
    EdRevenue: TRzEdit;
    RzLabel10: TRzLabel;
    EdCommission: TRzEdit;
    DsCustomer: TDataSource;
    QrCustomer: TADOQuery;
    CDSCustomer: TClientDataSet;
    PrCustomer: TDataSetProvider;
    CDSCustomerACC_ID: TWideStringField;
    CDSCustomerACC_Description: TWideStringField;
    CDSCustomerACC_Revenue: TFloatField;
    CDSCustomerACC_Commission: TFloatField;
    CDSCustomerSlc: TBooleanField;
    cxGrid1DBTableView1Slc: TcxGridDBColumn;
    cxGrid1DBTableView1ACC_ID: TcxGridDBColumn;
    cxGrid1DBTableView1ACC_Description: TcxGridDBColumn;
    cxGrid1DBTableView1ACC_Revenue: TcxGridDBColumn;
    cxGrid1DBTableView1ACC_Commission: TcxGridDBColumn;
    RzLabel1: TRzLabel;
    ChkRecord: TsuiCheckBox;
    suiButton1: TsuiButton;
    //procedure RzButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtAccountIDChange(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure RunQrUpdate(SBnkID:String);
    procedure RunQrUpdAll();
  public
    { Public declarations }
  end;

var
  frmUpdCmms: TfrmUpdCmms;

implementation
uses ufrmDatacenter ;

{$R *.dfm}



{procedure TfrmUpdCmms.LoadPermission();
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
end; }

procedure TfrmUpdCmms.FormActivate(Sender: TObject);
begin
   

   QrCustomer.Close;
   QrCustomer.SQL.Clear;
   QrCustomer.SQL.Text := 'Select ACC_ID,ACC_Description,ACC_Revenue,ACC_Commission'+
                          ' from DBAccountMaster' ;
   QrCustomer.Open;


   if CDSCustomer.Active = false then
      CDSCustomer.Active := true;

      {CDSCustomer.First;

      while not CDSCustomer.Eof do
      begin
         CDSCustomer.Edit;
         CDSCustomer.FieldByName('Slc').Value := false;
         CDSCustomer.Post;
         CDSCustomer.Next;
      end;   }


end;


procedure TfrmUpdCmms.edtAccountIDChange(Sender: TObject);
begin
 if(trim(edtAccountID.Text) <> '') then
   begin
     CDSCustomer.Active := false;
     QrCustomer.Active  := false ;
      with QrCustomer do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Select * from DBAccountMaster '+
                      ' Where '+
                      ' ACC_ID like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Description like '+QuotedStr('%'+trim(edtAccountID.Text)+'%'); //+

                     { ' or '+
                      ' ACC_Address1 like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Address2 like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Mobile like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_Tel like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' or '+
                      ' ACC_EMail like '+QuotedStr('%'+trim(edtAccountID.Text)+'%') +
                      ' and '+
                      ' ACC_Office	= '+QuotedStr(fBank)+
                      ' and '+
                      ' ACC_Branch	= '+QuotedStr(fBrn) ;  }

          Active := true ;
          CDSCustomer.Active := true;
        end;
   end;
end;

procedure TfrmUpdCmms.RunQrUpdate(SBnkID:String);
var
   QrUPdate : TADOQuery;
begin
   QrUPdate := TADOQuery.Create(nil);
   if QrUPdate.Active = true then QrUPdate.Active := false;
   with QrUPdate do
   begin
      Connection := frmDataCenter.ADOConnection1;
      SQL.Clear;


           SQL.Text := 'Update DBAccountMaster set ACC_Revenue = ' +QuotedStr(EdRevenue.text)+
                       ', ACC_Commission = '+QuotedStr(EdCommission.text)+
                       ' where ACC_ID =' +QuotedStr(SBnkID);

      ExecSQL;
   end;
end;

procedure TfrmUpdCmms.RunQrUpdAll();
var
   QrUPdate : TADOQuery;
begin
   QrUPdate := TADOQuery.Create(nil);
   if QrUPdate.Active = true then QrUPdate.Active := false;
   with QrUPdate do
   begin
      Connection := frmDataCenter.ADOConnection1;
      SQL.Clear;

      //if ChkRecord.Checked then
           SQL.Text := 'Update DBAccountMaster set ACC_Revenue = ' +QuotedStr(EdRevenue.text)+
                       ', ACC_Commission = '+QuotedStr(EdCommission.text);

      ExecSQL;
   end;
end;


procedure TfrmUpdCmms.suiButton1Click(Sender: TObject);
begin
   if CDSCustomer.RecordCount > 0 then
  begin
      if ChkRecord.Checked then
      begin
         RunQrUpdAll();
      end
      else
      begin

            CDSCustomer.First;

            While not CDSCustomer.Eof do
            begin
               if CDSCustomer.FieldByName('Slc').AsBoolean = true then
               begin
                  RunQrUpdate(CDSCustomer.FieldByName('ACC_ID').AsString);
               end;

               CDSCustomer.Next;
            end;

      end;

  end;

  CDSCustomer.Close;
  QrCustomer.Close;

  QrCustomer.Open ;
  CDSCustomer.Open;
end;

procedure TfrmUpdCmms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
