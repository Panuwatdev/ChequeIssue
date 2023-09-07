unit ufrmChequeProperties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, StdCtrls, RzLabel, Mask, RzEdit,
  SUIPageControl, SUITabControl, RzPanel, SUIButton, SUIImagePanel,
  SUIGroupBox, RzCmboBx, DB, ADODB, SUIComboBox;

type TfExitType = (etAccept, etCancel) ;
type
  TfrmChequeProperties = class(TForm)
    SkinCheque: TsuiForm;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    PagesLists: TsuiPageControl;
    suiTabSheet1: TsuiTabSheet;
    suiTabSheet2: TsuiTabSheet;
    suiTabSheet3: TsuiTabSheet;
    suiTabSheet4: TsuiTabSheet;
    suiGroupBox1: TsuiGroupBox;
    RzLabel1: TRzLabel;
    edtName: TRzEdit;
    edtWidth: TRzEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edtLength: TRzEdit;
    suiGroupBox2: TsuiGroupBox;
    cbNewformat: TsuiCheckBox;
    suiGroupBox3: TsuiGroupBox;
    RzLabel4: TRzLabel;
    edtPrice: TRzEdit;
    cbDiscountPercent: TsuiRadioButton;
    cbDiscountBath: TsuiRadioButton;
    suiGroupBox4: TsuiGroupBox;
    suiGroupBox5: TsuiGroupBox;
    RzLabel5: TRzLabel;
    edtFDDocQty: TRzEdit;
    cbUseFD: TsuiCheckBox;
    suiGroupBox6: TsuiGroupBox;
    RzLabel6: TRzLabel;
    edtFDENSequence: TRzEdit;
    suiGroupBox7: TsuiGroupBox;
    cbFDENDataSerialStub: TsuiCheckBox;
    cbFDENDataSerial: TsuiCheckBox;
    cbFDENDataBank: TsuiCheckBox;
    cbFDENDataBranch: TsuiCheckBox;
    cbFDENDataAccount: TsuiCheckBox;
    cbFDENDataTC: TsuiCheckBox;
    cbFDENDataAmount: TsuiCheckBox;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabel13: TRzLabel;
    cbFDENSBDataSerialStub: TsuiCheckBox;
    cbFDENSBDataSerial: TsuiCheckBox;
    cbFDENSBDataBank: TsuiCheckBox;
    cbFDENSBDataBranch: TsuiCheckBox;
    cbFDENSBDataAccount: TsuiCheckBox;
    cbFDENSBDataTC: TsuiCheckBox;
    cbFDENSBDataAmount: TsuiCheckBox;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    edtFDENSerialStubPOS: TRzEdit;
    edtFDENSerialPOS: TRzEdit;
    RzLabel18: TRzLabel;
    edtFDENBankPOS: TRzEdit;
    edtFDENBranchPOS: TRzEdit;
    edtFDENAccountPOS: TRzEdit;
    edtFDENTCPOS: TRzEdit;
    edtFDENAmountPOS: TRzEdit;
    suiGroupBox8: TsuiGroupBox;
    suiGroupBox9: TsuiGroupBox;
    RzLabel16: TRzLabel;
    ListFDFont: TRzComboBox;
    suiGroupBox10: TsuiGroupBox;
    suiGroupBox11: TsuiGroupBox;
    RzLabel17: TRzLabel;
    RzLabel19: TRzLabel;
    RzLabel20: TRzLabel;
    RzLabel21: TRzLabel;
    ListFDH1L1D1: TRzComboBox;
    ListFDH1L1D2: TRzComboBox;
    ListFDH1L2D1: TRzComboBox;
    ListFDH1L2D2: TRzComboBox;
    ListFDH1L3D1: TRzComboBox;
    ListFDH1L3D2: TRzComboBox;
    ListFDH1L4D1: TRzComboBox;
    ListFDH1L4D2: TRzComboBox;
    RzLabel23: TRzLabel;
    ListFDH2L1D1: TRzComboBox;
    ListFDH2L1D2: TRzComboBox;
    ListFDH2L2D2: TRzComboBox;
    ListFDH2L2D1: TRzComboBox;
    RzLabel24: TRzLabel;
    RzLabel25: TRzLabel;
    ListFDH2L3D1: TRzComboBox;
    ListFDH2L3D2: TRzComboBox;
    ListFDH2L4D2: TRzComboBox;
    ListFDH2L4D1: TRzComboBox;
    RzLabel26: TRzLabel;
    suiGroupBox12: TsuiGroupBox;
    RzLabel27: TRzLabel;
    RzLabel28: TRzLabel;
    edtBDDocQty: TRzEdit;
    cbUseBD: TsuiCheckBox;
    edtBDENSequence: TRzEdit;
    suiGroupBox15: TsuiGroupBox;
    suiGroupBox16: TsuiGroupBox;
    RzLabel39: TRzLabel;
    RzLabel40: TRzLabel;
    ListBDFont: TRzComboBox;
    edtBDNumberChar: TRzEdit;
    suiGroupBox17: TsuiGroupBox;
    RzLabel41: TRzLabel;
    RzLabel42: TRzLabel;
    RzLabel43: TRzLabel;
    RzLabel44: TRzLabel;
    ListBDH2L1D2: TRzComboBox;
    ListBDH2L2D2: TRzComboBox;
    ListBDH2L2D1: TRzComboBox;
    ListBDH2L3D1: TRzComboBox;
    ListBDH2L3D2: TRzComboBox;
    ListBDH2L4D2: TRzComboBox;
    ListBDH2L4D1: TRzComboBox;
    suiGroupBox18: TsuiGroupBox;
    RzLabel45: TRzLabel;
    RzLabel46: TRzLabel;
    RzLabel47: TRzLabel;
    RzLabel48: TRzLabel;
    ListBDH1L1D1: TRzComboBox;
    ListBDH1L1D2: TRzComboBox;
    ListBDH1L2D1: TRzComboBox;
    ListBDH1L2D2: TRzComboBox;
    ListBDH1L3D1: TRzComboBox;
    ListBDH1L3D2: TRzComboBox;
    ListBDH1L4D1: TRzComboBox;
    ListBDH1L4D2: TRzComboBox;
    suiGroupBox19: TsuiGroupBox;
    RzLabel49: TRzLabel;
    RzLabel50: TRzLabel;
    edtRDDocQty: TRzEdit;
    cbUseRD: TsuiCheckBox;
    edtRDENSequence: TRzEdit;
    suiGroupBox20: TsuiGroupBox;
    suiGroupBox21: TsuiGroupBox;
    RzLabel51: TRzLabel;
    RzLabel52: TRzLabel;
    RzLabel53: TRzLabel;
    RzLabel54: TRzLabel;
    RzLabel55: TRzLabel;
    RzLabel56: TRzLabel;
    RzLabel57: TRzLabel;
    RzLabel58: TRzLabel;
    RzLabel59: TRzLabel;
    RzLabel60: TRzLabel;
    cbRDENDataSerialStub: TsuiCheckBox;
    cbRDENDataSerial: TsuiCheckBox;
    cbRDENDataBank: TsuiCheckBox;
    cbRDENDataBranch: TsuiCheckBox;
    cbRDENDataAccount: TsuiCheckBox;
    cbRDENDataTC: TsuiCheckBox;
    cbRDENDataAmount: TsuiCheckBox;
    cbRDENSBDataSerialStub: TsuiCheckBox;
    cbRDENSBDataSerial: TsuiCheckBox;
    cbRDENSBDataBank: TsuiCheckBox;
    cbRDENSBDataBranch: TsuiCheckBox;
    cbRDENSBDataAccount: TsuiCheckBox;
    cbRDENSBDataTC: TsuiCheckBox;
    cbRDENSBDataAmount: TsuiCheckBox;
    edtRDENSerialStubPOS: TRzEdit;
    edtRDENSerialPOS: TRzEdit;
    edtRDENBankPOS: TRzEdit;
    edtRDENBranchPOS: TRzEdit;
    edtRDENAccountPOS: TRzEdit;
    edtRDENTCPOS: TRzEdit;
    edtRDENAmountPOS: TRzEdit;
    suiGroupBox22: TsuiGroupBox;
    suiGroupBox23: TsuiGroupBox;
    RzLabel61: TRzLabel;
    RzLabel62: TRzLabel;
    ListRDFont: TRzComboBox;
    edtRDNumberChar: TRzEdit;
    suiGroupBox24: TsuiGroupBox;
    RzLabel63: TRzLabel;
    RzLabel64: TRzLabel;
    RzLabel65: TRzLabel;
    RzLabel66: TRzLabel;
    ListRDH2L1D1: TRzComboBox;
    ListRDH2L2D2: TRzComboBox;
    ListRDH2L2D1: TRzComboBox;
    ListRDH2L3D1: TRzComboBox;
    ListRDH2L3D2: TRzComboBox;
    ListRDH2L4D2: TRzComboBox;
    ListRDH2L4D1: TRzComboBox;
    suiGroupBox25: TsuiGroupBox;
    RzLabel67: TRzLabel;
    RzLabel68: TRzLabel;
    RzLabel69: TRzLabel;
    RzLabel70: TRzLabel;
    ListRDH1L1D1: TRzComboBox;
    ListRDH1L1D2: TRzComboBox;
    ListRDH1L2D1: TRzComboBox;
    ListRDH1L2D2: TRzComboBox;
    ListRDH1L3D1: TRzComboBox;
    ListRDH1L3D2: TRzComboBox;
    ListRDH1L4D1: TRzComboBox;
    ListRDH1L4D2: TRzComboBox;
    suiGroupBox26: TsuiGroupBox;
    RzLabel71: TRzLabel;
    RzLabel72: TRzLabel;
    edtBCDocQty: TRzEdit;
    cbUseBC: TsuiCheckBox;
    edtBCENSequence: TRzEdit;
    suiGroupBox27: TsuiGroupBox;
    suiGroupBox28: TsuiGroupBox;
    RzLabel73: TRzLabel;
    RzLabel74: TRzLabel;
    RzLabel75: TRzLabel;
    RzLabel76: TRzLabel;
    RzLabel77: TRzLabel;
    RzLabel78: TRzLabel;
    RzLabel79: TRzLabel;
    RzLabel80: TRzLabel;
    RzLabel81: TRzLabel;
    RzLabel82: TRzLabel;
    cbBCENDataSerialStub: TsuiCheckBox;
    cbBCENDataSerial: TsuiCheckBox;
    cbBCENDataBank: TsuiCheckBox;
    cbBCENDataBranch: TsuiCheckBox;
    cbBCENDataAccount: TsuiCheckBox;
    cbBCENDataTC: TsuiCheckBox;
    cbBCENDataAmount: TsuiCheckBox;
    cbBCENSBDataSerialStub: TsuiCheckBox;
    cbBCENSBDataSerial: TsuiCheckBox;
    cbBCENSBDataBank: TsuiCheckBox;
    cbBCENSBDataBranch: TsuiCheckBox;
    cbBCENSBDataAccount: TsuiCheckBox;
    cbBCENSBDataTC: TsuiCheckBox;
    cbBCENSBDataAmount: TsuiCheckBox;
    edtBCENSerialStubPOS: TRzEdit;
    edtBCENSerialPOS: TRzEdit;
    edtBCENBankPOS: TRzEdit;
    edtBCENBranchPOS: TRzEdit;
    edtBCENAccountPOS: TRzEdit;
    edtBCENTCPOS: TRzEdit;
    edtBCENAmountPOS: TRzEdit;
    suiGroupBox29: TsuiGroupBox;
    suiGroupBox30: TsuiGroupBox;
    RzLabel83: TRzLabel;
    RzLabel84: TRzLabel;
    ListBCFont: TRzComboBox;
    edtBCNumberChar: TRzEdit;
    suiGroupBox31: TsuiGroupBox;
    RzLabel85: TRzLabel;
    RzLabel86: TRzLabel;
    RzLabel87: TRzLabel;
    RzLabel88: TRzLabel;
    ListBCH2L1D1: TRzComboBox;
    ListBCH2L1D2: TRzComboBox;
    ListBCH2L2D2: TRzComboBox;
    ListBCH2L2D1: TRzComboBox;
    ListBCH2L3D1: TRzComboBox;
    ListBCH2L3D2: TRzComboBox;
    ListBCH2L4D1: TRzComboBox;
    suiGroupBox32: TsuiGroupBox;
    RzLabel89: TRzLabel;
    RzLabel90: TRzLabel;
    RzLabel91: TRzLabel;
    RzLabel92: TRzLabel;
    ListBCH1L1D1: TRzComboBox;
    ListBCH1L1D2: TRzComboBox;
    ListBCH1L2D1: TRzComboBox;
    ListBCH1L2D2: TRzComboBox;
    ListBCH1L3D1: TRzComboBox;
    ListBCH1L3D2: TRzComboBox;
    ListBCH1L4D1: TRzComboBox;
    ListBCH1L4D2: TRzComboBox;
    edtFDPRH1L1Pos: TRzEdit;
    edtFDPRH1L2Pos: TRzEdit;
    edtFDPRH1L3Pos: TRzEdit;
    edtFDPRH1L4Pos: TRzEdit;
    edtFDPRH2L1Pos: TRzEdit;
    edtFDPRH2L2Pos: TRzEdit;
    edtFDPRH2L3Pos: TRzEdit;
    edtFDPRH2L4Pos: TRzEdit;
    edtBDPRH1L1Pos: TRzEdit;
    edtBDPRH1L2Pos: TRzEdit;
    edtBDPRH1L3Pos: TRzEdit;
    edtBDPRH1L4Pos: TRzEdit;
    edtBDPRH2L1Pos: TRzEdit;
    edtBDPRH2L2Pos: TRzEdit;
    edtBDPRH2L3Pos: TRzEdit;
    edtBDPRH2L4Pos: TRzEdit;
    edtRDPRH1L1Pos: TRzEdit;
    edtRDPRH1L2Pos: TRzEdit;
    edtRDPRH1L4Pos: TRzEdit;
    edtRDPRH2L1Pos: TRzEdit;
    edtRDPRH2L2Pos: TRzEdit;
    edtRDPRH2L3Pos: TRzEdit;
    edtRDPRH2L4Pos: TRzEdit;
    edtBCPRH1L1Pos: TRzEdit;
    edtBCPRH1L2Pos: TRzEdit;
    edtBCPRH1L3Pos: TRzEdit;
    edtBCPRH1L4Pos: TRzEdit;
    edtBCPRH2L1Pos: TRzEdit;
    edtBCPRH2L2Pos: TRzEdit;
    edtBCPRH2L3Pos: TRzEdit;
    edtBCPRH2L4Pos: TRzEdit;
    ListBDH2L1D1: TRzComboBox;
    edtRDPRH1L3Pos: TRzEdit;
    ListRDH2L1D2: TRzComboBox;
    ListBCH2L4D2: TRzComboBox;
    RzPanel3: TRzPanel;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    RzLabel93: TRzLabel;
    edtDiscountValues: TRzEdit;
    RzLabel94: TRzLabel;
    cbFDENDataSerialEnd: TsuiCheckBox;
    cbFDENSBDataSerialEnd: TsuiCheckBox;
    edtFDENSerialEndPOS: TRzEdit;
    RzLabel96: TRzLabel;
    cbRDENDataSerialEnd: TsuiCheckBox;
    cbRDENSBDataSerialEnd: TsuiCheckBox;
    edtRDENSerialEndPOS: TRzEdit;
    RzLabel97: TRzLabel;
    cbBCENDataSerialEnd: TsuiCheckBox;
    cbBCENSBDataSerialEnd: TsuiCheckBox;
    edtBCENSerialEndPOS: TRzEdit;
    suiComboBox9: TsuiComboBox;
    suiComboBox10: TsuiComboBox;
    suiComboBox11: TsuiComboBox;
    suiComboBox12: TsuiComboBox;
    suiComboBox13: TsuiComboBox;
    suiComboBox14: TsuiComboBox;
    suiComboBox15: TsuiComboBox;
    suiGroupBox13: TsuiGroupBox;
    suiGroupBox14: TsuiGroupBox;
    RzLabel29: TRzLabel;
    RzLabel30: TRzLabel;
    RzLabel31: TRzLabel;
    RzLabel32: TRzLabel;
    RzLabel33: TRzLabel;
    RzLabel34: TRzLabel;
    RzLabel35: TRzLabel;
    RzLabel36: TRzLabel;
    RzLabel37: TRzLabel;
    RzLabel38: TRzLabel;
    RzLabel95: TRzLabel;
    cbBDENDataSerialStub: TsuiCheckBox;
    cbBDENDataSerial: TsuiCheckBox;
    cbBDENDataBank: TsuiCheckBox;
    cbBDENDataBranch: TsuiCheckBox;
    cbBDENDataAccount: TsuiCheckBox;
    cbBDENDataTC: TsuiCheckBox;
    cbBDENDataAmount: TsuiCheckBox;
    cbBDENSBDataSerialStub: TsuiCheckBox;
    cbBDENSBDataSerial: TsuiCheckBox;
    cbBDENSBDataBank: TsuiCheckBox;
    cbBDENSBDataBranch: TsuiCheckBox;
    cbBDENSBDataAccount: TsuiCheckBox;
    cbBDENSBDataTC: TsuiCheckBox;
    cbBDENSBDataAmount: TsuiCheckBox;
    edtBDENSerialStubPOS: TRzEdit;
    edtBDENSerialPOS: TRzEdit;
    edtBDENBankPOS: TRzEdit;
    edtBDENBranchPOS: TRzEdit;
    edtBDENAccountPOS: TRzEdit;
    edtBDENTCPOS: TRzEdit;
    edtBDENAmountPOS: TRzEdit;
    cbBDENDataSerialEnd: TsuiCheckBox;
    cbBDENSBDataSerialEnd: TsuiCheckBox;
    edtBDENSerialEndPOS: TRzEdit;
    lbFDENSBDataSerialStub: TRzComboBox;
    lbFDENSBDataSerial: TRzComboBox;
    lbFDENSBDataBank: TRzComboBox;
    lbFDENSBDataBranch: TRzComboBox;
    lbFDENSBDataAccount: TRzComboBox;
    lbFDENSBDataTC: TRzComboBox;
    lbFDENSBDataAmount: TRzComboBox;
    lbFDENSBDataSerialEnd: TRzComboBox;
    lbBDENSBDataSerialStub: TRzComboBox;
    lbBDENSBDataSerial: TRzComboBox;
    lbBDENSBDataBank: TRzComboBox;
    lbBDENSBDataBranch: TRzComboBox;
    lbBDENSBDataAccount: TRzComboBox;
    lbBDENSBDataTC: TRzComboBox;
    lbBDENSBDataAmount: TRzComboBox;
    lbBDENSBDataSerialEnd: TRzComboBox;
    lbRDENSBDataSerialStub: TRzComboBox;
    lbRDENSBDataSerial: TRzComboBox;
    lbRDENSBDataBank: TRzComboBox;
    lbRDENSBDataBranch: TRzComboBox;
    lbRDENSBDataAccount: TRzComboBox;
    lbRDENSBDataTC: TRzComboBox;
    lbRDENSBDataAmount: TRzComboBox;
    lbRDENSBDataSerialEnd: TRzComboBox;
    lbBCENSBDataSerialStub: TRzComboBox;
    lbBCENSBDataSerial: TRzComboBox;
    lbBCENSBDataBank: TRzComboBox;
    lbBCENSBDataBranch: TRzComboBox;
    lbBCENSBDataAccount: TRzComboBox;
    lbBCENSBDataTC: TRzComboBox;
    lbBCENSBDataAmount: TRzComboBox;
    lbBCENSBDataSerialEnd: TRzComboBox;
    cbDefault: TsuiCheckBox;
    edtFDNumberChar: TRzEdit;
    RzLabel22: TRzLabel;
    RzLabel99: TRzLabel;
    edtBDPstart: TRzEdit;
    RzLabel100: TRzLabel;
    edtRDPstart: TRzEdit;
    RzLabel101: TRzLabel;
    edtBCPstart: TRzEdit;
    RzLabel102: TRzLabel;
    edtFee: TRzEdit;
    RzLabel98: TRzLabel;
    edtFDPstart: TRzEdit;
    procedure edtNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbFDENSBDataSerialChange(Sender: TObject);
    procedure edtWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edtFDDocQtyKeyPress(Sender: TObject; var Key: Char);
    procedure edtBDDocQtyKeyPress(Sender: TObject; var Key: Char);
    procedure edtRDDocQtyKeyPress(Sender: TObject; var Key: Char);
    procedure edtBCDocQtyKeyPress(Sender: TObject; var Key: Char);
    procedure edtFDENSerialStubPOSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFDPRH1L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFDPRH2L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBDENSerialStubPOSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBDPRH1L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBDPRH2L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRDENSerialStubPOSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRDPRH1L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtRDPRH2L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBCENSerialStubPOSKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBCPRH1L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBCPRH2L1PosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fFormatName : String ;
    fMode : String ;
    fExitType : TfExitType ;
    Procedure StartProperty(inFormatName : String);
    Procedure NewFormat();
    Procedure EditFormat();
    Procedure ClearScreen();
    Procedure ShowScreen() ;
    Procedure GetPrintListProperties();
    Procedure GetListMICRSymbol() ;
    Function GetIndexOfList(inList : TRzComboBox; inValue : String) : Integer;
  public
    { Public declarations }
  Published
    Property FormatName : String Read fFormatName Write  StartProperty ;
    Property ExitType : TfExitType Read fExitType Write fExitType ;
  end;

Type TfRunListClass = Class(TThread)

  Protected
//    procedure Execute; override ;

  Private

  Public
//    Constructor Create() ;

end;

var
  frmChequeProperties: TfrmChequeProperties;

implementation
uses ufrmDatacenter ;
{$R *.dfm}

//Constructor TfRunListClass.Create();
//begin
//end;

Procedure TfrmChequeProperties.StartProperty(inFormatName : String);
begin
    GetListMICRSymbol() ;
  GetPrintListProperties() ;

  if(trim(inFormatName) = '') then
   begin
     fFormatName := 'New Format' ;
     fMode := 'New' ;
     edtName.ReadOnly := false ;
     NewFormat();
   end else
   begin
     fFormatName := inFormatName ;
     fMode := 'Edit' ;
     edtName.ReadOnly := true ;
     EditFormat();
   end;
end;

Procedure TfrmChequeProperties.NewFormat();
begin
  ClearScreen ;
end;

Procedure TfrmChequeProperties.EditFormat();
begin
 ShowScreen ;
end;


{
FFM_Name	nvarchar(50)	Checked
FFM_Description	nvarchar(50)	Checked
FFM_Width	int	Checked
FFM_Length	int	Checked
FFM_NewFormat	bit	Checked
FFM_Price	float	Checked
FFM_Discount	char(1)	Checked
FFM_FDUse	bit	Checked
FFM_FDQty	int	Checked
FFM_FDRunning	int	Checked
FFM_FDECData	nvarchar(50)	Checked
FFM_FDECSymbol	nvarchar(50)	Checked
FFM_FDPRFontSize	int	Checked
FFM_FDPRCharNum	int	Checked
FFM_FDPRStartPrintH1	nvarchar(50)	Checked
FFM_FDPRStartPrintH2	nvarchar(50)	Checked
FFM_FDPRPrintLine1H1	nvarchar(50)	Checked
FFM_FDPRPrintLine2H1	nvarchar(50)	Checked
FFM_FDPRPrintLine3H1	nvarchar(50)	Checked
FFM_FDPRPrintLine4H1	nvarchar(50)	Checked
FFM_FDPRPrintLine1H2	nvarchar(50)	Checked
FFM_FDPRPrintLine2H2	nvarchar(50)	Checked
FFM_FDPRPrintLine3H2	nvarchar(50)	Checked
FFM_FDPRPrintLine4H2	nvarchar(50)	Checked
FFM_BDUse	bit	Checked
FFM_BDQty	int	Checked
FFM_BDRunning	int	Checked
FFM_BDECData	nvarchar(50)	Checked
FFM_BDECSymbol	nvarchar(50)	Checked
FFM_BDPRFontSize	int	Checked
FFM_BDPRCharNum	int	Checked
FFM_BDPRStartPrintH1	nvarchar(50)	Checked
FFM_BDPRStartPrintH2	nvarchar(50)	Checked
FFM_BDPRPrintLine1H1	nvarchar(50)	Checked
FFM_BDPRPrintLine2H1	nvarchar(50)	Checked
FFM_BDPRPrintLine3H1	nvarchar(50)	Checked
FFM_BDPRPrintLine4H1	nvarchar(50)	Checked
FFM_BDPRPrintLine1H2	nvarchar(50)	Checked
FFM_BDPRPrintLine2H2	nvarchar(50)	Checked
FFM_BDPRPrintLine3H2	nvarchar(50)	Checked
FFM_BDPRPrintLine4H2	nvarchar(50)	Checked
FFM_RDUse	bit	Checked
FFM_RDQty	int	Checked
FFM_RDRunning	int	Checked
FFM_RDECData	nvarchar(50)	Checked
FFM_RDECSymbol	nvarchar(50)	Checked
FFM_RDPRFontSize	int	Checked
FFM_RDPRCharNum	int	Checked
FFM_RDPRStartPrintH1	nvarchar(50)	Checked
FFM_RDPRStartPrintH2	nvarchar(50)	Checked
FFM_RDPRPrintLine1H1	nvarchar(50)	Checked
FFM_RDPRPrintLine2H1	nvarchar(50)	Checked
FFM_RDPRPrintLine3H1	nvarchar(50)	Checked
FFM_RDPRPrintLine4H1	nvarchar(50)	Checked
FFM_RDPRPrintLine1H2	nvarchar(50)	Checked
FFM_RDPRPrintLine2H2	nvarchar(50)	Checked
FFM_RDPRPrintLine3H2	nvarchar(50)	Checked
FM_RDPRPrintLine4H21	nvarchar(50)	Checked
FFM_BCUse	bit	Checked
FFM_BCQty	int	Checked
FFM_BCRunning	int	Checked
FFM_BCECData	nvarchar(50)	Checked
FFM_BCECSymbol	nvarchar(50)	Checked
FFM_BCPRFontSize	int	Checked
FFM_BCPRCharNum	int	Checked
FFM_BCPRStartPrintH1	nvarchar(50)	Checked
FFM_BCPRStartPrintH2	nvarchar(50)	Checked
FFM_BCPRPrintLine1H1	nvarchar(50)	Checked
FFM_BCPRPrintLine2H1	nvarchar(50)	Checked
FFM_BCPRPrintLine3H1	nvarchar(50)	Checked
FFM_BCPRPrintLine4H1	nvarchar(50)	Checked
FFM_BCPRPrintLine1H2	nvarchar(50)	Checked
FFM_BCPRPrintLine2H2	nvarchar(50)	Checked
FFM_BCPRPrintLine3H2	nvarchar(50)	Checked
FFM_BCPRPrintLine4H2	nvarchar(50)	Checked
}

procedure TfrmChequeProperties.ClearScreen();
var Rec : Integer ;
begin
  for Rec := 0 to suiGroupBox1.ControlCount - 1 do
    begin
      if(suiGroupBox1.Controls[Rec].ClassName = 'TRzEdit') then TRzEdit(suiGroupBox1.Controls[Rec]).Text := '' ;
    end;

    cbNewformat.Checked := True ;
    edtPrice.Text := '0.00' ;
    cbDiscountPercent.Checked := false ;
    cbDiscountBath.Checked    := false ;

   for Rec := 0 to  suiGroupBox7.ControlCount - 1 do
     begin
      if(suiGroupBox7.Controls[Rec].ClassName = 'TRzEdit') then TRzEdit(suiGroupBox7.Controls[Rec]).Text := '0' ;
      if(suiGroupBox7.Controls[Rec].ClassName = 'TsuiCheckBox') then TsuiCheckBox(suiGroupBox7.Controls[Rec]).Checked := false ;
     end;

   for Rec := 0 to  suiGroupBox14.ControlCount - 1 do
     begin
      if(suiGroupBox14.Controls[Rec].ClassName = 'TRzEdit') then TRzEdit(suiGroupBox14.Controls[Rec]).Text := '0' ;
      if(suiGroupBox14.Controls[Rec].ClassName = 'TsuiCheckBox') then TsuiCheckBox(suiGroupBox14.Controls[Rec]).Checked := false ;
     end;

   for Rec := 0 to  suiGroupBox21.ControlCount - 1 do
     begin
      if(suiGroupBox21.Controls[Rec].ClassName = 'TRzEdit') then TRzEdit(suiGroupBox21.Controls[Rec]).Text := '0' ;
      if(suiGroupBox21.Controls[Rec].ClassName = 'TsuiCheckBox') then TsuiCheckBox(suiGroupBox21.Controls[Rec]).Checked := false ;
     end;

   for Rec := 0 to  suiGroupBox28.ControlCount - 1 do
     begin
      if(suiGroupBox28.Controls[Rec].ClassName = 'TRzEdit') then TRzEdit(suiGroupBox28.Controls[Rec]).Text := '0' ;
      if(suiGroupBox28.Controls[Rec].ClassName = 'TsuiCheckBox') then TsuiCheckBox(suiGroupBox28.Controls[Rec]).Checked := false ;
     end;

     cbUseFD.Checked := true ;
     cbUseBD.Checked := true ;
     cbUseRD.Checked := true ;
     cbUseBC.Checked := true ;
     edtFDDocQty.Text := '0' ;
     edtBDDocQty.Text := '0' ;
     edtRDDocQty.Text := '0' ;
     edtBCDocQty.Text := '0' ;

     edtFDENSequence.Text := '0' ;
     edtBDENSequence.Text := '0' ;
     edtRDENSequence.Text := '0' ;
     edtBCENSequence.Text := '0' ;


     ListFDFont.ItemIndex := 0 ;
     ListBDFont.ItemIndex := 0 ;
     ListRDFont.ItemIndex := 0 ;
     ListBCFont.ItemIndex := 0 ;

     
     edtFDNumberChar.Text := '35' ;
     edtBDNumberChar.Text := '35' ;
     edtRDNumberChar.Text := '35' ;
     edtBCNumberChar.Text := '35' ;

    for Rec := 0 to suiGroupBox10.ControlCount - 1 do
      begin
        if(suiGroupBox10.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox10.Controls[Rec]).ItemIndex := 0 ;
         end;
      end;
     
    for Rec := 0 to suiGroupBox11.ControlCount - 1 do
      begin
        if(suiGroupBox11.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox11.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox18.ControlCount - 1 do
      begin
        if(suiGroupBox18.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox18.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox17.ControlCount - 1 do
      begin
        if(suiGroupBox17.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox17.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

          for Rec := 0 to suiGroupBox25.ControlCount - 1 do
      begin
        if(suiGroupBox25.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox25.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox24.ControlCount - 1 do
      begin
        if(suiGroupBox24.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox24.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox32.ControlCount - 1 do
      begin
        if(suiGroupBox32.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox32.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox31.ControlCount - 1 do
      begin
        if(suiGroupBox31.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox31.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

end;

Function TfrmChequeProperties.GetIndexOfList(inList : TRzComboBox; inValue : String) : Integer;
var Rec : Integer ;
begin
  GetIndexOfList := -1 ;
  for Rec := 0 to inList.Count - 1 do
    begin
      if(inList.Values.Strings[Rec] = inValue) then
       begin
         GetIndexOfList := Rec ;
         Break ;
       end;
    end;

end;

Procedure TfrmChequeProperties.ShowScreen();
var DBShow : TADOQuery ;
    Rec, Rec1 : Integer ;
    TempStr, TempStr2 : String ;
    CountCom : Integer ;
    TemStr : TStringList ;
begin
    TemStr := TStringList.Create ;
    DBShow := TADOQuery.Create(nil);
      with DBShow do
        begin
          Connection := frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Select * from DBChequeProperties ' +
                      ' Where FFM_Name = '+QuotedStr(fFormatName);
          Active := true ;

          edtName.Text   := trim(FieldByname('FFM_Name').AsString) ;

          edtWidth.Text  := trim(FieldByname('FFM_Width').AsString) ;
          edtLength.Text := Trim(FieldByname('FFM_Length').AsString) ;
          cbNewformat.Checked := FieldByname('FFM_NewFormat').AsBoolean ;
          //          if(FieldByname('FFM_NewFormat').AsInteger = 0) then cbNewformat.Checked := false else  cbNewformat.Checked := false ;
          edtPrice.Text          := FieldByname('FFM_Price').AsString ;
          edtDiscountValues.Text := FieldByname('FFM_DiscountValues').AsString ;
          cbUseFD.Checked        := FieldByname('FFM_FDUse').AsBoolean ;
          edtFDDocQty.Text       := FieldByname('FFM_FDQty').AsString ;
          edtFDENSequence.Text   := FieldByname('FFM_FDRunning').AsString ;
          cbDefault.Checked      := FieldByname('FFM_Default').AsBoolean ;
          edtFDPstart.Text       := FieldByname('FFM_FDPStart').AsString ;
          edtBDPstart.Text       := FieldByname('FFM_BDPStart').AsString ;
          edtRDPstart.Text       := FieldByname('FFM_RDPStart').AsString ;
          edtBCPstart.Text       := FieldByname('FFM_BCPStart').AsString ;
          edtFee.Text            := FieldByname('FFM_FeeValue').AsString ;

          for Rec := 1 to Length(trim(FieldByname('FFM_FDECData').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_FDECData').AsString),Rec,1) ;
              case Rec of
                1: if(TempStr = '1') then cbFDENDataSerialStub.Checked := true else if(TempStr = '0') then cbFDENDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbFDENDataSerial.Checked := true     else if(TempStr = '0') then cbFDENDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbFDENDataBank.Checked := true       else if(TempStr = '0') then cbFDENDataBank.Checked := false ;
                4: if(TempStr = '1') then cbFDENDataBranch.Checked := true     else if(TempStr = '0') then cbFDENDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbFDENDataAccount.Checked := true    else if(TempStr = '0') then cbFDENDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbFDENDataTC.Checked := true         else if(TempStr = '0') then cbFDENDataTC.Checked := false ;
                7: if(TempStr = '1') then cbFDENDataAmount.Checked := true     else if(TempStr = '0') then cbFDENDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbFDENDataSerialEnd.Checked := true  else if(TempStr = '0') then cbFDENDataSerialEnd.Checked := false ;
              end;
            end;

          for Rec := 1 to Length(trim(FieldByname('FFM_FDECSymbol').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_FDECSymbol').AsString),Rec,1) ;
//               lbFDENSBDataSerialStub.Values.
              case Rec of

                1 : lbFDENSBDataSerialStub.ItemIndex :=  lbFDENSBDataSerialStub.Values.IndexOf(TempStr) ;
                2 : lbFDENSBDataSerial.ItemIndex     :=  lbFDENSBDataSerial.Values.IndexOf(TempStr) ;
                3 : lbFDENSBDataBank.ItemIndex       :=  lbFDENSBDataBank.Values.IndexOf(TempStr) ;
                4 : lbFDENSBDataBranch.ItemIndex     :=  lbFDENSBDataBranch.Values.IndexOf(TempStr) ;
                5 : lbFDENSBDataAccount.ItemIndex    :=  lbFDENSBDataAccount.Values.IndexOf(TempStr) ;
                6 : lbFDENSBDataTC.ItemIndex         :=  lbFDENSBDataTC.Values.IndexOf(TempStr) ;
                7 : lbFDENSBDataAmount.ItemIndex     :=  lbFDENSBDataAmount.Values.IndexOf(TempStr) ;
                8 : lbFDENSBDataSerialEnd.ItemIndex  :=  lbFDENSBDataSerialEnd.Values.IndexOf(TempStr) ;
              end;

              {
              case Rec of
                1: if(TempStr = '1') then cbFDENSBDataSerialStub.Checked := true else if(TempStr = '0') then cbFDENSBDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbFDENSBDataSerial.Checked := true     else if(TempStr = '0') then cbFDENSBDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbFDENSBDataBank.Checked := true       else if(TempStr = '0') then cbFDENSBDataBank.Checked := false ;
                4: if(TempStr = '1') then cbFDENSBDataBranch.Checked := true     else if(TempStr = '0') then cbFDENSBDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbFDENSBDataAccount.Checked := true    else if(TempStr = '0') then cbFDENSBDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbFDENSBDataTC.Checked := true         else if(TempStr = '0') then cbFDENSBDataTC.Checked := false ;
                7: if(TempStr = '1') then cbFDENSBDataAmount.Checked := true     else if(TempStr = '0') then cbFDENSBDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbFDENSBDataSerialEnd.Checked := true  else if(TempStr = '0') then cbFDENSBDataSerialEnd.Checked := false ;
              end;
              }
            end;
          TempStr2 := '' ;
          CountCom := 0 ;
          for Rec := 1 to Length(trim(FieldByname('FFM_FDENPosition').AsString)) do
            begin
              tempStr := Copy(trim(FieldByname('FFM_FDENPosition').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtFDENSerialStubPOS.Text := TempStr2 ;
                      2 : edtFDENSerialPOS.Text     := TempStr2 ;
                      3 : edtFDENBankPOS.Text       := TempStr2 ;
                      4 : edtFDENBranchPOS.Text     := TempStr2 ;
                      5 : edtFDENAccountPOS.Text    := TempStr2 ;
                      6 : edtFDENTCPOS.Text         := TempStr2 ;
                      7 : edtFDENAmountPOS.Text     := TempStr2 ;
                      8 : edtFDENSerialEndPOS.Text  := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
            end;
            ListFDFont.ItemIndex := ListFDFont.Values.IndexOf(trim(FieldByname('FFM_FDPRFontSize').AsString)) ;
            edtFDNumberChar.Text := trim(FieldByname('FFM_FDPRCharNum').AsString) ;

            TempStr2 := '' ;
            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_FDPRStartPrintH1').AsString) ;
            edtFDPRH1L1Pos.Text := TemStr.Strings[0] ;
            edtFDPRH1L2Pos.Text := TemStr.Strings[1] ;
            edtFDPRH1L3Pos.Text := TemStr.Strings[2] ;
            edtFDPRH1L4Pos.Text := TemStr.Strings[3] ;

            TempStr2 := '' ;
            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_FDPRStartPrintH2').AsString) ;
            edtFDPRH2L1Pos.Text := TemStr.Strings[0] ;
            edtFDPRH2L2Pos.Text := TemStr.Strings[1] ;
            edtFDPRH2L3Pos.Text := TemStr.Strings[2] ;
            edtFDPRH2L4Pos.Text := TemStr.Strings[3] ;





 {
            for Rec := 1 to Length(trim(FieldByname('FFM_FDPRStartPrintH1').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_FDPRStartPrintH1').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtFDPRH1L1Pos.Text := TempStr2 ;
                      2 : edtFDPRH1L2Pos.Text := TempStr2 ;
                      3 : edtFDPRH1L3Pos.Text := TempStr2 ;
                      4 : edtFDPRH1L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;

            for Rec := 1 to Length(trim(FieldByname('FFM_FDPRStartPrintH2').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_FDPRStartPrintH2').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtFDPRH2L1Pos.Text := TempStr2 ;
                      2 : edtFDPRH2L2Pos.Text := TempStr2 ;
                      3 : edtFDPRH2L3Pos.Text := TempStr2 ;
                      4 : edtFDPRH2L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;
}
           ListFDH1L1D1.ItemIndex :=  ListFDH1L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine1H1').AsString),1,5));
           ListFDH1L1D2.ItemIndex :=  ListFDH1L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine1H1').AsString),6,5));
           ListFDH1L2D1.ItemIndex :=  ListFDH1L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine2H1').AsString),1,5));
           ListFDH1L2D2.ItemIndex :=  ListFDH1L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine2H1').AsString),6,5));
           ListFDH1L3D1.ItemIndex :=  ListFDH1L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine3H1').AsString),1,5));
           ListFDH1L3D2.ItemIndex :=  ListFDH1L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine3H1').AsString),6,5));
           ListFDH1L4D1.ItemIndex :=  ListFDH1L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine4H1').AsString),1,5));
           ListFDH1L4D2.ItemIndex :=  ListFDH1L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine4H1').AsString),6,5));

           ListFDH2L1D1.ItemIndex :=  ListFDH2L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine1H2').AsString),1,5));
           ListFDH2L1D2.ItemIndex :=  ListFDH2L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine1H2').AsString),6,5));
           ListFDH2L2D1.ItemIndex :=  ListFDH2L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine2H2').AsString),1,5));
           ListFDH2L2D2.ItemIndex :=  ListFDH2L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine2H2').AsString),6,5));
           ListFDH2L3D1.ItemIndex :=  ListFDH2L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine3H2').AsString),1,5));
           ListFDH2L3D2.ItemIndex :=  ListFDH2L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine3H2').AsString),6,5));
           ListFDH2L4D1.ItemIndex :=  ListFDH2L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine4H2').AsString),1,5));
           ListFDH2L4D2.ItemIndex :=  ListFDH2L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_FDPRPrintLine4H2').AsString),6,5));

//==================================================================================================

          cbUseBD.Checked        := FieldByname('FFM_BDUse').AsBoolean ;
          edtBDDocQty.Text       := FieldByname('FFM_BDQty').AsString ;
          edtBDENSequence.Text   := FieldByname('FFM_BDRunning').AsString ;

          for Rec := 1 to Length(trim(FieldByname('FFM_BDECData').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_BDECData').AsString),Rec,1) ;
              case Rec of
                1: if(TempStr = '1') then cbBDENDataSerialStub.Checked := true else if(TempStr = '0') then cbBDENDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbBDENDataSerial.Checked := true     else if(TempStr = '0') then cbBDENDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbBDENDataBank.Checked := true       else if(TempStr = '0') then cbBDENDataBank.Checked := false ;
                4: if(TempStr = '1') then cbBDENDataBranch.Checked := true     else if(TempStr = '0') then cbBDENDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbBDENDataAccount.Checked := true    else if(TempStr = '0') then cbBDENDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbBDENDataTC.Checked := true         else if(TempStr = '0') then cbBDENDataTC.Checked := false ;
                7: if(TempStr = '1') then cbBDENDataAmount.Checked := true     else if(TempStr = '0') then cbBDENDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbBDENDataSerialEnd.Checked := true  else if(TempStr = '0') then cbBDENDataSerialEnd.Checked := false ;
              end;
            end;

          for Rec := 1 to Length(trim(FieldByname('FFM_BDECSymbol').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_BDECSymbol').AsString),Rec,1) ;
              case Rec of
                1 : lbBDENSBDataSerialStub.ItemIndex :=  lbBDENSBDataSerialStub.Values.IndexOf(TempStr) ;
                2 : lbBDENSBDataSerial.ItemIndex     :=  lbBDENSBDataSerial.Values.IndexOf(TempStr) ;
                3 : lbBDENSBDataBank.ItemIndex       :=  lbBDENSBDataBank.Values.IndexOf(TempStr) ;
                4 : lbBDENSBDataBranch.ItemIndex     :=  lbBDENSBDataBranch.Values.IndexOf(TempStr) ;
                5 : lbBDENSBDataAccount.ItemIndex    :=  lbBDENSBDataAccount.Values.IndexOf(TempStr) ;
                6 : lbBDENSBDataTC.ItemIndex         :=  lbBDENSBDataTC.Values.IndexOf(TempStr) ;
                7 : lbBDENSBDataAmount.ItemIndex     :=  lbBDENSBDataAmount.Values.IndexOf(TempStr) ;
                8 : lbBDENSBDataSerialEnd.ItemIndex  :=  lbBDENSBDataSerialEnd.Values.IndexOf(TempStr) ;
              end;




{
              case Rec of
                1: if(TempStr = '1') then cbBDENSBDataSerialStub.Checked := true else if(TempStr = '0') then cbBDENSBDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbBDENSBDataSerial.Checked := true     else if(TempStr = '0') then cbBDENSBDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbBDENSBDataBank.Checked := true       else if(TempStr = '0') then cbBDENSBDataBank.Checked := false ;
                4: if(TempStr = '1') then cbBDENSBDataBranch.Checked := true     else if(TempStr = '0') then cbBDENSBDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbBDENSBDataAccount.Checked := true    else if(TempStr = '0') then cbBDENSBDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbBDENSBDataTC.Checked := true         else if(TempStr = '0') then cbBDENSBDataTC.Checked := false ;
                7: if(TempStr = '1') then cbBDENSBDataAmount.Checked := true     else if(TempStr = '0') then cbBDENSBDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbBDENSBDataSerialEnd.Checked := true  else if(TempStr = '0') then cbBDENSBDataSerialEnd.Checked := false ;
              end;
}
            end;
          TempStr2 := '' ;
          CountCom := 0 ;
          for Rec := 1 to Length(trim(FieldByname('FFM_BDENPosition').AsString)) do
            begin
              tempStr := Copy(trim(FieldByname('FFM_BDENPosition').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtBDENSerialStubPOS.Text := TempStr2 ;
                      2 : edtBDENSerialPOS.Text     := TempStr2 ;
                      3 : edtBDENBankPOS.Text       := TempStr2 ;
                      4 : edtBDENBranchPOS.Text     := TempStr2 ;
                      5 : edtBDENAccountPOS.Text    := TempStr2 ;
                      6 : edtBDENTCPOS.Text         := TempStr2 ;
                      7 : edtBDENAmountPOS.Text     := TempStr2 ;
                      8 : edtBDENSerialEndPOS.Text  := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
            end;
            ListBDFont.ItemIndex := ListBDFont.Values.IndexOf(trim(FieldByname('FFM_BDPRFontSize').AsString)) ;
            edtBDNumberChar.Text := trim(FieldByname('FFM_BDPRCharNum').AsString) ;

            TempStr2 := '' ;


            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_BDPRStartPrintH1').AsString) ;
            edtBDPRH1L1Pos.Text := TemStr.Strings[0] ;
            edtBDPRH1L2Pos.Text := TemStr.Strings[1] ;
            edtBDPRH1L3Pos.Text := TemStr.Strings[2] ;
            edtBDPRH1L4Pos.Text := TemStr.Strings[3] ;


            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_BDPRStartPrintH2').AsString) ;
            edtBDPRH2L1Pos.Text := TemStr.Strings[0] ;
            edtBDPRH2L2Pos.Text := TemStr.Strings[1] ;
            edtBDPRH2L3Pos.Text := TemStr.Strings[2] ;
            edtBDPRH2L4Pos.Text := TemStr.Strings[3] ;

{
            for Rec := 1 to Length(trim(FieldByname('FFM_BDPRStartPrintH1').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_BDPRStartPrintH1').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtBDPRH1L1Pos.Text := TempStr2 ;
                      2 : edtBDPRH1L2Pos.Text := TempStr2 ;
                      3 : edtBDPRH1L3Pos.Text := TempStr2 ;
                      4 : edtBDPRH1L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;

            for Rec := 1 to Length(trim(FieldByname('FFM_BDPRStartPrintH2').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_BDPRStartPrintH2').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtBDPRH2L1Pos.Text := TempStr2 ;
                      2 : edtBDPRH2L2Pos.Text := TempStr2 ;
                      3 : edtBDPRH2L3Pos.Text := TempStr2 ;
                      4 : edtBDPRH2L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;
}
           ListBDH1L1D1.ItemIndex :=  ListBDH1L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine1H1').AsString),1,5));
           ListBDH1L1D2.ItemIndex :=  ListBDH1L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine1H1').AsString),6,5));
           ListBDH1L2D1.ItemIndex :=  ListBDH1L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine2H1').AsString),1,5));
           ListBDH1L2D2.ItemIndex :=  ListBDH1L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine2H1').AsString),6,5));
           ListBDH1L3D1.ItemIndex :=  ListBDH1L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine3H1').AsString),1,5));
           ListBDH1L3D2.ItemIndex :=  ListBDH1L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine3H1').AsString),6,5));
           ListBDH1L4D1.ItemIndex :=  ListBDH1L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine4H1').AsString),1,5));
           ListBDH1L4D2.ItemIndex :=  ListBDH1L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine4H1').AsString),6,5));

           ListBDH2L1D1.ItemIndex :=  ListBDH2L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine1H2').AsString),1,5));
           ListBDH2L1D2.ItemIndex :=  ListBDH2L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine1H2').AsString),6,5));
           ListBDH2L2D1.ItemIndex :=  ListBDH2L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine2H2').AsString),1,5));
           ListBDH2L2D2.ItemIndex :=  ListBDH2L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine2H2').AsString),6,5));
           ListBDH2L3D1.ItemIndex :=  ListBDH2L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine3H2').AsString),1,5));
           ListBDH2L3D2.ItemIndex :=  ListBDH2L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine3H2').AsString),6,5));
           ListBDH2L4D1.ItemIndex :=  ListBDH2L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine4H2').AsString),1,5));
           ListBDH2L4D2.ItemIndex :=  ListBDH2L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BDPRPrintLine4H2').AsString),6,5));

//=================================================================================

          cbUseRD.Checked        := FieldByname('FFM_RDUse').AsBoolean ;
          edtRDDocQty.Text       := FieldByname('FFM_RDQty').AsString ;
          edtRDENSequence.Text   := FieldByname('FFM_RDRunning').AsString ;

          for Rec := 1 to Length(trim(FieldByname('FFM_RDECData').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_RDECData').AsString),Rec,1) ;
              case Rec of
                1: if(TempStr = '1') then cbRDENDataSerialStub.Checked := true else if(TempStr = '0') then cbRDENDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbRDENDataSerial.Checked := true     else if(TempStr = '0') then cbRDENDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbRDENDataBank.Checked := true       else if(TempStr = '0') then cbRDENDataBank.Checked := false ;
                4: if(TempStr = '1') then cbRDENDataBranch.Checked := true     else if(TempStr = '0') then cbRDENDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbRDENDataAccount.Checked := true    else if(TempStr = '0') then cbRDENDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbRDENDataTC.Checked := true         else if(TempStr = '0') then cbRDENDataTC.Checked := false ;
                7: if(TempStr = '1') then cbRDENDataAmount.Checked := true     else if(TempStr = '0') then cbRDENDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbRDENDataSerialEnd.Checked := true  else if(TempStr = '0') then cbRDENDataSerialEnd.Checked := false ;
              end;
            end;

          for Rec := 1 to Length(trim(FieldByname('FFM_RDECSymbol').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_RDECSymbol').AsString),Rec,1) ;
              case Rec of
                1 : lbRDENSBDataSerialStub.ItemIndex :=  lbRDENSBDataSerialStub.Values.IndexOf(TempStr) ;
                2 : lbRDENSBDataSerial.ItemIndex     :=  lbRDENSBDataSerial.Values.IndexOf(TempStr) ;
                3 : lbRDENSBDataBank.ItemIndex       :=  lbRDENSBDataBank.Values.IndexOf(TempStr) ;
                4 : lbRDENSBDataBranch.ItemIndex     :=  lbRDENSBDataBranch.Values.IndexOf(TempStr) ;
                5 : lbRDENSBDataAccount.ItemIndex    :=  lbRDENSBDataAccount.Values.IndexOf(TempStr) ;
                6 : lbRDENSBDataTC.ItemIndex         :=  lbRDENSBDataTC.Values.IndexOf(TempStr) ;
                7 : lbRDENSBDataAmount.ItemIndex     :=  lbRDENSBDataAmount.Values.IndexOf(TempStr) ;
                8 : lbRDENSBDataSerialEnd.ItemIndex  :=  lbRDENSBDataSerialEnd.Values.IndexOf(TempStr) ;
              end;



{
              case Rec of
                1: if(TempStr = '1') then cbRDENSBDataSerialStub.Checked := true else if(TempStr = '0') then cbRDENSBDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbRDENSBDataSerial.Checked := true     else if(TempStr = '0') then cbRDENSBDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbRDENSBDataBank.Checked := true       else if(TempStr = '0') then cbRDENSBDataBank.Checked := false ;
                4: if(TempStr = '1') then cbRDENSBDataBranch.Checked := true     else if(TempStr = '0') then cbRDENSBDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbRDENSBDataAccount.Checked := true    else if(TempStr = '0') then cbRDENSBDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbRDENSBDataTC.Checked := true         else if(TempStr = '0') then cbRDENSBDataTC.Checked := false ;
                7: if(TempStr = '1') then cbRDENSBDataAmount.Checked := true     else if(TempStr = '0') then cbRDENSBDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbRDENSBDataSerialEnd.Checked := true  else if(TempStr = '0') then cbRDENSBDataSerialEnd.Checked := false ;
              end;
}
            end;
          TempStr2 := '' ;
          CountCom := 0 ;
          for Rec := 1 to Length(trim(FieldByname('FFM_RDENPosition').AsString)) do
            begin
              tempStr := Copy(trim(FieldByname('FFM_RDENPosition').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtRDENSerialStubPOS.Text := TempStr2 ;
                      2 : edtRDENSerialPOS.Text     := TempStr2 ;
                      3 : edtRDENBankPOS.Text       := TempStr2 ;
                      4 : edtRDENBranchPOS.Text     := TempStr2 ;
                      5 : edtRDENAccountPOS.Text    := TempStr2 ;
                      6 : edtRDENTCPOS.Text         := TempStr2 ;
                      7 : edtRDENAmountPOS.Text     := TempStr2 ;
                      8 : edtRDENSerialEndPOS.Text  := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
            end;
            ListRDFont.ItemIndex := ListRDFont.Values.IndexOf(trim(FieldByname('FFM_RDPRFontSize').AsString)) ;
            edtRDNumberChar.Text := trim(FieldByname('FFM_RDPRCharNum').AsString) ;

            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_RDPRStartPrintH1').AsString) ;
            edtRDPRH1L1Pos.Text := TemStr.Strings[0] ;
            edtRDPRH1L2Pos.Text := TemStr.Strings[1] ;
            edtRDPRH1L3Pos.Text := TemStr.Strings[2] ;
            edtRDPRH1L4Pos.Text := TemStr.Strings[3] ;


            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_RDPRStartPrintH2').AsString) ;
            edtRDPRH2L1Pos.Text := TemStr.Strings[0] ;
            edtRDPRH2L2Pos.Text := TemStr.Strings[1] ;
            edtRDPRH2L3Pos.Text := TemStr.Strings[2] ;
            edtRDPRH2L4Pos.Text := TemStr.Strings[3] ;

{
            TempStr2 := '' ;

            for Rec := 1 to Length(trim(FieldByname('FFM_RDPRStartPrintH1').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_RDPRStartPrintH1').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtRDPRH1L1Pos.Text := TempStr2 ;
                      2 : edtRDPRH1L2Pos.Text := TempStr2 ;
                      3 : edtRDPRH1L3Pos.Text := TempStr2 ;
                      4 : edtRDPRH1L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;


            for Rec := 1 to Length(trim(FieldByname('FFM_RDPRStartPrintH2').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_RDPRStartPrintH2').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtRDPRH2L1Pos.Text := TempStr2 ;
                      2 : edtRDPRH2L2Pos.Text := TempStr2 ;
                      3 : edtRDPRH2L3Pos.Text := TempStr2 ;
                      4 : edtRDPRH2L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;
}
           ListRDH1L1D1.ItemIndex :=  ListRDH1L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine1H1').AsString),1,5));
           ListRDH1L1D2.ItemIndex :=  ListRDH1L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine1H1').AsString),6,5));
           ListRDH1L2D1.ItemIndex :=  ListRDH1L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine2H1').AsString),1,5));
           ListRDH1L2D2.ItemIndex :=  ListRDH1L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine2H1').AsString),6,5));
           ListRDH1L3D1.ItemIndex :=  ListRDH1L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine3H1').AsString),1,5));
           ListRDH1L3D2.ItemIndex :=  ListRDH1L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine3H1').AsString),6,5));
           ListRDH1L4D1.ItemIndex :=  ListRDH1L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine4H1').AsString),1,5));
           ListRDH1L4D2.ItemIndex :=  ListRDH1L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine4H1').AsString),6,5));

           ListRDH2L1D1.ItemIndex :=  ListRDH2L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine1H2').AsString),1,5));
           ListRDH2L1D2.ItemIndex :=  ListRDH2L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine1H2').AsString),6,5));
           ListRDH2L2D1.ItemIndex :=  ListRDH2L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine2H2').AsString),1,5));
           ListRDH2L2D2.ItemIndex :=  ListRDH2L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine2H2').AsString),6,5));
           ListRDH2L3D1.ItemIndex :=  ListRDH2L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine3H2').AsString),1,5));
           ListRDH2L3D2.ItemIndex :=  ListRDH2L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine3H2').AsString),6,5));
           ListRDH2L4D1.ItemIndex :=  ListRDH2L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine4H2').AsString),1,5));
           ListRDH2L4D2.ItemIndex :=  ListRDH2L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_RDPRPrintLine4H2').AsString),6,5));

//====================================================================================

          cbUseBC.Checked        := FieldByname('FFM_BCUse').AsBoolean ;
          edtBCDocQty.Text       := FieldByname('FFM_BCQty').AsString ;
          edtBCENSequence.Text   := FieldByname('FFM_BCRunning').AsString ;

          for Rec := 1 to Length(trim(FieldByname('FFM_BCECData').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_BCECData').AsString),Rec,1) ;
              case Rec of
                1: if(TempStr = '1') then cbBCENDataSerialStub.Checked := true else if(TempStr = '0') then cbBCENDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbBCENDataSerial.Checked := true     else if(TempStr = '0') then cbBCENDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbBCENDataBank.Checked := true       else if(TempStr = '0') then cbBCENDataBank.Checked := false ;
                4: if(TempStr = '1') then cbBCENDataBranch.Checked := true     else if(TempStr = '0') then cbBCENDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbBCENDataAccount.Checked := true    else if(TempStr = '0') then cbBCENDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbBCENDataTC.Checked := true         else if(TempStr = '0') then cbBCENDataTC.Checked := false ;
                7: if(TempStr = '1') then cbBCENDataAmount.Checked := true     else if(TempStr = '0') then cbBCENDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbBCENDataSerialEnd.Checked := true  else if(TempStr = '0') then cbBCENDataSerialEnd.Checked := false ;
              end;
            end;

          for Rec := 1 to Length(trim(FieldByname('FFM_BCECSymbol').AsString)) do
            begin
              TempStr := Copy(trim(FieldByname('FFM_BCECSymbol').AsString),Rec,1) ;

              case Rec of
                1 : lbBCENSBDataSerialStub.ItemIndex :=  lbBCENSBDataSerialStub.Values.IndexOf(TempStr) ;
                2 : lbBCENSBDataSerial.ItemIndex     :=  lbBCENSBDataSerial.Values.IndexOf(TempStr) ;
                3 : lbBCENSBDataBank.ItemIndex       :=  lbBCENSBDataBank.Values.IndexOf(TempStr) ;
                4 : lbBCENSBDataBranch.ItemIndex     :=  lbBCENSBDataBranch.Values.IndexOf(TempStr) ;
                5 : lbBCENSBDataAccount.ItemIndex    :=  lbBCENSBDataAccount.Values.IndexOf(TempStr) ;
                6 : lbBCENSBDataTC.ItemIndex         :=  lbBCENSBDataTC.Values.IndexOf(TempStr) ;
                7 : lbBCENSBDataAmount.ItemIndex     :=  lbBCENSBDataAmount.Values.IndexOf(TempStr) ;
                8 : lbBCENSBDataSerialEnd.ItemIndex  :=  lbBCENSBDataSerialEnd.Values.IndexOf(TempStr) ;
              end;


             {
              case Rec of

                1: if(TempStr = '1') then cbBCENSBDataSerialStub.Checked := true else if(TempStr = '0') then cbBCENSBDataSerialStub.Checked := false ;
                2: if(TempStr = '1') then cbBCENSBDataSerial.Checked := true     else if(TempStr = '0') then cbBCENSBDataSerial.Checked := false ;
                3: if(TempStr = '1') then cbBCENSBDataBank.Checked := true       else if(TempStr = '0') then cbBCENSBDataBank.Checked := false ;
                4: if(TempStr = '1') then cbBCENSBDataBranch.Checked := true     else if(TempStr = '0') then cbBCENSBDataBranch.Checked := false ;
                5: if(TempStr = '1') then cbBCENSBDataAccount.Checked := true    else if(TempStr = '0') then cbBCENSBDataAccount.Checked := false ;
                6: if(TempStr = '1') then cbBCENSBDataTC.Checked := true         else if(TempStr = '0') then cbBCENSBDataTC.Checked := false ;
                7: if(TempStr = '1') then cbBCENSBDataAmount.Checked := true     else if(TempStr = '0') then cbBCENSBDataAmount.Checked := false ;
                8: if(TempStr = '1') then cbBCENSBDataSerialEnd.Checked := true  else if(TempStr = '0') then cbBCENSBDataSerialEnd.Checked := false ;
              end;
           }
            end;
          TempStr2 := '' ;
          CountCom := 0 ;
          for Rec := 1 to Length(trim(FieldByname('FFM_BCENPosition').AsString)) do
            begin
              tempStr := Copy(trim(FieldByname('FFM_BCENPosition').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtBCENSerialStubPOS.Text := TempStr2 ;
                      2 : edtBCENSerialPOS.Text     := TempStr2 ;
                      3 : edtBCENBankPOS.Text       := TempStr2 ;
                      4 : edtBCENBranchPOS.Text     := TempStr2 ;
                      5 : edtBCENAccountPOS.Text    := TempStr2 ;
                      6 : edtBCENTCPOS.Text         := TempStr2 ;
                      7 : edtBCENAmountPOS.Text     := TempStr2 ;
                      8 : edtBCENSerialEndPOS.Text  := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
            end;
            ListBCFont.ItemIndex := ListRDFont.Values.IndexOf(trim(FieldByname('FFM_BCPRFontSize').AsString)) ;
            edtBCNumberChar.Text := trim(FieldByname('FFM_BCPRCharNum').AsString) ;

            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_BCPRStartPrintH1').AsString) ;
            edtBCPRH1L1Pos.Text := TemStr.Strings[0] ;
            edtBCPRH1L2Pos.Text := TemStr.Strings[1] ;
            edtBCPRH1L3Pos.Text := TemStr.Strings[2] ;
            edtBCPRH1L4Pos.Text := TemStr.Strings[3] ;


            TemStr.Clear ;
            TemStr.CommaText := trim(FieldByname('FFM_BCPRStartPrintH2').AsString) ;
            edtBCPRH2L1Pos.Text := TemStr.Strings[0] ;
            edtBCPRH2L2Pos.Text := TemStr.Strings[1] ;
            edtBCPRH2L3Pos.Text := TemStr.Strings[2] ;
            edtBCPRH2L4Pos.Text := TemStr.Strings[3] ;



            {
            TempStr2 := '' ;

            for Rec := 1 to Length(trim(FieldByname('FFM_BCPRStartPrintH1').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_BCPRStartPrintH1').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtBCPRH1L1Pos.Text := TempStr2 ;
                      2 : edtBCPRH1L2Pos.Text := TempStr2 ;
                      3 : edtBCPRH1L3Pos.Text := TempStr2 ;
                      4 : edtBCPRH1L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;

            for Rec := 1 to Length(trim(FieldByname('FFM_BCPRStartPrintH2').AsString)) do
              begin
              tempStr := Copy(trim(FieldByname('FFM_BCPRStartPrintH2').AsString),Rec,1) ;
              if(TempStr <> ',') then
                 begin
                   TempStr2 := TempStr2 + TempStr ;
                 end else if(TempStr = ',') then
                 begin
                    CountCom := CountCom + 1 ;
                    case CountCom of
                      1 : edtBCPRH2L1Pos.Text := TempStr2 ;
                      2 : edtBCPRH2L2Pos.Text := TempStr2 ;
                      3 : edtBCPRH2L3Pos.Text := TempStr2 ;
                      4 : edtBCPRH2L4Pos.Text := TempStr2 ;
                    end;
                   TempStr2 := '' ;
                 end;
              end;
            }
           ListBCH1L1D1.ItemIndex :=  ListBCH1L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine1H1').AsString),1,5));
           ListBCH1L1D2.ItemIndex :=  ListBCH1L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine1H1').AsString),6,5));
           ListBCH1L2D1.ItemIndex :=  ListBCH1L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine2H1').AsString),1,5));
           ListBCH1L2D2.ItemIndex :=  ListBCH1L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine2H1').AsString),6,5));
           ListBCH1L3D1.ItemIndex :=  ListBCH1L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine3H1').AsString),1,5));
           ListBCH1L3D2.ItemIndex :=  ListBCH1L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine3H1').AsString),6,5));
           ListBCH1L4D1.ItemIndex :=  ListBCH1L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine4H1').AsString),1,5));
           ListBCH1L4D2.ItemIndex :=  ListBCH1L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine4H1').AsString),6,5));

           ListBCH2L1D1.ItemIndex :=  ListBCH2L1D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine1H2').AsString),1,5));
           ListBCH2L1D2.ItemIndex :=  ListBCH2L1D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine1H2').AsString),6,5));
           ListBCH2L2D1.ItemIndex :=  ListBCH2L2D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine2H2').AsString),1,5));
           ListBCH2L2D2.ItemIndex :=  ListBCH2L2D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine2H2').AsString),6,5));
           ListBCH2L3D1.ItemIndex :=  ListBCH2L3D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine3H2').AsString),1,5));
           ListBCH2L3D2.ItemIndex :=  ListBCH2L3D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine3H2').AsString),6,5));
           ListBCH2L4D1.ItemIndex :=  ListBCH2L4D1.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine4H2').AsString),1,5));
           ListBCH2L4D2.ItemIndex :=  ListBCH2L4D2.Values.IndexOf(Copy(trim(FieldByname('FFM_BCPRPrintLine4H2').AsString),6,5));

           Active := false ;
           Free ;
     end;

end;

procedure TfrmChequeProperties.edtNameKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = Vk_Return) then SelectNext(ActiveControl,True,true);
end;

Procedure TfrmChequeProperties.GetListMICRSymbol() ;
var Rec : Integer ;
begin
     for Rec := 0 to suiGroupBox7.ControlCount - 1 do
      begin
        if(suiGroupBox7.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox7.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox7.Controls[Rec]).AddItemValue('N','N') ;
            TRzComboBox(suiGroupBox7.Controls[Rec]).AddItemValue('@','<') ;
            TRzComboBox(suiGroupBox7.Controls[Rec]).AddItemValue('-','=') ;
            TRzComboBox(suiGroupBox7.Controls[Rec]).AddItemValue('[',':') ;
            TRzComboBox(suiGroupBox7.Controls[Rec]).AddItemValue('#',';') ;
            TRzComboBox(suiGroupBox7.Controls[Rec]).ItemIndex := 0 ;

         end;
      end;

     for Rec := 0 to suiGroupBox14.ControlCount - 1 do
      begin
        if(suiGroupBox14.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox14.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox14.Controls[Rec]).AddItemValue('N','N') ;
            TRzComboBox(suiGroupBox14.Controls[Rec]).AddItemValue('@','<') ;
            TRzComboBox(suiGroupBox14.Controls[Rec]).AddItemValue('-','=') ;
            TRzComboBox(suiGroupBox14.Controls[Rec]).AddItemValue('[',':') ;
            TRzComboBox(suiGroupBox14.Controls[Rec]).AddItemValue('#',';') ;
            TRzComboBox(suiGroupBox14.Controls[Rec]).ItemIndex := 0 ;
         end;
      end;

     for Rec := 0 to suiGroupBox21.ControlCount - 1 do
      begin
        if(suiGroupBox21.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox21.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox21.Controls[Rec]).AddItemValue('N','N') ;
            TRzComboBox(suiGroupBox21.Controls[Rec]).AddItemValue('@','<') ;
            TRzComboBox(suiGroupBox21.Controls[Rec]).AddItemValue('-','=') ;
            TRzComboBox(suiGroupBox21.Controls[Rec]).AddItemValue('[',':') ;
            TRzComboBox(suiGroupBox21.Controls[Rec]).AddItemValue('#',';') ;
            TRzComboBox(suiGroupBox21.Controls[Rec]).ItemIndex := 0 ;
         end;
      end;

     for Rec := 0 to suiGroupBox28.ControlCount - 1 do
      begin
        if(suiGroupBox28.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox28.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox28.Controls[Rec]).AddItemValue('N','N') ;
            TRzComboBox(suiGroupBox28.Controls[Rec]).AddItemValue('@','<') ;
            TRzComboBox(suiGroupBox28.Controls[Rec]).AddItemValue('-','=') ;
            TRzComboBox(suiGroupBox28.Controls[Rec]).AddItemValue('[',':') ;
            TRzComboBox(suiGroupBox28.Controls[Rec]).AddItemValue('#',';') ;
            TRzComboBox(suiGroupBox28.Controls[Rec]).ItemIndex := 0 ;
         end;
      end;
end;

Procedure TfrmChequeProperties.GetPrintListProperties();
var Rec : Integer ;
begin

    for Rec := 0 to suiGroupBox10.ControlCount - 1 do
      begin
        if(suiGroupBox10.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox10.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox10.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox10.Controls[Rec]).ItemIndex := 0 ;
         end;
      end;

    for Rec := 0 to suiGroupBox11.ControlCount - 1 do
      begin
        if(suiGroupBox11.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox11.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox11.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox11.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox18.ControlCount - 1 do
      begin
        if(suiGroupBox18.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox18.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox18.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox18.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox17.ControlCount - 1 do
      begin
        if(suiGroupBox17.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox17.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox17.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox25.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox25.ControlCount - 1 do
      begin
        if(suiGroupBox25.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox25.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox25.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

             TRzComboBox(suiGroupBox25.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox24.ControlCount - 1 do
      begin
        if(suiGroupBox24.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox24.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox24.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox24.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox32.ControlCount - 1 do
      begin
        if(suiGroupBox32.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox32.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;

            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;
//            TRzComboBox(suiGroupBox32.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox32.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;

    for Rec := 0 to suiGroupBox31.ControlCount - 1 do
      begin
        if(suiGroupBox31.Controls[Rec].ClassName = 'TRzComboBox') then
          begin
            TRzComboBox(suiGroupBox31.Controls[Rec]).Clear ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('None','None0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Start Cheque Number','PSCN0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('End Cheque Number','PECN0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Bank Code','PBKC0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Bank Name','PBKN0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Bank Address1','PBKA1') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Bank Address2','PBKA2') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Bank City','PBKCT') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Bank Region','PBKBR') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Branch Code','PBRC0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Branch Name','PBRN0') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Branch Address1','PBRA1') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Branch Address2','PBRA2') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Branch City','PBRCT') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Branch Region','PBRBR') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Account ID','PACID') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Account Name','PACNA') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Account Address1','PACA1') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Account Address2','PACA2') ;

            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Price','PEPRE') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Price Thai','PPRTH') ;
            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Price ENG','PPREN') ;            
//            TRzComboBox(suiGroupBox31.Controls[Rec]).AddItemValue('Summery Set','PTPRI') ;

            TRzComboBox(suiGroupBox31.Controls[Rec]).ItemIndex := 0 ;
          end;
      end;
end;

{
 Serial Start
 Serail End

 Bank Code
 Bank Name
 Bank Address1
 Bank Address2
 Bank City
 Bank Region

 Branch Code
 Branch Name
 Branch Address1
 Branch Address2
 Branch City
 Branch Region

 Account ID
 Account Name
 Account Address1
 Account Address2

 Date
 Qty
 Price
 Total Price
 Discount
 Entry Data
}

procedure TfrmChequeProperties.FormActivate(Sender: TObject);
begin
//====
end;



procedure TfrmChequeProperties.suiButton1Click(Sender: TObject);
var DBSave : TADOQuery ;
    REC : Integer ;
    fEncodeData, fEncodeSymbol, fPosition : String ;
    fPrintData1, fPrintData2, fPrintPosition1, fPrintPosition2 : String ;
    fEnPosition1, fEnPosition2 : String ;
//    fPrintData1, fPrintData2, fPrintPosition1, fPrintPosition2 : String ;
//    fPrintData1, fPrintData2, fPrintPosition1, fPrintPosition2 : String ;
//    fPrintData1, fPrintData2, fPrintPosition1, fPrintPosition2 : String ;
    TempStr : String ;

    //FDPRH1L1Pos,FDPRH1L2Pos,FDPRH1L3Pos,FDPRH1L4Pos :String;
    //FDPRH2L1Pos,FDPRH2L2Pos,FDPRH2L3Pos,FDPRH2L4Pos :String;

    SPrintPosition1,SPrintPosition2:String;

    SFDPstart,SBDPstart,SRDPstart,SBCPstart :String;


begin

  if(trim(edtName.Text) = '') then
    begin
      MessageDlg('ยังไม่ได้ใส่ชื่อรูปแบบการพิมพ์',mtError,[mbOK],0) ;
      edtName.SetFocus ;
      Exit ;
    end;

  if(trim(edtWidth.Text) = '') then
    begin
      MessageDlg('ยังไม่ได้ใส่ความกว้างของกระดาษ',mtError,[mbOK],0) ;
      edtName.SetFocus ;
      Exit ;
    end;

  if(trim(edtLength.Text) = '') then
    begin
      MessageDlg('ยังไม่ได้ใส่ความยาวของกระดาษ',mtError,[mbOK],0) ;
      edtName.SetFocus ;
      Exit ;
    end;

  if(trim(edtFDDocQty.Text) <> '' ) then
     begin
       if(trim(edtFDENSequence.Text) = '') then
         begin
           MessageDlg('คุณต้องใส่ลำดับการพิมพ์ของกระดาษปกหน้า',mtError,[mbOk],0) ;
           PagesLists.ActivePage := suiTabSheet1 ;
           edtFDENSequence.SetFocus ;
           Exit ;
         end;
     end;


  if(trim(edtBDDocQty.Text) <> ' ' ) then
     begin
       if(trim(edtBDENSequence.Text) = ' ') then
         begin
           MessageDlg('คุณต้องใส่ลำดับการพิมพ์ของกระดาษเช็ค',mtError,[mbOk],0) ;
           PagesLists.ActivePage := suiTabSheet2 ;
           edtBDENSequence.SetFocus ;
           Exit ;
         end;
     end;


  if(trim(edtRDDocQty.Text) <> ' ' ) then
     begin
       if(trim(edtRDENSequence.Text) = ' ') then
         begin
           MessageDlg('คุณต้องใส่ลำดับการพิมพ์ของกระดาษใบขอชื้อเช็ค',mtError,[mbOk],0) ;
           PagesLists.ActivePage := suiTabSheet3 ;
           edtRDENSequence.SetFocus ;
           Exit ;
         end;
     end;


  if(trim(edtBCDocQty.Text) <> ' ' ) then
     begin
       if(trim(edtBCENSequence.Text) = ' ') then
         begin
           MessageDlg('คุณต้องใส่ลำดับการพิมพ์ของกระดาษปกหลัง',mtError,[mbOk],0) ;
           PagesLists.ActivePage := suiTabSheet4 ;
           edtBCENSequence.SetFocus ;
           Exit ;
         end;
     end;

     fFormatName := trim(edtName.Text) ;
     DBSave := TADOQuery.Create(nil);
     fEncodeData := '' ;

      with DBSave do
        begin
          Connection :=  frmDataCenter.ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Delete DBChequeProperties '+
                      ' Where FFM_Name = '+QuotedStr(trim(edtName.Text))+
                      ' Insert into DBChequeProperties '+
                      ' ( ' +
                      ' FFM_Name, '+                //1
                      ' FFM_Description, '+          //2
                      ' FFM_Width, '+
                      ' FFM_Length,	'+
                      ' FFM_NewFormat, '+
                      ' FFM_Price, '+
                      ' FFM_Discount, '+

                      ' FFM_FDUse, '+
                      ' FFM_FDQty, '+
                      ' FFM_FDRunning, '+
                      ' FFM_FDECData, '+
                      ' FFM_FDECSymbol, '+
                      ' FFM_FDENPosition, '+
                      ' FFM_FDPRFontSize, '+
                      ' FFM_FDPRCharNum, '+
                      ' FFM_FDPRStartPrintH1, '+ //
                      ' FFM_FDPRStartPrintH2, '+
                      ' FFM_FDPRPrintLine1H1, '+
                      ' FFM_FDPRPrintLine2H1, '+
                      ' FFM_FDPRPrintLine3H1, '+
                      ' FFM_FDPRPrintLine4H1, '+
                      ' FFM_FDPRPrintLine1H2, '+
                      ' FFM_FDPRPrintLine2H2, '+
                      ' FFM_FDPRPrintLine3H2, '+
                      ' FFM_FDPRPrintLine4H2, '+

                      ' FFM_BDUse, '+
                      ' FFM_BDQty, '+
                      ' FFM_BDRunning, '+
                      ' FFM_BDECData, '+
                      ' FFM_BDECSymbol, '+
                      ' FFM_BDENPosition, '+
                      ' FFM_BDPRFontSize, '+
                      ' FFM_BDPRCharNum, '+
                      ' FFM_BDPRStartPrintH1, '+
                      ' FFM_BDPRStartPrintH2, '+
                      ' FFM_BDPRPrintLine1H1, '+
                      ' FFM_BDPRPrintLine2H1, '+
                      ' FFM_BDPRPrintLine3H1, '+
                      ' FFM_BDPRPrintLine4H1, '+
                      ' FFM_BDPRPrintLine1H2, '+
                      ' FFM_BDPRPrintLine2H2, '+
                      ' FFM_BDPRPrintLine3H2, '+
                      ' FFM_BDPRPrintLine4H2, '+

                      ' FFM_RDUse, '+
                      ' FFM_RDQty, '+
                      ' FFM_RDRunning, '+
                      ' FFM_RDECData, '+
                      ' FFM_RDECSymbol, '+
                      ' FFM_RDENPosition, '+
                      ' FFM_RDPRFontSize,	'+
                      ' FFM_RDPRCharNum, '+
                      ' FFM_RDPRStartPrintH1, '+
                      ' FFM_RDPRStartPrintH2, '+
                      ' FFM_RDPRPrintLine1H1, '+
                      ' FFM_RDPRPrintLine2H1, '+
                      ' FFM_RDPRPrintLine3H1, '+
                      ' FFM_RDPRPrintLine4H1, '+
                      ' FFM_RDPRPrintLine1H2, '+
                      ' FFM_RDPRPrintLine2H2, '+
                      ' FFM_RDPRPrintLine3H2, '+
                      ' FFM_RDPRPrintLine4H2, '+

                      ' FFM_BCUse, '+
                      '	FFM_BCQty, '+
                      ' FFM_BCRunning, '+
                      ' FFM_BCECData, '+
                      ' FFM_BCECSymbol, '+
                      ' FFM_BCENPosition, '+
                      ' FFM_BCPRFontSize, '+
                      ' FFM_BCPRCharNum, '+
                      ' FFM_BCPRStartPrintH1, '+
                      ' FFM_BCPRStartPrintH2, '+
                      ' FFM_BCPRPrintLine1H1, '+
                      ' FFM_BCPRPrintLine2H1, '+
                      ' FFM_BCPRPrintLine3H1, '+
                      ' FFM_BCPRPrintLine4H1, '+
                      ' FFM_BCPRPrintLine1H2,	'+
                      ' FFM_BCPRPrintLine2H2,	'+
                      ' FFM_BCPRPrintLine3H2, '+
                      ' FFM_BCPRPrintLine4H2, '+
                      ' FFM_DiscountValues, '+
                      ' FFM_Default, '+
                      ' FFM_FDPStart, '+
                      ' FFM_BDPStart, '+
                      ' FFM_RDPStart, '+
                      ' FFM_BCPStart, '+
                      ' FFM_FeeValue '+
                      ' ) '+
                      ' Values '+
                      ' ( '+
                       QuotedStr(trim(edtName.Text))+','+
                       QuotedStr('')+','+
                       trim(edtWidth.Text)+','+
                       trim(edtLength.Text)+',' ;
                       if(cbNewformat.Checked) then SQl.Text := SQL.Text + QuotedStr('1')+',' else SQl.Text := SQL.Text + QuotedStr('0')+',' ;
                       SQl.Text := SQL.Text + trim(edtPrice.Text)+',' ;
                       if(not cbDiscountPercent.Checked) and (Not cbDiscountBath.Checked) then  SQl.Text := SQL.Text + QuotedStr('N')+',' else
                       if(not cbDiscountPercent.Checked) and (cbDiscountBath.Checked) then SQl.Text := SQL.Text + QuotedStr('B')+',' else
                       if(cbDiscountPercent.Checked) and (not cbDiscountBath.Checked) then SQl.Text := SQL.Text + QuotedStr('P')+',' ;
                       if(cbUseFD.Checked) then SQl.Text := SQL.Text + QuotedStr('1')+',' else SQl.Text := SQL.Text + QuotedStr('0')+',' ;
                       SQL.Text := SQL.Text + trim(edtFDDocQty.Text)+','+
                       trim(edtFDENSequence.Text)+',' ;
                       if(cbFDENDataSerialStub.Checked) then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataSerial.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataBank.Checked)       then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataBranch.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataAccount.Checked)    then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataTC.Checked)         then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataAmount.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbFDENDataSerialEnd.Checked)  then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;

                       SQL.Text := SQL.Text + QuotedStr(fEncodeData)+',' ;

                       fEncodeSymbol := trim(lbFDENSBDataSerialStub.Values.Strings[lbFDENSBDataSerialStub.ItemIndex])+
                                        trim(lbFDENSBDataSerial.Values.Strings[lbFDENSBDataSerial.ItemIndex])+
                                        trim(lbFDENSBDataBank.Values.Strings[lbFDENSBDataBank.ItemIndex])+
                                        trim(lbFDENSBDataBranch.Values.Strings[lbFDENSBDataBranch.ItemIndex])+
                                        trim(lbFDENSBDataAccount.Values.Strings[lbFDENSBDataAccount.ItemIndex])+
                                        trim(lbFDENSBDataTC.Values.Strings[lbFDENSBDataTC.ItemIndex])+
                                        trim(lbFDENSBDataAmount.Values.Strings[lbFDENSBDataAmount.ItemIndex])+
                                        trim(lbFDENSBDataSerialEnd.Values.Strings[lbFDENSBDataSerialEnd.ItemIndex]) ;

                      SQL.Text := SQL.Text+QuotedStr(fEncodeSymbol)+',' ;

                    {

                       if(cbFDENSBDataSerialStub.Checked) then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataSerial.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataBank.Checked)       then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataBranch.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataAccount.Checked)    then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataTC.Checked)         then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataAmount.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbFDENSBDataSerialEnd.Checked)  then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeSymbol)+',' ;
                     }

                       fEnPosition1 := trim(edtFDENSerialStubPOS.Text)+','+trim(edtFDENSerialPOS.Text)+','+trim(edtFDENBankPOS.Text)+','+trim(edtFDENBranchPOS.Text)+','+trim(edtFDENAccountPOS.Text)+','+trim(edtFDENTCPOS.Text)+','+trim(edtFDENAmountPOS.Text)+','+trim(edtFDENSerialEndPOS.Text)+',' ;

                       SQL.Text := SQL.Text + quotedStr(fEnPosition1)+',' ;
                       SQL.Text := SQL.Text + ListFDFont.Values.Strings[ListFDFont.Itemindex]+',' ;
                       SQL.Text := SQL.text + trim(edtFDNumberChar.Text)+',' ;





                        fPrintPosition1 := '' ;
                        fPrintPosition2 := '' ;
                        fPrintData1 := '' ;
                        fPrintData2 := '' ;

                        {FDPRH1L1Pos,FDPRH1L2Pos,FDPRH1L3Pos,FDPRH1L4Pos

                        FDPRH2L1Pos,FDPRH2L2Pos,FDPRH2L3Pos,FDPRH2L4Pos }


                        SPrintPosition1 := trim(edtFDPRH1L1Pos.Text) +','+trim(edtFDPRH1L2Pos.Text)+','+trim(edtFDPRH1L3Pos.Text)+','+trim(edtFDPRH1L4Pos.Text)+',' ;
                        SPrintPosition2 := trim(edtFDPRH2L1Pos.Text) +','+trim(edtFDPRH2L2Pos.Text)+','+trim(edtFDPRH2L3Pos.Text)+','+trim(edtFDPRH2L4Pos.Text)+',' ;

                        if SPrintPosition1 = ',,,,' then fPrintPosition1 := '0,0,0,0,' else fPrintPosition1 := SPrintPosition1;

                        if SPrintPosition2 = ',,,,' then fPrintPosition2 := '0,0,0,0,' else fPrintPosition2 := SPrintPosition2;


                        {if trim(edtFDPRH1L1Pos.Text)= '' then
                           FDPRH1L1Pos := '0'
                        else
                           FDPRH1L1Pos := edtFDPRH1L1Pos.Text;

                        trim(edtFDPRH1L2Pos.Text)
                        trim(edtFDPRH1L3Pos.Text)
                        trim(edtFDPRH1L4Pos.Text)

                        trim(edtFDPRH2L1Pos.Text)
                        trim(edtFDPRH2L2Pos.Text)
                        trim(edtFDPRH2L3Pos.Text)
                        trim(edtFDPRH2L4Pos.Text) }



                        //fPrintPosition1 := trim(edtFDPRH1L1Pos.Text) +','+trim(edtFDPRH1L2Pos.Text)+','+trim(edtFDPRH1L3Pos.Text)+','+trim(edtFDPRH1L4Pos.Text)+',' ;
                        //fPrintPosition2 := trim(edtFDPRH2L1Pos.Text) +','+trim(edtFDPRH2L2Pos.Text)+','+trim(edtFDPRH2L3Pos.Text)+','+trim(edtFDPRH2L4Pos.Text)+',' ;


                        SQL.Text := SQL.Text + Quotedstr(fPrintPosition1)+','+Quotedstr(fPrintPosition2)+',' ;

                        fPrintData1 := QuotedStr(trim(ListFDH1L1D1.Values.Strings[ListFDH1L1D1.ItemIndex])+trim(ListFDH1L1D2.Values.Strings[ListFDH1L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListFDH1L2D1.Values.Strings[ListFDH1L2D1.ItemIndex])+trim(ListFDH1L2D2.Values.Strings[ListFDH1L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListFDH1L3D1.Values.Strings[ListFDH1L3D1.ItemIndex])+trim(ListFDH1L3D2.Values.Strings[ListFDH1L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListFDH1L4D1.Values.Strings[ListFDH1L4D1.ItemIndex])+trim(ListFDH1L4D2.Values.Strings[ListFDH1L4D2.ItemIndex]))+','+

                                       QuotedStr(trim(ListFDH2L1D1.Values.Strings[ListFDH2L1D1.ItemIndex])+trim(ListFDH2L1D2.Values.Strings[ListFDH2L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListFDH2L2D1.Values.Strings[ListFDH2L2D1.ItemIndex])+trim(ListFDH2L2D2.Values.Strings[ListFDH2L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListFDH2L3D1.Values.Strings[ListFDH2L3D1.ItemIndex])+trim(ListFDH2L3D2.Values.Strings[ListFDH2L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListFDH2L4D1.Values.Strings[ListFDH2L4D1.ItemIndex])+trim(ListFDH2L4D2.Values.Strings[ListFDH2L4D2.ItemIndex]))+',';


                        SQL.Text := SQL.Text + fPrintData1  ;

                       fEncodeData   := '' ;
                       fEncodeSymbol := '' ;

                       if(cbUseBD.Checked) then SQl.Text := SQL.Text + QuotedStr('1')+',' else SQl.Text := SQL.Text + QuotedStr('0')+',' ;
                       SQL.Text := SQL.Text + trim(edtBDDocQty.Text)+','+
                       trim(edtBDENSequence.Text)+',' ;
                       if(cbBDENDataSerialStub.Checked) then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataSerial.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataBank.Checked)       then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataBranch.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataAccount.Checked)    then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataTC.Checked)         then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataAmount.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBDENDataSerialEnd.Checked)  then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeData)+',' ;

                       fEncodeSymbol := trim(lbBDENSBDataSerialStub.Values.Strings[lbBDENSBDataSerialStub.ItemIndex])+
                                        trim(lbBDENSBDataSerial.Values.Strings[lbBDENSBDataSerial.ItemIndex])+
                                        trim(lbBDENSBDataBank.Values.Strings[lbBDENSBDataBank.ItemIndex])+
                                        trim(lbBDENSBDataBranch.Values.Strings[lbBDENSBDataBranch.ItemIndex])+
                                        trim(lbBDENSBDataAccount.Values.Strings[lbBDENSBDataAccount.ItemIndex])+
                                        trim(lbBDENSBDataTC.Values.Strings[lbBDENSBDataTC.ItemIndex])+
                                        trim(lbBDENSBDataAmount.Values.Strings[lbBDENSBDataAmount.ItemIndex])+
                                        trim(lbBDENSBDataSerialEnd.Values.Strings[lbBDENSBDataSerialEnd.ItemIndex]) ;

                      SQL.Text := SQL.Text+QuotedStr(fEncodeSymbol)+',' ;



{
                       if(cbBDENSBDataSerialStub.Checked) then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataSerial.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataBank.Checked)       then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataBranch.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataAccount.Checked)    then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataTC.Checked)         then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataAmount.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBDENSBDataSerialEnd.Checked)  then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeSymbol)+',' ;
}
                       fEnPosition1 := trim(edtBDENSerialStubPOS.Text)+','+trim(edtBDENSerialPOS.Text)+','+trim(edtBDENBankPOS.Text)+','+trim(edtBDENBranchPOS.Text)+','+trim(edtBDENAccountPOS.Text)+','+trim(edtBDENTCPOS.Text)+','+trim(edtBDENAmountPOS.Text)+','+trim(edtBDENSerialEndPOS.Text)+',' ;

                       SQL.Text := SQL.Text + quotedStr(fEnPosition1)+',' ;
                       SQL.Text := SQL.Text + ListBDFont.Values.Strings[ListBDFont.Itemindex]+',' ;
                       //----------
                       //SQL.Text := SQL.text + trim(edtBDNumberChar.Text)+',' ;
                       SQL.Text := SQL.text + trim(edtFDNumberChar.Text)+',' ;


                        fPrintPosition1 := '' ;
                        fPrintPosition2 := '' ;
                        fPrintData1 := '' ;
                        fPrintData2 := '' ;

                        


                        SPrintPosition1 :=  trim(edtBDPRH1L1Pos.Text) +','+trim(edtBDPRH1L2Pos.Text)+','+trim(edtBDPRH1L3Pos.Text)+','+trim(edtBDPRH1L4Pos.Text)+',' ;
                        SPrintPosition2 :=  trim(edtBDPRH2L1Pos.Text) +','+trim(edtBDPRH2L2Pos.Text)+','+trim(edtBDPRH2L3Pos.Text)+','+trim(edtBDPRH2L4Pos.Text)+',' ;

                        if SPrintPosition1 = ',,,,' then fPrintPosition1 := '0,0,0,0,' else fPrintPosition1 := SPrintPosition1;

                        if SPrintPosition2 = ',,,,' then fPrintPosition2 := '0,0,0,0,' else fPrintPosition2 := SPrintPosition2;


                        SQL.Text := SQL.Text + Quotedstr(fPrintPosition1)+','+Quotedstr(fPrintPosition2)+',' ;

                        fPrintData1 := QuotedStr(trim(ListBDH1L1D1.Values.Strings[ListBDH1L1D1.ItemIndex])+trim(ListBDH1L1D2.Values.Strings[ListBDH1L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBDH1L2D1.Values.Strings[ListBDH1L2D1.ItemIndex])+trim(ListBDH1L2D2.Values.Strings[ListBDH1L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBDH1L3D1.Values.Strings[ListBDH1L3D1.ItemIndex])+trim(ListBDH1L3D2.Values.Strings[ListBDH1L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBDH1L4D1.Values.Strings[ListBDH1L4D1.ItemIndex])+trim(ListBDH1L4D2.Values.Strings[ListBDH1L4D2.ItemIndex]))+','+

                                       QuotedStr(trim(ListBDH2L1D1.Values.Strings[ListBDH2L1D1.ItemIndex])+trim(ListBDH2L1D2.Values.Strings[ListBDH2L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBDH2L2D1.Values.Strings[ListBDH2L2D1.ItemIndex])+trim(ListBDH2L2D2.Values.Strings[ListBDH2L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBDH2L3D1.Values.Strings[ListBDH2L3D1.ItemIndex])+trim(ListBDH2L3D2.Values.Strings[ListBDH2L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBDH2L4D1.Values.Strings[ListBDH2L4D1.ItemIndex])+trim(ListBDH2L4D2.Values.Strings[ListBDH2L4D2.ItemIndex]))+',' ;


                        SQL.Text := SQL.Text + fPrintData1   ;


                       fEncodeData   := '' ;
                       fEncodeSymbol := '' ;

                       if(cbUseRD.Checked) then SQl.Text := SQL.Text + QuotedStr('1')+',' else SQl.Text := SQL.Text + QuotedStr('0')+',' ;
                       SQL.Text := SQL.Text + trim(edtRDDocQty.Text)+','+
                       trim(edtRDENSequence.Text)+',' ;
                       if(cbRDENDataSerialStub.Checked) then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataSerial.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataBank.Checked)       then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataBranch.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataAccount.Checked)    then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataTC.Checked)         then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataAmount.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbRDENDataSerialEnd.Checked)  then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeData)+',' ;

                       fEncodeSymbol := trim(lbRDENSBDataSerialStub.Values.Strings[lbRDENSBDataSerialStub.ItemIndex])+
                                        trim(lbRDENSBDataSerial.Values.Strings[lbRDENSBDataSerial.ItemIndex])+
                                        trim(lbRDENSBDataBank.Values.Strings[lbRDENSBDataBank.ItemIndex])+
                                        trim(lbRDENSBDataBranch.Values.Strings[lbRDENSBDataBranch.ItemIndex])+
                                        trim(lbRDENSBDataAccount.Values.Strings[lbRDENSBDataAccount.ItemIndex])+
                                        trim(lbRDENSBDataTC.Values.Strings[lbRDENSBDataTC.ItemIndex])+
                                        trim(lbRDENSBDataAmount.Values.Strings[lbRDENSBDataAmount.ItemIndex])+
                                        trim(lbRDENSBDataSerialEnd.Values.Strings[lbRDENSBDataSerialEnd.ItemIndex]) ;

                      SQL.Text := SQL.Text+QuotedStr(fEncodeSymbol)+',' ;





{
                       if(cbRDENSBDataSerialStub.Checked) then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataSerial.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataBank.Checked)       then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataBranch.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataAccount.Checked)    then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataTC.Checked)         then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataAmount.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbRDENSBDataSerialEnd.Checked)  then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeSymbol)+',' ;
}
                       fEnPosition1 := trim(edtRDENSerialStubPOS.Text)+','+trim(edtRDENSerialPOS.Text)+','+trim(edtRDENBankPOS.Text)+','+trim(edtRDENBranchPOS.Text)+','+trim(edtRDENAccountPOS.Text)+','+trim(edtRDENTCPOS.Text)+','+trim(edtRDENAmountPOS.Text)+','+trim(edtRDENSerialEndPOS.Text)+',' ;

                       SQL.Text := SQL.Text + quotedStr(fEnPosition1)+',' ;
                       SQL.Text := SQL.Text + ListRDFont.Values.Strings[ListRDFont.Itemindex]+',' ;
                      // SQL.Text := SQL.text + trim(edtRDNumberChar.Text)+',' ;
                       SQL.Text := SQL.text + trim(edtFDNumberChar.Text)+',' ;

                        fPrintPosition1 := '' ;
                        fPrintPosition2 := '' ;
                        fPrintData1 := '' ;
                        fPrintData2 := '' ;
                        {
                        fPrintPosition1 := trim(edtRDPRH1L1Pos.Text) +','+trim(edtRDPRH1L2Pos.Text)+','+trim(edtRDPRH1L3Pos.Text)+','+trim(edtRDPRH1L4Pos.Text)+',' ;
                        fPrintPosition2 := trim(edtRDPRH2L1Pos.Text) +','+trim(edtRDPRH2L2Pos.Text)+','+trim(edtRDPRH2L3Pos.Text)+','+trim(edtRDPRH2L4Pos.Text)+',' ;
                        }

                        SPrintPosition1 := trim(edtRDPRH1L1Pos.Text) +','+trim(edtRDPRH1L2Pos.Text)+','+trim(edtRDPRH1L3Pos.Text)+','+trim(edtRDPRH1L4Pos.Text)+',' ;
                        SPrintPosition2 := trim(edtRDPRH2L1Pos.Text) +','+trim(edtRDPRH2L2Pos.Text)+','+trim(edtRDPRH2L3Pos.Text)+','+trim(edtRDPRH2L4Pos.Text)+',' ;

                       if SPrintPosition1 = ',,,,' then fPrintPosition1 := '0,0,0,0,' else fPrintPosition1 := SPrintPosition1;

                       if SPrintPosition2 = ',,,,' then fPrintPosition2 := '0,0,0,0,' else fPrintPosition2 := SPrintPosition2;


                        SQL.Text := SQL.Text + Quotedstr(fPrintPosition1)+','+Quotedstr(fPrintPosition2)+',' ;

                        fPrintData1 := QuotedStr(trim(ListRDH1L1D1.Values.Strings[ListRDH1L1D1.ItemIndex])+trim(ListRDH1L1D2.Values.Strings[ListRDH1L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListRDH1L2D1.Values.Strings[ListRDH1L2D1.ItemIndex])+trim(ListRDH1L2D2.Values.Strings[ListRDH1L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListRDH1L3D1.Values.Strings[ListRDH1L3D1.ItemIndex])+trim(ListRDH1L3D2.Values.Strings[ListRDH1L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListRDH1L4D1.Values.Strings[ListRDH1L4D1.ItemIndex])+trim(ListRDH1L4D2.Values.Strings[ListRDH1L4D2.ItemIndex]))+','+

                                       QuotedStr(trim(ListRDH2L1D1.Values.Strings[ListRDH2L1D1.ItemIndex])+trim(ListRDH2L1D2.Values.Strings[ListRDH2L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListRDH2L2D1.Values.Strings[ListRDH2L2D1.ItemIndex])+trim(ListRDH2L2D2.Values.Strings[ListRDH2L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListRDH2L3D1.Values.Strings[ListRDH2L3D1.ItemIndex])+trim(ListRDH2L3D2.Values.Strings[ListRDH2L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListRDH2L4D1.Values.Strings[ListRDH2L4D1.ItemIndex])+trim(ListRDH2L4D2.Values.Strings[ListRDH2L4D2.ItemIndex]))+',' ;


                        SQL.Text := SQL.Text + fPrintData1  ;

                       fEncodeData   := '' ;
                       fEncodeSymbol := '' ;

                       if(cbUseBC.Checked) then SQl.Text := SQL.Text + QuotedStr('1')+',' else SQl.Text := SQL.Text + QuotedStr('0')+',' ;
                       SQL.Text := SQL.Text + trim(edtBCDocQty.Text)+','+
                       trim(edtBCENSequence.Text)+',' ;
                       if(cbBCENDataSerialStub.Checked) then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataSerial.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataBank.Checked)       then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataBranch.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataAccount.Checked)    then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataTC.Checked)         then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataAmount.Checked)     then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       if(cbBCENDataSerialEnd.Checked)  then fEncodeData := fEncodeData + '1' else fEncodeData := fEncodeData + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeData)+',' ;

                       fEncodeSymbol := trim(lbBCENSBDataSerialStub.Values.Strings[lbBCENSBDataSerialStub.ItemIndex])+
                                        trim(lbBCENSBDataSerial.Values.Strings[lbBCENSBDataSerial.ItemIndex])+
                                        trim(lbBCENSBDataBank.Values.Strings[lbBCENSBDataBank.ItemIndex])+
                                        trim(lbBCENSBDataBranch.Values.Strings[lbBCENSBDataBranch.ItemIndex])+
                                        trim(lbBCENSBDataAccount.Values.Strings[lbBCENSBDataAccount.ItemIndex])+
                                        trim(lbBCENSBDataTC.Values.Strings[lbBCENSBDataTC.ItemIndex])+
                                        trim(lbBCENSBDataAmount.Values.Strings[lbBCENSBDataAmount.ItemIndex])+
                                        trim(lbBCENSBDataSerialEnd.Values.Strings[lbBCENSBDataSerialEnd.ItemIndex]) ;

                      SQL.Text := SQL.Text+QuotedStr(fEncodeSymbol)+',' ;

{
                       if(cbBCENSBDataSerialStub.Checked) then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataSerial.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataBank.Checked)       then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataBranch.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataAccount.Checked)    then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataTC.Checked)         then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataAmount.Checked)     then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       if(cbBCENSBDataSerialEnd.Checked)  then fEncodeSymbol := fEncodeSymbol + '1' else fEncodeSymbol := fEncodeSymbol + '0' ;
                       SQL.Text := SQL.Text + QuotedStr(fEncodeSymbol)+',' ;
}

                       fEnPosition1 := trim(edtBCENSerialStubPOS.Text)+','+trim(edtBCENSerialPOS.Text)+','+trim(edtBCENBankPOS.Text)+','+trim(edtBCENBranchPOS.Text)+','+trim(edtBCENAccountPOS.Text)+','+trim(edtBCENTCPOS.Text)+','+trim(edtBCENAmountPOS.Text)+','+trim(edtBCENSerialEndPOS.Text)+',' ;

                       SQL.Text := SQL.Text + quotedStr(fEnPosition1)+',' ;
                       SQL.Text := SQL.Text + ListBCFont.Values.Strings[ListBCFont.Itemindex]+',' ;
                       //SQL.Text := SQL.text + trim(edtBCNumberChar.Text)+',' ;
                       SQL.Text := SQL.text + trim(edtFDNumberChar.Text)+',' ;

                        fPrintPosition1 := '' ;
                        fPrintPosition2 := '' ;
                        fPrintData1 := '' ;
                        fPrintData2 := '' ;
                        {
                        fPrintPosition1 := trim(edtBCPRH1L1Pos.Text) +','+trim(edtBCPRH1L2Pos.Text)+','+trim(edtBCPRH1L3Pos.Text)+','+trim(edtBCPRH1L4Pos.Text)+',' ;
                        fPrintPosition2 := trim(edtBCPRH2L1Pos.Text) +','+trim(edtBCPRH2L2Pos.Text)+','+trim(edtBCPRH2L3Pos.Text)+','+trim(edtBCPRH2L4Pos.Text)+',' ;
                        }

                        SPrintPosition1 := trim(edtBCPRH1L1Pos.Text) +','+trim(edtBCPRH1L2Pos.Text)+','+trim(edtBCPRH1L3Pos.Text)+','+trim(edtBCPRH1L4Pos.Text)+',' ;
                        SPrintPosition2 := trim(edtBCPRH2L1Pos.Text) +','+trim(edtBCPRH2L2Pos.Text)+','+trim(edtBCPRH2L3Pos.Text)+','+trim(edtBCPRH2L4Pos.Text)+',' ;

                        if SPrintPosition1 = ',,,,' then fPrintPosition1 := '0,0,0,0,' else fPrintPosition1 := SPrintPosition1;

                        if SPrintPosition2 = ',,,,' then fPrintPosition2 := '0,0,0,0,' else fPrintPosition2 := SPrintPosition2;



                        SQL.Text := SQL.Text + Quotedstr(fPrintPosition1)+','+Quotedstr(fPrintPosition2)+',' ;

                        fPrintData1 := QuotedStr(trim(ListBCH1L1D1.Values.Strings[ListBCH1L1D1.ItemIndex])+trim(ListBCH1L1D2.Values.Strings[ListBCH1L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBCH1L2D1.Values.Strings[ListBCH1L2D1.ItemIndex])+trim(ListBCH1L2D2.Values.Strings[ListBCH1L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBCH1L3D1.Values.Strings[ListBCH1L3D1.ItemIndex])+trim(ListBCH1L3D2.Values.Strings[ListBCH1L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBCH1L4D1.Values.Strings[ListBCH1L4D1.ItemIndex])+trim(ListBCH1L4D2.Values.Strings[ListBCH1L4D2.ItemIndex]))+','+

                                       QuotedStr(trim(ListBCH2L1D1.Values.Strings[ListBCH2L1D1.ItemIndex])+trim(ListBCH2L1D2.Values.Strings[ListBCH2L1D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBCH2L2D1.Values.Strings[ListBCH2L2D1.ItemIndex])+trim(ListBCH2L2D2.Values.Strings[ListBCH2L2D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBCH2L3D1.Values.Strings[ListBCH2L3D1.ItemIndex])+trim(ListBCH2L3D2.Values.Strings[ListBCH2L3D2.ItemIndex]))+','+
                                       QuotedStr(trim(ListBCH2L4D1.Values.Strings[ListBCH2L4D1.ItemIndex])+trim(ListBCH2L4D2.Values.Strings[ListBCH2L4D2.ItemIndex])) ;

                        if trim(edtFDPstart.Text) = '' then SFDPstart := '0' else SFDPstart := edtFDPstart.Text;

                        if trim(edtBDPstart.Text) = '' then SBDPstart := '0' else SBDPstart := edtBDPstart.Text;

                        if trim(edtRDPstart.Text) = '' then SRDPstart := '0' else SRDPstart := edtRDPstart.Text;

                        if trim(edtBCPstart.Text) = '' then SBCPstart := '0' else SBCPstart := edtBCPstart.Text;


                        {
                        SQL.Text := SQL.Text + fPrintData1 +','+QuotedStr(edtDiscountValues.Text) +','+BoolToStr(cbDefault.Checked) +','+
                        edtFDPstart.Text +','+ edtBDPstart.Text +','+edtRDPstart.Text+','+edtBCPstart.Text+' , '+edtFee.Text+
                        }

                        SQL.Text := SQL.Text + fPrintData1 +','+QuotedStr(edtDiscountValues.Text) +','+BoolToStr(cbDefault.Checked) +','+
                        SFDPstart +','+ SBDPstart +','+SRDPstart+','+SBCPstart+' , '+edtFee.Text+



                        ' ) '  ;
    //        showmessage(SQL.Text) ;
            //edit1.Text := sql.Text;
            ExecSQL ;
            Free ;
        end;
       fExitType := etAccept ;
       frmChequeProperties.Close ;
//       frmChequeProperties.Destroy ;

end;

procedure TfrmChequeProperties.suiButton2Click(Sender: TObject);
begin
   fExitType := etCancel ;
   frmChequeProperties.Close ;

//   frmChequeProperties.Destroy ;
end;

procedure TfrmChequeProperties.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if(MessageDlg('ต้องการจบการทำงานของการออกแบบเช็ค',mtWarning,[mbYes,mbNo],0) = mrYes) then Action := caFree else Action := caNone ;
end;

procedure TfrmChequeProperties.lbFDENSBDataSerialChange(Sender: TObject);
begin
//   ShowMessage(lbFDENSBDataSerial.Values.Strings[lbFDENSBDataSerial.itemIndex]) ;

//  ShowMessage(lbFDENSBDataSerial.Values.ValueFromIndex[lbFDENSBDataSerial.itemIndex]);
end;

procedure TfrmChequeProperties.edtWidthKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmChequeProperties.edtFDDocQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmChequeProperties.edtBDDocQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmChequeProperties.edtRDDocQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmChequeProperties.edtBCDocQtyKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not (Key in [#48..#57,#13,#08,#127]) then Key := #0 ;
end;

procedure TfrmChequeProperties.edtFDENSerialStubPOSKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtFDPRH1L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtFDPRH2L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtBDENSerialStubPOSKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtBDPRH1L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtBDPRH2L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtRDENSerialStubPOSKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtRDPRH1L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtRDPRH2L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtBCENSerialStubPOSKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtBCPRH1L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

procedure TfrmChequeProperties.edtBCPRH2L1PosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if(Key = VK_Return) then SelectNext(ActiveControl,true,true);
end;

end.
