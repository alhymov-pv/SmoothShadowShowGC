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
    Left = 272
    Top = 72
    Width = 69
    Height = 15
    Caption = 'LabelOpacity'
  end
  object ButtonOpenGDIP: TButton
    Left = 32
    Top = 48
    Width = 129
    Height = 25
    Caption = 'ButtonOpen gdip'
    TabOrder = 0
    OnClick = ButtonOpenGDIPClick
  end
  object TrackBarOpacity: TTrackBar
    Left = 184
    Top = 103
    Width = 233
    Height = 45
    TabOrder = 1
    OnChange = TrackBarOpacityChange
  end
  object ButtonOpenVCL: TButton
    Left = 32
    Top = 91
    Width = 129
    Height = 25
    Caption = 'ButtonOpen vcl'
    TabOrder = 2
    OnClick = ButtonOpenVCLClick
  end
  object ButtonOpenLayered: TButton
    Left = 32
    Top = 131
    Width = 129
    Height = 25
    Caption = 'ButtonOpen Layered'
    TabOrder = 3
    OnClick = ButtonOpenLayeredClick
  end
end
