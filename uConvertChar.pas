unit uConvertChar;

interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs ;

//type TInPutString : String ;

type TfConvertChar = Class
Private
 fInputString : String ;
 fOutStr : String ;

Public
// function ConvertCharFunc(InputString : String): String ;
 Procedure ConvertCharFunc(InputString : String) ;

Published
 Property InPutString : String read fInputString write ConvertCharFunc ;
 Property OutStr      : String Read fOutStr Write fOutStr ;
 
end;

var fConvertChar : TfConvertChar ;

implementation

Procedure TfConvertChar.ConvertCharFunc(InputString : String) ;
var StrLen : Integer ;
    StrRec : Integer ;
    StrRec2 : Integer ;
    TempStr1 : String ;
    TempStr2 : String ;
    AddStr   : String ;
begin
  AddStr  := '' ;
  StrLen  := Length(InPutString) ;
  StrRec2 := 1 ;
//  for StrRec := 1 to StrLen do
  while StrRec2 <= StrLen do
   begin
     TempStr1 := Copy(InputString,StrRec2,1);
     TempStr2 := Copy(InputString,StrRec2+1,1) ;
     if(TempStr1 = 'Ñ')  then
      begin
        if(TempStr2 = 'è') then
         begin
           AddStr := AddStr + '%T'+Char($92) ;
           StrRec2 := StrRec2+2  ;
         end  else
        if(TempStr2 = 'é') then
          begin
           AddStr := AddStr + '%T'+Char($93) ;
           StrRec2 := StrRec2+2  ;
          end else
        if(TempStr2 = 'ê') then
          begin
           AddStr := AddStr + '%T'+Char($94) ;
           StrRec2 := StrRec2+2  ;
          end else
        if(TempStr2 = 'ë') then
          begin
            AddStr := AddStr + '%T'+Char($95) ;
            StrRec2 := StrRec2+2  ;
          end else
           begin
             AddStr := AddStr+ '%T'+TempStr1 ;
             StrRec2 := StrRec2+1 ;
           end;
     end else

     if(TempStr1 = 'Ô')  then
      begin
        if(TempStr2 = 'è') then
          begin
           AddStr := AddStr + '%T'+Char($96) ;
           StrRec2 := StrRec2+2  ;
          end else
        if(TempStr2 = 'é') then
          begin
           AddStr := AddStr + '%T'+Char($97) ;
           StrRec2 := StrRec2+2  ;
          end else
        if(TempStr2 = 'ê') then
          begin
           AddStr := AddStr + '%T'+Char($98) ;
           StrRec2 := StrRec2+2  ;
          end else
        if(TempStr2 = 'ë') then
          begin
            AddStr := AddStr + '%T'+Char($99) ;
            StrRec2 := StrRec2+2  ;
          end else

        if(TempStr2 = 'ì') then
          begin
           AddStr := AddStr + '%T'+Char($9A) ;
           StrRec2 := StrRec2+2  ;
          end else
           begin
            AddStr := AddStr+ '%T'+TempStr1 ;
            StrRec2 := StrRec2+1  ;
           end ;
      end else

     if(TempStr1 = 'Õ') then
       begin
         if(TempStr2 = 'è') then
          begin
           AddStr := AddStr + '%T'+Char($9B) ;
           StrRec2 := StrRec2+2 ;
          end else
         if(TempStr2 = 'é') then
           begin
            AddStr := AddStr + '%T'+Char($9C) ;
            StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'ê') then
           begin
             AddStr := AddStr + '%T'+Char($9D) ;
             StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'ë') then
           begin
            AddStr := AddStr + '%T'+Char($9E) ;
            StrRec2 := StrRec2+2 ;
           end else
            begin
             AddStr := AddStr+ '%T'+TempStr1 ;
             StrRec2 := StrRec2+1  ;
            end ;
       end else

     if(TempStr1 = 'Ö') then
       begin
         if(TempStr2 = 'è') then
           begin
            AddStr := AddStr + '%T'+Char($DB) ;
            StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'é') then
           begin
            AddStr := AddStr + '%T'+Char($DC) ;
            StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'ê') then
           begin
            AddStr := AddStr + '%T'+Char($DD) ;
            StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'ë') then
           begin
            AddStr := AddStr + '%T'+Char($DE) ;
            StrRec2 := StrRec2+2 ;
           end else
            begin
             AddStr := AddStr+ '%T'+TempStr1 ;
             StrRec2 := StrRec2+1  ;
            end ;
       end else

     if(TempStr1 = '×') then
       begin
         if(TempStr2 = 'è') then
           begin
            AddStr := AddStr + '%T'+Char($FB);
            StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'é') then
           begin
             AddStr := AddStr + '%T'+Char($FC) ;
             StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'ê') then
           begin
            AddStr := AddStr + '%T'+Char($FD) ;
            StrRec2 := StrRec2+2 ;
           end else
         if(TempStr2 = 'ë') then
           begin
            AddStr := AddStr + '%T'+Char($FE) ;
            StrRec2 := StrRec2+2 ;
           end else
             begin
              AddStr := AddStr+ '%T'+TempStr1 ;
              StrRec2 := StrRec2+1  ;
             end;
       end else

     if(TempStr1 = 'Ø') Then
      begin
       AddStr := AddStr+'%T'+TempStr1 ;
       StrRec2 := StrRec2 + 1 ;
      end else
     if(TempStr1 = 'Ù') Then
      begin
       AddStr := AddStr+'%T'+TempStr1  ;
       StrRec2 := StrRec2 + 1 ;
      end else
     if(TempStr1 = 'ç') Then
      begin
       AddStr := AddStr+'%T'+TempStr1 ;
       StrRec2 := StrRec2 + 1 ;
      end else
     if(TempStr1 = 'è') Then
      begin
       AddStr := AddStr+'%T'+TempStr1 ;
       StrRec2 := StrRec2 + 1 ;
      end else
     if(TempStr1 = 'é') Then
       begin
        AddStr := AddStr+'%T'+TempStr1 ;
        StrRec2 := StrRec2 + 1 ;
       end else
     if(TempStr1 = 'ê') Then
       begin
        AddStr := AddStr+'%T'+TempStr1  ;
        StrRec2 := StrRec2 + 1 ;
       end else
     if(TempStr1 = 'ë') Then
       begin
        AddStr := AddStr+'%T'+TempStr1 ;
        StrRec2 := StrRec2 + 1 ;
       end else
     if(TempStr1 = 'ì') Then
       begin
        AddStr := AddStr+'%T'+TempStr1 ;
        StrRec2 := StrRec2 + 1 ;
       end else
//     if(TempStr1 = '­') Then
//       begin
//        AddStr := AddStr+Char($AD) ;
//        StrRec2 := StrRec2 + 1 ;
//       end else
      begin
       AddStr := AddStr + TempStr1 ;
       StrRec2 := StrRec2 + 1 ;
      end;
     if(StrRec2 > StrLen) Then Break ;

   end;
  fInputString := AddStr ;
//  Result := AddStr ;
//   fOutStr  := AddStr ;
end;

Initialization
 fConvertChar := TfConvertChar.Create ;
finalization
 fConvertChar.Free ;

end.
