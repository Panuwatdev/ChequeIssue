unit ufrmDatabaseSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, StdCtrls, ComObj, DB, ADODB,  Mask, RzEdit, RzBtnEdt, RzPanel,
  RzCmboBx, RzButton,  ImgList, RzLabel, inifiles,  RzGroupBar,
  RzStatus, ActiveX, RzRadChk, RzSpnEdt,  
  LbCipher, LbClass;
type TfMode = (fmNew,fmEdit) ;
type
  TfrmDatabasesetup = class(TForm)
    RzPanel2: TRzPanel;
    Connection1: TADOConnection;
    ImageList1: TImageList;
    RzPanel1: TRzPanel;
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    RzGroup2: TRzGroup;
    RzLabel1: TRzLabel;
    SelectServer: TRzComboBox;
    edtUser: TRzEdit;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edtPassword: TRzEdit;
    SelectDBDriver: TRzComboBox;
    RzLabel4: TRzLabel;
    RzBitBtn2: TRzBitBtn;
    btnSearchServer: TRzBitBtn;
    RzGroup3: TRzGroup;
    SelectDataBase: TRzComboBox;
    RzLabel5: TRzLabel;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    Image1: TImage;
    RzLabel6: TRzLabel;
    Timer1: TTimer;
    RzStatusBar1: TRzStatusBar;
    ConnectStatus: TRzStatusPane;
    RzClockStatus1: TRzClockStatus;
    IMGStatus: TRzGlyphStatus;
    Timer2: TTimer;
    ImageList2: TImageList;
    btnSearchDB: TRzBitBtn;
    rbWindowsAutherition: TRzRadioButton;
    rbSQLSecurity: TRzRadioButton;
    RzGroup4: TRzGroup;
    RzLabel7: TRzLabel;
    SRunning: TRzSpinEdit;
    Lb3DES1: TLb3DES;
    procedure btnSearchServerClick(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SelectDBDriverChange(Sender: TObject);
    procedure SelectServerChange(Sender: TObject);
    procedure SelectDataBaseChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnSearchDBClick(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbWindowsAutheritionClick(Sender: TObject);
    procedure rbSQLSecurityClick(Sender: TObject);
  private
    { Private declarations }
    fApplicationPath : WideString ;
    fServerName : String ;
    fAdminUser : String ;
    fAdminPassword : String ;
    fDBDriver : String ;
    fDatabaseName : String ;
    fConnectTimeOut : Boolean ;
    fConnected : Boolean ;
    fConnectType : String ;
    fConfigurationName : String;
    fMode : TfMode ;
    fSearch : Integer ;

    Procedure LoadServerName();
    Procedure LoadDataBaseName();
    Procedure GetConfigFile();
    Procedure ShowScreen();
    Procedure CreateCfgFile();
    Procedure GetTestConnect();
    Procedure GetDataBaseList() ;
    Function GetLastSearch() : Integer ;

  public
    { Public declarations }

  Published
    Property ConfigurationName : String Read fConfigurationName Write fConfigurationName ;
    Property Mode              : TfMode Read fMode Write fMode ;  

  end;

type TConnectThread = Class(TThread)

Private
  TempConnectObj : TADOConnection ;
//  Procedure GetConnect();

  protected
    procedure Execute; override ;
  Public
    Constructor Create(ObjConnect : TADOConnection) ;

//  Destructor Free ;
end;


var
  frmDatabasesetup: TfrmDatabasesetup;
  THRConnect : Boolean ;
  Key128           : TKey128;

  //  'Provider=PostgreSQL OLE DB Provider;Password=190216;User ID=passakorn;Data Source=\\192.168.1.207;Location=NewChequePrint;Extended Properties=""';

implementation

uses LbString, Math;

{$R *.dfm}

Constructor TConnectThread.Create(ObjConnect : TADOConnection);
begin

//  TempConnectObj := TADOConnection.Create(nil) ;
  TempConnectObj := ObjConnect ;
  THRConnect := false ;
  FreeOnTerminate := True ;

  inherited Create(false);
end;

Procedure TConnectThread.Execute ;
var TempTO : Integer ;
begin
  CoInitialize(nil) ;
//  TempConnectObj.Open ;
  Try
    TempConnectObj.ConnectionString ;
    TempConnectObj.Connected := true ;
  Except
    THRConnect := false ;
    CoUninitialize ;
    DoTerminate ;
    Exit ;
   end;
    THRConnect := true ;
    CoUninitialize ;
    DoTerminate ;
end;

Function TfrmDatabasesetup.GetLastSearch(): Integer ;
var Tempconfig   : TIniFile ;
    SecsionCount : Integer ;
    SecsionStr  : TStrings ;
    TempSer,Maxser : Integer ;    

begin
   Maxser := 0 ;
   Tempconfig := TIniFile.Create(fApplicationPath+'DBConfig.ini');
   Tempconfig.ReadSections(SecsionStr);
   for SecsionCount := 0 to SecsionStr.count -1 do
    begin
      TempSer := Tempconfig.ReadInteger(SecsionStr.ValueFromIndex[SecsionCount],'Search',0) ;
      if(TempSer > Maxser) then Maxser := TempSer ;
    end;
   Tempconfig.Free ;
 Result := TempSer ;
end;


Procedure TfrmDatabasesetup.ShowScreen();
begin
  SelectServer.Items.Add(fServerName) ;
  RzGroup1.Caption := RzGroup1.Caption +' of '+ fConfigurationName ;
  edtUser.Text      := fAdminUser ;
  edtPassword.Text  := fAdminPassword ;
  SelectDBDriver.ItemIndex := SelectDBDriver.Values.IndexOf(fDBDriver) ;
  SelectDataBase.Items.Add(fDatabaseName) ;
  SelectServer.ItemIndex := 0 ;
  SelectDataBase.ItemIndex := 0 ;
  SRunning.IntValue := fSearch ;
    case fMode of
     fmNew  : SRunning.IntValue := SRunning.IntValue + 1 ;
//     fmEdit :
    end;

  if(fConnectType = 'SQL') then rbSQLSecurity.Checked := true else if(fConnectType = 'Windows') then rbWindowsAutherition.Checked := true  ;
end;

Procedure TfrmDatabasesetup.CreateCfgFile();
var CfgFile : TIniFile ;
    TypeOfConnect : String ;
begin
 try
  CfgFile := TIniFile.Create(fApplicationPath+'DBConfig.ini');
  if(SelectDBDriver.ItemIndex = 2) then
   begin
     CfgFile.WriteString(fConfigurationName,'Database',Trim(SelectDataBase.Text)) ;
     CfgFile.WriteString(fConfigurationName,'ServerName',trim(SelectServer.Text));
   end else
   begin
     CfgFile.WriteString(fConfigurationName,'Database',Trim(SelectDataBase.Items.Strings[SelectDataBase.ItemIndex])) ;
     CfgFile.WriteString(fConfigurationName,'ServerName',trim(SelectServer.Text));
   end;

  CfgFile.WriteString(fConfigurationName,'ConnectionUser',TripleDESEncryptStringEx(trim(edtUser.Text), Key128, True)) ;
  CfgFile.WriteString(fConfigurationName,'ConnectionPassword',TripleDESEncryptStringEx(trim(edtPassword.Text), Key128, True)) ;
  CfgFile.WriteString(fConfigurationName,'DBDriver',SelectDBDriver.Values.Strings[SelectDBDriver.itemindex]) ;
//  fmNew : CfgFile.WriteInteger(fConfigurationName,'Search',SRunning.IntValue) ;




  CfgFile.WriteString(fConfigurationName,'SecurityType',fConnectType) ;

  CfgFile.UpdateFile ;
  CfgFile.Free ;
  Except
    MessageDlg('ไม่สามารถบันทึก Database Config ได้',mtError,[mbOk],0) ;
    Exit ;
  end;
    MessageDlg('บันทึก Database Config เรียบร้อย',mtError,[mbOk],0) ;

end;

Procedure TfrmDatabasesetup.GetConfigFile();
var CfgFile : TIniFile ;
begin

  if(not FileExists(fApplicationPath+'DBConfig.ini')) then
    begin
//       CreateCfgFile();
    end else
    begin
          CfgFile := TIniFile.Create(fApplicationPath+'DBConfig.ini');
           if(CfgFile.SectionExists(fConfigurationName)) then
             begin
               fServerName    := CfgFile.ReadString(fConfigurationName,'ServerName','') ;
               fAdminUser     := CfgFile.ReadString(fConfigurationName,'ConnectionUser','') ;
               fAdminPassword := CfgFile.ReadString(fConfigurationName,'ConnectionPassword','') ;
               if(trim(fAdminUser) <> '') then  fAdminUser := TripleDESEncryptStringEx(fAdminUser, Key128, false) ;
               if(trim(fAdminPassword) <> '') then fAdminPassword := TripleDESEncryptStringEx(fAdminPassword, Key128, false) ;
               fDBDriver      := CfgFile.ReadString(fConfigurationName,'DBDriver','SQLOLEDB.1') ;
               fDatabaseName  := CfgFile.ReadString(fConfigurationName,'Database','') ;
               fConnectType   := CfgFile.ReadString(fConfigurationName,'SecurityType','SQL') ;
               fSearch        := CfgFile.ReadInteger(fConfigurationName,'Search',0) ;
             end else
             begin

             end;

          CfgFile.Free ;

 //     if(fDBDriver = 'PostgreSQL OLE DB Provider') then

    end;
end;


Procedure TfrmDatabasesetup.LoadServerName();
//Var SerList : NameList ;
//    Count : Integer ;
//    SQLServer1 : TSQLServer ;

begin
{
   SelectServer.Items.Clear ;
   SQLServer1 := TSQLServer.Create(nil);

   SerList :=  SQLServer1.Application.ListAvailableSQLServers ;
   for Count := 1 to SerList.Count do
    begin
      SelectServer.Items.Add(SerList.Item(Count)) ;
    end;
    SelectServer.ItemIndex := 0 ;
    SQLServer1.Free ;
}
end;
{
Procedure TfrmDatabasesetup.LoadServerName();
var  SQL_DMO: TSQLServer;
     SQLDatabase: _Database;
     SQLStoredProcedure: _StoredProcedure;
     oServer: OleVariant;
     iScriptOptions: Integer;
     strScript: TStringList;
     i: Integer;

begin
   SQL_DMO := CoSQLServer.Create;
     try 
      SQL_DMO.LoginSecure := True;    
      oServer := GetLocalComputerName;                    
      SQL_DMO.Connect(oServer, '', '');
      SQLDatabase := SQL_DMO.Databases.item(DB_NAME,'dbo');    
         if assigned(SQLDataBase) then    
            try      
              for i := 1 to SQLDatabase.StoredProcedures.Count do      
                begin        
                  SQLStoredProcedure := SQLDatabase.StoredProcedures.Item(i, 'dbo');        
                    if Assigned(SQLStoredProcedure) then        
                      begin          
                        try            // bypass system objects            
                         if not SQLStoredProcedure.SystemObject then            
                            begin              
                              iScriptOptions := SQLDMOScript_Default or SQLDMOScript_Drops;              
                              strScript      := TStringList.Create;              
                                try                // Here, the Script call is not returning anything.                
                                    strScript.Text := SQLStoredProcedure.Script(iScriptOptions, SCRIPT_PATH + SQLStoredProcedure.Name + '.sql', SQLDMOScript2_Default);  
                                    // Even tired this with no affect: (EmptyParam is same as NULL)                                
                                    // strScript.Text := SQLStoredProcedure.Script(iScriptOptions, EmptyParam, SQLDMOScript2_Default);
                                   strScript.SaveToFile(SCRIPT_PATH + SQLStoredProcedure.Name + '.sql');              
                                finally
                                   strScript.Free;
                            end;
                      end; 
                      {if not SQLStoredProcedure.SystemObject} 
//                      finally
//                     SQLStoredProcedure := nil;
//                   end;
//               end; {if Assigned(SQLStoredProcedure)}

//            end;
            {for i := 0 to SQLDatabase.StoredProcedures.Count-1}
//            finally
//            SQLDataBase := nil;
//            end;
//           finally
//           SQL_DMO.DisConnect;
//           SQL_DMO := nil;
//       end;
//end;

Procedure TfrmDatabasesetup.LoadDataBaseName();
begin
//
end ;

procedure TfrmDatabasesetup.btnSearchServerClick(Sender: TObject);
begin
  LoadServerName ;
end;

Procedure TfrmDatabasesetup.GetTestConnect();
var TMOut : Integer ;
    AppObj : TApplication ;
begin
//Provider=SQLOLEDB.1;Password=190216;Persist Security Info=True;User ID=sa;Data Source=SIMURATE_SERVER
//Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=sa;Data Source=SIMURATE_SERVER
   ConnectStatus.Font.Color := clHighlight ;
   ConnectStatus.Caption := 'CONNECTING......';
   Timer1.Enabled := true ;
   Timer2.Enabled := true ;
   AppObj := TApplication.Create(Self);
   TMOut := 1 ;
   Connection1.Close ;
   if(SelectDBDriver.ItemIndex = 2) then
     begin
         Connection1.ConnectionString := 'Provider='+SelectDBDriver.Values.Strings[SelectDBDriver.ItemIndex]+';Password='+trim(edtPassword.Text)+';User ID='+trim(edtUser.Text)+';Data Source='+Trim(SelectServer.Text)+';Location='+trim(SelectDataBase.Text)+';Extended Properties=""';
     end else
     begin
       if(rbWindowsAutherition.Checked) then
          Connection1.ConnectionString := 'Provider='+SelectDBDriver.Values.Strings[SelectDBDriver.ItemIndex]+';Integrated Security=SSPI;Persist Security Info=False;User ID='+trim(edtUser.Text)+';Data Source='+Trim(SelectServer.Items.Strings[SelectServer.itemindex])
       else if(rbSQLSecurity.Checked) then
          Connection1.ConnectionString := 'Provider='+SelectDBDriver.Values.Strings[SelectDBDriver.ItemIndex]+';Password='+trim(edtPassword.Text)+';Persist Security Info=True;User ID='+trim(edtUser.Text)+';Data Source='+Trim(SelectServer.text);
     end;
   Connection1.LoginPrompt := False ;
   TConnectThread.Create(Connection1);
end;

Procedure TfrmDatabasesetup.GetDataBaseList();
var TempDB : TADOQuery ;
begin
 SelectDataBase.Clear ;
 if(Not fConnected) then Exit ;
 TempDB := TADOQuery.Create(self);
   with TempDB do
    begin
      Connection := Connection1 ;
      SQL.Clear ;
      SQL.Text := 'EXEC SP_Databases' ;
      Active := true ;
      if(RecordCount > 0) then
        begin
          while not eof do
           begin
             SelectDataBase.Items.Append(trim(FieldByname('DATABASE_NAME').AsString));
             Next ;
           end;
        end;
      Active := false ;
      Free ;
//      ExecSQL ;

    end;
    SelectDataBase.ItemIndex := 0 ;
end;

procedure TfrmDatabasesetup.RzBitBtn2Click(Sender: TObject);
begin
 GetTestConnect ;

end;

procedure TfrmDatabasesetup.FormActivate(Sender: TObject);
var AppObj : TApplication ;
begin
  fConnected := false ;
  AppObj := TApplication.Create(self);
  fApplicationPath := ExtractFilePath(AppObj.ExeName) ;
  GetConfigFile ;
  ShowScreen ;

end;

procedure TfrmDatabasesetup.SelectDBDriverChange(Sender: TObject);
begin
  fDBDriver := SelectDBDriver.Items.Strings[SelectDBDriver.itemindex] ;

  case SelectDBDriver.ItemIndex of
    2 : begin
          btnSearchServer.Enabled := false ;
          btnSearchDB.Enabled := false ;
          SelectServer.Clear ;
          SelectDataBase.Clear ;
          rbWindowsAutherition.Enabled := false ;
          rbSQLSecurity.Enabled := false ;
//          SelectServer.AllowEdit := true ;
//          SelectServer.Style := csDropDown ;
          SelectDataBase.AllowEdit := true ;
          SelectDataBase.Style := csDropDown ;
        end;
   else
        begin
          btnSearchServer.Enabled := true ;
          btnSearchDB.Enabled := true ;
          rbWindowsAutherition.Enabled := true ;
          rbSQLSecurity.Enabled := true ;
//          SelectServer.AllowEdit := false ;
//          SelectServer.Style := csDropDownList ;
          SelectDataBase.AllowEdit := false ;
          SelectDataBase.Style := csDropDownList ;
        end;
  end;
end;

procedure TfrmDatabasesetup.SelectServerChange(Sender: TObject);
begin
 // fServerName := SelectServer.Items.Strings[SelectServer.itemindex] ;
end;

procedure TfrmDatabasesetup.SelectDataBaseChange(Sender: TObject);
begin
//  fDatabaseName := SelectDataBase.Items.Strings[SelectDataBase.itemindex] ;
end;

procedure TfrmDatabasesetup.Timer1Timer(Sender: TObject);
begin
       if(THRConnect) then
         begin
           fConnected := true ;
           ConnectStatus.Font.Color := clGreen ;
           ConnectStatus.Caption := 'CONNECTED' ;
           Timer1.Enabled := false ;
           Timer2.Enabled := false ;
           IMGStatus.ImageIndex := 0 ;
           if(SelectDBDriver.ItemIndex <> 2) then GetDataBaseList();

         end else
         begin
           fConnected := false ;
           ConnectStatus.Font.Color := clRed ;
           ConnectStatus.Caption := 'NOT CONNECT' ;
           Timer1.Enabled := false ;
           Timer2.Enabled := false ;
           IMGStatus.ImageIndex := 1 ;
         end;
end;

procedure TfrmDatabasesetup.Timer2Timer(Sender: TObject);
begin
  if(IMGStatus.ImageIndex = 0) then IMGStatus.ImageIndex := 1 else IMGStatus.ImageIndex := 0 ; 
end;

procedure TfrmDatabasesetup.btnSearchDBClick(Sender: TObject);
begin
  GetDataBaseList ;
end;

procedure TfrmDatabasesetup.RzBitBtn3Click(Sender: TObject);
begin
  CreateCfgFile ;
//  if(SelectServer.Text = '')
  //
end;

procedure TfrmDatabasesetup.RzBitBtn4Click(Sender: TObject);
begin
  Connection1.Close ;
  Connection1.Free ;
  frmDatabasesetup.Close ;
end;

procedure TfrmDatabasesetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree ;
end;

procedure TfrmDatabasesetup.rbWindowsAutheritionClick(Sender: TObject);
begin
  if(rbWindowsAutherition.Checked) then
    begin
      edtUser.Enabled := false ;
      edtPassword.Enabled := false ;
      fConnectType := 'Windows' ;
    end;
end;

procedure TfrmDatabasesetup.rbSQLSecurityClick(Sender: TObject);
begin
  if(rbSQLSecurity.Checked) then
    begin
      edtUser.Enabled := true ;
      edtPassword.Enabled := true ;
      fConnectType := 'SQL' ;
    end;
end;

end.


