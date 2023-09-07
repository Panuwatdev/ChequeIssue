unit ufrmAdvanceConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzGroupBar, ExtCtrls, SUIForm, RzPanel, StdCtrls, Mask, RzEdit,
  RzLabel, DB, ADODB, ImgList;

type
  TfrmAdvanceConfig = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    RzLabel5: TRzLabel;
    edtLoginWrong: TRzEdit;
    RzPanel1: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    RzLabel1: TRzLabel;
    edtHitory: TRzEdit;
    edtAlert: TRzEdit;
    RzLabel3: TRzLabel;
    edtUserMin: TRzEdit;
    edtPassMin: TRzEdit;
    RzLabel4: TRzLabel;
    edtLockUser: TRzEdit;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    edtUserDisable: TRzEdit;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel15: TRzLabel;
    ImageList1: TImageList;
    procedure edtLoginWrongKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtLoginWrongKeyPress(Sender: TObject; var Key: Char);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Procedure ShowScreen();
  public
    { Public declarations }
  end;

var
  frmAdvanceConfig: TfrmAdvanceConfig;

implementation
uses ufrmDatacenter ;

{$R *.dfm}

procedure TfrmAdvanceConfig.edtLoginWrongKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if(Key = VK_RETURN) then SelectNext(ActiveControl,true,true) ;
end;

procedure TfrmAdvanceConfig.edtLoginWrongKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

Procedure TfrmAdvanceConfig.ShowScreen();
var DBSHOW : TADOQuery ;
begin
   DBSHOW := TADOQuery.Create(nil);
     with DBSHOW do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBAdvanceConfig ' ;
         Active := true ;
         edtLoginWrong.Text   := FieldByname('ADV_LoginLimited').AsString ;
         edtHitory.Text       := FieldByname('ADV_ReturnLog').AsString ;
         edtAlert.Text        := FieldByname('ADV_ExpireAlert').AsString ;
         edtUserMin.Text      := FieldByname('ADV_UserMin').AsString ;
         edtPassMin.Text      := FieldByname('ADV_PassMin').AsString ;
         edtLockUser.Text     := FieldByname('ADV_UserLock').AsString ;
         edtUserDisable.Text  := FieldByname('ADV_Disable').AsString ;
         Active := false ;
         Free ;
       end;
end;

procedure TfrmAdvanceConfig.RzGroup1Items0Click(Sender: TObject);
var DBADV : TADOQuery ;
    Rec : Integer ;
begin
  DBADV := TADOQuery.Create(nil);
    with DBADV do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBAdvanceConfig ' ;
        Active := true ;
        Rec := RecordCount ;
        Active := false ;
        if(Rec > 0) then
         begin
           SQL.Clear ;
           SQL.Text := ' update DBAdvanceConfig '+
                       ' Set '+
                       ' ADV_LoginLimited = '+trim(edtLoginWrong.Text)+','+
                       ' ADV_ReturnLog = '+trim(edtHitory.Text)+','+
                       ' ADV_ExpireAlert = '+trim(edtAlert.Text)+','+
                       ' ADV_UserMin = '+trim(edtUserMin.Text)+','+
                       ' ADV_PassMin = '+trim(edtPassMin.Text)+','+
                       ' ADV_UserLock = '+trim(edtLockUser.Text)+','+
                       ' ADV_Disable = '+trim(edtUserDisable.Text) ;
           ExecSQL ;
         end else if(Rec <= 0) then 
         begin
           SQL.Clear ;
           SQL.Text := ' Insert into DBAdvanceConfig '+
                       ' ( '+
                       ' ADV_LoginLimited, ADV_ReturnLog, ADV_ExpireAlert, ADV_UserMin, ADV_PassMin, '+
                       ' ADV_UserLock, ADV_Disable ' +
                       ' ) '+
                       ' Values ('+
                       trim(edtLoginWrong.Text)+','+
                       trim(edtHitory.Text)+','+
                       trim(edtAlert.Text)+','+
                       trim(edtUserMin.Text)+','+
                       trim(edtPassMin.Text)+','+
                       trim(edtLockUser.Text)+','+
                       trim(edtUserDisable.Text) +
                       ' ) ' ;
           ExecSQL ;
         end;
      end;
      frmAdvanceConfig.Close;
end;

procedure TfrmAdvanceConfig.FormActivate(Sender: TObject);
begin
  ShowScreen ;
end;

procedure TfrmAdvanceConfig.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
