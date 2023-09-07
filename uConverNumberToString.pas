unit uConverNumberToString;

{$R-}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,stdctrls,math;

type
  TLanguageType = (Thai,English);
  Tn2wMoney = class(TComponent)
  private
    { Private declarations }
    FValue : extended;
    FText  : string;
    FLabel : TLabel;
    FLanguage : TLanguageType;
    FPoint : integer;
    FonChange : TNotifyEvent;
    function RepeatChar(const Source:string): string;
    function Rcopy(var Source:string;Max:integer):string;
    function GetMesure(const value: Integer): string;
    function GetZero(const digit:integer):longint;
    function GetThai(digit,value:integer):string;
    procedure SetValue(Value:extended);
    procedure SetLanguage(Value:TLanguageType);
    procedure SetLabel(Value:TLabel);
    procedure SetPoint(Value:integer);
    function LongintToThai(value:longint):string;

    function getNumEng(const Value:longint):string;
    function GetEng(const Value:longint):string;

  protected
    { Protected declarations }
    function FloatToThai(value:extended):string;
    function FloatToEng(const value:extended) : String;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    { Public declarations }
    constructor Create(AOwner:TComponent); Override;
    destructor Destroy; Override;
    function FloatToText(const value:extended):string;

  published
    { Published declarations }
    property Value:extended read FValue write SetValue;
    property Text:string read FText;
    property Language:TLanguageType read FLanguage write SetLanguage;
    property TextLabel:TLabel read FLabel write SetLabel;
    property Point : integer read FPoint write SetPoint;
    property onChange:TNotifyEvent read FonChange write FonChange;
  end;

// var fn2wMoney : Tn2wMoney ;

implementation

constructor Tn2wMoney.Create(AOwner:TComponent);
begin
   inherited Create(AOwner);
   FPoint:=2;
end;

destructor Tn2wMoney.Destroy;
begin
   inherited Destroy;
end;

procedure Tn2wMoney.SetValue(Value: extended);
begin
   //if FValue<>Value then begin
      FValue:=Value;
      FText:=FloatToText(Value);
      //ShowMessage(FloatToStr(Value)); //For Debug Only
      if Assigned(FLabel) then FLabel.caption:=FText;
      if Assigned(FonChange) then FonChange(self);
   //end;
end;

procedure Tn2wMoney.SetLanguage(Value: TLanguageType);
begin
   if FLanguage<>Value then begin
      FLanguage:=Value;
      FText:=FloatToText(FValue);
      if Assigned(FLabel) then FLabel.caption:=FText;
   end;
end;

procedure Tn2wMoney.SetLabel(Value: TLabel);
begin
   if FLabel <> Value then begin
      FLabel:=Value;
      if Assigned(FLabel) then FLabel.caption:=FText;
   end;
end;

procedure Tn2wMoney.SetPoint(Value: integer);
begin
    if FPoint<>Value then begin
       FPoint:=Value;
       FText:=FloatToText(FValue);
       if Assigned(FLabel) then FLabel.caption:=FText;
       if Assigned(FonChange) then FonChange(self);
    end;
end;

procedure Tn2wMoney.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (TextLabel <> nil) and
    (AComponent = TextLabel) then TextLabel:= nil;
end;

//--------------------------------------------------------
function Tn2wMoney.RepeatChar(const Source: string): string;
var i:integer; S:string;
begin
   S:='';
   for i:=length(Source) to FPoint-1 do S:=S+'0';
   result:=Source+S;
end;

function Tn2wMoney.Rcopy(var Source:string;Max:integer):string;
var Ssize, fMod:integer;
begin
   Ssize := length(Source);
   fMod  := Ssize mod Max;
   if fMod=0 then fMod:=6;
   result:= copy(Source,1,fMod);
   Source:= copy(Source,fMod+1,Ssize-fMod);
end;

function Tn2wMoney.GetMesure(const value:longint):string;
begin
   case value of
      10 : result:='สิบ';
      100 : result:='ร้อย';
      1000 : result:='พัน';
      10000 : result:='หมื่น';
      100000 : result:='แสน';
      1000000 : result:='ล้าน';
   end;
end;

function Tn2wMoney.GetZero(const digit:integer):longint;
var i:integer;
    S:string;
begin
    S:='1';
    for i:=digit-1 downto 1 do begin
        S:=S+'0';
    end;
    result:=strtoint(S);
end;

function Tn2wMoney.GetThai(digit,value:integer):string;
begin
    case value of
       1 : case digit of
              0: result:='เอ็ด';
              2: result:='';
              else result:='หนึ่ง';
           end;
       2 : case digit of
              2: result:='ยี่'
              else result:='สอง';
           end;
       3 : result:='สาม';
       4 : result:='สี่';
       5 : result:='ห้า';
       6 : result:='หก';
       7 : result:='เจ็ด';
       8 : result:='แปด';
       9 : result:='เก้า';
    end;
end;

function Tn2wMoney.LongintToThai(value:longint):string;
var Digit:integer;
    zDiv,zMod:longint;
begin
     if value=0 then begin result:=''; exit; end;
     Digit:=length(inttostr(value));
     if Digit > 1 then begin
       zDiv:=GetZero(Digit);
       zMod:=Value mod zDiv;
       if zMod >= 10 then
           result:=GetThai(digit,Value div zDiv)+
                   GetMesure(zDiv)+
                   LongintToThai(zMod)
       else
           result:=GetThai(digit,Value div zDiv)+
                   GetMesure(zDiv)+
                   GetThai(0,zMod);
     end
     else begin
        result:=GetThai(digit,value);
     end;
end;

function Tn2wMoney.FloatToThai(value:extended):string;
var Svalue,First,Second:string;
    nFirst, nSecond:longint;
begin
    SValue:=trim(FloatToStr(value));
    result:=''; nFirst:=0; nSecond:=0; //Initial value set to '' and 0

    if pos('.',Svalue)>0 then begin //check symbol '.', It has or not?
      First:=copy(SValue,1,pos('.',Svalue)-1); //copy Str before '.'
      Second:=copy(SValue,pos('.',Svalue)+1,length(Svalue)); //copy Str after '.'
    end
    else begin
      First:=SValue;  //(value before '.') = SValue
      Second:='';     //(value after  '.') = '' or zero
    end;

    while length(First)>7 do begin //check length of Str before '.'
       nFirst:=strtoint(Rcopy(First,6));
       Result:=Result+LongintToThai(nFirst)+'ล้าน';
    end;

    if First<>'' then nFirst:=strtoint(First);
    if Second<>'' then nSecond:=strtoint(RepeatChar(Second));

    if (result='')and(nFirst=0)and(nSecond=0) then result:='ศูนย์บาทถ้วน'
    else begin
      result:=result+LongintToThai(nFirst);
      if result<>'' then result:=result+'บาท';
      if nSecond>0 then
         result:=result+LongintToThai(nSecond)+'สตางค์'
      else
         result:=result+'ถ้วน';
    end;
end;

//------ English ----
function Tn2wMoney.getNumEng(const Value:longint):string;
begin
   case Value of
       0:result:='ZERO';
       1:result:='ONE';
       2:result:='TWO';
       3:result:='THREE';
       4:result:='FOUR';
       5:result:='FIVE';
       6:result:='SIX';
       7:result:='SEVEN';
       8:result:='EIGHT';
       9:result:='NINE';
       10:result:='TEN';
       11:result:='ELEVEN';
       12:result:='TWELVE';
       13:result:='THIRTEEN';
       14:result:='FOURTEEN';
       15:result:='FIFTEEN';
       16:result:='SIXTEEN';
       17:result:='SEVENTEEN';
       18:result:='EIGHTEEN';
       19:result:='NINETEEN';
       20:result:='TWENTY';
       30:result:='THIRTY';
       40:result:='FORTY';
       50:result:='FIFTY';
       60:result:='SIXTY';
       70:result:='SEVENTY';
       80:result:='EIGHTY';
       90:result:='NINETY';
       100:result:='HUNDRED';
       1000:result:='THOUSAND';
       1000000:result:='MILLION';
   end;
end;

function Tn2wMoney.GetEng(const Value:longint):string;
var Digit:integer;
begin
    result:='';
    if Value=0 then exit;
    Digit:= Value div 1000000;
    if (Digit>0) then begin
       result:=GetEng(Digit)+' ' + GetNumEng(1000000);
       if (Value Mod 1000000) > 0 then
          result:=result+' '+GetEng(Value Mod 1000000);
    end
    else begin
      Digit:=Value Div 1000;
      if Digit>0 then begin
         result:=GetEng(Digit)+ ' ' + GetNumEng(1000);
         if (Value mod 1000)>0 then begin
            result:=result+' '+GetEng(Value Mod 1000);
         end;
      end
      else begin
         Digit:=Value Div 100;
         if Digit>0 then begin
            result:=GetEng(Digit) + ' ' + GetNumEng(100);
            if (Value mod 100)>0 then
               result:=result+GetEng(Value Mod 100);
         end
         else begin
            if Value > 20 then begin
               Digit:=Value Div 10;
               result:=GetNumEng(Digit*10);
               if (Value Mod (Digit*10))>0 then
                  result:=result+GetNumEng(Value Mod (Digit*10));
            end
            else
               result:=getNumEng(Value);
         end;
      end;
    end;
end;

function Tn2wMoney.FloatToEng(const value:extended) : String;
var x:string;
    Svalue,First,Second:string;
    V,M,nSecond:longint;
begin
  result:='';
  if Value=0 then exit;
  SValue:=trim(floattostr(value));
  if pos('.',Svalue)>0 then begin
    First:=copy(SValue,1,pos('.',Svalue)-1);
    if First='' then First:='0';
    Second:=copy(SValue,pos('.',Svalue)+1,length(Svalue));
  end
  else begin
    First:=SValue;
    Second:='';
  end;
  result:='';
  V:=strtoint(First);
  if Value=0 then x:=GetNumEng(V) else
  if V>100 then begin
    M:=(V Mod 100);
    x:=GetEng(V-M);
//    if( M>0 ) and (nSecond<=0) then x:=x+' AND '+GetEng(M) else x:=x+GetEng(M) ;
    if( M>0 ) then
      begin
        if(Second = '') then x:=x+' AND '+GetEng(M) else x:=x+' '+GetEng(M) ;
      end;
  end
  else x:=GetEng(V);

  if Second<>'' then nSecond:=strtoint(RepeatChar(Second));
  if nSecond>0 then x := x+' AND '+GetEng(nSecond)+' STANG' ;
  result := x ;
end;

function Tn2wMoney.FloatToText(const value: extended): string;
begin
  if FLanguage=TLanguageType(Thai) then begin
    result:=FloatToThai(value);
  end
  else begin
    result:=FloatToEng(value);
  end;
end;


end.
