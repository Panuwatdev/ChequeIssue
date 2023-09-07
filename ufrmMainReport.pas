unit ufrmMainReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxPreview, SUIForm, ExtCtrls, RzPanel, frxDBSet, DB,
   ADODB, RzButton, StdCtrls, Mask, RzEdit, RzCmboBx, RzGroupBar, ImgList,
  ExcelXP, OleServer, Grids, DBGrids, Provider, DBClient;

type
  TfrmMainReport = class(TForm)
    RzPanel1: TRzPanel;
    suiForm1: TsuiForm;
    frxPreview1: TfrxPreview;
    frxReport1: TfrxReport;
    RzGroupBar1: TRzGroupBar;
    ReportGroup: TRzGroup;
    BankGroup: TRzGroup;
    edtBank: TRzComboBox;
    BranchGroup: TRzGroup;
    edtBranch: TRzComboBox;
    StartDateGroup: TRzGroup;
    edtStartDate: TRzDateTimeEdit;
    EndDateGroup: TRzGroup;
    edtEndDate: TRzDateTimeEdit;
    AccountGroup: TRzGroup;
    edtAcc: TRzComboBox;
    UserGroup: TRzGroup;
    edtUser: TRzComboBox;
    RzGroup1: TRzGroup;
    frxDBDataset1: TfrxDBDataset;
    ADOQuery1: TADOQuery;
    DBTrn2: TADOQuery;
    DBTrn2BankName: TStringField;
    DBTrn2BRNName: TStringField;
    DBTrn2TRN_JobID: TWideStringField;
    DBTrn2TRN_JobDescr: TWideStringField;
    DBTrn2TRN_BookQty: TIntegerField;
    DBTrn2TRN_Amount: TFloatField;
    DBTrn2TRN_JobCreateDate: TDateTimeField;
    DBTrn2TRN_JobRunningDate: TDateTimeField;
    DBTrn2TRN_JobFinishDate: TDateTimeField;
    DBTrn2TRN_PrintCount: TIntegerField;
    DBTrn2TRN_Status: TWideStringField;
    DBTrn2TRN_StartSerailData: TWideStringField;
    DBTrn2TRN_EndSerialData: TWideStringField;
    DBTrn2TRN_OfficeData: TWideStringField;
    DBTrn2TRN_BranchData: TWideStringField;
    DBTrn2TRN_AccountData: TWideStringField;
    DBTrn2TRN_TCData: TWideStringField;
    DBTrn2TRN_AmtData: TWideStringField;
    DBTrn2TRN_ChequeProfilesID: TIntegerField;
    DBTrn2TRN_JobCreateByUserID: TWideStringField;
    DBTrn2TRN_CreateByPCMachineNo: TWideStringField;
    DBTrn2TRN_CreateByMachineNo: TWideStringField;
    DBTrn2TRN_JobRunByUserID: TWideStringField;
    DBTrn2TRN_JobFinishByUserID: TWideStringField;
    DBTrn2TRN_CustomerRecieveDate: TDateTimeField;
    DBTrn2TRN_SentToCustomerBy: TWideStringField;
    DBTrn2TRN_CustomerRecieveTime: TDateTimeField;
    DBTrn2TRN_StausOfPrint: TBooleanField;
    DBTrn2TRN_UserId: TWideStringField;
    DBTrn2TRN_ChequeFormat: TWideStringField;
    DBTrn2TRN_Queue: TIntegerField;
    DBTrn2TRN_CancelReason: TWideStringField;
    DBTrn2TRN_Time: TDateTimeField;
    DBTrn2TRN_Document: TWideStringField;
    DBTrn2TRN_Input: TWideStringField;
    DBTrn2TRN_Fields: TWideStringField;
    DBTrn2TRN_OfficeWork: TWideStringField;
    DBTrn2TRN_BranchWork: TWideStringField;
    DBTrn2TRN_FrontDocQty: TIntegerField;
    DBTrn2TRN_FrontRun: TIntegerField;
    DBTrn2TRN_BodyDocQty: TIntegerField;
    DBTrn2TRN_BodyRun: TIntegerField;
    DBTrn2TRN_REQDocQty: TIntegerField;
    DBTrn2TRN_REQRun: TIntegerField;
    DBTrn2TRN_BackDocQty: TIntegerField;
    DBTrn2TRN_BackRun: TIntegerField;
    DBTrn2TRN_DocRunning: TIntegerField;
    DBTrn2TRN_BookRunning: TIntegerField;
    DBTrn2TRN_ChequeCurrent: TWideStringField;
    DBTrn2TRN_StatusDisp: TStringField;
    DBTrn2Status: TStringField;
    DBTransactionCustomer: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    IntegerField1: TIntegerField;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    DateTimeField3: TDateTimeField;
    IntegerField2: TIntegerField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    IntegerField3: TIntegerField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    WideStringField14: TWideStringField;
    WideStringField15: TWideStringField;
    DateTimeField4: TDateTimeField;
    WideStringField16: TWideStringField;
    DateTimeField5: TDateTimeField;
    BooleanField1: TBooleanField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    IntegerField4: TIntegerField;
    WideStringField19: TWideStringField;
    DateTimeField6: TDateTimeField;
    WideStringField20: TWideStringField;
    WideStringField21: TWideStringField;
    WideStringField22: TWideStringField;
    WideStringField23: TWideStringField;
    WideStringField24: TWideStringField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    IntegerField13: TIntegerField;
    IntegerField14: TIntegerField;
    WideStringField25: TWideStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    DBTransactionCustomerAccName: TWideStringField;
    DBUserTrans: TADOQuery;
    StringField5: TStringField;
    StringField6: TStringField;
    WideStringField26: TWideStringField;
    WideStringField27: TWideStringField;
    IntegerField15: TIntegerField;
    FloatField2: TFloatField;
    DateTimeField7: TDateTimeField;
    DateTimeField8: TDateTimeField;
    DateTimeField9: TDateTimeField;
    IntegerField16: TIntegerField;
    WideStringField28: TWideStringField;
    WideStringField29: TWideStringField;
    WideStringField30: TWideStringField;
    WideStringField31: TWideStringField;
    WideStringField32: TWideStringField;
    WideStringField33: TWideStringField;
    WideStringField34: TWideStringField;
    WideStringField35: TWideStringField;
    IntegerField17: TIntegerField;
    WideStringField36: TWideStringField;
    WideStringField37: TWideStringField;
    WideStringField38: TWideStringField;
    WideStringField39: TWideStringField;
    WideStringField40: TWideStringField;
    DateTimeField10: TDateTimeField;
    WideStringField41: TWideStringField;
    DateTimeField11: TDateTimeField;
    BooleanField2: TBooleanField;
    WideStringField42: TWideStringField;
    WideStringField43: TWideStringField;
    IntegerField18: TIntegerField;
    WideStringField44: TWideStringField;
    DateTimeField12: TDateTimeField;
    WideStringField45: TWideStringField;
    WideStringField46: TWideStringField;
    WideStringField47: TWideStringField;
    WideStringField48: TWideStringField;
    WideStringField49: TWideStringField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    IntegerField21: TIntegerField;
    IntegerField22: TIntegerField;
    IntegerField23: TIntegerField;
    IntegerField24: TIntegerField;
    IntegerField25: TIntegerField;
    IntegerField26: TIntegerField;
    IntegerField27: TIntegerField;
    IntegerField28: TIntegerField;
    WideStringField50: TWideStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    WideStringField51: TWideStringField;
    DBUserTransUserName: TStringField;
    DBLog: TADOQuery;
    RzPanel2: TRzPanel;
    btnTools: TRzToolButton;
    btnPreview: TRzToolButton;
    btnPrint: TRzToolButton;
    ImageList1: TImageList;
    ExcelApplication1: TExcelApplication;
    ExcelWorkbook1: TExcelWorkbook;
    QrTnsIn: TADOQuery;
    CdsTnsIn: TClientDataSet;
    DsTNSInOut: TDataSource;
    PrTnsIn: TDataSetProvider;
    SaveDialog1: TSaveDialog;
    CdsTnsInFF_Qty: TIntegerField;
    CdsTnsInCmf: TWideStringField;
    CdsTnsInCcy: TWideStringField;
    CdsTnsInRevenu: TFloatField;
    CdsTnsInCommission: TFloatField;
    CdsTnsInTRD_BookQty: TIntegerField;
    CdsTnsInTRD_SerialNo: TWideStringField;
    CdsTnsInTRD_AccountID: TWideStringField;
    CdsTnsInTRD_AccountName: TWideStringField;
    CdsTnsInTRD_Amt: TFloatField;
    CdsTnsInTRD_Rev: TFloatField;
    CdsTnsInTRD_Cmms: TFloatField;
    CdsTnsInTRD_RT: TStringField;
    CdsTnsIntrd_serialend: TWideStringField;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    ADOQuery1FF_Qty: TIntegerField;
    ADOQuery1Cmf: TWideStringField;
    ADOQuery1Ccy: TWideStringField;
    ADOQuery1Revenu: TFloatField;
    ADOQuery1Commission: TFloatField;
    ADOQuery1Addr1: TWideStringField;
    ADOQuery1Addr2: TWideStringField;
    ADOQuery1TRD_BookQty: TIntegerField;
    ADOQuery1TRD_SerialNo: TWideStringField;
    ADOQuery1TRD_AccountID: TWideStringField;
    ADOQuery1TRD_AccountName: TWideStringField;
    ADOQuery1TRD_Amt: TFloatField;
    ADOQuery1TRD_Rev: TFloatField;
    ADOQuery1TRD_Cmms: TFloatField;
    ADOQuery1TRD_RT: TStringField;
    ADOQuery1trd_serialend: TWideStringField;
    QrTnsInFF_Qty: TIntegerField;
    QrTnsInCmf: TWideStringField;
    QrTnsInCcy: TWideStringField;
    QrTnsInRevenu: TFloatField;
    QrTnsInCommission: TFloatField;
    QrTnsInAddr1: TWideStringField;
    QrTnsInAddr2: TWideStringField;
    QrTnsInTRD_BookQty: TIntegerField;
    QrTnsInTRD_SerialNo: TWideStringField;
    QrTnsInTRD_AccountID: TWideStringField;
    QrTnsInTRD_AccountName: TWideStringField;
    QrTnsInTRD_Amt: TFloatField;
    QrTnsInTRD_Rev: TFloatField;
    QrTnsInTRD_Cmms: TFloatField;
    QrTnsInTRD_RT: TStringField;
    QrTnsIntrd_serialend: TWideStringField;
    CdsTnsInAddr1: TWideStringField;
    CdsTnsInAddr2: TWideStringField;
    procedure ReportGroupItems0Click(Sender: TObject);
    procedure ReportGroupItems1Click(Sender: TObject);
    procedure ReportGroupItems2Click(Sender: TObject);

    procedure BtPreviewClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure btnToolsClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    fMSGUserNotAccess : String ;
    fMSGConfirmLoginExit : String ;
    fRPTAllTransaction  : String ;
    fRPTSumeryJob       : String ;
    fRPTSumeryFormat    : String ;
    fRPTSummeryBranch   : String ;
    fRPTSummeryBank     : String ;
    fRPTSummeryAccount  : String ;
    fRPTSummeryUser     : String ;
    fRPTAuditLog        : String ;
    fMSGExitApplication : String ;

    ApplicationPath : String ;
    DispHD : String ;
    TypeOfPrint : String ;

    //Procedure GetMsg();
//    Function GetAccessRight(ProcessName : String): Boolean ;
    Procedure ListBankMaster() ;
    Procedure ListBranchMaster();
    Function GetNameOfBank(Langauge : String): String ;
    Function GetNameOfBranch(Langauge : String; Bank : String): String ;
    Procedure LoadAccount() ;
    Procedure LoadUser();

    Procedure PrnPrev();

    //procedure ExporttoExcel();

    procedure ExportTns();

    procedure ExportSummariz();



    //Procedure LoadScreenMSG();

  public
    { Public declarations }
  end;

var
  frmMainReport: TfrmMainReport;

implementation
uses ufrmDatacenter,ufrmSlcPrnAdvice;

{$R *.dfm}

procedure TfrmMainReport.ReportGroupItems0Click(Sender: TObject);
begin
  //DataCenter.GetSaveWorkLog(fCommonData.UserUesd,'Select '+ReportGroup.Items[0].Caption,frmMainMenuPage.Caption);
  BankGroup.Visible := false ;
  BranchGroup.Visible := false ;
  StartDateGroup.Visible := true ;
  EndDateGroup.Visible := true ;
  AccountGroup.Visible := false ;
  UserGroup.Visible := false ;
  
end;

procedure TfrmMainReport.ReportGroupItems1Click(Sender: TObject);
begin
  //DataCenter.GetSaveWorkLog(fCommonData.UserUesd,'Select '+ReportGroup.Items[1].Caption,frmMainMenuPage.Caption);
  BankGroup.Visible := false ;
  BranchGroup.Visible := false ;
  StartDateGroup.Visible := true ;
  EndDateGroup.Visible := true ;
  AccountGroup.Visible := false ;
  UserGroup.Visible := false ;
end;

procedure TfrmMainReport.ReportGroupItems2Click(Sender: TObject);
begin
  //DataCenter.GetSaveWorkLog(fCommonData.UserUesd,'Select '+ReportGroup.Items[2].Caption,frmMainMenuPage.Caption);
  BankGroup.Visible := false ;
  BranchGroup.Visible := false ;
  StartDateGroup.Visible := true ;
  EndDateGroup.Visible := true ;
  AccountGroup.Visible := false ;
  UserGroup.Visible := false ;
end;



procedure TfrmMainReport.BtPreviewClick(Sender: TObject);
begin
   PrnPrev();
end;

procedure TfrmMainReport.PrnPrev();
var OpInsert   : String ;
    DateBtween : String;
begin
 //ShowMessage(inttostr(ReportGroup.SelectedItem.Index));

 if edtStartDate.Text = edtEndDate.Text then
 begin
   DateBtween :=  FormatDatetime('dd-mm-yyyy',edtStartDate.Date);
 end else
   DateBtween :=  FormatDatetime('dd-mm-yyyy',edtStartDate.Date) +' - ' + FormatDatetime('dd/mm/yyyy',edtEndDate.Date);

  case ReportGroup.SelectedItem.Index of
   0 : begin

      //DataCenter.GetSaveWorkLog(fCommonData.UserUesd,' Preview '+fRPTAllTransaction,frmMainMenuPage.Caption);
      DispHD := fRPTAllTransaction ;
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
                      ' (select DBAccountMaster.ACC_Address1 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr1, '+
                      ' (select DBAccountMaster.ACC_Address2 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr2, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;



          //SQL.Text := ' Select * from DBTransactionDetails' ;
                      {if(edtBank.ItemIndex > 0) then
                        begin
                          SQL.Text := SQL.Text + ' DTR_OfficeWork = '+QuotedStr(trim(edtBank.Value))+' And ' ;
                        end;
                      if(edtBranch.ItemIndex > 0) then
                        begin
                          SQL.Text := SQL.Text + ' DTR_BranchWork = '+QuotedStr(Trim(edtBranch.Value))+' and ' ;
                        end;  }

                        SQL.Text := SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                        ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date))+   //;

                        ' and TRD_Repared = 0 order by TRD_SerialNo'  ;

                      //SQL.Text := SQL.Text + ' DTR_Date = '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                      //' order by DTR_JobID,DTR_OfficeWork, DTR_BranchWork ' ;  }
                      //ShowMessage(SQL.Text) ;
                      //Edit1.Text := SQL.Text;


                      //ShowMessage(frmDatacenter.ADOConnection1.ConnectionString);

                      //' where TNS.Transaction_Date between '+QuotedStr(StartDate) +' and '+QuotedStr(endDate) +

         Active := true ;
         //Open;

         //Edit1.Text := SQL.Text;
        end;

        frxDBDataset1.DataSet := ADOQuery1 ;
        frxReport1.DataSet := frxDBDataset1 ;
        frxReport1.Preview := frxPreview1 ;

        frxPreview1.Zoom := 1 ;
        frxReport1.LoadFromFile(ApplicationPath+'\Report\Tns.fr3') ;
        frxReport1.Variables['SDate'] := ''''+DateBtween+'''';
        frxReport1.ShowReport ;    
       end ;


   1: begin
          
      //DataCenter.GetSaveWorkLog(fCommonData.UserUesd,' Preview '+fRPTAllTransaction,frmMainMenuPage.Caption);
      DispHD := fRPTAllTransaction ;
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
                      ' (select DBAccountMaster.ACC_Address1 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr1, '+
                      ' (select DBAccountMaster.ACC_Address2 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr2, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;

                        SQL.Text := SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                        ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date))+  //;

                        ' and TRD_Repared = 0  order by TRD_SerialNo '  ;

         Active := true ;
        end;
           frxDBDataset1.DataSet := ADOQuery1 ;
           frxReport1.DataSet := frxDBDataset1 ;
           frxReport1.Preview := frxPreview1 ;

           frxPreview1.Zoom := 1 ;


           frxReport1.LoadFromFile(ApplicationPath+'\Report\Adv_Deb.fr3') ;
           frxReport1.ShowReport ;

           

           {frxReport1.LoadFromFile(ApplicationPath+'\Report\Tns_Adv.fr3') ;
           frxReport1.Variables['SDate'] := ''''+DateBtween+'''';
           frxReport1.ShowReport ; }
       end;

   2: begin
          
      //DataCenter.GetSaveWorkLog(fCommonData.UserUesd,' Preview '+fRPTAllTransaction,frmMainMenuPage.Caption);
      DispHD := fRPTAllTransaction ;
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
                      ' (select DBAccountMaster.ACC_Address1 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr1, '+
                      ' (select DBAccountMaster.ACC_Address2 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr2, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;

                        SQL.Text := SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                        ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date)) + //;
                        ' and TRD_Repared = 0 order by TRD_SerialNo '  ;

         Active := true ;
        end;
           frxDBDataset1.DataSet := ADOQuery1 ;
           frxReport1.DataSet := frxDBDataset1 ;
           frxReport1.Preview := frxPreview1 ;

           frxPreview1.Zoom := 1 ;

           frxReport1.LoadFromFile(ApplicationPath+'\Report\Tns_Adv.fr3') ;
           frxReport1.Variables['SDate'] := ''''+DateBtween+'''';
           frxReport1.ShowReport ;
       end;

  //frmSlcPrnAdvice.ShowModal;
  end;

 // end;

  

end;

Procedure TfrmMainReport.LoadAccount() ;
var DBMasAcc : TADOQuery ;
    AccCode : String ;
    AccName : String ;
begin
  edtAcc.Clear ;
  DBMasAcc := TADOQuery.Create(nil);
    with DBMasAcc do
      begin
        //ConnectionString := fCommonData.ConnectionStr ;
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBAccountMaster ' ;
        if(edtBank.ItemIndex <> 0) then
          begin
           SQL.Text := SQL.Text + 'Where ACC_Office = '+QuotedStr(edtBank.Value) ;
           if(edtBranch.ItemIndex <> 0) then SQL.Text := SQL.Text + ' and ACC_Branch = '+QuotedStr(edtBranch.Value) ;
          end ;
        Active := true ;
        edtAcc.AddItemValue('[ALL] of Account','ALL');
         while not eof do
           begin
             AccCode := trim(FieldByname('ACC_ID').AsString) ;
             AccName := trim(FieldByname('ACC_Description').AsString) ;
             edtAcc.AddItemValue(AccCode+' '+AccName,AccCode) ;
             Next ;
           end;
        edtAcc.ItemIndex := 0 ;
        Active := false ;
        Free;
      end;
end;

Procedure TfrmMainReport.LoadUser();
var DBUser : TADOQuery ;
    UserCode : STring ;
    UserName : String ;
begin
  edtUser.Clear ;
  DBUser := TADOQuery.Create(nil);
    with DBUser do
      begin
        //ConnectionString := fCommonData.ConnectionStr ;
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBUserMaster ' ;
        if(edtBank.ItemIndex <> 0) then
          begin
           SQL.Text := SQL.Text + 'Where USE_LinkOffice = '+QuotedStr(edtBank.Value) ;
           if(edtBranch.ItemIndex <> 0) then SQL.Text := SQL.Text + ' and USE_LinkBranch = '+QuotedStr(edtBranch.Value) ;
          end ;
        Active := true ;
          edtUser.AddItemValue('[ALL] All User',UserCode);
          while not eof do
            begin
             UserCode := trim(FieldByname('USE_ID').AsString) ;
             UserName := trim(FieldByname('USE_Name').AsString) ;
             edtUser.AddItemValue(UserCode+' '+UserName,UserCode);
             Next ;
            end;
        edtUser.ItemIndex := 0 ;
        Active := false ;
        Free ;
      end;

end;

Procedure TfrmMainReport.ListBankMaster() ;
var DBBank : TADOQuery ;
    BankDescr : String ;
    BankCode : String ;
    RecDefault : Integer ;
    FieldDisp : String ;
begin

  edtBank.Clear ;
  RecDefault := 1 ;
  //if(fCommonData.DefaultDBLangauge = 'TH') then FieldDisp := 'HOF_AlternetDescr' else
  //if(fCommonData.DefaultDBLangauge = 'EN') then FieldDisp := 'HOF_DefaultDescr' ;

  FieldDisp := 'HOF_InternationsDescr';

  DBBank := TADOQuery.Create(nil);
    with DBBank do
      begin
        //ConnectionString := fCommonData.ConnectionStr ;
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select TRD_Bank, (Select '+FieldDisp+' from DBOfficeMaster Where TRN_OfficeWork = HOF_ID) As BankName   from DBTransactionDetails '+
                    ' Group by TRD_Bank '+
                    ' Order by TRD_Bank ' ;
        Active := true ;
        if(RecordCount > 0) then
          begin
              edtBank.AddItemValue('[ALL] Transaction All of Bank','ALL');
              while not eof do
                begin
                  BankCode  := trim(FieldByName('TRD_Bank').AsString) ;
                  BankDescr := trim(FieldByName('BankName').AsString) ;
                  edtBank.AddItemValue('['+BankCode+']'+' '+BankDescr,BankCode);
                  Next ;
                end;

           end else
           begin

             edtBank.AddItemValue('[None Data]','None');
           end;
             Active := false ;
             Free;
             edtBank.ItemIndex := 0 ;

      end;

end ;

Procedure TfrmMainReport.ListBranchMaster();
var DBBrn : TADOQuery ;
    Brncode  : String ;
    BrnDescr : string ;
    RecDefault : Integer;
    FieldDisp : String ;
    Insertline : String ;
begin

    edtBranch.Clear ;
    //if(fCommonData.DefaultDBLangauge = 'TH') then FieldDisp := 'BOF_AlternetDescr' else
    //if(fCommonData.DefaultDBLangauge = 'EN') then FieldDisp := 'BOF_DefaultDescr' ;
    if(edtBank.Value = 'None') Then Exit else
    if(edtBank.Value = 'ALL') Then Insertline := '' else Insertline := ' Where TRN_OfficeWork = '+QuotedStr(edtBank.Value) ;
    DBBrn := TADOQuery.Create(nil);
     with DBBrn do
      begin
         //ConnectionString := fCommonData.ConnectionStr ;
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select TRD_Bank, TRD_BRN, '+
                     ' (Select HOF_InternationsDescr from DBOfficeMaster Where TRD_Bank = HOF_ID) As BankName, '+
                     ' (Select BOF_DefaultDescr from DBOfficeMaster,DBBranchMaster Where TRN_OfficeWork = BOF_OfficeLink and TRN_BranchWork = BOF_Code and BOF_OfficeLink = HOF_Code ) As BrnName '+
                     ' from DBTransactionDetails '+ Insertline +
                     ' Group by TRD_Bank, TRD_BRN '+
                     ' Order by TRD_Bank, TRD_BRN ' ;
        Active := true ;
        edtBranch.AddItemValue('[ALL] Transaction All of Branch', 'ALL');
        if(RecordCount > 0) then
          begin

              while not eof do
               begin
                 Brncode  := trim(FieldByName('TRN_BranchWork').AsString) ;
                 edtBranch.AddItemValue('['+BrnCode+']'+' '+trim(FieldByName('BrnName').AsString),BrnCode);
                 next ;
               end;
           end else
           begin
              edtBranch.AddItemValue('[None Data]','None');
           end;
            Active := false ;
            Free;
            edtBranch.ItemIndex := 0 ;
      end ;
   
end;

Function TfrmMainReport.GetNameOfBank(Langauge : String): String ;
var DBBank : TADOQuery ;
begin
   DBBank := TADOQuery.Create(nil);
     with DBBank do
       begin
        //ConnectionString := fCommonData.ConnectionStr ;
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBOfficeMaster '+
                    ' Where HOF_Default = 1' ;
        Active := true ;
         if(Langauge = 'TH') then Result := trim(FieldByName('HOF_AlternetDescr').AsString) else
         if(Langauge = 'EN') Then Result := trim(FieldByName('HOF_DefaultDescr').AsString)  ;
        Active := false ;
        Free ;
       end;
end;
Function TfrmMainReport.GetNameOfBranch(Langauge : String; Bank : String): String ;
var DBBrn : TADOQuery ;
begin
   DBBrn := TADOQuery.Create(nil);
     with DBBrn do
       begin
        //ConnectionString := fCommonData.ConnectionStr ;
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBBranchMaster '+
                    ' Where '+
                    ' BOF_OfficeLink = '+QuotedStr(Bank) +
                    ' and '+
                    ' BOF_Default = 1' ;
        Active := true ;
         if(Langauge = 'TH') then Result := trim(FieldByName('BOF_AlternetDescr').AsString) else
         if(Langauge = 'EN') Then Result := trim(FieldByName('BOF_DefaultDescr').AsString)  ;
        Active := false ;
        Free ;
      end;
end;

procedure TfrmMainReport.FormActivate(Sender: TObject);
begin
   //LoadAccount() ;
   //ReportGroup.SelectedItem.Index := 0;

   //ListBankMaster() ;
   //ListBranchMaster();


   ReportGroup.Items.Items[0].Selected := true;


   BankGroup.Visible := false ;
   BranchGroup.Visible := false ;
   StartDateGroup.Visible := true ;
   EndDateGroup.Visible := true ;
   AccountGroup.Visible := false ;
   UserGroup.Visible := false ;    
   
end;

procedure TfrmMainReport.FormShow(Sender: TObject);
begin
   ApplicationPath := ExtractFilePath(Application.ExeName) ;
end;



procedure TfrmMainReport.btnToolsClick(Sender: TObject);
begin
   frxReport1.SelectPrinter ;
end;

procedure TfrmMainReport.btnPrintClick(Sender: TObject);
begin
   frxReport1.Print ;
end;

procedure TfrmMainReport.btnPreviewClick(Sender: TObject);
begin
   PrnPrev();
end;

procedure TfrmMainReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree ;
end;

{procedure TfrmMainReport.ExporttoExcel();
var
    StartDate,EndDate,SWhere   :  String;
    SCashBRN_ID,SCashUID       :  String;
    SCus_ID,SCusBRN_ID,SCusGrp_ID,ScusUID  :String;
    Idx : Integer;

    objExcel : TExcelApplication;
    objWB    : _Workbook;

    Irow : integer;
    Icol : integer;
    i,j  : integer;

begin

  // StartDate := SqlDate(datetostr(DateTimePicker1.Date));
  // EndDate   := SqlDate(datetostr(DateTimePicker2.Date));
     //==
   //  if (CbCashInOut.ItemIndex = 4) then
   //  begin
        //CbSelectData.Enabled := false;

        QrTnsIn.Active       := false;
        CdsTnsIn.Active      := false;
        QrTnsIn.ConnectionString := '' ;
        QrTnsIn.Connection := frmDataCenter.ADOConnection1 ;

        //QrTnsIn.Active       := false;

        QrTnsIn.SQL.Clear;
        {QrTnsIn.SQL.Text     := 'select TNS.Transaction_ID ,TNS.Branch_ID, '+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0005')+' THEN '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('1000 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0004')+' THEN  '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('500 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0003')+' THEN  '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('100 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0002')+' THEN  '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('50 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0001')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('20 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0006')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('10 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0005')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('5 Baht')+',' +
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0004')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('2 Baht')+',' +
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0003')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END)'+QuotedStr('1 Baht') +
                                ' from TB_transaction TNS  '+
                                ' left join TB_transactiondt TNSdt   ' +
                                ' on TNS.Transaction_ID = TNSdt.Transaction_ID '+
                                ' where TNS.Transaction_Date between '+QuotedStr(StartDate) +' and '+QuotedStr(endDate) +
                                ' GROUP BY    Tns.Transaction_ID,TNS.Branch_ID ' +
                                ' ORDER BY    Tns.Transaction_ID,TNS.Branch_ID ' ;      }

       {QrTnsIn.SQL.Text     :=  ' select '+
                      ' (select FFM_BDQty from DBChequeProperties where FFM_Name = TRD_FormatID) as FF_Qty, '+
                      ' (select DBAccountMaster.ACC_Cmf from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Cmf, '+
                      ' (select DBAccountMaster.ACC_Ccy from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Ccy, '+
                      ' (select DBAccountMaster.ACC_Revenue from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Revenu, '+
                      ' (select DBAccountMaster.ACC_Commission from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Commission, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;

                   QrTnsIn.SQL.Text := QrTnsIn.SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                        ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date))+  //;

                        ' and TRD_Repared = 0'  ;



      CdsTnsIn.Active := true;
  //    end;

   Irow := CdsTNSIn.RecordCount;
   //Icol := DBGrid1.FieldCount;
   Icol := CdsTnsIn.FieldCount;

   objExcel := TExcelApplication.Create(nil);

   objExcel.Visible[0] := TRUE;


   objWB := objExcel.Workbooks.Add(null,1);

   for j:=1 to Icol do
      objWB.Worksheets.Application.Cells.Item[1,j]:= DBGrid1.Fields[j-1].DisplayName;

      CdsTnsIn.First;

      for i:=1 to Irow do
      begin
      for j:=1 to Icol do
          if  j=1 then
              objWB.Worksheets.Application.Cells.Item[i+1,j]:='"'+DBGrid1.Fields[j-1].AsString+'"'
          else
              objWB.Worksheets.Application.Cells.Item[i+1,j]:=DBGrid1.Fields[j-1].AsString;

          CdsTnsIn.Next;

      end;

      objExcel.Free;

end;  }


procedure TfrmMainReport.ExportTns();
var
    StartDate,EndDate,SWhere   :  String;
    SCashBRN_ID,SCashUID       :  String;
    SCus_ID,SCusBRN_ID,SCusGrp_ID,ScusUID  :String;
    Idx : Integer;

    objExcel : TExcelApplication;
    objWB    : _Workbook;

    Irow : integer;
    Icol : integer;
    i,j  : integer;

    RowData : String;

    myFile : TextFile;

    filename :String;

    SCCy,SAcNo,SCmf,SCustommer_Name,SChq_form,Schq_to,SVolume,SDestruc :String;

    IVolum:Integer;
    IDestruct :Integer;


begin

   //SaveDialog1.Options := [ofAllowMultiSelect, ofFileMustExist];
   //SaveDialog1.Filter := 'Text files (*.txt)|*.txt|All files (*.*)|*.*';
   SaveDialog1.Filter := 'Text files (*.csv)';
   //SaveDialog1.FilterIndex := 1; { start the dialog showing all files }
   //SaveDialog1.

   if SaveDialog1.Execute then
         filename := SaveDialog1.FileName+'.csv';



   //AssignFile(myFile,filename);
   //ReWrite(myFile);

   //StartDate := SqlDate(datetostr(DateTimePicker1.Date));
   //EndDate   := SqlDate(datetostr(DateTimePicker2.Date));

     //if (CbCashInOut.ItemIndex = 4) then
     //begin
     //   CbSelectData.Enabled := false;

        QrTnsIn.Active       := false;
        CdsTnsIn.Active      := false;
        QrTnsIn.ConnectionString := '' ;
        QrTnsIn.Connection := frmDataCenter.ADOConnection1 ;

        QrTnsIn.SQL.Clear;
       { QrTnsIn.SQL.Text     := 'select TNS.Transaction_ID ,TNS.Branch_ID, '+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0005')+' THEN '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('1000 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0004')+' THEN  '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('500 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0003')+' THEN  '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('100 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0002')+' THEN  '+
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('50 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('N0001')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('20 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0006')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('10 Baht')+','+
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0005')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('5 Baht')+',' +
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0004')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END) '+QuotedStr('2 Baht')+',' +
                                ' sum(CASE Tnsdt.Denom_ID WHEN '+QuotedStr('C0003')+' THEN  ' +
                                '     Tnsdt.Qty_Total ELSE 0 END)'+QuotedStr('1 Baht') +
                                ' from TB_transaction TNS  '+
                                ' left join TB_transactiondt TNSdt   ' +
                                ' on TNS.Transaction_ID = TNSdt.Transaction_ID '+
                                ' where TNS.Transaction_Date between '+QuotedStr(StartDate) +' and '+QuotedStr(endDate) +
                                ' GROUP BY    Tns.Transaction_ID,TNS.Branch_ID ' +
                                ' ORDER BY    Tns.Transaction_ID,TNS.Branch_ID ' ; }

              QrTnsIn.SQL.Text     :=  ' select '+
                      ' (select FFM_BDQty from DBChequeProperties where FFM_Name = TRD_FormatID) as FF_Qty, '+
                      ' (select DBAccountMaster.ACC_Cmf from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Cmf, '+
                      ' (select DBAccountMaster.ACC_Ccy from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Ccy, '+
                      ' (select DBAccountMaster.ACC_Revenue from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Revenu, '+
                      ' (select DBAccountMaster.ACC_Commission from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Commission, '+
                      ' (select DBAccountMaster.ACC_Address1 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr1, '+
                      ' (select DBAccountMaster.ACC_Address2 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr2, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;

                   QrTnsIn.SQL.Text := QrTnsIn.SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                        ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date))+  //;

                        ' and TRD_Repared = 0'  ;




      CdsTnsIn.Active := true;
     // end;

   //===

   if filename <> '' then
   begin

     AssignFile(myFile,filename);
     ReWrite(myFile);

     Irow := CdsTNSIn.RecordCount;
     //Icol := DBGrid1.FieldCount;
     Icol := CdsTNSIn.FieldCount;

     CdsTnsIn.First;

     WriteLn(myFile, 'CCy'+','+'A/C No'+','+'Cmf'+','+'Custommer Name'+','+'Chq form'+','+'Chq To'+','+'Volume'+','+'Destruction' );

     for i:=1 to Irow do
     begin
        SCCy             := CdsTnsIn.fieldbyname('ccy').AsString;
        SAcNo            := CdsTnsIn.fieldbyname('TRD_AccountID').AsString;
        SCmf             := CdsTnsIn.fieldbyname('Cmf').AsString;
        SCustommer_Name  := CdsTnsIn.fieldbyname('TRD_AccountName').AsString + ' ' + CdsTnsIn.fieldbyname('Addr1').AsString+ ' ' + CdsTnsIn.fieldbyname('Addr2').AsString;
        SChq_form        := CdsTnsIn.fieldbyname('TRD_SerialNo').AsString;
        Schq_to          := CdsTnsIn.fieldbyname('trd_serialend').AsString;
        SVolume          := CdsTnsIn.fieldbyname('TRD_BookQty').AsString;
        //SDestruc         := CdsTnsIn.fieldbyname('').AsString;
        IVolum := strtoint(Svolume);

        if Ivolum < 2 then
        begin
           IDestruct := 0;
        end
        else
        begin
           IDestruct := IVolum - 1;
        end;

        SDestruc := inttostr(IDestruct);


        RowData := '';
      //  for j:=1 to Icol do
      //  begin

           //RowData := RowData + '"'+DBGrid1.Fields[j-1].AsString+'"';
          // RowData := RowData + DBGrid1.Fields[j-1].AsString;

          // RowData := RowData + CdsTnsIn.Fields[j-1].AsString;

            RowData := RowData + SCCy+','+SAcNo+','+SCmf+','+SCustommer_Name+','+SChq_form+','+Schq_to+','+SVolume+','+SDestruc   ;

           //if j < ICol then RowData := RowData + ',';

      //  end;
        WriteLn(myFile, RowData);
        CdsTnsIn.next;
     end;

     CloseFile(myFile);

   end;


end;

procedure TfrmMainReport.ExportSummariz();
var
    StartDate,EndDate,SWhere   :  String;
    SCashBRN_ID,SCashUID       :  String;
    SCus_ID,SCusBRN_ID,SCusGrp_ID,ScusUID  :String;
    Idx : Integer;

    objExcel : TExcelApplication;
    objWB    : _Workbook;

    Irow : integer;
    Icol : integer;
    i,j  : integer;

    RowData : String;

    myFile : TextFile;

    filename :String;

    SCCy,SAcNo,SCmf,SCustommer_Name,SChq_form,Schq_to,SVolume,SDestruc :String;

    SRev,SCmm,SAmt:String;

    IVolum:Integer;
    IDestruct :Integer;


begin

   //SaveDialog1.Options := [ofAllowMultiSelect, ofFileMustExist];
   //SaveDialog1.Filter := 'Text files (*.txt)|*.txt|All files (*.*)|*.*';
   SaveDialog1.Filter := 'Text files (*.csv)';
   //SaveDialog1.FilterIndex := 1; { start the dialog showing all files }
   //SaveDialog1.

   if SaveDialog1.Execute then
         filename := SaveDialog1.FileName+'.csv';




        QrTnsIn.Active       := false;
        CdsTnsIn.Active      := false;
        QrTnsIn.ConnectionString := '' ;
        QrTnsIn.Connection := frmDataCenter.ADOConnection1 ;

        QrTnsIn.SQL.Clear;


              QrTnsIn.SQL.Text     :=  ' select '+
                      ' (select FFM_BDQty from DBChequeProperties where FFM_Name = TRD_FormatID) as FF_Qty, '+
                      ' (select DBAccountMaster.ACC_Cmf from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Cmf, '+
                      ' (select DBAccountMaster.ACC_Ccy from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Ccy, '+
                      ' (select DBAccountMaster.ACC_Revenue from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Revenu, '+
                      ' (select DBAccountMaster.ACC_Commission from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Commission, '+
                      ' (select DBAccountMaster.ACC_Address1 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr1, '+
                      ' (select DBAccountMaster.ACC_Address2 from DBAccountMaster where ACC_ID = TnsDt.TRD_AccountID and Acc_office != '''') as Addr2, '+
                      ' TnsDt.TRD_BookQty,TnsDt.TRD_SerialNo,TnsDt.TRD_AccountID,TnsDt.TRD_AccountName, '+
                      ' TnsDt.TRD_Amt,TnsDt.TRD_Rev,TnsDt.TRD_Cmms,TnsDt.TRD_RT,TnsDt.trd_serialend '+
                      ' from DBTransactionDetails TnsDt  '+
                      ' Where' ;

                   QrTnsIn.SQL.Text := QrTnsIn.SQL.Text + ' TnsDt.TRD_CreateDate between '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtStartDate.Date))+
                        ' and '+ QuotedStr(FormatDatetime('yyyy/mm/dd',edtEndDate.Date))+  //;

                        ' and TRD_Repared = 0'  ;




      CdsTnsIn.Active := true;
     // end;

   //===

   if filename <> '' then
   begin

     AssignFile(myFile,filename);
     ReWrite(myFile);

     Irow := CdsTNSIn.RecordCount;
     //Icol := DBGrid1.FieldCount;
     Icol := CdsTNSIn.FieldCount;

     CdsTnsIn.First;

     WriteLn(myFile, 'SAcNo'+','+'Custommer Name'+','+'Volume'+','+'Revenue'+','+'Commission'+','+'Amout');

     for i:=1 to Irow do
     begin
        SCCy             := CdsTnsIn.fieldbyname('ccy').AsString;
        SAcNo            := CdsTnsIn.fieldbyname('TRD_AccountID').AsString;
        SCmf             := CdsTnsIn.fieldbyname('Cmf').AsString;
        SCustommer_Name  := CdsTnsIn.fieldbyname('TRD_AccountName').AsString+' '+CdsTnsIn.fieldbyname('Addr1').AsString+' '+CdsTnsIn.fieldbyname('Addr2').AsString;
        SChq_form        := CdsTnsIn.fieldbyname('TRD_SerialNo').AsString;
        Schq_to          := CdsTnsIn.fieldbyname('trd_serialend').AsString;
        SVolume          := CdsTnsIn.fieldbyname('TRD_BookQty').AsString;
        //SDestruc         := CdsTnsIn.fieldbyname('').AsString;
        IVolum := strtoint(Svolume);

        SRev             := CdsTnsIn.fieldbyname('TRD_Rev').AsString;
        SCmm             := CdsTnsIn.fieldbyname('TRD_Cmms').AsString;
        SAmt             := CdsTnsIn.fieldbyname('TRD_Amt').AsString;


        if Ivolum < 2 then
        begin
           IDestruct := 0;
        end
        else
        begin
           IDestruct := IVolum - 1;
        end;

        SDestruc := inttostr(IDestruct);


        RowData := '';


            RowData := RowData +SAcNo+','+SCustommer_Name+','+SVolume+','+SRev+','+SCmm+','+SAmt   ;

        WriteLn(myFile, RowData);
        CdsTnsIn.next;
     end;

     CloseFile(myFile);

   end;


end;

procedure TfrmMainReport.RzBitBtn3Click(Sender: TObject);
begin
   PrnPrev();
end;

procedure TfrmMainReport.RzBitBtn1Click(Sender: TObject);
begin
   case ReportGroup.SelectedItem.Index of
      0 : ExportTns();
      2 : ExportSummariz();

    end;
end;

procedure TfrmMainReport.RzBitBtn2Click(Sender: TObject);
begin

   {case ReportGroup.SelectedItem.Index of
      0 : frxReport1.Print ;
      1 : frmSlcPrnAdvice.ShowModal;
      2 : frxReport1.Print ;
    end; }



   frxReport1.Print ;

   //frmSlcPrnAdvice.ShowModal;
end;

end.
