object frmGraphList: TfrmGraphList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Graph list'
  ClientHeight = 396
  ClientWidth = 921
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object lblType: TLabel
    Left = 8
    Top = 10
    Width = 67
    Height = 16
    Caption = 'Graph type:'
  end
  object lblPrimary: TLabel
    Left = 127
    Top = 10
    Width = 102
    Height = 16
    Caption = 'Primary equation:'
  end
  object lblSecondary: TLabel
    Left = 359
    Top = 10
    Width = 118
    Height = 16
    Caption = 'Secondary equation:'
  end
  object lblLowBound: TLabel
    Left = 591
    Top = 10
    Width = 51
    Height = 16
    Caption = 'From X='
  end
  object lblHighBound: TLabel
    Left = 678
    Top = 10
    Width = 36
    Height = 16
    Caption = 'To X='
  end
  object lblColour: TLabel
    Left = 765
    Top = 10
    Width = 78
    Height = 16
    Caption = 'Graph colour:'
  end
  object lblSecond: TLabel
    Left = 359
    Top = 26
    Width = 226
    Height = 16
    Caption = '(required for parametric functions only)'
  end
  object lblFromTo: TLabel
    Left = 591
    Top = 26
    Width = 153
    Height = 16
    Caption = '(for polar/parametric only)'
  end
  object lblPrim: TLabel
    Left = 126
    Top = 26
    Width = 166
    Height = 16
    Caption = '(required for all graph types)'
  end
  object lblGraphType: TLabel
    Left = 7
    Top = 26
    Width = 105
    Height = 16
    Caption = '(none: not drawn)'
  end
  object cmbType0: TComboBox
    Left = 8
    Top = 48
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 0
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary0: TEdit
    Left = 127
    Top = 48
    Width = 226
    Height = 24
    TabOrder = 1
  end
  object txtSecondary0: TEdit
    Left = 359
    Top = 48
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object txtLowBound0: TEdit
    Left = 591
    Top = 48
    Width = 81
    Height = 24
    TabOrder = 3
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound0: TEdit
    Left = 678
    Top = 48
    Width = 81
    Height = 24
    TabOrder = 4
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox0: TColorBox
    Left = 765
    Top = 48
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 5
  end
  object cmbType1: TComboBox
    Left = 8
    Top = 78
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 6
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary1: TEdit
    Left = 127
    Top = 78
    Width = 226
    Height = 24
    TabOrder = 7
  end
  object txtSecondary1: TEdit
    Left = 359
    Top = 78
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
  end
  object txtLowBound1: TEdit
    Left = 591
    Top = 78
    Width = 81
    Height = 24
    TabOrder = 9
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound1: TEdit
    Left = 678
    Top = 78
    Width = 81
    Height = 24
    TabOrder = 10
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox1: TColorBox
    Left = 765
    Top = 78
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 11
  end
  object cmbType2: TComboBox
    Left = 8
    Top = 108
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 12
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary2: TEdit
    Left = 127
    Top = 108
    Width = 226
    Height = 24
    TabOrder = 13
  end
  object txtSecondary2: TEdit
    Left = 359
    Top = 108
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
  end
  object txtLowBound2: TEdit
    Left = 591
    Top = 108
    Width = 81
    Height = 24
    TabOrder = 15
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound2: TEdit
    Left = 678
    Top = 108
    Width = 81
    Height = 24
    TabOrder = 16
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox2: TColorBox
    Left = 765
    Top = 108
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 17
  end
  object cmbType3: TComboBox
    Left = 8
    Top = 138
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 18
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary3: TEdit
    Left = 127
    Top = 138
    Width = 226
    Height = 24
    TabOrder = 19
  end
  object txtSecondary3: TEdit
    Left = 359
    Top = 138
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
  end
  object txtLowBound3: TEdit
    Left = 591
    Top = 138
    Width = 81
    Height = 24
    TabOrder = 21
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound3: TEdit
    Left = 678
    Top = 138
    Width = 81
    Height = 24
    TabOrder = 22
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox3: TColorBox
    Left = 765
    Top = 138
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 23
  end
  object cmbType4: TComboBox
    Left = 8
    Top = 168
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 24
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary4: TEdit
    Left = 127
    Top = 168
    Width = 226
    Height = 24
    TabOrder = 25
  end
  object txtSecondary4: TEdit
    Left = 359
    Top = 168
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 26
  end
  object txtLowBound4: TEdit
    Left = 591
    Top = 168
    Width = 81
    Height = 24
    TabOrder = 27
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound4: TEdit
    Left = 678
    Top = 168
    Width = 81
    Height = 24
    TabOrder = 28
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox4: TColorBox
    Left = 765
    Top = 168
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 29
  end
  object cmbType5: TComboBox
    Left = 8
    Top = 198
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 30
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary5: TEdit
    Left = 127
    Top = 198
    Width = 226
    Height = 24
    TabOrder = 31
  end
  object txtSecondary5: TEdit
    Left = 359
    Top = 198
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 32
  end
  object txtLowBound5: TEdit
    Left = 591
    Top = 198
    Width = 81
    Height = 24
    TabOrder = 33
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound5: TEdit
    Left = 678
    Top = 198
    Width = 81
    Height = 24
    TabOrder = 34
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox5: TColorBox
    Left = 765
    Top = 198
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 35
  end
  object cmbType6: TComboBox
    Left = 8
    Top = 228
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 36
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary6: TEdit
    Left = 127
    Top = 228
    Width = 226
    Height = 24
    TabOrder = 37
  end
  object txtSecondary6: TEdit
    Left = 359
    Top = 228
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 38
  end
  object txtLowBound6: TEdit
    Left = 591
    Top = 228
    Width = 81
    Height = 24
    TabOrder = 39
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound6: TEdit
    Left = 678
    Top = 228
    Width = 81
    Height = 24
    TabOrder = 40
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox6: TColorBox
    Left = 765
    Top = 228
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 41
  end
  object cmbType7: TComboBox
    Left = 8
    Top = 258
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 42
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary7: TEdit
    Left = 127
    Top = 258
    Width = 226
    Height = 24
    TabOrder = 43
  end
  object txtSecondary7: TEdit
    Left = 359
    Top = 258
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 44
  end
  object txtLowBound7: TEdit
    Left = 591
    Top = 258
    Width = 81
    Height = 24
    TabOrder = 45
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound7: TEdit
    Left = 678
    Top = 258
    Width = 81
    Height = 24
    TabOrder = 46
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox7: TColorBox
    Left = 765
    Top = 258
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 47
  end
  object cmbType8: TComboBox
    Left = 8
    Top = 288
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 48
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary8: TEdit
    Left = 127
    Top = 288
    Width = 226
    Height = 24
    TabOrder = 49
  end
  object txtSecondary8: TEdit
    Left = 359
    Top = 288
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 50
  end
  object txtLowBound8: TEdit
    Left = 591
    Top = 288
    Width = 81
    Height = 24
    TabOrder = 51
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound8: TEdit
    Left = 678
    Top = 288
    Width = 81
    Height = 24
    TabOrder = 52
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox8: TColorBox
    Left = 765
    Top = 288
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 53
  end
  object cmbType9: TComboBox
    Left = 8
    Top = 318
    Width = 113
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 54
    Text = '(none)'
    Items.Strings = (
      '(none)'
      'Function'
      'Polar'
      'Parametric')
  end
  object txtPrimary9: TEdit
    Left = 127
    Top = 318
    Width = 226
    Height = 24
    TabOrder = 55
  end
  object txtSecondary9: TEdit
    Left = 359
    Top = 318
    Width = 226
    Height = 24
    Hint = 'Only required for parametric graphs'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 56
  end
  object txtLowBound9: TEdit
    Left = 591
    Top = 318
    Width = 81
    Height = 24
    TabOrder = 57
    OnKeyPress = TEditOnlyNumerical
  end
  object txtHighBound9: TEdit
    Left = 678
    Top = 318
    Width = 81
    Height = 24
    TabOrder = 58
    OnKeyPress = TEditOnlyNumerical
  end
  object colBox9: TColorBox
    Left = 765
    Top = 318
    Width = 145
    Height = 22
    ItemHeight = 16
    TabOrder = 59
  end
  object btnOK: TButton
    Left = 728
    Top = 359
    Width = 185
    Height = 25
    Caption = 'Ok'
    TabOrder = 61
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 8
    Top = 359
    Width = 185
    Height = 25
    Caption = 'Cancel'
    TabOrder = 60
    OnClick = btnCancelClick
  end
end
