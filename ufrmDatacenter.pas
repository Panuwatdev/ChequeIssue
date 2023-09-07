unit ufrmDatacenter;

interface

uses
  SysUtils, Classes, Windows, Messages, DB, ADODB, inifiles, Controls, Forms,
  Dialogs, LbCipher, LbClass ;

type
  TfrmDataCenter = class(TDataModule)
    ADOConnection1: TADOConnection;
    Lb3DES1: TLb3DES;
  private
    { Private declarations }
    fDBConnected : Boolean ;
    fPostgreSQLDriver   :  Boolean ;
    fUsedID : String ;
    fBankID : String ;
    fBRNID  : String ;

    Procedure OpenConfigFiles();


  public
    { Public declarations }
    Function  SearchDataInDB(DBName : String ; Condition : String) : Boolean ;
    Procedure DeleteDataInDB(DBName : String ; Condition : String) ;
    Procedure ExcuteDataInDB(DBName : String ; Condition : String) ;
    Procedure SaveHistoryLogin(inUserID : String ;inPass : String) ;
    Procedure SaveHistoryUsed(inUserID : String ; inApplication : String ; inWork : String; inStatus : String) ;

  Published
    Property DBConnected : Boolean Read fDBConnected write fDBConnected ;
    Property PostgreSQLDriver : Boolean Read fPostgreSQLDriver Write fPostgreSQLDriver default false ;
    Property UserID : String Read fUsedID Write fUsedID ;
    Property BankID : String Read fBankID Write fBankID ;
    Property BRNID : String Read fBRNID Write fBRNID ;



  end;

var
  frmDataCenter: TfrmDataCenter;
  Key128     : TKey128;

implementation
uses LbString ;

{$R *.dfm}

{
Procedure TfrmDataCenter.GetBankDefault();
var DBBank : TADOQuery ;
begin
   DBBank := TADOQuery.Create(nil);
     with DBBank do
       begin
         Connection := ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBOfficeMaster '+
                     ' Where HOF_Onwer = 1 ' ;
         Active := true ;
         fBankID := trim(FieldByname('HOF_ID').AsString) ;
         Active := false ;
         Free ;
       end;
end;

Procedure TfrmDataCenter.GetBRNDefault();
var DBBrn : TADOQuery ;
begin
   DBBrn := TADOQuery.Create(nil);
     with DBBrn do
       begin
         Connection := ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Select * from DBBranchesMaster '+
                     ' Where BOF_OnwerOffice = '+QuotedStr(fBankID)+
                     ' and BOF_Onwer = 1 ' ;
         Active := true ;
         fBRNID  := trim(FieldByname('BOF_ID').AsString) ;
         Active := false ;
         Free ;
       end;
end;

}
Procedure TfrmDataCenter.SaveHistoryLogin(inUserID : String ;inPass : String) ;
var DBHL : TADOQuery ;
begin
   DBHL := TADOQuery.Create(nil);
     with DBHL do
       begin
         Connection := ADOConnection1 ;
         SQL.Clear ;
         SQL.Text := ' Insert into DBHistoryLogin '+
                     ' ( '+
                     ' HLG_Date, HLG_User, HLG_PassKey '+
                     ' ) '+
                     ' Values '+
                     ' ( '+
                     QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:nn ',Date))+','+
                     QuotedStr(TripleDESEncryptStringEx(inUserID,Key128,true))+','+
                     QuotedStr(TripleDESEncryptStringEx(inPass,Key128,true))+
                     ' ) ' ;
//         ShowMessage(SQL.Text) ;
         ExecSQL ;
         Free ;
       end;
end;


Procedure TfrmDataCenter.SaveHistoryUsed(inUserID : String ; inApplication : String ; inWork : String ; inStatus : String) ;
var DBHU : TADOQuery ;
begin
    DBHU := TADOQuery.Create(nil);
      with DBHU do
        begin
          Connection := ADOConnection1 ;
          SQL.Clear ;
          SQL.Text := ' Insert into DBHistoryUsed ' +
                      ' ( '+
                      ' HUE_ID, HUE_Application, HUE_Work, HUE_Status, HUE_Date '+
                      ' ) '+
                      ' Values '+
                      ' ( '+
                      Quotedstr(inUserID)+','+
                      Quotedstr(inApplication)+','+
                      Quotedstr(inWork)+','+
                      Quotedstr(inStatus)+','+
                      QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:nn',Date))+
                      ' ) ' ;

          ExecSQL ;
          Free ;
        end;
end;

Procedure TfrmDataCenter.ExcuteDataInDB(DBName : String ; Condition : String);
var DBTemp : TADOQuery ;
    DBUse  : String ;
begin
   if(trim(DBName) = '') then DBUse := ADOConnection1.DefaultDatabase else DBUse := DBName ;

     DBTemp := TADOQuery.Create(nil);
     with DBTemp do
      begin
        Connection := ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := Condition ;
        ExecSQL ;
        Free ;
      end;
end;

Function TfrmDataCenter.SearchDatainDB(DBName : String ; Condition : String) : Boolean ;
var DBTemp : TADOQuery ;
    Ret : Boolean ;
    DBUse : String ;
begin

   if(trim(DBName) = '') then DBUse := ADOConnection1.DefaultDatabase else DBUse := DBName ;
   DBTemp := TADOQuery.Create(nil);
     with DBTemp do
      begin
        Connection := ADOConnection1 ;
        SQL.Clear ;
        SQL.Text := Condition ;
        Active := true ;
         if(RecordCount > 0) then  Ret := true else Ret := false ;
          Active := false ;
          Free ;
      end;
 Result := Ret ;
end;

Procedure TfrmDataCenter.DeleteDataInDB(DBName : String ; Condition : String);
begin

end;

Procedure TfrmDataCenter.OpenConfigFiles();
var CfgFile : TIniFile ;
begin

end;


end.
