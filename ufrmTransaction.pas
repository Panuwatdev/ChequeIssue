unit ufrmTransaction;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, RzPanel, ComCtrls, SUIListView, SUIButton,
  RzGroupBar, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, ADODB, Menus, cxImageComboBox, ImgList,
  OleCtrls, FRS_COMLib_TLB, SUIPopupMenu, cxLabel, cxCurrencyEdit,
  StdCtrls, Mask, RzEdit, frxClass, frxDBSet, cxCheckBox, DBClient,
  Provider;

type
  TfrmTransaction = class(TForm)
    suiForm1: TsuiForm;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    ViewTransaction: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    DBTR: TADOQuery;
    DataSource1: TDataSource;
    ImageList2: TImageList;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    ViewTransactionTRD_JobID: TcxGridDBColumn;
    ViewTransactionTRD_AccountID: TcxGridDBColumn;
    ViewTransactionTRD_FormatID: TcxGridDBColumn;
    ViewTransactionTRD_BookQty: TcxGridDBColumn;
    ViewTransactionTRD_Status: TcxGridDBColumn;
    ViewTransactionTRD_SerialNo: TcxGridDBColumn;
    ViewTransactionTRD_TC: TcxGridDBColumn;
    ViewTransactionTRD_Amount: TcxGridDBColumn;
    ViewTransactionTRD_CreateDate: TcxGridDBColumn;
    ViewTransactionTRD_Finished: TcxGridDBColumn;
    ViewTransactionTRD_AccountName: TcxGridDBColumn;
    ViewTransactionTRD_Price: TcxGridDBColumn;
    Fz: TFrs_com;
    suiPopupMenu1: TsuiPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    RzGroup2: TRzGroup;
    edtWorkDate: TRzDateTimeEdit;
    frxReport1: TfrxReport;
    ADOQuery1: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    ViewTransactionDBColumn1: TcxGridDBColumn;
    PrDBTR: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    ClientDataSet2: TClientDataSet;
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure RzGroup1Items2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzGroup1Items3Click(Sender: TObject);
    procedure RzGroup1Items5Click(Sender: TObject);
    procedure edtWorkDateChange(Sender: TObject);
    procedure RzGroup1Items6Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure RzGroup1Items8Click(Sender: TObject);
    procedure RzGroup1Items7Click(Sender: TObject);
    procedure RzGroup1Items4Click(Sender: TObject);
    procedure RzGroup1Items9Click(Sender: TObject);
  private
    { Private declarations }
    fJobNO  : String ;
    fJobMode : Integer ;
    fJobstart : Integer ;
    fBankID : String ;
    fBRNID  : String ;
    fUSERID : String ;

    fConnected : Boolean ;
    fPort : integer ;
    fBoudRate : String ;
    fDataBit  : String ;
    fStopBit  : String;

    fFDDocUsed : Boolean ;
    fBDDocUsed : Boolean ;
    fRDDocUsed : Boolean ;
    fBCDocUsed : Boolean ;

    fDocLen   : Integer ;
    fDocWidth : Integer ;
    fNewFormat : Boolean ;

    fFDDocQty : Integer ;
    fBDDocQty : Integer ;
    fRDDocQty : Integer ;
    fBCDocQty : Integer ;

    fFDDocStRun : Integer ;
    fBDDocStRun : Integer ;
    fRDDocStRun : Integer ;
    fBCDocStRun : Integer ;

    fFDEStubChequeNo : Integer ;
    fFDEChequeNo     : Integer ;
    fFDEChequeEnd    : Integer ;
    fFDEBankID       : Integer ;
    fFDEBRNID        : Integer ;
    fFDEAccountID    : Integer ;
    fFDETC           : Integer ;
    fFDEAmount       : Integer ;
//    fFDEChequeEnd    : Boolean ;

    fFDESBStubChequeNo : String ;
    fFDESBChequeNo     : String ;
    fFDESBChequeEnd    : String ;
    fFDESBBankID       : String ;
    fFDESBBRNID        : String ;
    fFDESBAccountID    : String ;
    fFDESBTC           : String ;
    fFDESBAmount       : String ;
//    fFDESBChequeEnd    : Boolean ;

    fFDEStubChequeNoPOS : Integer ;
    fFDEChequeNoPOS     : Integer ;
    fFDEChequeEndPOS    : Integer ;
    fFDEBankIDPOS       : Integer ;
    fFDEBRNIDPOS        : Integer ;
    fFDEAccountIDPOS    : Integer ;
    fFDETCPOS           : Integer ;
    fFDEAmountPOS       : Integer ;
//    fFDEChequeEndPOS    : Integer ;


    fBDEStubChequeNo : Integer ;
    fBDEChequeNo     : Integer ;
    fBDEChequeEnd    : Integer ;
    fBDEBankID       : Integer ;
    fBDEBRNID        : Integer ;
    fBDEAccountID    : Integer ;
    fBDETC           : Integer ;
    fBDEAmount       : Integer ;
//    fBDEChequeEnd    : Boolean ;

    fBDESBStubChequeNo : String ;
    fBDESBChequeNo     : String ;
    fBDESBChequeEnd    : String ;
    fBDESBBankID       : String ;
    fBDESBBRNID        : String ;
    fBDESBAccountID    : String ;
    fBDESBTC           : String ;
    fBDESBAmount       : String ;
//    fBDESBChequeEnd    : Boolean ;

    fBDEStubChequeNoPOS : Integer ;
    fBDEChequeNoPOS     : Integer ;
    fBDEChequeEndPOS    : Integer ;
    fBDEBankIDPOS       : Integer ;
    fBDEBRNIDPOS        : Integer ;
    fBDEAccountIDPOS    : Integer ;
    fBDETCPOS           : Integer ;
    fBDEAmountPOS       : Integer ;
//    fBDEChequeEndPOS    : Integer ;

    fRDEStubChequeNo : Integer ;
    fRDEChequeNo     : Integer ;
    fRDEChequeEnd    : Integer ;
    fRDEBankID       : Integer ;
    fRDEBRNID        : Integer ;
    fRDEAccountID    : Integer ;
    fRDETC           : Integer ;
    fRDEAmount       : Integer ;
//    fRDEChequeEnd    : Boolean ;

    fRDESBStubChequeNo : String ;
    fRDESBChequeNo     : String ;
    fRDESBChequeEnd    : String ;
    fRDESBBankID       : String ;
    fRDESBBRNID        : String ;
    fRDESBAccountID    : String ;
    fRDESBTC           : String ;
    fRDESBAmount       : String ;
//    fRDESBChequeEnd    : Boolean ;

    fRDEStubChequeNoPOS : Integer ;
    fRDEChequeNoPOS     : Integer ;
    fRDEChequeEndPOS    : Integer ;
    fRDEBankIDPOS       : Integer ;
    fRDEBRNIDPOS        : Integer ;
    fRDEAccountIDPOS    : Integer ;
    fRDETCPOS           : Integer ;
    fRDEAmountPOS      : Integer ;
//    fRDEChequeEndPOS    : Integer ;

    fBCEStubChequeNo : Integer ;
    fBCDEChequeNo    : Integer ;
    fBCEChequeEnd    : Integer ;
    fBCEBankID       : Integer ;
    fBCEBRNID        : Integer ;
    fBCEAccountID    : Integer ;
    fBCETC           : Integer ;
    fBCEAmount       : Integer ;
//    fBCEChequeEnd    : Boolean ;

    fBCESBStubChequeNo : String ;
    fBCESBChequeNo     : String ;
    fBCESBChequeEnd    : String ;
    fBCESBBankID       : String ;
    fBCESBBRNID        : String ;
    fBCESBAccountID    : String ;
    fBCESBTC           : String ;
    fBCESBAmount       : String ;
//    fBCESBChequeEnd    : Boolean ;

    fBCEStubChequeNoPOS : Integer ;
    fBCEChequeNoPOS     : Integer ;
    fBCEChequeEndPOS    : Integer ;
    fBCEBankIDPOS       : Integer ;
    fBCEBRNIDPOS        : Integer ;
    fBCEAccountIDPOS    : Integer ;
    fBCETCPOS           : Integer ;
    fBCEAmountPOS       : Integer ;
//    fBCEChequeEndPOS    : Integer ;

    fFDFontSize        : Integer ;
    fBDFontSize        : Integer ;
    fRDFontSize        : Integer ;
    fBCFontSize        : Integer ;

    fFDCharNum        : Integer ;
    fBDCharNum        : Integer ;
    fRDCharNum        : Integer ;
    fBCCharNum        : Integer ;

    fFDStartH1L1   : Integer ;
    fFDStartH1L2   : Integer ;
    fFDStartH1L3   : Integer ;
    fFDStartH1L4   : Integer ;

    fFDStartH2L1   : Integer ;
    fFDStartH2L2   : Integer ;
    fFDStartH2L3   : Integer ;
    fFDStartH2L4   : Integer ;


    fBDStartH1L1   : Integer ;
    fBDStartH1L2   : Integer ;
    fBDStartH1L3   : Integer ;
    fBDStartH1L4   : Integer ;

    fBDStartH2L1   : Integer ;
    fBDStartH2L2   : Integer ;
    fBDStartH2L3   : Integer ;
    fBDStartH2L4   : Integer ;


    fRDStartH1L1   : Integer ;
    fRDStartH1L2   : Integer ;
    fRDStartH1L3   : Integer ;
    fRDStartH1L4   : Integer ;

    fRDStartH2L1   : Integer ;
    fRDStartH2L2   : Integer ;
    fRDStartH2L3   : Integer ;
    fRDStartH2L4   : Integer ;

    fBCStartH1L1   : Integer ;
    fBCStartH1L2   : Integer ;
    fBCStartH1L3   : Integer ;
    fBCStartH1L4   : Integer ;

    fBCStartH2L1   : Integer ;
    fBCStartH2L2   : Integer ;
    fBCStartH2L3   : Integer ;
    fBCStartH2L4   : Integer ;

    fFDPL1H1F1     : String ;
    fFDPL1H1F2     : String ;
    fFDPL2H1F1     : String ;
    fFDPL2H1F2     : String ;
    fFDPL3H1F1     : String ;
    fFDPL3H1F2     : String ;
    fFDPL4H1F1     : String ;
    fFDPL4H1F2     : String ;

    fFDPL1H2F1     : String ;
    fFDPL1H2F2     : String ;
    fFDPL2H2F1     : String ;
    fFDPL2H2F2     : String ;
    fFDPL3H2F1     : String ;
    fFDPL3H2F2     : String ;
    fFDPL4H2F1     : String ;
    fFDPL4H2F2     : String ;

    fBDPL1H1F1     : String ;
    fBDPL1H1F2     : String ;
    fBDPL2H1F1     : String ;
    fBDPL2H1F2     : String ;
    fBDPL3H1F1     : String ;
    fBDPL3H1F2     : String ;
    fBDPL4H1F1     : String ;
    fBDPL4H1F2     : String ;

    fBDPL1H2F1     : String ;
    fBDPL1H2F2     : String ;
    fBDPL2H2F1     : String ;
    fBDPL2H2F2     : String ;
    fBDPL3H2F1     : String ;
    fBDPL3H2F2     : String ;
    fBDPL4H2F1     : String ;
    fBDPL4H2F2     : String ;

    fRDPL1H1F1     : String ;
    fRDPL1H1F2     : String ;
    fRDPL2H1F1     : String ;
    fRDPL2H1F2     : String ;
    fRDPL3H1F1     : String ;
    fRDPL3H1F2     : String ;
    fRDPL4H1F1     : String ;
    fRDPL4H1F2     : String ;

    fRDPL1H2F1     : String ;
    fRDPL1H2F2     : String ;
    fRDPL2H2F1     : String ;
    fRDPL2H2F2     : String ;
    fRDPL3H2F1     : String ;
    fRDPL3H2F2     : String ;
    fRDPL4H2F1     : String ;
    fRDPL4H2F2     : String ;

    fBCPL1H1F1     : String ;
    fBCPL1H1F2     : String ;
    fBCPL2H1F1     : String ;
    fBCPL2H1F2     : String ;
    fBCPL3H1F1     : String ;
    fBCPL3H1F2     : String ;
    fBCPL4H1F1     : String ;
    fBCPL4H1F2     : String ;

    fBCPL1H2F1     : String ;
    fBCPL1H2F2     : String ;
    fBCPL2H2F1     : String ;
    fBCPL2H2F2     : String ;
    fBCPL3H2F1     : String ;
    fBCPL3H2F2     : String ;
    fBCPL4H2F1     : String ;
    fBCPL4H2F2     : String ;

    fFDPStart : Integer ;
    fBDPStart : Integer ;
    fRDPStart : Integer ;
    fBCPStart : Integer ;

    RunState : Boolean ;
    fMachineError : Boolean ;


    Procedure LoadSoftCfg();
    Function CheckLastJob() : Integer;
    Procedure LoadTR() ;
    Procedure OpenMachine();
    Procedure LoadHWConfig() ;
    procedure GetMsgError( Errcode: integer);
    Procedure LoadDetailFormat(inFormat : String) ;
    Function GetINKDisp() : Integer ;

    procedure PrnContinue();

    //procedure PrnContinue2();


  public

    { Public declarations }
  end;

var
  frmTransaction: TfrmTransaction;

implementation

uses ufrmDatacenter,ufrmTransactionProperties, uConvertChar, Math,UfrmSlcPrnAdvice;

{$R *.dfm}


Procedure TfrmTransaction.LoadDetailFormat(inFormat : String) ;
var DBFor : TADOQuery ;
    TempStr : String ;
    StrLine : TStringList ;

begin
   StrLine := TStringList.Create ;
   DBFor := TADOQuery.Create(nil);
     with DBFor do
       begin
         Connection := frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBChequeProperties '+
                     ' Where FFM_Name = '+QuotedStr(inFormat) ;
         Active := true ;
         fFDDocUsed := FieldByName('FFM_FDUse').AsBoolean ;
         fBDDocUsed := FieldByName('FFM_BDUse').AsBoolean ;
         fRDDocUsed := FieldByName('FFM_RDUse').AsBoolean ;
         fBCDocUsed := FieldByName('FFM_BCUse').AsBoolean ;

         fDocLen   := FieldByName('FFM_Length').AsInteger ;
         fDocWidth := FieldByName('FFM_Width').AsInteger ;

         fFDDocQty := FieldByName('FFM_FDQty').AsInteger ;
         fBDDocQty := FieldByName('FFM_BDQty').AsInteger ;
         fRDDocQty := FieldByName('FFM_RDQty').AsInteger ;
         fBCDocQty := FieldByName('FFM_BCQty').AsInteger ;

         fFDDocStRun := FieldByName('FFM_FDRunning').AsInteger ;
         fBDDocStRun := FieldByName('FFM_BDRunning').AsInteger ;
         fRDDocStRun := FieldByName('FFM_RDRunning').AsInteger ;
         fBCDocStRun := FieldByName('FFM_BCRunning').AsInteger ;
//===Face===
//Data
    fFDEStubChequeNo := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,1,1),0) ;
    fFDEChequeNo     := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,2,1),0) ;
    fFDEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,3,1),0) ;
    fFDEBankID       := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,4,1),0) ;
    fFDEBRNID        := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,5,1),0) ;
    fFDEAccountID    := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,6,1),0) ;
    fFDETC           := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,7,1),0) ;
    fFDEAmount       := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,8,1),0) ;
    fFDEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_FDECData').AsString,9,1),0) ;
//Symbol
    fFDESBStubChequeNo := Copy(FieldByName('FFM_FDECSymbol').AsString,1,1) ;
    fFDESBChequeNo     := Copy(FieldByName('FFM_FDECSymbol').AsString,2,1) ;
    fFDESBChequeEnd    := Copy(FieldByName('FFM_FDECSymbol').AsString,3,1) ;
    fFDESBBankID       := Copy(FieldByName('FFM_FDECSymbol').AsString,4,1) ;
    fFDESBBRNID        := Copy(FieldByName('FFM_FDECSymbol').AsString,5,1) ;
    fFDESBAccountID    := Copy(FieldByName('FFM_FDECSymbol').AsString,6,1) ;
    fFDESBTC           := Copy(FieldByName('FFM_FDECSymbol').AsString,7,1) ;
    fFDESBAmount       := Copy(FieldByName('FFM_FDECSymbol').AsString,8,1) ;
    fFDESBChequeEnd    := Copy(FieldByName('FFM_FDECSymbol').AsString,9,1) ;

//===Body====
//== Data
    fBDEStubChequeNo := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,1,1),0) ;
    fBDEChequeNo     := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,2,1),0) ;
    fBDEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,3,1),0) ;
    fBDEBankID       := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,4,1),0) ;
    fBDEBRNID        := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,5,1),0) ;
    fBDEAccountID    := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,6,1),0) ;
    fBDETC           := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,7,1),0) ;
    fBDEAmount       := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,8,1),0) ;
    fBDEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_BDECData').AsString,9,1),0) ;

//==Symbol
    fBDESBStubChequeNo := Copy(FieldByName('FFM_BDECSymbol').AsString,1,1) ;
    fBDESBChequeNo     := Copy(FieldByName('FFM_BDECSymbol').AsString,2,1) ;
    fBDESBChequeEnd    := Copy(FieldByName('FFM_BDECSymbol').AsString,3,1) ;
    fBDESBBankID       := Copy(FieldByName('FFM_BDECSymbol').AsString,4,1) ;
    fBDESBBRNID        := Copy(FieldByName('FFM_BDECSymbol').AsString,5,1) ;
    fBDESBAccountID    := Copy(FieldByName('FFM_BDECSymbol').AsString,6,1) ;
    fBDESBTC           := Copy(FieldByName('FFM_BDECSymbol').AsString,7,1) ;
    fBDESBAmount       := Copy(FieldByName('FFM_BDECSymbol').AsString,8,1) ;
    fBDESBChequeEnd    := Copy(FieldByName('FFM_BDECSymbol').AsString,9,1) ;


//===Request===
//== Data
    fRDEStubChequeNo := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,1,1),0) ;
    fRDEChequeNo     := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,2,1),0) ;
    fRDEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,3,1),0) ;
    fRDEBankID       := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,4,1),0) ;
    fRDEBRNID        := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,5,1),0) ;
    fRDEAccountID    := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,6,1),0) ;
    fRDETC           := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,7,1),0) ;
    fRDEAmount       := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,8,1),0) ;
    fRDEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_RDECData').AsString,9,1),0) ;
// ==Symbol
    fRDESBStubChequeNo := Copy(FieldByName('FFM_RDECSymbol').AsString,1,1) ;
    fRDESBChequeNo     := Copy(FieldByName('FFM_RDECSymbol').AsString,2,1) ;
    fRDESBChequeEnd    := Copy(FieldByName('FFM_RDECSymbol').AsString,3,1) ;
    fRDESBBankID       := Copy(FieldByName('FFM_RDECSymbol').AsString,4,1) ;
    fRDESBBRNID        := Copy(FieldByName('FFM_RDECSymbol').AsString,5,1) ;
    fRDESBAccountID    := Copy(FieldByName('FFM_RDECSymbol').AsString,6,1) ;
    fRDESBTC           := Copy(FieldByName('FFM_RDECSymbol').AsString,7,1) ;
    fRDESBAmount       := Copy(FieldByName('FFM_RDECSymbol').AsString,8,1) ;
    fRDESBChequeEnd    := Copy(FieldByName('FFM_RDECSymbol').AsString,9,1) ;


//===Back===
//== Data
    fBCEStubChequeNo := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,1,1),0) ;
    fBCDEChequeNo    := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,2,1),0) ;
    fBCEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,3,1),0) ;
    fBCEBankID       := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,4,1),0) ;
    fBCEBRNID        := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,5,1),0) ;
    fBCEAccountID    := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,6,1),0) ;
    fBCETC           := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,7,1),0) ;
    fBCEAmount       := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,8,1),0) ;
    fBCEChequeEnd    := StrToIntdef(Copy(FieldByName('FFM_BCECData').AsString,9,1),0) ;

// == Symbol    
    fBCESBStubChequeNo := Copy(FieldByName('FFM_BCECSymbol').AsString,1,1) ;
    fBCESBChequeNo     := Copy(FieldByName('FFM_BCECSymbol').AsString,2,1) ;
    fBCESBChequeEnd    := Copy(FieldByName('FFM_BCECSymbol').AsString,3,1) ;
    fBCESBBankID       := Copy(FieldByName('FFM_BCECSymbol').AsString,4,1) ;
    fBCESBBRNID        := Copy(FieldByName('FFM_BCECSymbol').AsString,5,1) ;
    fBCESBAccountID    := Copy(FieldByName('FFM_BCECSymbol').AsString,6,1) ;
    fBCESBTC           := Copy(FieldByName('FFM_BCECSymbol').AsString,7,1) ;
    fBCESBAmount       := Copy(FieldByName('FFM_BCECSymbol').AsString,8,1) ;
    fBCESBChequeEnd    := Copy(FieldByName('FFM_BCECSymbol').AsString,9,1) ;

    fFDFontSize        := FieldByName('FFM_FDPRFontSize').AsInteger ;
    fBDFontSize        := FieldByName('FFM_BDPRFontSize').AsInteger ;
    fRDFontSize        := FieldByName('FFM_RDPRFontSize').AsInteger ;
    fBCFontSize        := FieldByName('FFM_BCPRFontSize').AsInteger ;

    fFDCharNum        := FieldByName('FFM_FDPRCharNum').AsInteger ;
    fBDCharNum        := FieldByName('FFM_BDPRCharNum').AsInteger ;
    fRDCharNum        := FieldByName('FFM_RDPRCharNum').AsInteger ;
    fBCCharNum        := FieldByName('FFM_BCPRCharNum').AsInteger ;

    //== Face H1
    TempStr :=  FieldByName('FFM_FDPRStartPrintH1').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;


    fFDStartH1L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fFDStartH1L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fFDStartH1L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fFDStartH1L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Face H2
    TempStr :=  FieldByName('FFM_FDPRStartPrintH2').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fFDStartH2L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fFDStartH2L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fFDStartH2L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fFDStartH2L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Body H1
    TempStr :=  FieldByName('FFM_BDPRStartPrintH1').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fBDStartH1L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fBDStartH1L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fBDStartH1L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fBDStartH1L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Body H2
    TempStr :=  FieldByName('FFM_BDPRStartPrintH2').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fBDStartH2L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fBDStartH2L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fBDStartH2L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fBDStartH2L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Reques H1
    TempStr :=  FieldByName('FFM_RDPRStartPrintH1').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fRDStartH1L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fRDStartH1L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fRDStartH1L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fRDStartH1L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Reques H2
    TempStr :=  FieldByName('FFM_RDPRStartPrintH2').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fRDStartH2L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fRDStartH2L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fRDStartH2L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fRDStartH2L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Back H1
    TempStr :=  FieldByName('FFM_BCPRStartPrintH1').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;


    fBCStartH1L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fBCStartH1L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fBCStartH1L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fBCStartH1L4   := StrToIntDef(StrLine.Strings[3],0) ;

    //== Back H2
    TempStr :=  FieldByName('FFM_BCPRStartPrintH2').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fBCStartH2L1   := StrToIntDef(StrLine.Strings[0],0) ;
    fBCStartH2L2   := StrToIntDef(StrLine.Strings[1],0) ;
    fBCStartH2L3   := StrToIntDef(StrLine.Strings[2],0) ;
    fBCStartH2L4   := StrToIntDef(StrLine.Strings[3],0) ;

//    TempStr :=  FieldByName('FFM_FDPRPrintLine1H1').AsString ;
//    StrLine.Clear ;
//    StrLine.CommaText := TempStr ;


    fFDPL1H1F1     := Copy(FieldByName('FFM_FDPRPrintLine1H1').AsString,1,5) ;
    fFDPL1H1F2     := Copy(FieldByName('FFM_FDPRPrintLine1H1').AsString,6,5) ;
    fFDPL2H1F1     := Copy(FieldByName('FFM_FDPRPrintLine2H1').AsString,1,5) ;
    fFDPL2H1F2     := Copy(FieldByName('FFM_FDPRPrintLine2H1').AsString,6,5) ;
    fFDPL3H1F1     := Copy(FieldByName('FFM_FDPRPrintLine3H1').AsString,1,5) ;
    fFDPL3H1F2     := Copy(FieldByName('FFM_FDPRPrintLine3H1').AsString,6,5) ;
    fFDPL4H1F1     := Copy(FieldByName('FFM_FDPRPrintLine4H1').AsString,1,5) ;
    fFDPL4H1F2     := Copy(FieldByName('FFM_FDPRPrintLine4H1').AsString,6,5) ;

    fFDPL1H2F1     := Copy(FieldByName('FFM_FDPRPrintLine1H2').AsString,1,5) ;
    fFDPL1H2F2     := Copy(FieldByName('FFM_FDPRPrintLine1H2').AsString,6,5) ;
    fFDPL2H2F1     := Copy(FieldByName('FFM_FDPRPrintLine2H2').AsString,1,5) ;
    fFDPL2H2F2     := Copy(FieldByName('FFM_FDPRPrintLine2H2').AsString,6,5) ;
    fFDPL3H2F1     := Copy(FieldByName('FFM_FDPRPrintLine3H2').AsString,1,5) ;
    fFDPL3H2F2     := Copy(FieldByName('FFM_FDPRPrintLine3H2').AsString,6,5) ;
    fFDPL4H2F1     := Copy(FieldByName('FFM_FDPRPrintLine4H2').AsString,1,5) ;
    fFDPL4H2F2     := Copy(FieldByName('FFM_FDPRPrintLine4H2').AsString,6,5) ;

    fBDPL1H1F1     := Copy(FieldByName('FFM_BDPRPrintLine1H1').AsString,1,5) ;
    fBDPL1H1F2     := Copy(FieldByName('FFM_BDPRPrintLine1H1').AsString,6,5) ;
    fBDPL2H1F1     := Copy(FieldByName('FFM_BDPRPrintLine2H1').AsString,1,5) ;
    fBDPL2H1F2     := Copy(FieldByName('FFM_BDPRPrintLine2H1').AsString,6,5) ;
    fBDPL3H1F1     := Copy(FieldByName('FFM_BDPRPrintLine3H1').AsString,1,5) ;
    fBDPL3H1F2     := Copy(FieldByName('FFM_BDPRPrintLine3H1').AsString,6,5) ;
    fBDPL4H1F1     := Copy(FieldByName('FFM_BDPRPrintLine4H1').AsString,1,5) ;
    fBDPL4H1F2     := Copy(FieldByName('FFM_BDPRPrintLine4H1').AsString,6,5) ;

    fBDPL1H2F1     := Copy(FieldByName('FFM_BDPRPrintLine1H2').AsString,1,5) ;
    fBDPL1H2F2     := Copy(FieldByName('FFM_BDPRPrintLine1H2').AsString,6,5) ;
    fBDPL2H2F1     := Copy(FieldByName('FFM_BDPRPrintLine2H2').AsString,1,5) ;
    fBDPL2H2F2     := Copy(FieldByName('FFM_BDPRPrintLine2H2').AsString,6,5) ;
    fBDPL3H2F1     := Copy(FieldByName('FFM_BDPRPrintLine3H2').AsString,1,5) ;
    fBDPL3H2F2     := Copy(FieldByName('FFM_BDPRPrintLine3H2').AsString,6,5) ;
    fBDPL4H2F1     := Copy(FieldByName('FFM_BDPRPrintLine4H2').AsString,1,5) ;
    fBDPL4H2F2     := Copy(FieldByName('FFM_BDPRPrintLine4H2').AsString,6,5) ;

    fRDPL1H1F1     := Copy(FieldByName('FFM_RDPRPrintLine1H1').AsString,1,5) ;
    fRDPL1H1F2     := Copy(FieldByName('FFM_RDPRPrintLine1H1').AsString,6,5) ;
    fRDPL2H1F1     := Copy(FieldByName('FFM_RDPRPrintLine2H1').AsString,1,5) ;
    fRDPL2H1F2     := Copy(FieldByName('FFM_RDPRPrintLine2H1').AsString,6,5) ;
    fRDPL3H1F1     := Copy(FieldByName('FFM_RDPRPrintLine3H1').AsString,1,5) ;
    fRDPL3H1F2     := Copy(FieldByName('FFM_RDPRPrintLine3H1').AsString,6,5) ;
    fRDPL4H1F1     := Copy(FieldByName('FFM_RDPRPrintLine4H1').AsString,1,5) ;
    fRDPL4H1F2     := Copy(FieldByName('FFM_RDPRPrintLine4H1').AsString,6,5) ;

    fRDPL1H2F1     := Copy(FieldByName('FFM_RDPRPrintLine1H2').AsString,1,5) ;
    fRDPL1H2F2     := Copy(FieldByName('FFM_RDPRPrintLine1H2').AsString,6,5) ;
    fRDPL2H2F1     := Copy(FieldByName('FFM_RDPRPrintLine2H2').AsString,1,5) ;
    fRDPL2H2F2     := Copy(FieldByName('FFM_RDPRPrintLine2H2').AsString,6,5) ;
    fRDPL3H2F1     := Copy(FieldByName('FFM_RDPRPrintLine3H2').AsString,1,5) ;
    fRDPL3H2F2     := Copy(FieldByName('FFM_RDPRPrintLine3H2').AsString,6,5) ;
    fRDPL4H2F1     := Copy(FieldByName('FFM_RDPRPrintLine4H2').AsString,1,5) ;
    fRDPL4H2F2     := Copy(FieldByName('FFM_RDPRPrintLine4H2').AsString,6,5) ;

    fBCPL1H1F1     := Copy(FieldByName('FFM_RDPRPrintLine1H1').AsString,1,5) ;
    fBCPL1H1F2     := Copy(FieldByName('FFM_RDPRPrintLine1H1').AsString,6,5) ;
    fBCPL2H1F1     := Copy(FieldByName('FFM_RDPRPrintLine2H1').AsString,1,5) ;
    fBCPL2H1F2     := Copy(FieldByName('FFM_RDPRPrintLine2H1').AsString,6,5) ;
    fBCPL3H1F1     := Copy(FieldByName('FFM_RDPRPrintLine3H1').AsString,1,5) ;
    fBCPL3H1F2     := Copy(FieldByName('FFM_RDPRPrintLine3H1').AsString,6,5) ;
    fBCPL4H1F1     := Copy(FieldByName('FFM_RDPRPrintLine4H1').AsString,1,5) ;
    fBCPL4H1F2     := Copy(FieldByName('FFM_RDPRPrintLine4H1').AsString,6,5) ;

    fBCPL1H2F1     := Copy(FieldByName('FFM_RDPRPrintLine1H2').AsString,1,5) ;
    fBCPL1H2F2     := Copy(FieldByName('FFM_RDPRPrintLine1H2').AsString,6,5) ;
    fBCPL2H2F1     := Copy(FieldByName('FFM_RDPRPrintLine2H2').AsString,1,5) ;
    fBCPL2H2F2     := Copy(FieldByName('FFM_RDPRPrintLine2H2').AsString,6,5) ;
    fBCPL3H2F1     := Copy(FieldByName('FFM_RDPRPrintLine3H2').AsString,1,5) ;
    fBCPL3H2F2     := Copy(FieldByName('FFM_RDPRPrintLine3H2').AsString,6,5) ;
    fBCPL4H2F1     := Copy(FieldByName('FFM_RDPRPrintLine4H2').AsString,1,5) ;
    fBCPL4H2F2     := Copy(FieldByName('FFM_RDPRPrintLine4H2').AsString,6,5) ;

    //== Face 
    TempStr :=  FieldByName('FFM_FDENPosition').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fFDEStubChequeNoPOS := StrToIntDef(StrLine.Strings[0],0) ;
    fFDEChequeNoPOS     := StrToIntDef(StrLine.Strings[1],0) ;
    fFDEChequeEndPOS    := StrToIntDef(StrLine.Strings[2],0) ;
    fFDEBankIDPOS       := StrToIntDef(StrLine.Strings[3],0) ;
    fFDEBRNIDPOS        := StrToIntDef(StrLine.Strings[4],0) ;
    fFDEAccountIDPOS    := StrToIntDef(StrLine.Strings[5],0) ;
    fFDETCPOS           := StrToIntDef(StrLine.Strings[6],0) ;
    fFDEAmountPOS       := StrToIntDef(StrLine.Strings[7],0) ;
    fFDEChequeEndPOS    := StrToIntDef(StrLine.Strings[8],0) ;


    //== Body
    TempStr :=  FieldByName('FFM_BDENPosition').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fBDEStubChequeNoPOS := StrToIntDef(StrLine.Strings[0],0) ;
    fBDEChequeNoPOS     := StrToIntDef(StrLine.Strings[1],0) ;
    fBDEChequeEndPOS    := StrToIntDef(StrLine.Strings[2],0) ;
    fBDEBankIDPOS       := StrToIntDef(StrLine.Strings[3],0) ;
    fBDEBRNIDPOS        := StrToIntDef(StrLine.Strings[4],0) ;
    fBDEAccountIDPOS    := StrToIntDef(StrLine.Strings[5],0) ;
    fBDETCPOS           := StrToIntDef(StrLine.Strings[6],0) ;
    fBDEAmountPOS       := StrToIntDef(StrLine.Strings[7],0) ;
    fBDEChequeEndPOS    := StrToIntDef(StrLine.Strings[8],0) ;

    //== Reques
    TempStr :=  FieldByName('FFM_RDENPosition').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fRDEStubChequeNoPOS := StrToIntDef(StrLine.Strings[0],0) ;
    fRDEChequeNoPOS     := StrToIntDef(StrLine.Strings[1],0) ;
    fRDEChequeEndPOS    := StrToIntDef(StrLine.Strings[2],0) ;
    fRDEBankIDPOS       := StrToIntDef(StrLine.Strings[3],0) ;
    fRDEBRNIDPOS        := StrToIntDef(StrLine.Strings[4],0) ;
    fRDEAccountIDPOS    := StrToIntDef(StrLine.Strings[5],0) ;
    fRDETCPOS           := StrToIntDef(StrLine.Strings[6],0) ;
    fRDEAmountPOS       := StrToIntDef(StrLine.Strings[7],0) ;
    fRDEChequeEndPOS    := StrToIntDef(StrLine.Strings[8],0) ;

    //== Back
    TempStr :=  FieldByName('FFM_BCENPosition').AsString ;
    StrLine.Clear ;
    StrLine.CommaText := TempStr ;

    fBCEStubChequeNoPOS := StrToIntDef(StrLine.Strings[0],0) ;
    fBCEChequeNoPOS     := StrToIntDef(StrLine.Strings[1],0) ;
    fBCEChequeEndPOS    := StrToIntDef(StrLine.Strings[2],0) ;
    fBCEBankIDPOS       := StrToIntDef(StrLine.Strings[3],0) ;
    fBCEBRNIDPOS        := StrToIntDef(StrLine.Strings[4],0) ;
    fBCEAccountIDPOS    := StrToIntDef(StrLine.Strings[5],0) ;
    fBCETCPOS           := StrToIntDef(StrLine.Strings[6],0) ;
    fBCEAmountPOS       := StrToIntDef(StrLine.Strings[7],0) ;
    fBCEChequeEndPOS    := StrToIntDef(StrLine.Strings[8],0) ;

    fFDPStart := FieldByName('FFM_FDPStart').AsInteger ;
    fBDPStart := FieldByName('FFM_BDPStart').AsInteger ;
    fRDPStart := FieldByName('FFM_RDPStart').AsInteger ;
    fBCPStart := FieldByName('FFM_BCPStart').AsInteger ;
         Active := false ;
         Free ;
       end;
end ;


Procedure TfrmTransaction.LoadTR();
begin
  if(DBTR.Active) then DBTR.Active := false ;
    with DBTR do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBTransactionDetails '+
                    ' where TRD_CreateDate = '+QuotedStr(FormatDatetime('yyyy-mm-dd',edtWorkDate.Date)) ;
        Active := True ;
      end;
end;

Function TfrmTransaction.CheckLastJob() : Integer ;
var DBJOb : TADOQuery ;
    SDate : String;

begin
   SDate := formatDatetime('yyyy/mm/dd',date);

   DBJOb := TADOQuery.Create(nil);
     with DBJOb do
       begin
         Connection :=  frmDataCenter.ADOConnection1 ;
         SQL.Clear ;
         //SQL.Text := ' Select MAX(TRN_JobID) as JobST from DBTransaction  ' ;
         //SQL.Text := Select MAX(TRD_JobID) as JobST from DBTransactionDetails where SUBSTRING(Trd_jobID,1,10) = '2011/10/04';   //' Select MAX(TRD_JobID) as JobST from DBTransactionDetails  ';

         SQL.Text := 'Select MAX(TRD_JobID) as JobST from DBTransactionDetails where SUBSTRING(Trd_jobID,1,10) = ' + Quotedstr(SDate);

         Active := true ;
         if(RecordCount <= 0) then
           begin
             //BBBRRRRDDMMYYYYXXXXX
             fJobStart := 0 ;
             CheckLastJob := 0 ;
           end else
           begin
             if(trim(FieldByName('JobST').AsString) = '') then
               begin
                 fJobStart := 0 ;
                 CheckLastJob := 0 ;
               end else
               begin
         //    showMessage(FieldByName('JobST').AsString);
                 {fJobstart    := StrToInt(Copy(FieldByName('JobST').AsString,16,5)) ;
                 CheckLastJob := StrToInt(Copy(FieldByName('JobST').AsString,16,5)) ;}


                 fJobstart    := StrToInt(Copy(FieldByName('JobST').AsString,12,4)) ;
                 CheckLastJob := StrToInt(Copy(FieldByName('JobST').AsString,12,4)) ;

                 //CheckLastJob := fJobstart;
               end ;
           end;

         Active := false ;
         Free ;
       end;
end;

Procedure TfrmTransaction.LoadSoftCfg();
var DBCFG : TADOQuery ;
begin
    DBCFG := TADOQuery.Create(nil);
      with DBCFG do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Select * from DBSoftwareConfiguration '+
                      ' Where CFG_Name = '+QuotedStr('JOB_ID') ;
          Active := true ;

          if(RecordCount <= 0) then
            begin
              fJobMode := 0 ;
            end else
            begin
              fJobMode := 1 ;
            end ;
        end ;
end;

procedure TfrmTransaction.RzGroup1Items0Click(Sender: TObject);
begin
   //fJobNO := fBankID+fBRNID+FormatDatetime('ddmmyyyy',Date)+FormatFloat('00000',CheckLastJob+1) ;

  // fJobNO := FormatDatetime('dd/mm/yyyy',edtWorkDate.Date)+'-'+FormatFloat('0000',CheckLastJob+1) ;

   fJobNO := FormatDatetime('yyyy/mm/dd',edtWorkDate.Date)+'-'+FormatFloat('0000',CheckLastJob+1) ;

   if(frmTransactionProperties = nil) then Application.CreateForm(TfrmTransactionProperties,frmTransactionProperties) else
      frmTransactionProperties := TfrmTransactionProperties.Create(nil);
      frmTransactionProperties.TRMode := tmNew ;
      frmTransactionProperties.JOBNO := fJobNo ;
      frmTransactionProperties.Show ;
      LoadTR ;

end;

procedure TfrmTransaction.FormActivate(Sender: TObject);
begin
  edtWorkDate.Date := Date ;
  fBankID := frmDataCenter.BankID ;
  fBRNID  := frmDataCenter.BRNID ;
  fUSERID := frmDataCenter.UserID ;
  LoadHWConfig() ;
  LoadTR();
end;

procedure TfrmTransaction.RzGroup1Items1Click(Sender: TObject);
begin
   if(ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString <> 'W') then
     begin
       MessageDlg('ไม่สามารถเข้าทำการแก้ไขได้',mtWarning,[mbOk],0) ;
       Exit ;
     end ;

   if(frmTransactionProperties = nil) then Application.CreateForm(TfrmTransactionProperties,frmTransactionProperties) else
      frmTransactionProperties := TfrmTransactionProperties.Create(nil);
      frmTransactionProperties.TRMode := tmEdit ;
      frmTransactionProperties.JOBNO := ViewTransaction.DataController.DataSet.FieldByname('TRD_JOBID').AsString ;
      frmTransactionProperties.Show ;
      LoadTR ;
end;

procedure TfrmTransaction.RzGroup1Items2Click(Sender: TObject);
begin
  if(MessageDlg('ต้องการยกเลิกรายการที่เลือก',mtConfirmation,[mbYes,mbNo],0) = mrYes) then
    begin
      ViewTransaction.DataController.DataSet.Edit ;
      ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString := 'D' ;
      ViewTransaction.DataController.DataSet.Post;
    end;
end;

procedure TfrmTransaction.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DBTR.Active := false ;
  If(Fz.IsOpen) then
   begin
    if(Fz.IsWaiting) then Fz.KillWait ;
    Fz.Close ;
   end;
  
end;

Procedure TfrmTransaction.LoadHWConfig() ;
var DBHW : TADOQuery ;
begin
   DBHW := TADOQuery.Create(nil);
     with DBHW do
      begin
        Connection := frmDataCenter.ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := ' Select * from DBHardwareSetup ' ;
        Active := True ;
        fPort     := FieldByname('HWS_PORTNO').AsInteger ;
        fBoudRate := FieldByname('HWS_BOUDRATE').AsString;
        fDataBit  := FieldByname('HWS_DataBit').AsString ;
        fStopBit  := FieldByname('HWS_StopBit').AsString ;


        Active := false ;

      end;
end;

Procedure TfrmTransaction.OpenMachine();
begin
       if(Fz.IsOpen) Then Fz.Close ;
        Fz.nPort := fPort ;

        //==== Use thi bouadrate for Fuji Serial Port ===
        // Fz.strCommParam := '38400,n,8,2';
        //==== Use thi bouadrate for Fuji Serial Port ===

        Fz.strCommParam := fBoudRate+',n,'+fDataBit+','+fStopBit;

        Fz.nMaxWaitTimer := 20000;
        Fz.RecordControl(false,false,'') ;
        Fz.PostEventMask := $F;
        Fz.SetSortingOption(-1,'') ;
//        Fz.strCommParam := fCommonData.ConnectMac ;

        Fz.Open ;
        if(Fz.IsOpen) then
          begin
            Fz.SendCAN ;
              if(Fz.WaitReady(20000)) then
                  begin
                    if(Fz.GetSTS <> 0) then
                      begin
                        GetMsgError(Fz.GetSTS);
                      end;
                 end;
          end;
end;

procedure TfrmTransaction.GetMsgError( Errcode: integer);
Begin

  case Errcode of
  -1:  MessageDlg('Busy state',mtWarning,[mbOK],0);
    1: MessageDlg('GControlError',mtWarning,[mbOK],0);
    2: MessageDlg('MachineBusy',mtWarning,[mbOK],0);
    3: MessageDlg('HopperEmpty',mtWarning,[mbOK],0) ;
    4: MessageDlg('FeedError',mtWarning,[mbOK],0);
    5: MessageDlg('DocJam',mtWarning,[mbOK],0);
    6: MessageDlg('MICRError',mtWarning,[mbOK],0);
   // 7: MessageDlg('');
    8: MessageDlg('HardwareError',mtWarning,[mbOK],0);
    9: MessageDlg('SystemError',mtWarning,[mbOK],0);
    24: MessageDlg('Double feeding(in hopper)',mtWarning,[mbOK],0);
    26: MessageDlg('Hopper wrong transfer',mtWarning,[mbOK],0);
    27: MessageDlg('Not have document to feeding',mtWarning,[mbOK],0);
    32: MessageDlg('Transportation error',mtWarning,[mbOK],0);
    33: MessageDlg('Document is skewed',mtWarning,[mbOK],0);
    34: MessageDlg('Document is to short',mtWarning,[mbOK],0);
    35: MessageDlg('Ribbon end',mtWarning,[mbOK],0);
    36: MessageDlg('Abnormal print data length',mtWarning,[mbOK],0);
    40: MessageDlg('MICR print head home position error',mtWarning,[mbOK],0);
    42: MessageDlg('Home position error after encoding',mtWarning,[mbOK],0);
    52: MessageDlg('Error for Inkjet printer unit',mtWarning,[mbOK],0);
    53: MessageDlg('Ink-cartridge error',mtWarning,[mbOK],0);
    54: MessageDlg('Inkend warning',mtWarning,[mbOK],0);
    83: MessageDlg('Communication error between units',mtWarning,[mbOK],0);
    85: MessageDlg('communication error between MPU-PPU',mtWarning,[mbOK],0);
    86: MessageDlg('Hand check error',mtWarning,[mbOK],0);
    90: MessageDlg('Internalprocessing error',mtWarning,[mbOK],0);
    91..99: MessageDlg('Communication logic error',mtWarning,[mbOK],0);
    //9: MessageDlg('SystemError',mtWarning,[mbOK],0);
  end;
end;


procedure TfrmTransaction.RzGroup1Items3Click(Sender: TObject);
var test : String ;
    MICRData  : WideString ;
    PrintL1H1 : WideString ;
    PrintL2H1 : WideString ;
    PrintL3H1 : WideString ;
    PrintL4H1 : WideString ;
    TotalDoc : Integer ;
    DBJobDetail : TADOQuery ;
begin

     if(not Fz.IsOpen) then Openmachine();
       if(GetINKDisp() <> 0) then
         begin
           fMachineError := true ;
           Fz.close ;
           Exit ;
         end;
         
       Runstate := true ;
       fMachineError := false ;
       DBTR.First ;

         while not DBTR.eof do
           begin
             TotalDoc := 0 ;
             if(trim(ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString) = 'W') then
               begin
                  LoadDetailFormat(DBTR.FieldByName('TRD_FormatID').AsString);
                  DBJobDetail := TADOQuery.Create(nil);
//                   with DBJobDetail do
//                     begin
                       DBJobDetail.Connection := frmDataCenter.ADOConnection1 ;
                       DBJobDetail.SQL.Clear ;
                       DBJobDetail.SQL.Text := ' Select * from DBRunDetails '+
                                                ' Where ECD_JobID  = '+QuotedStr(trim(ViewTransaction.DataController.DataSet.FieldByName('TRD_JobID').AsString))+
                                                ' Order by ECD_RunJobID ';
                       DBJobDetail.Active := true ;

                       DBJobDetail.First;

                         while not DBJobDetail.eof do
                           begin
                             if(DBJobDetail.FieldByName('ECD_Status').AsString =  'W') then
                               begin
                                 MICRData  := DBJobDetail.FieldByName('ECD_FD_MICR').AsString ;

                                  //==Line1_H1==

                                  PrintL1H1 := '';
                                  PrintL2H1 := '';
                                  PrintL3H1 := '';
                                  PrintL4H1 := '';
                                                     

                                  if(trim(DBJobDetail.FieldByName('ECD_FD_P_L1_H1').AsString) <> '') then
                                     begin
                                       PrintL1H1 :=  DBJobDetail.FieldByName('ECD_FD_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                     end else

                                  if(trim(DBJobDetail.FieldByName('ECD_BD_P_L1_H1').AsString) <> '') then
                                     begin
                                       PrintL1H1 := DBJobDetail.FieldByName('ECD_BD_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                     end  else

                                  if(trim(DBJobDetail.FieldByName('ECD_RD_P_L1_H1').AsString) <> '') then
                                    begin
                                       PrintL1H1 := DBJobDetail.FieldByName('ECD_RD_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                    end else

                                  if(trim(DBJobDetail.FieldByName('ECD_BC_P_L1_H1').AsString) <> '') then
                                    begin
                                       PrintL1H1 := DBJobDetail.FieldByName('ECD_BC_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                     end ;


                                  //==Line2_H1
                                  if(trim(DBJobDetail.FieldByName('ECD_FD_P_L2_H1').AsString) <> '') then
                                    begin
                                      PrintL2H1 := DBJobDetail.FieldByName('ECD_FD_P_L2_H1').AsString ;
                                      fConvertChar.InPutString := PrintL2H1  ;
                                      PrintL2H1 := fConvertChar.InPutString  ;
                                    end  else

                                  if(trim(DBJobDetail.FieldByName('ECD_BD_P_L2_H1').AsString) <> '') then
                                   begin
                                     PrintL2H1 := DBJobDetail.FieldByName('ECD_BD_P_L2_H1').AsString ;
                                     fConvertChar.InPutString := PrintL2H1  ;
                                     PrintL2H1 := fConvertChar.InPutString  ;
                                   end else

                                  if(trim(DBJobDetail.FieldByName('ECD_RD_P_L2_H1').AsString) <> '') then
                                   begin
                                    PrintL2H1 := DBJobDetail.FieldByName('ECD_RD_P_L2_H1').AsString ;
                                    fConvertChar.InPutString := PrintL2H1  ;
                                    PrintL2H1 := fConvertChar.InPutString  ;
                                   end  else

                                  if(trim(DBJobDetail.FieldByName('ECD_BC_P_L2_H1').AsString) <> '') then
                                    begin
                                     PrintL2H1 := DBJobDetail.FieldByName('ECD_BC_P_L2_H1').AsString   ;
                                     fConvertChar.InPutString := PrintL2H1  ;
                                     PrintL2H1 := fConvertChar.InPutString  ;
                                    end ;


                                 //==Line3_H1
                                 if(trim(DBJobDetail.FieldByName('ECD_FD_P_L3_H1').AsString) <> '') then
                                    begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_FD_P_L3_H1').AsString ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                    end else

                                 if(trim(DBJobDetail.FieldByName('ECD_BD_P_L3_H1').AsString) <> '') then
                                    begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_BD_P_L3_H1').AsString  ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                   end  else

                                 if(trim(DBJobDetail.FieldByName('ECD_RD_P_L3_H1').AsString) <> '') then
                                   begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_RD_P_L3_H1').AsString  ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                   end else

                                 if(trim(DBJobDetail.FieldByName('ECD_BC_P_L3_H1').AsString) <> '') then
                                   begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_BC_P_L3_H1').AsString ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                   end ;


                                 //== Line4 H1
                                 if(trim(DBJobDetail.FieldByName('ECD_FD_P_L4_H1').AsString) <> '') then
                                   begin
                                    PrintL4H1 := DBJobDetail.FieldByName('ECD_FD_P_L4_H1').AsString ;
                                    fConvertChar.InPutString := PrintL4H1  ;
                                    PrintL4H1 := fConvertChar.InPutString  ;
                                   end else

                                if(trim(DBJobDetail.FieldByName('ECD_BD_P_L4_H1').AsString) <> '') then
                                   begin
                                     PrintL4H1 := DBJobDetail.FieldByName('ECD_BD_P_L4_H1').AsString ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL4H1 := fConvertChar.InPutString  ;
                                   end else

                               if(trim(DBJobDetail.FieldByName('ECD_RD_P_L4_H1').AsString) <> '') then
                                  begin
                                    PrintL4H1 := DBJobDetail.FieldByName('ECD_RD_P_L4_H1').AsString ;
                                    fConvertChar.InPutString := PrintL4H1  ;
                                    PrintL4H1 := fConvertChar.InPutString  ;
                                  end else
                                  
                               if(trim(DBJobDetail.FieldByName('ECD_BC_P_L4_H1').AsString) <> '') then
                                  begin
                                    PrintL4H1 := DBJobDetail.FieldByName('ECD_BC_P_L4_H1').AsString   ;
                                    fConvertChar.InPutString := PrintL4H1  ;
                                    PrintL4H1 := fConvertChar.InPutString  ;
                                  end;


                                 if(not RunState) then
                                   begin
                                    if(Fz.IsOpen) then Fz.Close ;
                                       Break ;
                                   end;  

                                if  PrintL1H1 = '' then PrintL1H1 := ' ';

                                if  PrintL2H1 = '' then PrintL2H1 := ' ';

                                if  PrintL3H1 = '' then PrintL3H1 := ' ';

                                if  PrintL4H1 = '' then PrintL4H1 := ' ';

                                if length(trim(PrintL1H1)) = 0 then PrintL1H1 := '                                ';
                                if length(trim(PrintL2H1)) = 0 then PrintL2H1 := '                                ';
                                if length(trim(PrintL3H1)) = 0 then PrintL3H1 := '                                ';
                                if length(trim(PrintL4H1)) = 0 then PrintL4H1 := '                                ';


                                if(Fz.IsOpen) then
                                  begin
                                   Fz.SetECD(MICRData) ;
                                   Fz.SetNPD(1,'%F'+FormatFloat('000',((fDocLen - fFDPStart)-(fFDCharNum+fFDCharNum)))+'%S070'+PrintL1H1+'%L'+'%S070'+PrintL2H1+'%L'+'%S070'+PrintL3H1+'%L'+'%S070'+PrintL4H1) ;
                                   //Fz.SetNPD(1,'%F'+FormatFloat('000',((241 - 65)-(35+35)))+'%S070'+'PrintL1H1'+'%L'+'%S070'+'PrintL2H1'+'%L'+'%S070'+'PrintL3H1'+'%L'+'%S070'+'PrintL4H1') ;
                                   Fz.SendPKT(0) ;
                                   Fz.WaitReady(5000) ;
                                      if(Fz.GetHwSTS <> 0) then
                                        begin
                                        // Showmessage(IntTostr(Fz.GetHwSTS)) ;
                                         GetMsgError(Fz.GetHwSTS);
                                         fz.SendCAN ;
                                         fMachineError := true ;
//                                         Break ;
                                       end;
                                  end;



                                 if(fMachineError) then
                                   begin
                                     DBJobDetail.Edit ;
                                     DBJobDetail.FieldByName('ECD_Status').AsString := 'E';
                                     DBJobDetail.Post ;
                                     if(Fz.IsWaiting) then Fz.KillWait ;
                                     Fz.Close ;
                                     Break ;
                                     //ShowMessage('fMachineError');
                                   end else
                                   begin
                                     DBJobDetail.Edit ;
                                     DBJobDetail.FieldByName('ECD_Status').AsString := 'F';

                                     DBJobDetail.Post ;
                                     //DBJobDetail.a
                                     //ShowMessage('fMachine_NOt Error');
                                   end;

                                   {PrintL1H1 := '';
                                   PrintL2H1 := '';
                                   PrintL3H1 := '';
                                   PrintL4H1 := ''; }

                               end ;

                                 DBJobDetail.next ;

                           end;
                       //                           end; // While DBJob


                           if(not RunState) then
                              begin
                                 if(Fz.IsOpen) then Fz.Close ;
                                 Break ;
                              end;
                             if(fMachineError) then
                               begin
                                 ViewTransaction.DataController.DataSet.Edit ;
                                 ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString := 'E';
                                 //ViewTransaction.DataController.DataSet.FieldByName('').AsVariant := ;
//                                 DBJobDetail.Post ;
                               end else
                               begin
                                 ViewTransaction.DataController.DataSet.Edit ;
                                 ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString := 'F';

                                 ViewTransaction.DataController.DataSet.FieldByName('TRD_Finished').AsDateTime  := Now //Date;//FormatDateTime('yyyy-mm-dd',Date);
//                                 DBJobDetail.Post ;
                               end;

                        end;
                   DBTR.Next ;

               end;    // Loop for  Check Status  if(FieldByName('TRD_Status').AsString = 'W') then

               DBTR.Close;
               DBTR.Open;
end;

//=======

procedure TfrmTransaction.PrnContinue();
var test : String ;
    MICRData  : WideString ;
    PrintL1H1 : WideString ;
    PrintL2H1 : WideString ;
    PrintL3H1 : WideString ;
    PrintL4H1 : WideString ;
    TotalDoc : Integer ;
    DBJobDetail : TADOQuery ;
begin

     if(not Fz.IsOpen) then Openmachine();
       if(GetINKDisp() <> 0) then
         begin
           fMachineError := true ;
           Fz.close ;
           Exit ;
         end;

       Runstate := true ;
       fMachineError := false ;

       DBTR.First ;

         while not DBTR.eof do
           begin
             TotalDoc := 0 ;
             if(trim(ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString) = 'E') then
               begin
                  LoadDetailFormat(DBTR.FieldByName('TRD_FormatID').AsString);
                  DBJobDetail := TADOQuery.Create(nil);
//                   with DBJobDetail do
//                     begin
                       DBJobDetail.Connection := frmDataCenter.ADOConnection1 ;
                       DBJobDetail.SQL.Clear ;
                       DBJobDetail.SQL.Text := ' Select * from DBRunDetails '+
                                                ' Where ECD_JobID  = '+QuotedStr(trim(ViewTransaction.DataController.DataSet.FieldByName('TRD_JobID').AsString)) +
                                                ' Order by ECD_RunJobID ';

                       DBJobDetail.Active := true ;

                       DBJobDetail.First;



                         while not DBJobDetail.eof do
                           begin
                             if(DBJobDetail.FieldByName('ECD_Status').AsString =  'W')or (DBJobDetail.FieldByName('ECD_Status').AsString =  'E') then
                               begin
                                 MICRData  := DBJobDetail.FieldByName('ECD_FD_MICR').AsString ;

                                  //==Line1_H1==

                                  PrintL1H1 := '';
                                  PrintL2H1 := '';
                                  PrintL3H1 := '';
                                  PrintL4H1 := '';

                                  if(trim(DBJobDetail.FieldByName('ECD_FD_P_L1_H1').AsString) <> '') then
                                     begin
                                       PrintL1H1 :=  DBJobDetail.FieldByName('ECD_FD_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                     end else

                                  if(trim(DBJobDetail.FieldByName('ECD_BD_P_L1_H1').AsString) <> '') then
                                     begin
                                       PrintL1H1 := DBJobDetail.FieldByName('ECD_BD_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                     end  else

                                  if(trim(DBJobDetail.FieldByName('ECD_RD_P_L1_H1').AsString) <> '') then
                                    begin
                                       PrintL1H1 := DBJobDetail.FieldByName('ECD_RD_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                    end else

                                  if(trim(DBJobDetail.FieldByName('ECD_BC_P_L1_H1').AsString) <> '') then
                                    begin
                                       PrintL1H1 := DBJobDetail.FieldByName('ECD_BC_P_L1_H1').AsString  ;
                                       fConvertChar.InPutString := PrintL1H1  ;
                                       PrintL1H1 := fConvertChar.InPutString  ;
                                     end ;


                                  //==Line2_H1
                                  if(trim(DBJobDetail.FieldByName('ECD_FD_P_L2_H1').AsString) <> '') then
                                    begin
                                      PrintL2H1 := DBJobDetail.FieldByName('ECD_FD_P_L2_H1').AsString ;
                                      fConvertChar.InPutString := PrintL2H1  ;
                                      PrintL2H1 := fConvertChar.InPutString  ;
                                    end  else

                                  if(trim(DBJobDetail.FieldByName('ECD_BD_P_L2_H1').AsString) <> '') then
                                   begin
                                     PrintL2H1 := DBJobDetail.FieldByName('ECD_BD_P_L2_H1').AsString ;
                                     fConvertChar.InPutString := PrintL2H1  ;
                                     PrintL2H1 := fConvertChar.InPutString  ;
                                   end else

                                  if(trim(DBJobDetail.FieldByName('ECD_RD_P_L2_H1').AsString) <> '') then
                                   begin
                                    PrintL2H1 := DBJobDetail.FieldByName('ECD_RD_P_L2_H1').AsString ;
                                    fConvertChar.InPutString := PrintL2H1  ;
                                    PrintL2H1 := fConvertChar.InPutString  ;
                                   end  else

                                  if(trim(DBJobDetail.FieldByName('ECD_BC_P_L2_H1').AsString) <> '') then
                                    begin
                                     PrintL2H1 := DBJobDetail.FieldByName('ECD_BC_P_L2_H1').AsString   ;
                                     fConvertChar.InPutString := PrintL2H1  ;
                                     PrintL2H1 := fConvertChar.InPutString  ;
                                    end ;


                                 //==Line3_H1
                                 if(trim(DBJobDetail.FieldByName('ECD_FD_P_L3_H1').AsString) <> '') then
                                    begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_FD_P_L3_H1').AsString ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                    end else

                                 if(trim(DBJobDetail.FieldByName('ECD_BD_P_L3_H1').AsString) <> '') then
                                    begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_BD_P_L3_H1').AsString  ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                   end  else

                                 if(trim(DBJobDetail.FieldByName('ECD_RD_P_L3_H1').AsString) <> '') then
                                   begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_RD_P_L3_H1').AsString  ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                   end else

                                 if(trim(DBJobDetail.FieldByName('ECD_BC_P_L3_H1').AsString) <> '') then
                                   begin
                                     PrintL3H1 := DBJobDetail.FieldByName('ECD_BC_P_L3_H1').AsString ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL3H1 := fConvertChar.InPutString  ;
                                   end ;


                                 //== Line4 H1
                                 if(trim(DBJobDetail.FieldByName('ECD_FD_P_L4_H1').AsString) <> '') then
                                   begin
                                    PrintL4H1 := DBJobDetail.FieldByName('ECD_FD_P_L4_H1').AsString ;
                                    fConvertChar.InPutString := PrintL4H1  ;
                                    PrintL4H1 := fConvertChar.InPutString  ;
                                   end else

                                if(trim(DBJobDetail.FieldByName('ECD_BD_P_L4_H1').AsString) <> '') then
                                   begin
                                     PrintL4H1 := DBJobDetail.FieldByName('ECD_BD_P_L4_H1').AsString ;
                                     fConvertChar.InPutString := PrintL3H1  ;
                                     PrintL4H1 := fConvertChar.InPutString  ;
                                   end else

                               if(trim(DBJobDetail.FieldByName('ECD_RD_P_L4_H1').AsString) <> '') then
                                  begin
                                    PrintL4H1 := DBJobDetail.FieldByName('ECD_RD_P_L4_H1').AsString ;
                                    fConvertChar.InPutString := PrintL4H1  ;
                                    PrintL4H1 := fConvertChar.InPutString  ;
                                  end else
                                  
                               if(trim(DBJobDetail.FieldByName('ECD_BC_P_L4_H1').AsString) <> '') then
                                  begin
                                    PrintL4H1 := DBJobDetail.FieldByName('ECD_BC_P_L4_H1').AsString   ;
                                    fConvertChar.InPutString := PrintL4H1  ;
                                    PrintL4H1 := fConvertChar.InPutString  ;
                                  end;


                                 if(not RunState) then
                                   begin
                                    if(Fz.IsOpen) then Fz.Close ;
                                       Break ;
                                   end;

                                   if length(trim(PrintL1H1)) = 0 then PrintL1H1 := '                                ';
                                   if length(trim(PrintL2H1)) = 0 then PrintL2H1 := '                                ';
                                   if length(trim(PrintL3H1)) = 0 then PrintL3H1 := '                                ';
                                   if length(trim(PrintL4H1)) = 0 then PrintL4H1 := '                                ';



                                if(Fz.IsOpen) then
                                  begin
                                   Fz.SetECD(MICRData) ;
                                   Fz.SetNPD(1,'%F'+FormatFloat('000',((fDocLen - fFDPStart)-(fFDCharNum+fFDCharNum)))+'%S070'+PrintL1H1+'%L'+'%S070'+PrintL2H1+'%L'+'%S070'+PrintL3H1+'%L'+'%S070'+PrintL4H1) ;
                                   //Fz.SetNPD(1,'%F'+FormatFloat('000',((241 - 65)-(35+35)))+'%S070'+'PrintL1H1'+'%L'+'%S070'+'PrintL2H1'+'%L'+'%S070'+'PrintL3H1'+'%L'+'%S070'+'PrintL4H1') ;
                                   Fz.SendPKT(1) ;
                                   Fz.WaitReady(5000) ;
                                      if(Fz.GetHwSTS <> 0) then
                                        begin
                                         GetMsgError(Fz.GetHwSTS);
                                         fz.SendCAN ;
                                         fMachineError := true ;
//                                         Break ;
                                       end;  
                                  end;



                                 if(fMachineError) then
                                   begin
                                     DBJobDetail.Edit ;
                                     DBJobDetail.FieldByName('ECD_Status').AsString := 'E';
                                     DBJobDetail.Post ;  
                                     if(Fz.IsWaiting) then Fz.KillWait ;
                                     Fz.Close ;
                                     Break ;
                                     //ShowMessage('fMachineError');
                                   end else
                                   begin
                                     DBJobDetail.Edit ;
                                     DBJobDetail.FieldByName('ECD_Status').AsString := 'F';
                                     DBJobDetail.Post ;
                                     //DBJobDetail.a
                                     //ShowMessage('fMachine_NOt Error');
                                   end;


                               end ;

                                 DBJobDetail.next ;

                           end;
                       //                           end; // While DBJob


                           if(not RunState) then
                              begin
                                 if(Fz.IsOpen) then Fz.Close ;
                                 Break ;
                              end;
                             if(fMachineError) then
                               begin
                                 ViewTransaction.DataController.DataSet.Edit ;
                                 ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString := 'E';
//                                 DBJobDetail.Post ;
                               end else
                               begin
                                 ViewTransaction.DataController.DataSet.Edit ;
                                 ViewTransaction.DataController.DataSet.FieldByName('TRD_Status').AsString := 'F';
                                 ViewTransaction.DataController.DataSet.FieldByName('TRD_Finished').AsDateTime  := Now
//                                 DBJobDetail.Post ;
                               end;

                        end;
                   DBTR.Next ;

               end;    // Loop for  Check Status  if(FieldByName('TRD_Status').AsString = 'W') then
               DBTR.Close;
               DBTR.Open;

end;


//========



{procedure UpdJobDetail(S);
begin

end;  }
{
    fFDPStart := FieldByName('FFM_FDPStart').AsInteger ;
    fBDPStart := FieldByName('FFM_BDPStart').AsInteger ;
    fRDPStart := FieldByName('FFM_RDPStart').AsInteger ;
    fBCPStart := FieldByName('FFM_BCPStart').AsInteger ;
}
procedure TfrmTransaction.RzGroup1Items5Click(Sender: TObject);
var NewId : String ;
    NewStatus : Integer  ;
    NewCount  : Integer ;
    DetailInk : wideString ;
    DBInkSave : TADOQuery ;
begin
  if(not Fz.IsOpen) then Openmachine ;
    Fz.InkjetInfo(1,'A',DetailInk) ;
        NewID := Copy(DetailInk,3,3) ;
    NewStatus := StrToInt(Copy(DetailInk,6,1)) ;
    NewCount  := StrToInt(Copy(DetailInk,7,8)) ;
//    Fz.Close ;

     case NewStatus of
      0:
         begin
//            Result := 0 ;

         end;
      1:
         begin
           MessageDlg('หมึก InkJet หมดไม่สามารถพิมพ์ได้ กรุณาเปลี่ยนหมึก',mtWarning,[mbOk],0);
           Exit ;
//                Result := 1 ;
          end ;
      2:
          begin
           MessageDlg('หมึก InkJet มีปัญหาไม่สามารถพิมพ์ได้',mtWarning,[mbOk],0) ;
           Exit ;
 //               Result := 1 ;

         end ;
      3:
         begin
           MessageDlg('ไม่พบตลับหมึก InkJet ในเครื่อง',mtWarning,[mbOk],0) ;
             begin
//                Result := 1 ;  Exit ;
                Exit ;
              end;
         end ;
    4..5:
         begin
//           Result := 1 ;
           MessageDlg('ระบบเครื่องมีปัญหา',mtWarning,[mbok],0) ;
           Exit ;

         end;

        6:
           begin
{
             Result := 1 ;
             RzMemo1.Lines.Add('ค้นพบการเปลี่ยนหมึกใหม่') ;
             RzMemo1.Lines.Add('กำลังปรับหมึกใหม่ ...... กรุณารอสักครู่') ;
             AdjustInk ;
}
           end ;
     end;

end;

procedure TfrmTransaction.edtWorkDateChange(Sender: TObject);
begin
  LoadTR ;
end;

procedure TfrmTransaction.RzGroup1Items6Click(Sender: TObject);
begin
  if(not fz.IsOpen) then OpenMachine ;
    fz.SendCAN;
end;

procedure TfrmTransaction.N4Click(Sender: TObject);
begin
 ///
end;


Function TfrmTransaction.GetINKDisp() : Integer ;
var  NewId : String ;
    NewStatus : Integer  ;
    NewCount  : Integer ;
    DetailInk : wideString ;
    DBInkSave : TADOQuery ;
Begin
      if(not Fz.IsOpen) then Openmachine ;
    Fz.InkjetInfo(1,'B',DetailInk) ;
//    Fz.WaitReady(2000) ;
        NewID := Copy(DetailInk,3,3) ;
    NewStatus := StrToInt(Copy(DetailInk,6,1)) ;
    NewCount  := StrToInt(Copy(DetailInk,7,8)) ;
//    Fz.Close ;

     case NewStatus of
      0:
         begin

            Result := 0 ;
//           InkLevel.TotalParts := InkMax ;
//           Fz.Close ;
         end;
      1:
         begin

                MessageDlg('หมึก InkJet หมดไม่สามารถพิมพ์ได้ กรุณาเปลี่ยนหมึก',mtWarning,[mbOk],0);
                Result := 1 ;
          end ;
      2:
          begin
           MessageDlg('หมึก InkJet มีปัญหาไม่สามารถพิมพ์ได้',mtWarning,[mbOk],0) ;

                Result := 1 ;

         end ;
      3:
         begin
           MessageDlg('ไม่พบตลับหมึก InkJet ในเครื่องต้องการ Encode อย่างเดียว',mtWarning,[mbOk],0) ;
             begin
                 Result := 1 ;
 //               Fz.Close ;
              end;
         end ;
    4..5:
         begin
 //          Fz.Close ;
           Result := 1 ;
           MessageDlg('ระบบเครื่องมีปัญหา',mtWarning,[mbok],0) ;

         end;

        6:
           begin
              if(MessageDlg('พบการเปลี่ยนหมึหใหม่แต่ยังไม่ได้ติดตั้ง ต้องการติดตั้ง',mtWarning,[mbYes,mbNo],0) = mrYes)then
                begin
                  Result := 0 ;
                end else
                begin
                 Result := 1 ;
                end;
           end ;
     end;
end ;


procedure TfrmTransaction.RzGroup1Items8Click(Sender: TObject);
begin

   if(not Fz.IsOpen) then Openmachine();
   if(Fz.IsOpen) then Fz.Close ;
   frmTransaction.Close;
end;

procedure TfrmTransaction.RzGroup1Items7Click(Sender: TObject);
begin
  RunState := false ;
end;

procedure TfrmTransaction.RzGroup1Items4Click(Sender: TObject);
begin
   PrnContinue();
end;

procedure TfrmTransaction.RzGroup1Items9Click(Sender: TObject);
begin
   frmSlcPrnAdvice.ShowModal;
end;

end.
