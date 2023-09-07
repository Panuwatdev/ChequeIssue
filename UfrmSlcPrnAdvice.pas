unit UfrmSlcPrnAdvice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxCheckBox, DBClient, Provider,
  ADODB, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid,
  SUIButton, StdCtrls, Mask, RzEdit, RzLabel, RzPanel, ExtCtrls, SUIForm,
  frxClass, frxDBSet;

type
  TfrmSlcPrnAdvice = class(TForm)
    suiForm1: TsuiForm;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    suiButton1: TsuiButton;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Slc: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    QrCustomer: TADOQuery;
    PrCustomer: TDataSetProvider;
    CDSCustomer: TClientDataSet;
    CDSCustomerSlc: TBooleanField;
    DsCustomer: TDataSource;
    CDSCustomerTrd_jobID: TWideStringField;
    CDSCustomerTRD_BookQty: TIntegerField;
    CDSCustomerTRD_SerialNo: TWideStringField;
    CDSCustomerTRD_AccountID: TWideStringField;
    CDSCustomerTRD_AccountName: TWideStringField;
    CDSCustomerTRD_Amt: TFloatField;
    CDSCustomerTRD_Rev: TFloatField;
    CDSCustomerTRD_Cmms: TFloatField;
    CDSCustomerTRD_RT: TStringField;
    CDSCustomertrd_serialend: TWideStringField;
    CDSCustomerTRD_Printfinish: TBooleanField;
    cxGrid1DBTableView1DBColumn1: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn2: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn3: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn4: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn5: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn6: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn7: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn8: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn9: TcxGridDBColumn;
    cxGrid1DBTableView1DBColumn10: TcxGridDBColumn;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    ADOQuery1: TADOQuery;
    ADOQuery1FF_Qty: TIntegerField;
    ADOQuery1Cmf: TWideStringField;
    ADOQuery1Ccy: TWideStringField;
    ADOQuery1TRD_BookQty: TIntegerField;
    ADOQuery1TRD_SerialNo: TWideStringField;
    ADOQuery1TRD_AccountID: TWideStringField;
    ADOQuery1TRD_AccountName: TWideStringField;
    ADOQuery1Revenu: TFloatField;
    ADOQuery1Commission: TFloatField;
    ADOQuery1TRD_Amt: TFloatField;
    ADOQuery1TRD_Rev: TFloatField;
    ADOQuery1TRD_Cmms: TFloatField;
    ADOQuery1trd_serialend: TWideStringField;
    ADOQuery1TRD_RT: TStringField;
    procedure suiButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ApplicationPath : String;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSlcPrnAdvice: TfrmSlcPrnAdvice;

implementation

uses ufrmDatacenter;

{$R *.dfm}

procedure TfrmSlcPrnAdvice.suiButton1Click(Sender: TObject);
var
   txtslc : String;

   i : integer;

begin
   i := 0;

   txtslc := ' and (';

   //--
    CDSCustomer.First;

            While not CDSCustomer.Eof do
            //for i := 0 to CDSCustomer.RecordCount -1  do

            begin
               if CDSCustomer.FieldByName('Slc').AsBoolean = true then
               begin
                  //RunQrUpdate(CDSCustomer.FieldByName('ACC_ID').AsString);
                  if i = 0 then
                  begin
                      txtslc := txtslc + ' TRD_JobID = ' + quotedstr(CDSCustomer.FieldByName('TRD_JobID').AsString);
                      i:=i+1;
                  end
                  else
                  begin
                      txtslc := txtslc + ' or TRD_JobID = ' + quotedstr(CDSCustomer.FieldByName('TRD_JobID').AsString);
                      i:=i+1;
                  end
               end;


               CDSCustomer.Next;
            end;

            txtSlc := txtslc+ ' )';

   //--




   //======
   if(ADOQuery1.Active) then ADOQuery1.Active := false ;
      with ADOQuery1 do
        begin
          ConnectionString := '' ;
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear;
          SQL.Text := ' select '+
                      ' (select FFM_BDQty from DBChequeProperties where FFM_Name = TRD_FormatID) as FF_Qty, '+
                      ' (select DBAccountMaster.ACC_Cmf from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Cmf, '+
                      ' (select DBAccountMaster.ACC_Ccy from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Ccy, '+
                      ' (select DBAccountMaster.ACC_Revenue from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Revenu, '+
                      ' (select DBAccountMaster.ACC_Commission from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Commission, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;

                      //'where TRD_Repared = 0'  + txtSlc;


                        //SQL.Text := SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                       // ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date))+  //;

                        sQL.Text := SQL.Text + ' TnsDt.TRD_CreateDate = '+ QuotedStr(FormatDatetime('yyyy/mm/dd',Date))+

                        ' and TRD_Repared = 0'  + txtSlc;

         Active := true ;

        // ShowMessage(sql.Text);

       // edit1.Text := sql.Text;
        end;
           frxDBDataset1.DataSet := ADOQuery1 ;
           frxReport1.DataSet := frxDBDataset1 ;
           //frxReport1.Preview := frxPreview1 ;

           //frxPreview1.Zoom := 1 ;


           frxReport1.LoadFromFile(ApplicationPath+'\Report\Adv_Deb.fr3') ;
           frxReport1.ShowReport ;

          //frxReport1.Print;


   //======


end;

procedure TfrmSlcPrnAdvice.FormActivate(Sender: TObject);
begin
        CDSCustomer.Active := false;
        QrCustomer.Close;
        QrCustomer.Connection := frmDataCenter.ADOConnection1;
        QrCustomer.SQL.Clear;
        QrCustomer.SQL.Text := ' select  Trd_jobID, '+
                               ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                               ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend,TnsDt.TRD_Printfinish '+
                               ' from DBTransactionDetails TnsDt ' +
                               ' where TRD_CreateDate = '+ QuotedStr(FormatDatetime('yyyy/mm/dd',Date)) +
                               ' and TRD_Repared = 0';

       CDSCustomer.Active := true;                        
end;

procedure TfrmSlcPrnAdvice.FormShow(Sender: TObject);
begin
   ApplicationPath := ExtractFilePath(Application.ExeName)
end;

end.
