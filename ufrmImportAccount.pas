unit ufrmImportAccount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzShellDialogs, ExtCtrls, SUIForm, RzGroupBar, StdCtrls,
  RzLabel, SUIProgressBar, RzEdit, DB, ADODB, ImgList, Mask, RzButton,
  RzRadChk;

type
  TfrmImportAccount = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    suiForm1: TsuiForm;
    OP1: TRzOpenDialog;
    suiProgressBar1: TsuiProgressBar;
    RzLabel1: TRzLabel;
    RzMemo1: TRzMemo;
    ImageList1: TImageList;
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure RzGroup1Items2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    
  private
    { Private declarations }
    TempAcc : TStringList ;
    fBankID : String ;
    fBRNID  : String ;

    SFileType: String ;
    SFileName :String;
    SCmf      :String;
    SCcy      :String;
    SAccName  :String;
    SAccNo    :String;

    SPAccNo1  :String;
    SPAccNo2  :String;

    SAddress  :String;

    SAddress2  :String;

    LstFldData : TStrings;

    procedure SepField(LineData:String);
    procedure GetFldData();

    procedure ChkCutName(BCName:String);

    Function DelQuote(nm:String):String;

    procedure ChkCutName2(BCName:String);
  public
    { Public declarations }

  Published
    Property BankID : String Read fBankID Write fBankID ;
    Property BRNID  : String Read fBRNID  Write fBRNID ;  
  end;

var
  frmImportAccount: TfrmImportAccount;

implementation
uses ufrmDatacenter ;

{$R *.dfm}

procedure TfrmImportAccount.RzGroup1Items0Click(Sender: TObject);
begin
  if(TempAcc = nil) then TempAcc := TStringList.Create  else TempAcc.Clear ;
  OP1.Execute ;
//  ShowMessage(OP1.FileName) ;
  if(OP1.FileName = '') then Exit ;
  SFileName := OP1.FileName;
  SFileType := copy(OP1.FileName,pos('.',OP1.FileName)+1,3);
 // ShowMessage(SFileType);
  TempAcc.LoadFromFile(OP1.FileName);
  RzMemo1.Lines.Add(TempAcc.Text) ;

//  TempAcc.
//  ShowMessage(IntTosTr(TempAcc.Count)) ;
  suiProgressBar1.Max := RzMemo1.Lines.Count ;
  suiProgressBar1.Min := 0 ;
end;

procedure TfrmImportAccount.SepField(LineData:String);
var
   LstFldData : TStrings;
   TmpStr  : String;
   i       : Integer;
   Fld2Sts : String;
begin
   i := 0;
   TmpStr  := '';
   LstFldData := TStringList.Create;

   //while length(LineData) > 0 do
   while pos(',',LineData) > 0 do
   //while (pos(',',LineData) > 0) or (length(LineData)>0)  do
   begin
      TmpStr := copy(LineData,1,pos(',',LineData)-1);
      LstFldData.Add(TmpStr);
      //LstFldData[i] := TmpStr;
      case i of
           0 : SCmf     := TmpStr;

           1 : SAccName := TmpStr;

           2 : if TmpStr = '' then
               begin
                  SAccName := SAccName ;
                   Fld2Sts  := 'Emty';
               end
               else
               begin
                  //SAccName := SAccName + TmpStr ;
                  SAccName := SAccName + ','+TmpStr ;
                  //SAddress := TmpStr;
                  Fld2Sts  := 'notEmty';
               end;

           3 : if Fld2Sts  = 'Emty' then
               begin
                  SCcy     := TmpStr;
               end
               else
                  SAccName := SAccName + TmpStr;

           4 : if Fld2Sts  = 'notEmty' then
               begin
                  SCcy     := TmpStr;
               end
               else
                  SPAccNo1  := TmpStr;

           5 : if Fld2Sts  = 'notEmty' then
               begin
                  SPAccNo1     := TmpStr;
               end
               else
                  SPAccNo2  := TmpStr;


           6 : if Fld2Sts  = 'Emty' then
               begin
                  SAccNo   := TmpStr;
               end
               else
                  SPAccNo2:= TmpStr;
               
           7 : if Fld2Sts  = 'notEmty' then
               begin
                  SAccNo   := TmpStr;
               end;

           //SAccNo   := TmpStr;
      end;

     // ShowMessage(LstFldData[i]);
      delete(LineData,1,pos(',',LineData));
      i:=i+1;
   end;

   SAccNo   := LineData;
  // ShowMessage(SAccNo);
   //GetFldData();

end;

procedure TfrmImportAccount.GetFldData();
begin
   {SCmf     := LstFldData[0];
    SCcy     := LstFldData[3];
    SAccName := LstFldData[1]+LstFldData[2];
    SAccNo   := LstFldData[6]; }

    //LstFldData.Free;

    //ShowMessage(LstFldData[0]+' '+LstFldData[3]+' '+LstFldData[1]+LstFldData[2]+' '+LstFldData[6]);
end;



procedure TfrmImportAccount.RzGroup1Items1Click(Sender: TObject);
var Rec : Integer ;
    ACCID   : String ;
    ACCName : String ;
    DBAcc : TADOQuery ;
begin

  //SFileName;

  DBAcc := TADOQuery.Create(nil);

  for Rec := 0 to RzMemo1.Lines.Count - 1 do
    begin
    //==============
    // ACCID,ACCName,SAddress,SAddress2,fBankID,fBRNID,SCmf,SCcy  := '';

    //==============
 
       if(trim(RzMemo1.Lines.Strings[Rec]) <> '') then
       begin
       if UpperCase(SFileType) = 'TXT' then
       begin
           ACCID   := Copy(RzMemo1.Lines.Strings[Rec],1,10) ;
           ACCName := Copy(RzMemo1.Lines.Strings[Rec],11,35) ;
       end
       else if SFileType = 'csv' then
       begin
           SepField(RzMemo1.Lines.Strings[Rec]);

           //GetFldData();
           //SCmf+' '+SAccName+' '+SAccName+' '+SCcy+' '+SAccNo


           //ShowMessage('CMF='+SCmf+' '+'AccName='+SAccName+' '+'Ccy='+SCcy+' '+'AccNo='+SAccNo);

           //ACCID   := Copy(RzMemo1.Lines.Strings[Rec],1,10) ;
           //ACCName := Copy(RzMemo1.Lines.Strings[Rec],11,35) ;

           if Length(SAccNo) = 3 then  SAccNo := '000'+SAccNo;

           if Length(SAccNo) = 4 then  SAccNo := '00'+SAccNo;

           if Length(SAccNo) = 5 then  SAccNo := '0'+SAccNo;

           //showMessage(SAccNo);

           ACCID   := copy(SPAccNo1,2,1)+  copy(SPAccNo2,0,3)+SAccNo;

           ChkCutName(SAccName);

           ACCName := SAccName;

           LstFldData.Free;
       end
       else ShowMessage('‰ø≈Ïº‘¥æ≈“¥');


       //ACCID   := Copy(RzMemo1.Lines.Strings[Rec],1,10) ;
       //ACCName := Copy(RzMemo1.Lines.Strings[Rec],11,35) ;

       {with DBAcc do
          begin
             Connection := frmDataCenter.ADOConnection1 ;
             SQL.Clear ;
             SQL.Text := 'Select * from DBAccountMaster Where ACC_ID = '+QuotedStr(ACCID)+ ' and  ACC_Office = '+quotedStr(fBankID)+' and  ACC_Branch = '+quotedStr(fBRNID);

             Open;
          end;

          if DBAcc.RecordCount < 1 then
              ShowMessage(ACCID + '  '+ ACCName + ' Record = '+inttostr(DBacc.RecordCount));

          suiProgressBar1.StepIt ;}

         with DBAcc do
           begin
             Connection := frmDataCenter.ADOConnection1 ;
             SQL.Clear ;
             SQL.Text := 'if not Exists(Select * from DBAccountMaster Where ACC_ID = '+QuotedStr(ACCID)+ ' and  ACC_Office = '+quotedStr(fBankID)+' and  ACC_Branch = '+quotedStr(fBRNID) +') '+
                         ' begin '+
                         ' insert into DBAccountmaster '+
                         ' ( '+
                         ' ACC_ID, ACC_Description,ACC_Address1,ACC_Address2,ACC_Office, ACC_Branch, ACC_Discount,ACC_Cmf,ACC_Ccy '+
                         ' ) '+
                         ' Values '+
                         ' ( '+
                           QuotedStr(ACCID)+','+
                           QuotedStr(ACCName)+','+
                           QuotedStr(SAddress)+','+
                           QuotedStr(SAddress2)+','+
                           QuotedStr(fBankID)+','+
                           QuotedStr(fBRNID)+','+
                           QuotedStr('N')+','+
                           QuotedStr(SCmf)+','+
                           QuotedStr(SCcy)+
                         ' ) '+
                         ' end '+
                         ' else '+
                         ' begin '+
                         ' Update DBAccountmaster '+
                         ' Set '+
                         ' ACC_Description = '+QuotedStr(DelQuote(ACCName))+','+
                         ' ACC_Address1 = '+QuotedStr(DelQuote(SAddress))+','+
                         ' ACC_Address2 = '+QuotedStr(DelQuote(SAddress2))+','+
                         ' ACC_Cmf = '+QuotedStr(SCmf)+','+
                         ' ACC_Ccy = '+QuotedStr(SCcy)+
                         ' Where ACC_ID = '+QuotedStr(ACCID)+
                         ' and '+
                         ' ACC_Office = '+ QuotedStr(fBankID)+
                         ' and '+
                         ' ACC_Branch = '+ QuotedStr(fBRNID) +
                         ' end ' ;
               //showMessage(SQL.Text);
               ExecSQL ;
             suiProgressBar1.StepIt ;  
           end;
        end;
    end;
    DBAcc.Free ;

    //ShowMessage('Import Data is Complete');

    frmImportAccount.Close;

end;

{procedure TfrmImportAccount.ChkCutName(BCName:String);
begin
   if length(BCName) < 31 then
      begin
         SAccName := BCName;
         SAddress := '';
      end
   else
      begin

         SAccName := copy(BCName,1,30);
         SAddress := copy(BCName,31,length(BCName));
      end;

end;  }

procedure TfrmImportAccount.ChkCutName(BCName:String);
var
   SPos   : Integer;
   chkStr   : String;
   SCutName :String;
begin
   SAddress2 := '';
   SPos :=35;

   if length(BCName) < 36 then
      begin
         SAccName := BCName;
         SAddress := '';
      end
   else
      begin
         ChkStr := copy(BCName,35,1);

         if  ChkStr = ' ' then
         begin
         SAccName := copy(BCName,1,35);
         SAddress := copy(BCName,36,length(BCName));
         end
         else
         begin
            while ChkStr<> ' ' do
            begin
               SPos := SPos - 1;
               ChkStr := copy(BCName,SPos,1);
            end;
            SAccName := copy(BCName,1,SPos);
            SCutName := copy(BCName,SPos+1,length(BCName));

            ChkCutName2(SCutName);
         end
      end;

end;

procedure TfrmImportAccount.ChkCutName2(BCName:String);
var
   SPos   : Integer;
   chkStr : String;
begin
   SAddress2 := '';
   SPos :=35;

   if length(BCName) < 36 then
      begin
         SAddress := BCName;
         SAddress2 := '';
      end
   else
      begin
         ChkStr := copy(BCName,35,1);

         if  ChkStr = ' ' then
         begin
         SAddress := copy(BCName,1,35);
         SAddress2 := copy(BCName,36,length(BCName));
         end
         else
         begin
            while ChkStr<> ' ' do
            begin
               SPos := SPos - 1;
               ChkStr := copy(BCName,SPos,1);
            end;
            SAddress := copy(BCName,1,SPos);
            SAddress2 := copy(BCName,SPos+1,length(BCName));
         end
      end;

end;




procedure TfrmImportAccount.RzGroup1Items2Click(Sender: TObject);
begin
   frmImportAccount.Close;
end;

procedure TfrmImportAccount.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   //LstFldData.Free;
   Action := caFree ;
end;

Function TfrmImportAccount.DelQuote(nm:String):String;
var
    i:integer;
    nm2:String;
begin
    nm2:= '';
    for i := 1 to length(nm)do
    begin
      if   nm[i] = '"'   then
        nm2 := nm2
      else
        nm2 := nm2+nm[i];
    end;
    result := nm2;
end;



end.
