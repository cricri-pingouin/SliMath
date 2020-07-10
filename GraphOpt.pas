unit GraphOpt;

interface

uses
  SysUtils, Classes, Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TfrmGraphOptions = class(TForm)
    edtYmax: TEdit;
    edtYmin: TEdit;
    edtXmin: TEdit;
    edtXmax: TEdit;
    edtYscale: TEdit;
    edtXscale: TEdit;
    clrbxBackground: TColorBox;
    clrbxAxes: TColorBox;
    lblY: TLabel;
    lblX: TLabel;
    lblXscale: TLabel;
    lblYscale: TLabel;
    lblBackground: TLabel;
    lblAxesColour: TLabel;
    cbbGraphThick: TComboBox;
    cbbAxesThick: TComboBox;
    lblAxesThick: TLabel;
    edtNumSamples: TEdit;
    chkJoin: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    edtScaleSize: TEdit;
    lblTicksSize: TLabel;
    lblBgColour: TLabel;
    lblAxes: TLabel;
    chkDrawAxes: TCheckBox;
    lblGrid: TLabel;
    chkDrawGrid: TCheckBox;
    clrbxGrid: TColorBox;
    lblGridColour: TLabel;
    lblTicks: TLabel;
    chkDrawTicks: TCheckBox;
    clrbxTicks: TColorBox;
    lblTicksColour: TLabel;
    lblGridAndTicks: TLabel;
    lblGridThick: TLabel;
    cbbGridThick: TComboBox;
    lblTickThick: TLabel;
    cbbTicksThick: TComboBox;
    lblGraphArea: TLabel;
    lblStep: TLabel;
    lblGraphThick: TLabel;
    lblRange: TLabel;
    lblLabels: TLabel;
    lblLabelsColour: TLabel;
    clrbxLabels: TColorBox;
    chkDrawLabels: TCheckBox;
    procedure TEditSignedFloatOnly(Sender: TObject; var Key: Char);
    procedure TEditPositiveFloatOnly(Sender: TObject; var Key: Char);
    procedure TEditPositiveIntegerOnly(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGraphOptions: TfrmGraphOptions;

implementation

uses
  SharedGlobal;

{$R *.dfm}

procedure TfrmGraphOptions.TEditSignedFloatOnly(Sender: TObject; var Key: Char);
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

procedure TfrmGraphOptions.TEditPositiveFloatOnly(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9', DecimalSeparator]) then
  begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if (Key = DecimalSeparator) and (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end;
end;

procedure TfrmGraphOptions.TEditPositiveIntegerOnly(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9']) then
  begin
    ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if (Key = DecimalSeparator) and (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end;
end;

procedure TfrmGraphOptions.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGraphOptions.btnOkClick(Sender: TObject);
begin
  if (Xmax <= Xmin) or (Ymax <= Ymin) then
  begin
    ShowMessage('Your axes maximum have to be larger than their minimum!');
    Exit;
  end;
  Xmin := StrToFloat(edtXmin.Text);
  Xmax := StrToFloat(edtXmax.Text);
  Ymin := StrToFloat(edtYmin.Text);
  Ymax := StrToFloat(edtYmax.Text);
  NumSamples := StrToInt(edtNumSamples.Text);
  XAxisScale := StrToFloat(edtXscale.Text);
  YAxisScale := StrToFloat(edtYscale.Text);
  ScaleMarkSize := StrToFloat(edtScaleSize.Text);
  BackgroundColour := clrbxBackground.Selected;
  AxesColour := clrbxAxes.Selected;
  GridColour := clrbxGrid.Selected;
  TicksColour := clrbxTicks.Selected;
  LabelsColour := clrbxLabels.Selected;
  GraphThick := cbbGraphThick.ItemIndex + 1;
  AxesThick := cbbAxesThick.ItemIndex + 1;
  GridThick := cbbGridThick.ItemIndex + 1;
  TicksThick := cbbTicksThick.ItemIndex + 1;
  DrawAxes := chkDrawAxes.Checked;
  DrawGrid := chkDrawGrid.Checked;
  DrawTicks := chkDrawTicks.Checked;
  DrawLabels := chkDrawLabels.Checked;
  Interpolate := chkJoin.Checked;
  Close;
end;

procedure TfrmGraphOptions.FormShow(Sender: TObject);
begin
  edtXmin.Text := FloatToStr(Xmin);
  edtXmax.Text := FloatToStr(Xmax);
  edtYmin.Text := FloatToStr(Ymin);
  edtYmax.Text := FloatToStr(Ymax);
  edtNumSamples.Text := IntToStr(NumSamples);
  edtXscale.Text := FloatToStr(XAxisSCale);
  edtYscale.Text := FloatToStr(YAxisSCale);
  edtScaleSize.Text := FloatToStr(ScaleMarkSize);
  clrbxBackground.Selected := BackgroundColour;
  clrbxAxes.Selected := AxesColour;
  clrbxGrid.Selected := GridColour;
  clrbxTicks.Selected := TicksColour;
  clrbxLabels.Selected := LabelsColour;
  cbbGraphThick.ItemIndex := GraphThick - 1;
  cbbAxesThick.ItemIndex := AxesThick - 1;
  cbbGridThick.ItemIndex := GridThick - 1;
  cbbTicksThick.ItemIndex := TicksThick - 1;
  chkDrawAxes.Checked := DrawAxes;
  chkDrawGrid.Checked := DrawGrid;
  chkDrawTicks.Checked := DrawTicks;
  chkDrawLabels.Checked := DrawLabels;
  chkJoin.Checked := Interpolate;
end;

end.

