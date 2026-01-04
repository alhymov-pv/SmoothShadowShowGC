object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 384
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object LabelOpacity: TLabel
    Left = 136
    Top = 168
    Width = 69
    Height = 15
    Caption = 'LabelOpacity'
  end
  object ButtonOpenGDIP: TButton
    Left = 136
    Top = 120
    Width = 97
    Height = 25
    Caption = 'ButtonOpen gdip'
    TabOrder = 0
    OnClick = ButtonOpenGDIPClick
  end
  object TrackBarOpacity: TTrackBar
    Left = 136
    Top = 199
    Width = 233
    Height = 45
    TabOrder = 1
    OnChange = TrackBarOpacityChange
  end
  object ButtonOpenVCL: TButton
    Left = 264
    Top = 120
    Width = 105
    Height = 25
    Caption = 'ButtonOpen vcl'
    TabOrder = 2
    OnClick = ButtonOpenVCLClick
  end
end
