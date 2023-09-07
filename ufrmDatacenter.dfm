object frmDataCenter: TfrmDataCenter
  OldCreateOrder = False
  Left = 488
  Top = 119
  Height = 178
  Width = 192
  object ADOConnection1: TADOConnection
    CursorLocation = clUseServer
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 24
  end
  object Lb3DES1: TLb3DES
    CipherMode = cmECB
    Left = 96
    Top = 80
  end
end
