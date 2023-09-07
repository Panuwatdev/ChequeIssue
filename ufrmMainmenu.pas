unit ufrmMainmenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzGroupBar, RzPanel, ExtCtrls, SUIForm, ImgList, DB, ADODB,
  StdCtrls;

type
  TfrmMainMenu = class(TForm)
    suiForm1: TsuiForm;
    RzGroupBar1: TRzGroupBar;
    RzPanel1: TRzPanel;
    RzGroup1: TRzGroup;
    RzPanel2: TRzPanel;
    RzGroup2: TRzGroup;
    RzGroup3: TRzGroup;
    RzGroup4: TRzGroup;
    ImageList1: TImageList;
    Label1: TLabel;
    procedure RzGroup2Items2Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure RzGroup4Items0Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure RzGroup3Items1Click(Sender: TObject);
  private
    { Private declarations }
    fAccessBank      : Boolean ;
    fAccessBRN       : Boolean ;
    fAccessUser      : Boolean ;
    fAccessAccount   : Boolean ;
    fAccessAdvance   : Boolean ;
    fAccessHWSetup   : Boolean ;
    fAccessCHDesign  : boolean ;
    fAccessTR        : Boolean ;
    fAccessReport    : Boolean ;
    Procedure GetBankDefault();
    Procedure GetBRNDefault();
    Procedure LoadPermission() ;
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

uses ufrmDatacenter,ufrmChequeDesign, ufrmTransaction, ufrmAccountMaster, ufrmMainUser,
  ufrmMainReport;

{$R *.dfm}

procedure TfrmMainMenu.LoadPermission();
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
              if(trim(FieldByName('PER_Appication').AsString) = 'Bank Data') then fAccessBank          := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'BRN Data') then fAccessBRN            := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'USER Data') then fAccessUser          := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'Account Data') then fAccessAccount    := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'Advance Setup') then fAccessAdvance   := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'HardWare Setup') then fAccessHWSetup  := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'Cheque Design') then fAccessCHDesign  := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'Transaction') then fAccessTR          := FieldByName('PER_Access').AsBoolean  else
              if(trim(FieldByName('PER_Appication').AsString) = 'Report') then fAccessReport           := FieldByName('PER_Access').AsBoolean  ;
              Next ;
           end ;
         Active := false ;
         Free ;  
       end;
end;

Procedure TfrmMainMenu.GetBankDefault();
var DBBank : TADOQuery ;
begin
   DBBank := TADOQuery.Create(nil);
     with DBBank do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBOfficeMaster '+
                     ' Where HOF_Onwer = 1 ' ;
         Active := true ;
         frmDatacenter.BankID := trim(FieldByname('HOF_ID').AsString) ;
         Active := false ;
         Free ;
       end;
end;

Procedure TfrmMainMenu.GetBRNDefault();
var DBBrn : TADOQuery ;
begin
   DBBrn := TADOQuery.Create(nil);
     with DBBrn do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBBranchesMaster '+
                     ' Where BOF_OnwerOffice = '+QuotedStr(frmDatacenter.BankID)+
                     ' and BOF_Onwer = 1 ' ;
         Active := true ;
         frmDatacenter.BRNID  := trim(FieldByname('BOF_ID').AsString) ;
         Active := false ;
         Free ;
       end;
end;


procedure TfrmMainMenu.RzGroup2Items2Click(Sender: TObject);
begin
   if(Not fAccessCHDesign ) then
     begin
       MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าทำงาน',mtWarning,[mbOk],0) ;
       Exit ;
     end;
   if(frmChequeDesign = nil) then Application.CreateForm(TfrmChequeDesign,frmChequeDesign) else
      frmChequeDesign := TfrmChequeDesign.Create(nil);
      frmChequeDesign.Top  := RzPanel1.Height + 25 ;
      frmChequeDesign.Left := RzGroupBar1.Width + 5 ;
      frmChequeDesign.Width := (frmMainMenu.Width - RzGroupBar1.Width) - 10 ;
      frmChequeDesign.Height := (frmMainMenu.Height - RzPanel1.Height ) - 30 ;
      frmChequeDesign.ShowModal ;
end;

procedure TfrmMainMenu.RzGroup3Items0Click(Sender: TObject);
begin
   if(Not fAccessTR ) then
     begin
       MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าทำงาน',mtWarning,[mbOk],0) ;
       Exit ;
     end;
   if(frmTransaction = nil) then Application.CreateForm(TfrmTransaction,frmTransaction) else
      frmTransaction := TfrmTransaction.Create(nil);
      frmTransaction.Top  := RzPanel1.Height + 25 ;
      frmTransaction.Left := RzGroupBar1.Width + 5 ;
      frmTransaction.Width := (frmMainMenu.Width - RzGroupBar1.Width) - 10 ;
      frmTransaction.Height := (frmMainMenu.Height - RzPanel1.Height ) - 30 ;
      frmTransaction.ShowModal ;
end;



procedure TfrmMainMenu.RzGroup1Items0Click(Sender: TObject);
begin
   if(Not fAccessAccount ) then
     begin
       MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าทำงาน',mtWarning,[mbOk],0) ;
       Exit ;
     end;
   if(frmAccountMaster = nil) then Application.CreateForm(TfrmAccountMaster,frmAccountMaster) else
      frmAccountMaster := TfrmAccountMaster.Create(nil);
      frmAccountMaster.Top  := RzPanel1.Height + 25 ;
      frmAccountMaster.Left := RzGroupBar1.Width + 5 ;
      frmAccountMaster.Width := (frmMainMenu.Width - RzGroupBar1.Width) - 10 ;
      frmAccountMaster.Height := (frmMainMenu.Height - RzPanel1.Height ) - 30 ;
      frmAccountMaster.ShowModal ;
end;

procedure TfrmMainMenu.RzGroup1Items1Click(Sender: TObject);
begin
   if(Not fAccessUser ) then
     begin
       MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าทำงาน',mtWarning,[mbOk],0) ;
       Exit ;
     end;
   if(frmMainUser = nil) then Application.CreateForm(TfrmMainUser,frmMainUser) else
      frmMainUser := TfrmMainUser.Create(nil);
      frmMainUser.Top  := RzPanel1.Height + 25 ;
      frmMainUser.Left := RzGroupBar1.Width + 5 ;
      frmMainUser.Width := (frmMainMenu.Width - RzGroupBar1.Width) - 10 ;
      frmMainUser.Height := (frmMainMenu.Height - RzPanel1.Height ) - 30 ;
      frmMainUser.ShowModal ;

end;

procedure TfrmMainMenu.RzGroup4Items0Click(Sender: TObject);
begin
  Application.Terminate ;
end;

procedure TfrmMainMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Application.Terminate ;
end;

procedure TfrmMainMenu.FormActivate(Sender: TObject);
begin
  GetBankDefault ;
  GetBRNDefault ;
  LoadPermission();
end;

{procedure TfrmMainMenu.RzGroup3Items1Click(Sender: TObject);
begin
     if(Not fAccessReport ) then
     begin
       MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าทำงาน',mtWarning,[mbOk],0) ;
       Exit ;
     end;
end;  }

procedure TfrmMainMenu.RzGroup3Items1Click(Sender: TObject);
begin
   if(Not fAccessReport ) then
     begin
       MessageDlg('คุณไม่ได้รับอนุญาติให้เข้าทำงาน',mtWarning,[mbOk],0) ;
       Exit ;
     end;
   if(frmMainReport = nil) then Application.CreateForm(TfrmMainReport,frmMainReport) else
      frmMainReport := TfrmMainReport.Create(nil);
      frmMainReport.Top  := RzPanel1.Height + 25 ;
      frmMainReport.Left := RzGroupBar1.Width + 5 ;
      frmMainReport.Width := (frmMainMenu.Width - RzGroupBar1.Width) - 10 ;
      frmMainReport.Height := (frmMainMenu.Height - RzPanel1.Height ) - 30 ;
      frmMainReport.ShowModal ;
end;



end.
