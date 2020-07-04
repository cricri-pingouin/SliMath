Unit Calculate;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, Grids, StrUtils;

Type
  TfrmCalc = Class(TForm)
    edtEq: TEdit;
    mnuCalc: TMainMenu;
    mnuGraph: TMenuItem;
    strgrd: TStringGrid;
    btnEnter: TButton;
    mnuClear: TMenuItem;
    mnuFile: TMenuItem;
    mnuSep1: TMenuItem;
    mnuExit: TMenuItem;
    mnuLoad: TMenuItem;
    mnuSave: TMenuItem;
    Function RemoveSpaces(MyString: String): String;
    Procedure SaveStringGrid(StringGrid: TStringGrid; Const FileName: TFileName);
    Procedure LoadStringGrid(StringGrid: TStringGrid; Const FileName: TFileName);
    Procedure strgrdDblClick(Sender: TObject);
    Procedure btnEnterClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure FormResize(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure mnuLoadClick(Sender: TObject);
    Procedure mnuSaveClick(Sender: TObject);
    Procedure mnuExitClick(Sender: TObject);
    Procedure mnuClearClick(Sender: TObject);
    Procedure mnuGraphClick(Sender: TObject);
    Procedure edtEqKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  frmCalc: TfrmCalc;
  varX, varY, varZ: Double;
  EqCount: Integer;

Implementation

Uses
  SharedGlobal, ParseExpr, Graph, IniFiles;

Var
  MyParser: TExpressionParser;

{$R *.dfm}

Function TfrmCalc.RemoveSpaces(MyString: String): String;
Begin
  Result := LowerCase(StringReplace(MyString, ' ', '', [rfReplaceAll]));
End;

Procedure TfrmCalc.SaveStringGrid(StringGrid: TStringGrid; Const FileName: TFileName);
Var
  f: TextFile;
  i: Integer;
Begin
  AssignFile(f, FileName);
  Rewrite(f);
  For i := 0 To StringGrid.RowCount - 1 Do
    Writeln(f, StringGrid.Cells[0, i]);
  CloseFile(f);
End;

Procedure TfrmCalc.LoadStringGrid(StringGrid: TStringGrid; Const FileName: TFileName);
Var
  f: TextFile;
  i: Integer;
  strTemp, strPrefix: String;
Begin
  //File does not exists? Exit
  If Not FileExists(FileName) Then
    Exit;
  AssignFile(f, FileName);
  Reset(f);
  i := 0;
  While Not Eof(f) Do
  Begin
    Readln(f, strTemp);
    Inc(i);
    StringGrid.RowCount := i;
    StringGrid.Cells[0, i - 1] := strTemp;
    //BEGIN ADDED CHRISTOPHE
    strPrefix := LeftStr(strTemp, 4);
    If (strPrefix = 'X = ') Then
      varX := StrToFloat(RightStr(strTemp, Length(strTemp) - 4))
    Else If (strPrefix = 'Y = ') Then
      varY := StrToFloat(RightStr(strTemp, Length(strTemp) - 4))
    Else If (strPrefix = 'Z = ') Then
      varZ := StrToFloat(RightStr(strTemp, Length(strTemp) - 4));
  End;
  CloseFile(f);
  EqCount := i;
End;

Procedure TfrmCalc.FormCreate(Sender: TObject);
Var
  myINI: TIniFile;
  I: Integer;
Begin
  //Declare parser here and only free it on close to retain variables
  MyParser := TCstyleParser.Create;
  TCStyleParser(MyParser).CStyle := False;
  mnuClearClick(frmCalc);
  FormResize(frmCalc);
  //To capture keys at the form level while typing equations in TEDit 'edtEq'
  //Processing keys will happen in form TfrmCalc key event
//  KeyPreview := True;
  //Load history
  LoadStringGrid(strgrd, 'history.txt');
  If (EqCount > 0) Then
    strgrd.Row := EqCount - 1;
  //Load settings
  myINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'SliMath.ini');
  //OptHeight := myINI.ReadInteger('Settings', 'Starting_Height', 0);
  Xmin := myINI.ReadFloat('Graph', 'Xmin', -5);
  Xmax := myINI.ReadFloat('Graph', 'Xmax', 5);
  Ymin := myINI.ReadFloat('Graph', 'Ymin', -5);
  Ymax := myINI.ReadFloat('Graph', 'Ymax', 5);
  XAxisScale := myINI.ReadFloat('Graph', 'XAxisScale', 1);
  YAxisScale := myINI.ReadFloat('Graph', 'YAxisScale', 1);
  ScaleMarkSize := myINI.ReadFloat('Graph', 'ScaleMarkSize', 0.05);
  NumSamples := myINI.ReadInteger('Graph', 'NumSamples', 100);
  BackgroundColour := myINI.ReadInteger('Graph', 'BackgroundColour', clWhite);
  AxesColour := myINI.ReadInteger('Graph', 'AxesColour', clBlack);
  GridColour := myINI.ReadInteger('Graph', 'GridColour', clGray);
  TicksColour := myINI.ReadInteger('Graph', 'TicksColour', clBlack);
  LabelsColour := myINI.ReadInteger('Graph', 'LabelsColour', clBlack);
  GraphThick := myINI.ReadInteger('Graph', 'GraphThickness', 1);
  AxesThick := myINI.ReadInteger('Graph', 'AxesThickness', 1);
  GridThick := myINI.ReadInteger('Graph', 'GridThickness', 1);
  TicksThick := myINI.ReadInteger('Graph', 'TicksThickness', 1);
  DrawAxes := myINI.ReadBool('Graph', 'DrawAxes', True);
  DrawGrid := myINI.ReadBool('Graph', 'DrawGrid', True);
  DrawTicks := myINI.ReadBool('Graph', 'DrawTicks', True);
  DrawLabels := myINI.ReadBool('Graph', 'DrawLabels', True);
  Interpolate := myINI.ReadBool('Graph', 'Interpolate', True);
  For I := 0 To 9 Do
  Begin
    GraphsList[I].GraphType := myINI.ReadString('GraphEq', 'Graph' + IntToStr(I) + 'Type', '(none)');
    GraphsList[I].Eq1 := myINI.ReadString('GraphEq', 'Graph' + IntToStr(I) + 'Eq1', '');
    GraphsList[I].Eq2 := myINI.ReadString('GraphEq', 'Graph' + IntToStr(I) + 'Eq2', '');
    GraphsList[I].LowBound := myINI.ReadFloat('GraphEq', 'Graph' + IntToStr(I) + 'LowBound', 0);
    GraphsList[I].HighBound := myINI.ReadFloat('GraphEq', 'Graph' + IntToStr(I) + 'HighBound', 0);
    GraphsList[I].GraphColour := myINI.ReadInteger('GraphEq', 'Graph' + IntToStr(I) + 'Colour', 0);
  End;
  myINI.Free;
End;

Procedure TfrmCalc.FormResize(Sender: TObject);
Begin
  strgrd.ColWidths[0] := strgrd.Width - 4;
  edtEq.Width := frmCalc.ClientWidth - btnEnter.Width - 2;
End;

Procedure TfrmCalc.edtEqKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Var
  TempExpr: String;
  CursorPos: Integer;
Begin
  If Key = VK_INSERT Then
  Begin
  //Strip variable declaration
    TempExpr := StringReplace(strgrd.Cells[0, strgrd.Row], 'X = ', '', [rfReplaceAll]);
    TempExpr := StringReplace(TempExpr, 'Y = ', '', [rfReplaceAll]);
    TempExpr := StringReplace(TempExpr, 'Z = ', '', [rfReplaceAll]);
  //Remove spaces. No needed to call RemoveSpaces as that already happened
    TempExpr := StringReplace(TempExpr, '=', '', [rfReplaceAll]);
    TempExpr := StringReplace(TempExpr, ' ', '', [rfReplaceAll]);
  //Insert in edtEq textbox at cursor position
    CursorPos := edtEq.SelStart;
    edtEq.Text := LeftStr(edtEq.Text, CursorPos) + TempExpr + RightStr(edtEq.Text, Length(edtEq.Text) - CursorPos);
    edtEq.SetFocus;
    edtEq.SelStart := CursorPos + Length(TempExpr);
  End;
End;

Procedure TfrmCalc.FormClose(Sender: TObject; Var Action: TCloseAction);
Var
  myINI: TIniFile;
  i: Integer;
Begin
  //Save history
  SaveStringGrid(strgrd, 'history.txt');
  //Now we can free parser
  MyParser.Free;
  //Save settings to INI file
  myINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'SliMath.ini');
  myINI.WriteFloat('Graph', 'Xmin', Xmin);
  myINI.WriteFloat('Graph', 'Xmax', Xmax);
  myINI.WriteFloat('Graph', 'Ymin', Ymin);
  myINI.WriteFloat('Graph', 'Ymax', Ymax);
  myINI.WriteFloat('Graph', 'XAxisScale', XAxisScale);
  myINI.WriteFloat('Graph', 'YAxisScale', YAxisScale);
  myINI.WriteFloat('Graph', 'ScaleMarkSize', ScaleMarkSize);
  myINI.WriteInteger('Graph', 'NumSamples', NumSamples);
  myINI.WriteInteger('Graph', 'BackgroundColour', BackgroundColour);
  myINI.WriteInteger('Graph', 'AxesColour', AxesColour);
  myINI.WriteInteger('Graph', 'GridColour', GridColour);
  myINI.WriteInteger('Graph', 'TicksColour', TicksColour);
  myINI.WriteInteger('Graph', 'LabelsColour', LabelsColour);
  myINI.WriteInteger('Graph', 'GraphThickness', GraphThick);
  myINI.WriteInteger('Graph', 'AxesThickness', AxesThick);
  myINI.WriteInteger('Graph', 'GridThickness', GridThick);
  myINI.WriteInteger('Graph', 'TicksThickness', TicksThick);
  myINI.WriteBool('Graph', 'DrawAxes', DrawAxes);
  myINI.WriteBool('Graph', 'DrawGrid', DrawGrid);
  myINI.WriteBool('Graph', 'DrawTicks', DrawTicks);
  myINI.WriteBool('Graph', 'DrawLabels', DrawLabels);
  myINI.WriteBool('Graph', 'Interpolate', Interpolate);
  For i := 0 To 9 Do
  Begin
    myINI.WriteString('GraphEq', 'Graph' + IntToStr(i) + 'Type', GraphsList[i].GraphType);
    myINI.WriteString('GraphEq', 'Graph' + IntToStr(i) + 'Eq1', GraphsList[i].Eq1);
    myINI.WriteString('GraphEq', 'Graph' + IntToStr(i) + 'Eq2', GraphsList[i].Eq2);
    myINI.WriteFloat('GraphEq', 'Graph' + IntToStr(i) + 'LowBound', GraphsList[i].LowBound);
    myINI.WriteFloat('GraphEq', 'Graph' + IntToStr(i) + 'HighBound', GraphsList[i].HighBound);
    myINI.WriteInteger('GraphEq', 'Graph' + IntToStr(i) + 'Colour', GraphsList[i].GraphColour);
  End;
  myINI.Free;
End;

Procedure TfrmCalc.strgrdDblClick(Sender: TObject);
Var
  TempExpr: String;
  CursorPos: Integer;
Begin
  //Strip variable declaration
  TempExpr := StringReplace(strgrd.Cells[0, strgrd.Row], 'X = ', '', [rfReplaceAll]);
  TempExpr := StringReplace(TempExpr, 'Y = ', '', [rfReplaceAll]);
  TempExpr := StringReplace(TempExpr, 'Z = ', '', [rfReplaceAll]);
  //Remove spaces. No needed to call RemoveSpaces as that already happened
  TempExpr := StringReplace(TempExpr, '=', '', [rfReplaceAll]);
  TempExpr := StringReplace(TempExpr, ' ', '', [rfReplaceAll]);
  //Insert in edtEq textbox at cursor position
  CursorPos := edtEq.SelStart;
  edtEq.Text := LeftStr(edtEq.Text, CursorPos) + TempExpr + RightStr(edtEq.Text, Length(edtEq.Text) - CursorPos);
  edtEq.SetFocus;
  edtEq.SelStart := CursorPos + Length(TempExpr);
End;

Procedure TfrmCalc.btnEnterClick(Sender: TObject);
Var
  EqResult: Double;
  CurrExpr, TextResult, VarName: String;
  i: integer;
Begin
  CurrExpr := RemoveSpaces(edtEq.Text);
  edtEq.Text := CurrExpr;
  If (CurrExpr = '') Then
    Exit;
  VarName := LeftStr(CurrExpr, 2);
  If (VarName = 'x=') Or (VarName = 'y=') Or (VarName = 'z=') Then
  Begin
    CurrExpr := RightStr(CurrExpr, Length(CurrExpr) - 2);
    VarName := LeftStr(VarName, 1);
  End
  Else
    VarName := '';
  //Evaluate expression
  i := MyParser.AddExpression(CurrExpr);
  FailsToCompute := False;
  EqResult := MyParser.AsFloat[i];
  //Free parser
  TextResult := floattostr(EqResult);
  If Not FailsToCompute Then //(TextResult <> 'NAN') then
  Begin
    //Add expression to strgrd
    Inc(EqCount);
    strgrd.RowCount := EqCount;
    If (VarName = '') Then
    Begin
      strgrd.Cells[0, EqCount - 1] := CurrExpr;
      //Add result to strgrd
      Inc(EqCount);
      strgrd.RowCount := EqCount;
      strgrd.Cells[0, EqCount - 1] := '= ' + TextResult;
    End
    Else
    Begin
      If (VarName = 'x') Then
        varX := EqResult
      Else If (VarName = 'y') Then
        varY := EqResult
      Else If (VarName = 'z') Then
        varZ := EqResult;
      strgrd.Cells[0, EqCount - 1] := UpperCase(VarName) + ' = ' + TextResult;
    End;
    edtEq.Text := '';
  End
  Else
  Begin
    showmessage('Expression cannot be evaluated numerically!');
  End;
  //Select latest row: it gets highlighted and the strgrd is scrolled all the way down
  //Test needed in case grid empty and expression couldn't be evaluated
  If (EqCount > 0) Then
    strgrd.Row := EqCount - 1;
End;

Procedure TfrmCalc.mnuLoadClick(Sender: TObject);
Begin
  LoadStringGrid(strgrd, 'history.txt');
End;

Procedure TfrmCalc.mnuSaveClick(Sender: TObject);
Begin
  SaveStringGrid(strgrd, 'history.txt');
End;

Procedure TfrmCalc.mnuExitClick(Sender: TObject);
Begin
  Close;
End;

Procedure TfrmCalc.mnuClearClick(Sender: TObject);
Begin
  //StringGrid
  strgrd.Cols[0].Clear;
  strgrd.RowCount := 1;
  EqCount := 0;
  //Current expression
  edtEq.Text := '';
  //Parser
  MyParser.ClearExpressions();
  varX := 0;
  MyParser.DefineVariable('x', @varX);
  varY := 0;
  MyParser.DefineVariable('y', @varY);
  varZ := 0;
  MyParser.DefineVariable('z', @varZ);
End;

Procedure TfrmCalc.mnuGraphClick(Sender: TObject);
Begin
  If frmGraph.Visible = False Then
    frmGraph.Visible := True
  Else
    frmGraph.Visible := False;
End;

End.

