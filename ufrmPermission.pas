unit ufrmPermission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzGroupBar, ExtCtrls, SUIForm, ImgList, RzButton, RzPanel,
  Menus, SUIPopupMenu, StdCtrls, RzLabel, DB, ADODB;

type
  TfrmPermission = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    RzPanel1: TRzPanel;
    ImageList1: TImageList;
    btnDelete: TRzToolButton;
    btnModify: TRzToolButton;
    btnCreate: TRzToolButton;
    btnAccess: TRzToolButton;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    RzPanel8: TRzPanel;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    RzPanel11: TRzPanel;
    RzPanel12: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel14: TRzPanel;
    RzPanel15: TRzPanel;
    RzPanel16: TRzPanel;
    RzPanel17: TRzPanel;
    RzPanel18: TRzPanel;
    RzPanel19: TRzPanel;
    RzPanel20: TRzPanel;
    RzPanel21: TRzPanel;
    RzPanel22: TRzPanel;
    RzPanel23: TRzPanel;
    RzPanel24: TRzPanel;
    RzPanel25: TRzPanel;
    RzPanel26: TRzPanel;
    RzPanel27: TRzPanel;
    btnPrint: TRzToolButton;
    N1: TMenuItem;
    M1: TsuiPopupMenu;
    RzPanel28: TRzPanel;
    Image1: TImage;
    DispName: TRzLabel;
    procedure RzPanel9DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure RzPanel9DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnCancelDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure btnCancelDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure RzPanel1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure RzPanel1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure RzPanel1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fUserID : String ;
    fMode : String ;
//    fBankID : String ;
//    fBRN    : String ;
    Procedure ClickEvent(Sender: TObject) ;
    function CheckHave(cPage : TRzPanel; cControl : TRzToolButton) : Boolean;
    procedure RzP1EndDrag(Sender, Target: TObject; X, Y: Integer);
    Procedure StartPer(inUserID : String) ;
    Procedure ClearSceen() ;
    Procedure ShowScreen() ;

  public
    { Public declarations }

  Published
    Property UserID : String Read fUserID Write StartPer ;
//    Property BankID : String Read fBankID Write fBankID ;
//    Property BRNID  : String
  end;

var
  frmPermission: TfrmPermission;

implementation
uses ufrmDatacenter ;

{$R *.dfm}

Procedure TfrmPermission.ClearSceen();
begin
   RzPanel18.DestroyComponents ;
   RzPanel20.DestroyComponents ;
   RzPanel22.DestroyComponents ;
   RzPanel24.DestroyComponents ;
   RzPanel26.DestroyComponents ;
   RzPanel19.DestroyComponents ;
   RzPanel21.DestroyComponents ;
   RzPanel23.DestroyComponents ;
   RzPanel25.DestroyComponents ;
end;

Procedure TfrmPermission.ShowScreen();
var DBPre : TADOQuery ;
    Tempbtn : TRzToolButton ;
begin
    DBPre := TADOQuery.Create(nil);
      with DBPre do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Select * from DBUserPerMission '+
                      ' Where PER_UserID = '+quotedStr(fUserID) ;
          Active := true ;
          if(recordCount <= 0) then
            begin
              DispName.Caption := 'New Setup' ;
              fMode := 'NEW' ;
              ClearSceen ;
            end else
            begin
              DispName.Caption := fUserID ;
              fMode := 'EDIT' ;
              while not eof do
                begin

                   if(FieldByName('PER_Appication').AsString = 'Bank Data') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel18);
                            Tempbtn.Parent := RzPanel18 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel18);
                            Tempbtn.Parent := RzPanel18 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel18);
                            Tempbtn.Parent := RzPanel18 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel18);
                            Tempbtn.Parent := RzPanel18 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel18);
                            Tempbtn.Parent := RzPanel18 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;


                     end else
                   if(FieldByName('PER_Appication').AsString = 'BRN Data') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel19);
                            Tempbtn.Parent := RzPanel19 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel19);
                            Tempbtn.Parent := RzPanel19 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel19);
                            Tempbtn.Parent := RzPanel19 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel19);
                            Tempbtn.Parent := RzPanel19 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel19);
                            Tempbtn.Parent := RzPanel19 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                     end else
                   if(FieldByName('PER_Appication').AsString = 'Account Data') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel20);
                            Tempbtn.Parent := RzPanel20 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel20);
                            Tempbtn.Parent := RzPanel20 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel20);
                            Tempbtn.Parent := RzPanel20 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel20);
                            Tempbtn.Parent := RzPanel20 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel20);
                            Tempbtn.Parent := RzPanel20 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                     end else
                   if(FieldByName('PER_Appication').AsString = 'USER Data') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel21);
                            Tempbtn.Parent := RzPanel21 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel21);
                            Tempbtn.Parent := RzPanel21 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel21);
                            Tempbtn.Parent := RzPanel21 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel21);
                            Tempbtn.Parent := RzPanel21 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel21);
                            Tempbtn.Parent := RzPanel21 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                     end else
                   if(FieldByName('PER_Appication').AsString = 'Advance Setup')then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel22);
                            Tempbtn.Parent := RzPanel22 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel22);
                            Tempbtn.Parent := RzPanel22 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel22);
                            Tempbtn.Parent := RzPanel22 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel22);
                            Tempbtn.Parent := RzPanel22 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel22);
                            Tempbtn.Parent := RzPanel22 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                     end else
                   if(FieldByName('PER_Appication').AsString = 'HardWare Setup') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel23);
                            Tempbtn.Parent := RzPanel23 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel23);
                            Tempbtn.Parent := RzPanel23 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel23);
                            Tempbtn.Parent := RzPanel23 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel23);
                            Tempbtn.Parent := RzPanel23 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel23);
                            Tempbtn.Parent := RzPanel23 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                     end else
                   if(FieldByName('PER_Appication').AsString = 'Cheque Design') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel24);
                            Tempbtn.Parent := RzPanel24 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel24);
                            Tempbtn.Parent := RzPanel24 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel24);
                            Tempbtn.Parent := RzPanel24 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel24);
                            Tempbtn.Parent := RzPanel24 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel24);
                            Tempbtn.Parent := RzPanel24 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                     end else
                   if(FieldByName('PER_Appication').AsString = 'Transaction') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel25);
                            Tempbtn.Parent := RzPanel25 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel25);
                            Tempbtn.Parent := RzPanel25 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel25);
                            Tempbtn.Parent := RzPanel25 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel25);
                            Tempbtn.Parent := RzPanel25 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel25);
                            Tempbtn.Parent := RzPanel25 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                     end else
                   if(FieldByName('PER_Appication').AsString = 'Report') then
                     begin
                        if(FieldByName('PER_Access').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel26);
                            Tempbtn.Parent := RzPanel26 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 2 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Create').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel26);
                            Tempbtn.Parent := RzPanel26 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 3 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;

                        if(FieldByName('PER_Modify').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel26);
                            Tempbtn.Parent := RzPanel26 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 1 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Delete').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel26);
                            Tempbtn.Parent := RzPanel26 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 5 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                        if(FieldByName('PER_Print').AsBoolean) then
                          begin
                            Tempbtn := TRzToolButton.Create(RzPanel26);
                            Tempbtn.Parent := RzPanel26 ;
                            Tempbtn.Images := ImageList1 ;
                            Tempbtn.ImageIndex := 4 ;
                            Tempbtn.Align := alLeft ;
                            Tempbtn.OnEndDrag := RzP1EndDrag ;
                            Tempbtn.DragMode := dmAutomatic ;
                          end;
                     end ;
                 Next ;
                end;

            end;
          Active := false ;
          Free ;

        end;
end;

Procedure TfrmPermission.StartPer(inUserID : String) ;
begin
  fUserID := inUserID ;
  ShowScreen ;


end;

procedure TfrmPermission.RzPanel9DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin

  if(Source.ClassName = TRzToolButton.ClassName) then Accept := true ;

//  if(RzPanel18.)
end;

procedure TfrmPermission.RzPanel9DragDrop(Sender, Source: TObject; X,
  Y: Integer);
Var Tempbtn : TRzToolButton ;
begin
  if(Source.ClassName <> TRzToolButton.ClassName) then Exit ;
  if(CheckHave(TRzPanel(Sender),TRzToolButton(Source))) then Exit ;
  Tempbtn := TRzToolButton.Create(TRzPanel(Sender));
  Tempbtn.Parent := TRzPanel(Sender) ;
  Tempbtn.Images := ImageList1 ;
  Tempbtn.ImageIndex := TRzToolButton(Source).ImageIndex ;
  Tempbtn.Align := alLeft ;
  Tempbtn.PopupMenu := M1 ;
  Tempbtn.OnClick := ClickEvent ;
  Tempbtn.OnEndDrag := RzP1EndDrag ;
  Tempbtn.DragMode := dmAutomatic ;
end;

function TfrmPermission.CheckHave(cPage : TRzPanel; cControl : TRzToolButton) : Boolean;
var Rec : Integer ;
begin
   CheckHave := False ;
   for Rec := 0 to cPage.ControlCount - 1 do
     begin
       if(cPage.Controls[Rec].ClassName = TRzToolButton.ClassName) then
         begin
           if(TRzToolButton(cPage.Controls[Rec]).ImageIndex = cControl.ImageIndex) then
             begin
                CheckHave := true ;
                Break ;
             end;
         end;
     end;
end;

procedure TfrmPermission.btnCancelDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
    if(Source.ClassName = TRzToolButton.ClassName) then
    begin
      if(TRzToolButton(Source).Name = btnAccess.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnCreate.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnModify.Name) Then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnDelete.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnPrint.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
        Accept := true ;
    end;
end;

procedure TfrmPermission.btnCancelDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
    if(Source.ClassName = TRzToolButton.ClassName) then
    begin
//      if(TRzToolButton(Source).Name = btnAccess.Name) then Exit ;
//      if(TRzToolButton(Source).Name = btnCreate.Name) then Exit ;
//      if(TRzToolButton(Source).Name = btnModify.Name) then Exit ;
//      if(TRzToolButton(Source).Name = btnDelete.Name) then Exit ;
//      if(TRzToolButton(Source).Name = btnPrint.Name) then Exit ;
//      TRzPanel(TRzToolButton(Source).Parent).Controls[TRzToolButton(Source).]
//      ShowMessage() ;    \
      TRzToolButton(Source).BeginDrag(false);
      TRzToolButton(Source).Destroy ;

    end;
end;

procedure TfrmPermission.RzGroup1Items1Click(Sender: TObject);
begin
  frmPermission.Close ;
end;

Procedure TfrmPermission.ClickEvent(Sender: TObject) ;
begin
  //======
end;

procedure TfrmPermission.N1Click(Sender: TObject);
begin
 // ShowMessage(Sender.ClassName);
end;

procedure TfrmPermission.RzPanel1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
    if(Source.ClassName = TRzToolButton.ClassName) then
    begin
      if(TRzToolButton(Source).Name = btnAccess.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnCreate.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnModify.Name) Then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnDelete.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
      if(TRzToolButton(Source).Name = btnPrint.Name) then
         begin
          Accept := false ;
          Exit ;
         end ;
        Accept := true ;
    end;
end;

procedure TfrmPermission.RzPanel1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
//   TRzToolButton(Source).
 //  DragDone(true) ;
//   TRzToolButton(Source).DragMode := dmManual ;
//   DragCanceled ;
//   TRzToolButton(Source).Destroy ;
end;

procedure TfrmPermission.RzPanel1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
 // ShowMessage('End');
end;

procedure TfrmPermission.RzP1EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  if(Target <> nil) then  Sender.Destroy ;
//   ShowMessage('End');
end;

procedure TfrmPermission.RzGroup1Items0Click(Sender: TObject);
var DBSave : TADOQuery ;
    Rec, Rec2 : Integer ;
begin
  DBSave := TADOQuery.Create(nil);
  if(fMode = 'NEW') then
    begin
      with DBSave do
        begin
          Connection := frmDataCenter.ADOConnection1 ;

          for REC := 1 to 9 do
            begin
              SQL.Clear ;
              SQL.Text := ' insert into DBUserPermission '+
                          ' ( '+
                          ' PER_UserID,	PER_Appication, PER_Access, PER_Create,	PER_Modify,	PER_Delete,	PER_Print '+
                          ' ) '+
                          ' Values ( ' ;
                          case Rec of
                           1 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Bank Data')+','+
                                 BoolToStr(CheckHave(RzPanel18,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnPrint))+' ) ' ;
                               end;

                           2 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('BRN Data')+','+
                                 BoolToStr(CheckHave(RzPanel19,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnPrint))+' ) ' ;
                               end;


                           3 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Account Data')+','+
                                 BoolToStr(CheckHave(RzPanel20,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnPrint))+' ) ' ;
                               end;

                           4 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('USER Data')+','+
                                 BoolToStr(CheckHave(RzPanel21,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnPrint))+' ) ' ;
                               end;

                           5 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Advance Setup')+','+
                                 BoolToStr(CheckHave(RzPanel22,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnPrint))+' ) ' ;
                               end;

                           6 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('HardWare Setup')+','+
                                 BoolToStr(CheckHave(RzPanel23,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnPrint))+' ) ' ;
                               end;

                           7 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Cheque Design')+','+
                                 BoolToStr(CheckHave(RzPanel24,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnPrint))+' ) ' ;
                               end;

                           8 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Transaction')+','+
                                 BoolToStr(CheckHave(RzPanel25,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnPrint))+' ) ' ;
                               end;

                           9 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Report')+','+
                                 BoolToStr(CheckHave(RzPanel26,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnPrint))+' ) ' ;
                               end;

                          end;

                  ExecSQL ;
            end;


        end;
     end else
     if(fMode = 'EDIT') then
       begin
      with DBSave do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Delete from DBUserPermission '+
                      ' Where PER_UserID = '+QuotedStr(fUserID) ;
          ExecSQL ;


          for REC := 1 to 9 do
            begin
              SQL.Clear ;
              SQL.Text := ' insert into DBUserPermission '+
                          ' ( '+
                          ' PER_UserID,	PER_Appication, PER_Access, PER_Create,	PER_Modify,	PER_Delete,	PER_Print '+
                          ' ) '+
                          ' Values ( ' ;
                          case Rec of
                           1 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Bank Data')+','+
                                 BoolToStr(CheckHave(RzPanel18,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel18,btnPrint))+' ) ' ;
                               end;

                           2 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('BRN Data')+','+
                                 BoolToStr(CheckHave(RzPanel19,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel19,btnPrint))+' ) ' ;
                               end;


                           3 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Account Data')+','+
                                 BoolToStr(CheckHave(RzPanel20,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel20,btnPrint))+' ) ' ;
                               end;

                           4 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('USER Data')+','+
                                 BoolToStr(CheckHave(RzPanel21,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel21,btnPrint))+' ) ' ;
                               end;

                           5 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('SoftWare Setup')+','+
                                 BoolToStr(CheckHave(RzPanel22,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel22,btnPrint))+' ) ' ;
                               end;

                           6 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('HardWare Setup')+','+
                                 BoolToStr(CheckHave(RzPanel23,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel23,btnPrint))+' ) ' ;
                               end;

                           7 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Cheque Design')+','+
                                 BoolToStr(CheckHave(RzPanel24,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel24,btnPrint))+' ) ' ;
                               end;

                           8 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Transaction')+','+
                                 BoolToStr(CheckHave(RzPanel25,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel25,btnPrint))+' ) ' ;
                               end;

                           9 : begin
                                 SQL.Text := SQL.Text +
                                 Quotedstr(fUserID)+',' +
                                 Quotedstr('Report')+','+
                                 BoolToStr(CheckHave(RzPanel26,btnAccess))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnCreate))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnModify))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnDelete))+','+
                                 BoolToStr(CheckHave(RzPanel26,btnPrint))+' ) ' ;
                               end;

                          end;

                  ExecSQL ;
            end;
          end;  

     End;
     frmPermission.Close ;
end;

procedure TfrmPermission.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree ;
end;

end.
