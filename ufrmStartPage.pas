unit ufrmStartPage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, StdCtrls, RzLabel, SUIForm, DB, ADODB,
  LbCipher, LbClass, ActiveX, IniFiles, SUIButton;

type
  TfrmStartPage = class(TForm)
    suiForm1: TsuiForm;
    RzLabel1: TRzLabel;
    RzPanel1: TRzPanel;
    Image1: TImage;
    RzPanel2: TRzPanel;
    ADOConnection1: TADOConnection;
    RzPanel3: TRzPanel;
    RzLabel3: TRzLabel;
    DispStatus: TRzLabel;
    RzPanel4: TRzPanel;
    Image2: TImage;
    RzPanel5: TRzPanel;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    Timer1: TTimer;
    Lb3DES1: TLb3DES;
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
  private
    { Private declarations }
      UsedIMG1 : Boolean ;
      fServerName : String ;
      fAdminUser : String ;
      fAdminPassword : String ;
      fDBDriver : String ;
      fDatabaseName : String ;
      fConnectType : String ;

    Procedure GetConfigFile();
    Procedure GetConnect();

  public
    { Public declarations }
  end;

type TConnectThread2 = Class(TThread)

Private
  TempConnectObj : TADOConnection ;

  protected
    procedure Execute; override ;
  Public
    Constructor Create(ObjConnect : TADOConnection) ;


end;


var
  frmStartPage: TfrmStartPage;
  THRConnect2 : Boolean ;
  Key128      : TKey128;



//var
//  frmStartPage: TfrmStartPage;

implementation
uses LbString, ufrmDatacenter, ufrmMainMenu , ufrmDatabaseSetup, ufrmLogin;

{$R *.dfm}

Constructor TConnectThread2.Create(ObjConnect : TADOConnection);
begin

//  TempConnectObj := TADOConnection.Create(nil) ;
  TempConnectObj := ObjConnect ;
  THRConnect2 := false ;
  FreeOnTerminate := True ;

  inherited Create(false);
end;

Procedure TConnectThread2.Execute ;
var TempTO : Integer ;
begin
  CoInitialize(nil) ;
//  TempConnectObj.Open ;
  Try
    TempConnectObj.ConnectionString ;
    TempConnectObj.Connected := true ;
  Except
    THRConnect2 := false ;
    CoUninitialize ;
    DoTerminate ;
    Exit ;
   end;
    THRConnect2 := true ;
    CoUninitialize ;
    DoTerminate ;
end;


Procedure TfrmStartPage.GetConnect();
var TMOut : Integer ;
//    AppObj : TApplication ;
begin

  // Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=sa;Initial Catalog=CheckNew;Data Source=SIMURATE_SERVER
  // Provider=SQLOLEDB.1;Password=190216;Persist Security Info=True;User ID=sa;Initial Catalog=ChequeNew;Data Source=SIMURATE_SERVER
  //Provider=PostgreSQL OLE DB Provider;Password=190216;User ID=passakorn;Data Source=\\192.168.1.207;Location=NewChequePrint;Extended Properties=""';

//   Timer1.Enabled := true ;
//   Timer2.Enabled := true ;
   TMOut := 1 ;
   frmDataCenter.ADOConnection1.Close ;

   fAdminUser     := TripleDESEncryptStringEx(fAdminUser, Key128, false) ;
   fAdminPassword := TripleDESEncryptStringEx(fAdminPassword, Key128, false) ;
   if(fDBDriver = 'PostgreSQL OLE DB Provider') then
     begin
        frmDataCenter.ADOConnection1.ConnectionString := 'Provider='+fDBDriver+';Password='+fAdminPassword+';User ID='+fAdminUser+';Data Source='+fServerName+';Location='+fDatabaseName+';Extended Properties=""' ;
        frmDataCenter.PostgreSQLDriver := true ;
     end else
     begin
       frmDataCenter.PostgreSQLDriver := false ;
       if(fConnectType = 'SQL') then
          frmDataCenter.ADOConnection1.ConnectionString := 'Provider='+fDBDriver+';Password='+fAdminPassword+';Persist Security Info=True;User ID='+fAdminUser+';Initial Catalog='+fDatabaseName+';Data Source='+fServerName
       else if(fConnectType = 'Windows') then
          frmDataCenter.ADOConnection1.ConnectionString := 'Provider='+fDBDriver+';Integrated Security=SSPI;Persist Security Info=False;User ID='+fAdminUser+';Initial Catalog='+fDatabaseName+';Data Source='+fServerName ;
     end;
   frmDataCenter.ADOConnection1.LoginPrompt := False ;
   TConnectThread2.Create(frmDataCenter.ADOConnection1);
end;


Procedure TfrmStartPage.GetConfigFile();
var CfgFile : TIniFile ;
    SecsionList1 : TStringList ;
    SecsionRec  : Integer ;
begin

  if(not FileExists(ExtractFilePath(Application.ExeName)+'DBConfig.ini')) then
    begin
        DispStatus.Caption := 'Not Have Server Configuration File' ;
        Exit ;
//        if(frmDatabasesetup = nil) then Application.CreateForm(TfrmDatabasesetup,frmDatabasesetup) else
//           frmDatabasesetup := TfrmDatabasesetup.Create(nil);
//           frmDatabasesetup.ConfigurationName := '' ;
//           frmDatabasesetup.Mode := fmNew ;
//           frmDatabasesetup.ShowModal ;
//           GetConfigFile();
    end else
    begin
      DispStatus.Caption := 'Loading Server Configuration File : DBConfig.ini' ;
      CfgFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+'DBConfig.ini');
      SecsionList1 := TStringList.Create ;
      SecsionList1.Clear  ;
//      CfgFile.
      CfgFile.ReadSections(SecsionList1);

//      ShowMessage(SecsionList1.Strings[0]) ;

//      For SecsionRec := 0 to SecsionList.Count - 1 do
//        begin

          fServerName    := CfgFile.ReadString(SecsionList1.Strings[0],'ServerName','') ;
          fAdminUser     := CfgFile.ReadString(SecsionList1.Strings[0],'ConnectionUser','sa') ;
          fAdminPassword := CfgFile.ReadString(SecsionList1.Strings[0],'ConnectionPassword','') ;
          fDBDriver      := CfgFile.ReadString(SecsionList1.Strings[0],'DBDriver','SQLOLEDB.1') ;
          fDatabaseName  := CfgFile.ReadString(SecsionList1.Strings[0],'Database','') ;
          fConnectType   := CfgFile.ReadString(SecsionList1.Strings[0],'SecurityType','SQL') ;
          CfgFile.Free ;

      if(trim(fServerName) = '') or (trim(fAdminUser) = '') or (trim(fDBDriver) = '') or (trim(fDatabaseName) = '') or
        (trim(fConnectType) = '') then
          begin
           DispStatus.Caption := 'Do not Have Server Configuration Details' ;
          {
           if(frmDatabasesetup = nil) then Application.CreateForm(TfrmDatabasesetup,frmDatabasesetup) else
              frmDatabasesetup := TfrmDatabasesetup.Create(nil);
              frmDatabasesetup.ConfigurationName := SecsionList1.Strings[0] ;
              frmDatabasesetup.Mode :=  fmEdit ;
              frmDatabasesetup.ShowModal ;
              GetConfigFile();
          }
          end else
          begin
           GetConnect ;
          end;
    end;
end;

procedure TfrmStartPage.Timer2Timer(Sender: TObject);
var Sloop : Integer ;
begin
{
  if(Image3.Left < Image1.Left) then
    begin
      Image3.Left := Image3.Left + 60 ;
    end else if(Image3.Left >= Image1.Left) then
    begin
      Image3.Left := Image2.Left+Image2.Width ;
//      Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\AppImage\Connect.bmp');
    end;
}    
end;

procedure TfrmStartPage.Timer1Timer(Sender: TObject);
begin
       if(THRConnect2) then
         begin
           Timer1.Enabled := false ;
//           Timer2.Enabled := false ;
//           Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Image\Connect.bmp');
           DispStatus.Caption := 'Connected' ;
           frmDataCenter.DBConnected := true ;
//           frmMain.Status := stConnect ;

{
           if(frmMainMenu = nil) then Application.CreateForm(TfrmMainMenu,frmMainMenu) else
              frmMainMenu := TfrmMainMenu.Create(nil);
              frmMainMenu.ShowModal ;
              frmStartPage.Close ;
}
           if(frmLogin = nil) then Application.CreateForm(TfrmLogin,frmLogin) else
              frmLogin := TfrmLogin.Create(nil);
              frmLogin.ShowModal ;
              frmStartPage.Close ;
         end else
         begin
           Timer1.Enabled := false ;
//           Timer2.Enabled := false ;
//           Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Image\Unconnect.bmp');
           DispStatus.Caption := 'Not Connect' ;
           frmDataCenter.DBConnected := False ;
//           frmMainPage.Status := StUnConnect ;

{
          if(frmDatabasesetup = nil) then Application.CreateForm(TfrmDatabasesetup,frmDatabasesetup) else
             frmDatabasesetup := TfrmDatabasesetup.Create(nil);
             frmDatabasesetup.ShowModal ;
             GetConfigFile();
             GetConnect ;
}
         end;


end;

procedure TfrmStartPage.FormCreate(Sender: TObject);
begin
 //
end;

procedure TfrmStartPage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide ;
end;

procedure TfrmStartPage.FormActivate(Sender: TObject);
begin
//  frmMainPage.Status := StUnConnect ;
  GetConfigFile ;
//  Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Image\Unconnect.bmp');
//  Image2.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Image\Client.bmp');
//  Image3.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Image\Document.bmp');
end;

procedure TfrmStartPage.suiButton1Click(Sender: TObject);
begin
  GetConfigFile ;
end;

procedure TfrmStartPage.suiButton3Click(Sender: TObject);
begin
   if(frmDatabasesetup = nil) then Application.CreateForm(TfrmDatabasesetup,frmDatabasesetup) else
      frmDatabasesetup := TfrmDatabasesetup.Create(nil);
      frmDatabasesetup.ShowModal ;
end;

procedure TfrmStartPage.suiButton2Click(Sender: TObject);
begin
  Application.Terminate ;
  //
end;

end.
