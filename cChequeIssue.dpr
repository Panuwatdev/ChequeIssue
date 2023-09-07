program cChequeIssue;

uses
  Forms,
  ufrmMainmenu in 'ufrmMainmenu.pas' {frmMainMenu},
  ufrmStartPage in 'ufrmStartPage.pas' {frmStartPage},
  ufrmDatacenter in 'ufrmDatacenter.pas' {frmDataCenter: TDataModule},
  ufrmDatabaseSetup in 'ufrmDatabaseSetup.pas' {frmDatabasesetup},
  ufrmChequeDesign in 'ufrmChequeDesign.pas' {frmChequeDesign},
  ufrmChequeProperties in 'ufrmChequeProperties.pas' {frmChequeProperties},
  ufrmTransaction in 'ufrmTransaction.pas' {frmTransaction},
  ufrmTransactionProperties in 'ufrmTransactionProperties.pas' {frmTransactionProperties},
  ufrmAccountSearch in 'ufrmAccountSearch.pas' {frmAccountSearch},
  ufrmAccountMaster in 'ufrmAccountMaster.pas' {frmAccountMaster},
  ufrmAccountProperties in 'ufrmAccountProperties.pas' {frmAccountProperties},
  ufrmOfficeProperties in 'ufrmOfficeProperties.pas' {frmOfficeProperties},
  ufrmBaranchProperties in 'ufrmBaranchProperties.pas' {frmBranchProperties},
  ufrmUserMaster in 'ufrmUserMaster.pas' {frmUserMaster},
  ufrmAdvanceConfig in 'ufrmAdvanceConfig.pas' {frmAdvanceConfig},
  ufrmMainUser in 'ufrmMainUser.pas' {frmMainUser},
  ufrmLogin in 'ufrmLogin.pas' {frmLogin},
  ufrmChangePassword in 'ufrmChangePassword.pas' {frmChangePassword},
  ufrmImportAccount in 'ufrmImportAccount.pas' {frmImportAccount},
  ufrmPermission in 'ufrmPermission.pas' {frmPermission},
  uConverNumberToString in 'uConverNumberToString.pas',
  uConvertChar in 'uConvertChar.pas',
  ufrmMainReport in 'ufrmMainReport.pas' {frmMainReport},
  UUpdCmms in 'UUpdCmms.pas' {frmUpdCmms},
  UfrmSlcPrnAdvice in 'UfrmSlcPrnAdvice.pas' {frmSlcPrnAdvice};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmStartPage, frmStartPage);
  Application.CreateForm(TfrmDataCenter, frmDataCenter);
  Application.Run;
end.
