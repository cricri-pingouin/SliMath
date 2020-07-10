unit GraphList;

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TfrmGraphList = class(TForm)
    cmbType1: TComboBox;
    lblType: TLabel;
    lblPrimary: TLabel;
    lblSecondary: TLabel;
    lblLowBound: TLabel;
    lblHighBound: TLabel;
    lblColour: TLabel;
    txtPrimary1: TEdit;
    txtSecondary1: TEdit;
    txtLowBound1: TEdit;
    txtHighBound1: TEdit;
    colBox1: TColorBox;
    cmbType2: TComboBox;
    txtPrimary2: TEdit;
    txtSecondary2: TEdit;
    txtLowBound2: TEdit;
    txtHighBound2: TEdit;
    colBox2: TColorBox;
    cmbType3: TComboBox;
    txtPrimary3: TEdit;
    txtSecondary3: TEdit;
    txtLowBound3: TEdit;
    txtHighBound3: TEdit;
    colBox3: TColorBox;
    cmbType4: TComboBox;
    txtPrimary4: TEdit;
    txtSecondary4: TEdit;
    txtLowBound4: TEdit;
    txtHighBound4: TEdit;
    colBox4: TColorBox;
    cmbType5: TComboBox;
    txtPrimary5: TEdit;
    txtSecondary5: TEdit;
    txtLowBound5: TEdit;
    txtHighBound5: TEdit;
    colBox5: TColorBox;
    cmbType6: TComboBox;
    txtPrimary6: TEdit;
    txtSecondary6: TEdit;
    txtLowBound6: TEdit;
    txtHighBound6: TEdit;
    colBox6: TColorBox;
    cmbType7: TComboBox;
    txtPrimary7: TEdit;
    txtSecondary7: TEdit;
    txtLowBound7: TEdit;
    txtHighBound7: TEdit;
    colBox7: TColorBox;
    cmbType8: TComboBox;
    txtPrimary8: TEdit;
    txtSecondary8: TEdit;
    txtLowBound8: TEdit;
    txtHighBound8: TEdit;
    colBox8: TColorBox;
    cmbType9: TComboBox;
    txtPrimary9: TEdit;
    txtSecondary9: TEdit;
    txtLowBound9: TEdit;
    txtHighBound9: TEdit;
    colBox9: TColorBox;
    btnOK: TButton;
    btnCancel: TButton;
    lblSecond: TLabel;
    lblFromTo: TLabel;
    lblPrim: TLabel;
    lblGraphType: TLabel;
    procedure TEditOnlyNumerical(Sender: TObject; var Key: Char);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraphList: TfrmGraphList;

implementation

uses
  SharedGlobal;

{$R *.dfm}

procedure TfrmGraphList.TEditOnlyNumerical(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and ((Sender as TEdit).SelStart <> 0) then
  begin
    ShowMessage('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end;
end;

procedure TfrmGraphList.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGraphList.btnOKClick(Sender: TObject);
var
  i: Integer;
  TempString: string;
  TmpCombo: TComboBox;
  TmpEdit: TEdit;
  TmpColor: TColorBox;
begin
  TempString := '';
  for i := 0 to 9 do
  begin
    //Type
    TmpCombo := FindComponent('cmbType' + IntToStr(i)) as TComboBox;
    GraphsList[i].GraphType := TmpCombo.Text;
    //Primary Eq
    TmpEdit := FindComponent('txtPrimary' + IntToStr(i)) as TEdit;
    GraphsList[i].Eq1 := TmpEdit.Text;
    //Secondary Eq
    TmpEdit := FindComponent('txtSecondary' + IntToStr(i)) as TEdit;
    GraphsList[i].Eq2 := TmpEdit.Text;
    //Lower bound
    TmpEdit := FindComponent('txtLowBound' + IntToStr(i)) as TEdit;
    if (TmpEdit.Text = '') then
      GraphsList[i].LowBound := 0
    else
      GraphsList[i].LowBound := StrToFloat(TmpEdit.Text);
    //Upper bound
    TmpEdit := FindComponent('txtHighBound' + IntToStr(i)) as TEdit;
    if (TmpEdit.Text = '') then
      GraphsList[i].HighBound := 0
    else
      GraphsList[i].HighBound := StrToFloat(TmpEdit.Text);
    //Colour
    TmpColor := FindComponent('colBox' + IntToStr(i)) as TColorBox;
    GraphsList[i].GraphColour := TmpColor.Selected;
  end;
  Close;
end;

procedure TfrmGraphList.FormShow(Sender: TObject);
var
  i: Integer;
  TempString: string;
  TmpCombo: TComboBox;
  TmpEdit: TEdit;
  TmpColor: TColorBox;
begin
  TempString := '';
  for i := 0 to 9 do
  begin
    //Type
    TmpCombo := FindComponent('cmbType' + IntToStr(i)) as TComboBox;
    if (GraphsList[i].GraphType = '(none)') then
      TmpCombo.ItemIndex := 0
    else if (GraphsList[i].GraphType = 'Function') then
      TmpCombo.ItemIndex := 1
    else if (GraphsList[i].GraphType = 'Polar') then
      TmpCombo.ItemIndex := 2
    else if (GraphsList[i].GraphType = 'Parametric') then
      TmpCombo.ItemIndex := 3;
    //Primary Eq
    TmpEdit := FindComponent('txtPrimary' + IntToStr(i)) as TEdit;
    TmpEdit.Text := GraphsList[i].Eq1;
    //Secondary Eq
    TmpEdit := FindComponent('txtSecondary' + IntToStr(i)) as TEdit;
    TmpEdit.Text := GraphsList[i].Eq2;
    //Lower bound
    TmpEdit := FindComponent('txtLowBound' + IntToStr(i)) as TEdit;
    TmpEdit.Text := FloatToStr(GraphsList[i].LowBound);
    //Upper bound
    TmpEdit := FindComponent('txtHighBound' + IntToStr(i)) as TEdit;
    TmpEdit.Text := FloatToStr(GraphsList[i].HighBound);
    //Colour
    TmpColor := FindComponent('colBox' + IntToStr(i)) as TColorBox;
    TmpColor.Selected := GraphsList[i].GraphColour;
  end;
end;

end.

