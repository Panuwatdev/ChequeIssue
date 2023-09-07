unit ufrmChequeDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, ImgList, ComCtrls, SUIListView, Menus, DB, ADODB,
  SUIPopupMenu;

type
  TfrmChequeDesign = class(TForm)
    frmChequeSkin: TsuiForm;
    suiListView1: TsuiListView;
    ImageList1: TImageList;
    suiPopupMenu1: TsuiPopupMenu;
    NewCheque1: TMenuItem;
    EditCheque1: TMenuItem;
    RemoveCheque1: TMenuItem;
    ExittoMainMenu1: TMenuItem;
    procedure NewCheque1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditCheque1Click(Sender: TObject);
    procedure RemoveCheque1Click(Sender: TObject);
    procedure ExittoMainMenu1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Procedure ShowScreen();
  public
    { Public declarations }
  end;

var
  frmChequeDesign: TfrmChequeDesign;

implementation

uses ufrmChequeProperties, ufrmDataCenter ;

{$R *.dfm}

procedure TfrmChequeDesign.NewCheque1Click(Sender: TObject);
begin
   if(frmChequeProperties = nil) then Application.CreateForm(TfrmChequeProperties,frmChequeProperties) else
      frmChequeProperties := TfrmChequeProperties.Create(nil);
      frmChequeProperties.FormatName := '' ;
      frmChequeProperties.ShowModal ;

      if(frmChequeProperties.ExitType = etAccept) then
       begin
         suiListView1.Items.Add ;
         suiListView1.Items.Item[suiListView1.Items.Count-1].Caption := frmChequeProperties.FormatName ;
       end;
end;

Procedure TfrmChequeDesign.ShowScreen();
var DBList : TADOQuery ;
begin
  DBList := TADOQuery.Create(nil);
    with DBList do
      begin
       Connection := frmDataCenter.ADOConnection1 ;
       SQL.Clear ;
       SQL.Text := ' Select * from DBChequeProperties ' ;
       Active := true ;

       suiListView1.Clear ;

       while not eof do
         begin
          suiListView1.Items.Add ;
          suiListView1.Items.Item[suiListView1.Items.Count-1].Caption := trim(FieldByname('FFM_Name').AsString) ;
          Next ;
         end;
       Active := false ;
       Free ;

      end;
end;

procedure TfrmChequeDesign.FormActivate(Sender: TObject);
begin
  ShowScreen();
end;

procedure TfrmChequeDesign.EditCheque1Click(Sender: TObject);
begin
   if(frmChequeProperties = nil) then Application.CreateForm(TfrmChequeProperties,frmChequeProperties) else
      frmChequeProperties := TfrmChequeProperties.Create(nil);
      frmChequeProperties.FormatName := suiListView1.Selected.Caption ;
      frmChequeProperties.ShowModal ;


end;

procedure TfrmChequeDesign.RemoveCheque1Click(Sender: TObject);
var DBRemove : TADOQuery ;
begin
  if(MessageDlg('ต้องการลบเช็ครูปแบบ '+suiListView1.Selected.Caption,mtConfirmation,[mbYes,mbNo],0) = mryes) then
    begin
       DBRemove := TADOQuery.Create(nil);
         with DBRemove do
          begin
            Connection := frmDataCenter.ADOConnection1 ;
            SQL.Clear ;
            SQL.Text := ' Delete from DBChequeProperties '+
                        ' Where FFM_Name = '+QuotedStr(suiListView1.Selected.Caption) ;
            ExecSQL ;
            Free ;            
          end;
          suiListView1.Selected.Delete ;
    end;
end;

procedure TfrmChequeDesign.ExittoMainMenu1Click(Sender: TObject);
begin
  frmChequeDesign.Close ;
end;

procedure TfrmChequeDesign.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
