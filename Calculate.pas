unit Calculate;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Menus, Grids, StrUtils, Clipbrd;

type
  TfrmCalc = class(TForm)
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
    mniHelp: TMenuItem;
    procedure SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
    procedure LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
    procedure strgrdDblClick(Sender: TObject);
    procedure btnEnterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuLoadClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure mnuExitClick(Sender: TObject);
    procedure mnuClearClick(Sender: TObject);
    procedure mnuGraphClick(Sender: TObject);
    procedure edtEqKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mniHelpClick(Sender: TObject);
    procedure strgrdDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCalc: TfrmCalc;
  EqCount: Integer;

implementation

uses
  SharedGlobal, ParseExpr, Graph, IniFiles;

var
  MyParser: TExpressionParser;

{$R *.dfm}

procedure TfrmCalc.SaveStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, FileName);
  Rewrite(f);
  //If history is not clear, there'll be more than one row
  //Need this, otherwise writes and empty line to history that will get loaded next time
  if (StringGrid.RowCount > 1) then
    for i := 0 to StringGrid.RowCount - 1 do
      Writeln(f, StringGrid.Cells[0, i]);
  CloseFile(f);
end;

procedure TfrmCalc.LoadStringGrid(StringGrid: TStringGrid; const FileName: TFileName);
var
  f: TextFile;
  i: Integer;
  strTemp: string;
  //strPrefix: string;
begin
  //File does not exists? Exit
  if not FileExists(FileName) then
    Exit;
  AssignFile(f, FileName);
  Reset(f);
  i := 0;
  while not Eof(f) do
  begin
    Readln(f, strTemp);
    Inc(i);
    StringGrid.RowCount := i;
    StringGrid.Cells[0, i - 1] := strTemp;
  end;
  CloseFile(f);
  EqCount := i;
end;

procedure TfrmCalc.FormCreate(Sender: TObject);
var
  myINI: TIniFile;
  I: Integer;
begin
  //Declare parser here and only free it on close to retain variables
  MyParser := TCstyleParser.Create;
  TCStyleParser(MyParser).CStyle := False;
  mnuClearClick(frmCalc);
  //To capture keys at the form level while typing equations in TEDit 'edtEq'
  //Processing keys will happen in form TfrmCalc key event
//  KeyPreview := True;
  //Load history
  LoadStringGrid(strgrd, 'history.txt');
  if (EqCount > 0) then
    strgrd.Row := EqCount - 1;
  //Load settings
  myINI := TINIFile.Create(ExtractFilePath(Application.EXEName) + 'SliMath.ini');
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
  for I := 0 to 9 do
  begin
    GraphsList[I].GraphType := myINI.ReadString('GraphEq', 'Graph' + IntToStr(I) + 'Type', '(none)');
    GraphsList[I].Eq1 := myINI.ReadString('GraphEq', 'Graph' + IntToStr(I) + 'Eq1', '');
    GraphsList[I].Eq2 := myINI.ReadString('GraphEq', 'Graph' + IntToStr(I) + 'Eq2', '');
    GraphsList[I].LowBound := myINI.ReadFloat('GraphEq', 'Graph' + IntToStr(I) + 'LowBound', 0);
    GraphsList[I].HighBound := myINI.ReadFloat('GraphEq', 'Graph' + IntToStr(I) + 'HighBound', 0);
    GraphsList[I].GraphColour := myINI.ReadInteger('GraphEq', 'Graph' + IntToStr(I) + 'Colour', 0);
  end;
  myINI.Free;
end;

procedure TfrmCalc.edtEqKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  TempExpr: string;
  CursorPos: Integer;
begin
  if Key = VK_INSERT then
  begin
    //Strip variable declaration
    TempExpr := strgrd.Cells[0, strgrd.Row];
    //Result? Strip '= '
    if (LeftStr(TempExpr, 2) = '= ') then
      TempExpr := RightStr(TempExpr, Length(TempExpr) - 2);
//    TempExpr := StringReplace(TempExpr, ' ', '', [rfReplaceAll]);
  //Insert in edtEq textbox at cursor position
    CursorPos := edtEq.SelStart;
    edtEq.Text := LeftStr(edtEq.Text, CursorPos) + TempExpr + RightStr(edtEq.Text, Length(edtEq.Text) - CursorPos);
    edtEq.SetFocus;
    edtEq.SelStart := CursorPos + Length(TempExpr);
  end;
end;

procedure TfrmCalc.FormClose(Sender: TObject; var Action: TCloseAction);
var
  myINI: TIniFile;
  i: Integer;
begin
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
  for i := 0 to 9 do
  begin
    myINI.WriteString('GraphEq', 'Graph' + IntToStr(i) + 'Type', GraphsList[i].GraphType);
    myINI.WriteString('GraphEq', 'Graph' + IntToStr(i) + 'Eq1', GraphsList[i].Eq1);
    myINI.WriteString('GraphEq', 'Graph' + IntToStr(i) + 'Eq2', GraphsList[i].Eq2);
    myINI.WriteFloat('GraphEq', 'Graph' + IntToStr(i) + 'LowBound', GraphsList[i].LowBound);
    myINI.WriteFloat('GraphEq', 'Graph' + IntToStr(i) + 'HighBound', GraphsList[i].HighBound);
    myINI.WriteInteger('GraphEq', 'Graph' + IntToStr(i) + 'Colour', GraphsList[i].GraphColour);
  end;
  myINI.Free;
end;

procedure TfrmCalc.strgrdDblClick(Sender: TObject);
var
  TempExpr: string;
  CursorPos: Integer;
begin
  //Strip variable declaration
  TempExpr := strgrd.Cells[0, strgrd.Row];
  if (LeftStr(TempExpr, 2) = '= ') then
    TempExpr := RightStr(TempExpr, Length(TempExpr) - 2);
  //Insert in edtEq textbox at cursor position
  CursorPos := edtEq.SelStart;
  edtEq.Text := LeftStr(edtEq.Text, CursorPos) + TempExpr + RightStr(edtEq.Text, Length(edtEq.Text) - CursorPos);
  edtEq.SetFocus;
  edtEq.SelStart := CursorPos + Length(TempExpr);
  Clipboard.AsText := TempExpr;
end;

procedure TfrmCalc.strgrdDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  S: string;
  SavedAlign: word;
begin
  S := strgrd.Cells[ACol, ARow]; // cell contents
  if (LeftStr(S, 2) = '= ') then
  begin
    SavedAlign := SetTextAlign(strgrd.Canvas.Handle, TA_RIGHT);
    strgrd.Canvas.TextRect(Rect, Rect.Right - 2, Rect.Top + 2, S);
    SetTextAlign(strgrd.Canvas.Handle, SavedAlign);
  end;
end;

procedure TfrmCalc.btnEnterClick(Sender: TObject);
var
  EqResult: Double;
  CurrExpr, TextResult: string;
  i: integer;
begin
  CurrExpr := edtEq.Text;
  if (CurrExpr = '') then
    Exit;
  //Evaluate expression
  i := MyParser.AddExpression(CurrExpr);
  EqResult := MyParser.AsFloat[i];
  //Free parser
  TextResult := floattostr(EqResult);
  if (TextResult <> 'NAN') then
  begin
    //Add expression to strgrd
    //If row is empty, grid cleared: empty row without incrementing
    if (Length(strgrd.Cells[0, EqCount]) < 1) then
      Inc(EqCount);
    strgrd.RowCount := EqCount;
    strgrd.Cells[0, EqCount - 1] := CurrExpr;
    Inc(EqCount);
    strgrd.RowCount := EqCount;
    strgrd.Cells[0, EqCount - 1] := '= ' + TextResult;
    edtEq.Text := '';
    //Select latest row: it gets highlighted and the strgrd is scrolled all the way down
    //Test needed in case grid empty and expression couldn't be evaluated
    if (EqCount > 0) then
      strgrd.Row := EqCount - 1;
    Clipboard.AsText := TextResult;
  end
  else
    ShowMessage('Expression cannot be evaluated numerically!');
end;

procedure TfrmCalc.mnuLoadClick(Sender: TObject);
begin
  LoadStringGrid(strgrd, 'history.txt');
end;

procedure TfrmCalc.mnuSaveClick(Sender: TObject);
begin
  SaveStringGrid(strgrd, 'history.txt');
end;

procedure TfrmCalc.mnuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCalc.mniHelpClick(Sender: TObject);
var
  Help: string;
begin
  Help := 'When evaluating an expression, the result is copied to the clipboard.' + sLineBreak;
  Help := Help + 'Double clicking a line in the history copies it to the expression and to the clipboard.' + sLineBreak;
  Help := Help + 'Pressing  the ''Insert'' key inserts the previous results in the expression.' + sLineBreak;
  Help := Help + '+, -, *, / [example: 4/2+2*3-1 = 7]' + sLineBreak;
  Help := Help + '>, >=, <=, <, <>, = [example: 1<2 = 1]' + sLineBreak;
  Help := Help + 'not, or, and, xor, in [in is equal, example: 14 and 3 = 2]' + sLineBreak;
  Help := Help + ':= [assign, example: x:=2, i:=3, x*i = 12]' + sLineBreak;
  Help := Help + 'sqr [example: sqr(5) = 25]' + sLineBreak;
  Help := Help + 'sqrt [example: sqr(4) = 2]' + sLineBreak;
  Help := Help + 'exp [example: exp(0) = 1]' + sLineBreak;
  Help := Help + 'ln, log10, logN [example: log10(100) = 2]' + sLineBreak;
  Help := Help + '^ [example: 3^3 = 27]' + sLineBreak;
  Help := Help + 'pow, power [example: power(2.5,2.5) = 9.882...]' + sLineBreak;
  Help := Help + 'intpow, intpower [example: intpower(2.5,2.5) = 6.25]' + sLineBreak;
  Help := Help + 'min, max [example: max(2,5) = 5]' + sLineBreak;
  Help := Help + 'sin, cos, tan [example: cos(pi) = -1]' + sLineBreak;
  Help := Help + 'arcsin, arccos, arctan [example: arccos(1) = 0]' + sLineBreak;
  Help := Help + 'arctan2 [example: arctan2(0,1) = 0]' + sLineBreak;
  Help := Help + 'sinh, cosh, tanh [example: cosh(0) = 1]' + sLineBreak;
  Help := Help + 'arcsinh, arccosh, arctanh [example: arccosh(1) = 0]' + sLineBreak;
  Help := Help + 'degtorad, radtodeg [example: radtodeg(pi) = 180]' + sLineBreak;
  Help := Help + '! [example: !5 = 120]' + sLineBreak;
  Help := Help + 'gamma [Stirling approx, example: gamma(2.5) = 1.329...]' + sLineBreak;
  Help := Help + 'Cnr, Pnr [example: Pnr(6,3) = 120]' + sLineBreak;
//  Add(TFunction.CreateOper('-@', _negate, 1, True, 10));
//  Add(TFunction.CreateOper('+@', _plus, 1, True, 10));
//  Add(TFunction.CreateOper('^@', _IntPower, 2, True, 20));
  Help := Help + '% [example: 10% = 0.1]' + sLineBreak;
  Help := Help + 'abs [example: abs(-5) = 5]' + sLineBreak;
  Help := Help + 'round [example: round(exp(1)) = 3]' + sLineBreak;
  Help := Help + 'trunc [example: trunc(exp(1)) = 2]' + sLineBreak;
  Help := Help + 'div [integer division, example: 5 div 2 = 2]' + sLineBreak;
  Help := Help + 'mod [integer division remainder, example: 5 div 2 = 1]' + sLineBreak;
  Help := Help + '--, ++ [example: 5++ = 6]' + sLineBreak;
  Help := Help + 'rand, random [random number between 0 and 1]' + sLineBreak;
  Help := Help + 'norm, randg [normal distribution sample, example: norm(10,3)]' + sLineBreak;
  Help := Help + 'pos [position of substring, example: pos(''l'',''hello'') = 3]' + sLineBreak;
  Help := Help + 'lastpos [as pos but last occurence, example: lastpos(''l'',''hello'') = 4]' + sLineBreak;
  Help := Help + 'if [if statement, example: if(1<2,7,8) = 7]';
  ShowMessage(Help);
end;

procedure TfrmCalc.mnuClearClick(Sender: TObject);
begin
  //StringGrid
  strgrd.Cols[0].Clear;
  strgrd.RowCount := 1;
  EqCount := 0;
  //Current expression
  edtEq.Text := '';
end;

procedure TfrmCalc.mnuGraphClick(Sender: TObject);
begin
  if frmGraph.Visible = False then
    frmGraph.Visible := True
  else
    frmGraph.Visible := False;
end;

end.

