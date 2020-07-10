object frmGraphOptions: TfrmGraphOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Graph options'
  ClientHeight = 403
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object lblY: TLabel
    Left = 399
    Top = 217
    Width = 33
    Height = 16
    Caption = '< Y <'
  end
  object lblX: TLabel
    Left = 397
    Top = 187
    Width = 34
    Height = 16
    Caption = '< X <'
  end
  object lblXscale: TLabel
    Left = 324
    Top = 33
    Width = 13
    Height = 16
    Caption = 'X:'
  end
  object lblYscale: TLabel
    Left = 325
    Top = 66
    Width = 12
    Height = 16
    Caption = 'Y:'
  end
  object lblBackground: TLabel
    Left = 8
    Top = 8
    Width = 71
    Height = 16
    Caption = 'Background:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblAxesColour: TLabel
    Left = 64
    Top = 96
    Width = 42
    Height = 16
    Caption = 'Colour:'
  end
  object lblAxesThick: TLabel
    Left = 45
    Top = 128
    Width = 61
    Height = 16
    Caption = 'Thickness:'
  end
  object lblTicksSize: TLabel
    Left = 41
    Top = 336
    Width = 65
    Height = 16
    Caption = 'Marks size:'
  end
  object lblBgColour: TLabel
    Left = 64
    Top = 32
    Width = 42
    Height = 16
    Caption = 'Colour:'
  end
  object lblAxes: TLabel
    Left = 8
    Top = 56
    Width = 32
    Height = 16
    Caption = 'Axes:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblGrid: TLabel
    Left = 8
    Top = 160
    Width = 28
    Height = 16
    Caption = 'Grid:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblGridColour: TLabel
    Left = 64
    Top = 200
    Width = 42
    Height = 16
    Caption = 'Colour:'
  end
  object lblTicks: TLabel
    Left = 8
    Top = 264
    Width = 67
    Height = 16
    Caption = 'Tick marks:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblTicksColour: TLabel
    Left = 64
    Top = 304
    Width = 42
    Height = 16
    Caption = 'Colour:'
  end
  object lblGridAndTicks: TLabel
    Left = 272
    Top = 8
    Width = 162
    Height = 16
    Caption = 'Grid and tick marks spacing:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblGridThick: TLabel
    Left = 45
    Top = 232
    Width = 61
    Height = 16
    Caption = 'Thickness:'
  end
  object lblTickThick: TLabel
    Left = 45
    Top = 368
    Width = 61
    Height = 16
    Caption = 'Thickness:'
  end
  object lblGraphArea: TLabel
    Left = 272
    Top = 160
    Width = 39
    Height = 16
    Caption = 'Graph:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object lblStep: TLabel
    Left = 283
    Top = 251
    Width = 54
    Height = 16
    Caption = 'Samples:'
  end
  object lblGraphThick: TLabel
    Left = 276
    Top = 313
    Width = 61
    Height = 16
    Caption = 'Thickness:'
  end
  object lblRange: TLabel
    Left = 296
    Top = 187
    Width = 41
    Height = 16
    Caption = 'Range:'
  end
  object lblLabels: TLabel
    Left = 295
    Top = 136
    Width = 42
    Height = 16
    Caption = 'Colour:'
  end
  object lblLabelsColour: TLabel
    Left = 272
    Top = 96
    Width = 56
    Height = 16
    Caption = 'Numbers:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object edtYmax: TEdit
    Left = 438
    Top = 213
    Width = 51
    Height = 24
    TabOrder = 18
    OnKeyPress = TEditSignedFloatOnly
  end
  object edtYmin: TEdit
    Left = 342
    Top = 213
    Width = 51
    Height = 24
    TabOrder = 17
    OnKeyPress = TEditSignedFloatOnly
  end
  object edtXmin: TEdit
    Left = 344
    Top = 183
    Width = 51
    Height = 24
    TabOrder = 15
    OnKeyPress = TEditSignedFloatOnly
  end
  object edtXmax: TEdit
    Left = 437
    Top = 183
    Width = 51
    Height = 24
    TabOrder = 16
    OnKeyPress = TEditSignedFloatOnly
  end
  object edtYscale: TEdit
    Left = 343
    Top = 63
    Width = 66
    Height = 24
    TabOrder = 12
    OnKeyPress = TEditPositiveFloatOnly
  end
  object edtXscale: TEdit
    Left = 343
    Top = 33
    Width = 66
    Height = 24
    TabOrder = 11
    OnKeyPress = TEditPositiveFloatOnly
  end
  object clrbxBackground: TColorBox
    Left = 112
    Top = 29
    Width = 154
    Height = 22
    ItemHeight = 16
    TabOrder = 0
  end
  object clrbxAxes: TColorBox
    Left = 112
    Top = 95
    Width = 154
    Height = 22
    ItemHeight = 16
    TabOrder = 2
  end
  object cbbGraphThick: TComboBox
    Left = 343
    Top = 310
    Width = 155
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 21
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object cbbAxesThick: TComboBox
    Left = 112
    Top = 124
    Width = 154
    Height = 24
    ItemHeight = 16
    TabOrder = 3
    Text = 'cbbAxesThick'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object edtNumSamples: TEdit
    Left = 343
    Top = 250
    Width = 66
    Height = 24
    Hint = 'Number of points calculated to draw the whole graph'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 19
    Text = 'edtNumSamples'
    OnKeyPress = TEditPositiveIntegerOnly
  end
  object chkJoin: TCheckBox
    Left = 343
    Top = 280
    Width = 155
    Height = 24
    Hint = 'Check=join calculated points; Unchecked=plot dots only'
    Caption = 'Join samples with lines'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
  end
  object btnOk: TButton
    Left = 401
    Top = 352
    Width = 97
    Height = 37
    Caption = 'Ok'
    TabOrder = 23
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 283
    Top = 352
    Width = 97
    Height = 37
    Caption = 'Cancel'
    TabOrder = 22
    OnClick = btnCancelClick
  end
  object edtScaleSize: TEdit
    Left = 112
    Top = 332
    Width = 65
    Height = 24
    Hint = 'Length of the tick marks either side of the axes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    OnKeyPress = TEditPositiveFloatOnly
  end
  object chkDrawAxes: TCheckBox
    Left = 112
    Top = 64
    Width = 97
    Height = 25
    Caption = 'Draw axes'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object chkDrawGrid: TCheckBox
    Left = 112
    Top = 168
    Width = 81
    Height = 25
    Caption = 'Draw grid'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object clrbxGrid: TColorBox
    Left = 112
    Top = 197
    Width = 154
    Height = 22
    ItemHeight = 16
    TabOrder = 5
  end
  object chkDrawTicks: TCheckBox
    Left = 112
    Top = 272
    Width = 121
    Height = 25
    Caption = 'Draw tick marks'
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object clrbxTicks: TColorBox
    Left = 112
    Top = 303
    Width = 154
    Height = 22
    ItemHeight = 16
    TabOrder = 8
  end
  object cbbGridThick: TComboBox
    Left = 112
    Top = 228
    Width = 154
    Height = 24
    ItemHeight = 16
    TabOrder = 6
    Text = 'cbbAxesThick'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object cbbTicksThick: TComboBox
    Left = 112
    Top = 362
    Width = 154
    Height = 24
    ItemHeight = 16
    TabOrder = 10
    Text = 'cbbAxesThick'
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5')
  end
  object clrbxLabels: TColorBox
    Left = 343
    Top = 135
    Width = 155
    Height = 22
    ItemHeight = 16
    TabOrder = 14
  end
  object chkDrawLabels: TCheckBox
    Left = 343
    Top = 105
    Width = 145
    Height = 25
    Caption = 'Draw numbers labels'
    Checked = True
    State = cbChecked
    TabOrder = 13
  end
end
