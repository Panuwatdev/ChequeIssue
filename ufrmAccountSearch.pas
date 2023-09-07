unit ufrmAccountSearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, SUIImagePanel, StdCtrls, RzLabel, Mask,
  RzEdit, RzPanel, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid;

type
  TfrmAccountSearch = class(TForm)
    suiForm1: TsuiForm;
    RzPanel1: TRzPanel;
    edtName: TRzEdit;
    RzLabel1: TRzLabel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAccountSearch: TfrmAccountSearch;

implementation

{$R *.dfm}

procedure TfrmAccountSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree ;
end;

end.
