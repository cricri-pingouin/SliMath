unit Graph;

interface

uses
  Windows, SysUtils, Forms, Graphics, ParseExpr, Dialogs, Classes, Controls,
  ExtCtrls, Menus, ExtDlgs;

type
  TfrmGraph = class(TForm)
    imgGraph: TImage;
    mnuGraph: TMainMenu;
    mniDraw: TMenuItem;
    mniGraphOpt: TMenuItem;
    savPicDlg: TSavePictureDialog;
    mnuSave: TMenuItem;
    mnuGraphList: TMenuItem;
    function XToBMP(RealX: Double): Integer;
    function YToBMP(RealY: Double): Integer;
    procedure DrawGraph();
    procedure mniDrawClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mniGraphOptClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuGraphListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  FloatLimit = 1E6;

var
  frmGraph: TfrmGraph;
  Xscale, Yscale: Double;

implementation

uses
  SharedGlobal, GraphList, GraphOpt, PNGImage;

{$R *.dfm}

function TfrmGraph.XToBMP(RealX: Double): Integer;
begin
  //Not elegant, but need way to limit real value that gets converted to integer
  //Integer: -2,147,483,648 to 2,147,483,647
  if (RealX < -FloatLimit) then
    RealX := -FloatLimit;
  if (RealX > FloatLimit) then
    RealX := FloatLimit;
  Result := Trunc((RealX - Xmin) * Xscale);
end;

function TfrmGraph.YToBMP(RealY: Double): Integer;
begin
  //See comments above for X
  if (RealY < -FloatLimit) then
    RealY := -FloatLimit;
  if (RealY > FloatLimit) then
    RealY := FloatLimit;
  Result := Trunc(imgGraph.Height - (RealY - Ymin) * Yscale);
end;

procedure TfrmGraph.DrawGraph();
var
  X, Y: Double; //Functions and parametric
  StartX, EndX, Rx, Ry, VarStep: Double; //Parametric and polar
  i, j, GraphNum: Integer;
  NewStart: Boolean;
  //List: TStrings;
  GraphParser: TExpressionParser;
begin
  //Initialise TBitmap
  imgGraph.Canvas.Brush.Color := BackgroundColour;
  imgGraph.Canvas.FillRect(ClientRect);
  //Draw grid
  if DrawGrid then
  begin
    imgGraph.Canvas.Pen.Color := GridColour;
    imgGraph.Canvas.Pen.Width := GridThick;
    imgGraph.Canvas.MoveTo(XToBMP(Xmin), YToBMP(0));
    imgGraph.Canvas.LineTo(XToBMP(Xmax), YToBMP(0));
    imgGraph.Canvas.MoveTo(XToBMP(0), YToBMP(Ymin));
    imgGraph.Canvas.LineTo(XToBMP(0), YToBMP(Ymax));
    if (XAxisScale > 0) then
    begin
      if (Xmin < -XAxisScale) then
      begin
        X := -XAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(X), YToBMP(Ymin));
          imgGraph.Canvas.LineTo(XToBMP(X), YToBMP(Ymax));
          X := X - XAxisScale;
        until X <= Xmin;
      end;
      if (Xmax > XAxisScale) then
      begin
        X := XAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(X), YToBMP(Ymin));
          imgGraph.Canvas.LineTo(XToBMP(X), YToBMP(Ymax));
          X := X + XAxisScale;
        until X >= Xmax;
      end;
    end;
    if (YAxisScale > 0) then
    begin
      if (Ymin < -YAxisScale) then
      begin
        Y := -YAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(Xmin), YToBMP(Y));
          imgGraph.Canvas.LineTo(XToBMP(Xmax), YToBMP(Y));
          Y := Y - YAxisScale;
        until Y <= Ymin;
      end;
      if (Ymax > YAxisScale) then
      begin
        Y := YAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(Xmin), YToBMP(Y));
          imgGraph.Canvas.LineTo(XToBMP(Xmax), YToBMP(Y));
          Y := Y + YAxisScale;
        until Y >= Ymax;
      end;
    end;
  end;
  //Draw tick marks
  if DrawTicks then
  begin
    imgGraph.Canvas.Pen.Color := TicksColour;
    imgGraph.Canvas.Pen.Width := TicksThick;
    if (XAxisScale > 0) then
    begin
      if (Xmin < -XAxisScale) then
      begin
        X := -XAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(X), YToBMP(-ScaleMarkSize));
          imgGraph.Canvas.LineTo(XToBMP(X), YToBMP(ScaleMarkSize));
          X := X - XAxisScale;
        until X <= Xmin;
      end;
      if (Xmax > XAxisScale) then
      begin
        X := XAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(X), YToBMP(-ScaleMarkSize));
          imgGraph.Canvas.LineTo(XToBMP(X), YToBMP(ScaleMarkSize));
          X := X + XAxisScale;
        until X >= Xmax;
      end;
    end;
    if (YAxisScale > 0) then
    begin
      if (Ymin < -YAxisScale) then
      begin
        Y := -YAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(-ScaleMarkSize), YToBMP(Y));
          imgGraph.Canvas.LineTo(XToBMP(ScaleMarkSize), YToBMP(Y));
          Y := Y - YAxisScale;
        until Y <= Ymin;
      end;
      if (Ymax > YAxisScale) then
      begin
        Y := YAxisScale;
        repeat
          imgGraph.Canvas.MoveTo(XToBMP(-ScaleMarkSize), YToBMP(Y));
          imgGraph.Canvas.LineTo(XToBMP(ScaleMarkSize), YToBMP(Y));
          Y := Y + YAxisScale;
        until Y >= Ymax;
      end;
    end;
  end;
  //Draw axes
  if DrawAxes then
  begin
    imgGraph.Canvas.Pen.Color := AxesColour;
    imgGraph.Canvas.Pen.Width := AxesThick;
    imgGraph.Canvas.MoveTo(XToBMP(Xmin), YToBMP(0));
    imgGraph.Canvas.LineTo(XToBMP(Xmax), YToBMP(0));
    imgGraph.Canvas.MoveTo(XToBMP(0), YToBMP(Ymin));
    imgGraph.Canvas.LineTo(XToBMP(0), YToBMP(Ymax));
  end;
  //Draw labels
  if DrawLabels then
  begin
    imgGraph.Canvas.Font.Name := 'Courier';
    imgGraph.Canvas.Font.Size := 6;
    imgGraph.Canvas.Font.Color := LabelsColour; //Graph colour
    if (XAxisScale > 0) then
    begin
      if (Xmin < -XAxisScale) then
      begin
        X := -XAxisScale;
        repeat
          imgGraph.Canvas.TextOut(XToBMP(X) - 8, YToBMP(0) + 10, FloatToStr(X));
          X := X - XAxisScale;
        until X <= Xmin;
      end;
      if (Xmax > XAxisScale) then
      begin
        X := XAxisScale;
        repeat
          imgGraph.Canvas.TextOut(XToBMP(X) - 4, YToBMP(0) + 10, FloatToStr(X));
          X := X + XAxisScale;
        until X >= Xmax;
      end;
    end;
    if (YAxisScale > 0) then
    begin
      if (Ymin < -YAxisScale) then
      begin
        Y := -YAxisScale;
        repeat
          imgGraph.Canvas.TextOut(XToBMP(0) + 10, YToBMP(Y) - 6, FloatToStr(Y));
          Y := Y - YAxisScale;
        until Y <= Ymin;
      end;
      if (Ymax > YAxisScale) then
      begin
        Y := YAxisScale;
        repeat
          imgGraph.Canvas.TextOut(XToBMP(0) + 10, YToBMP(Y) - 6, FloatToStr(Y));
          Y := Y + YAxisScale;
        until Y >= Ymax;
      end;
    end;

  end;
  //Prepare parser
  GraphParser := TCstyleParser.Create;
  TCStyleParser(GraphParser).CStyle := False;
  GraphParser.DefineVariable('x', @X);
  GraphParser.Optimize := True; //Switch on optimization since we'll have many calls
  for GraphNum := 0 to 9 do
  begin
  {//Prepare equation
    List := TStringList.Create;
    ExtractStrings([';'], [], PChar(Eq), List); //Then can use List.Count and List[i] }
  //Calculate and plot
    if (GraphsList[GraphNum].Eq1 <> '') then
    begin
      imgGraph.Canvas.Pen.Color := GraphsList[GraphNum].GraphColour;
      imgGraph.Canvas.Pen.Width := GraphThick;
      if (GraphsList[GraphNum].GraphType = 'Polar') then
      begin //Polar, re-uses Y as R
        i := GraphParser.AddExpression(GraphsList[GraphNum].Eq1);
        StartX := GraphsList[GraphNum].LowBound;
        EndX := GraphsList[GraphNum].HighBound;
        VarStep := (EndX - StartX) / NumSamples;
        X := StartX - VarStep;
        repeat
          X := X + VarStep;
          FailsToCompute := False;
          Y := GraphParser.AsFloat[i];
          Rx := Y * Cos(X);
          Ry := Y * Sin(X);
        until (FailsToCompute <> True) or (X >= EndX);
        if (Interpolate = True) then
          imgGraph.Canvas.MoveTo(XToBMP(Rx), YToBMP(Ry))
        else
          imgGraph.Canvas.Pixels[XToBMP(Rx), YToBMP(Ry)] := GraphsList[GraphNum].GraphColour;
        NewStart := False;
        repeat
          X := X + VarStep;
          FailsToCompute := False;
          Y := GraphParser.AsFloat[i];
          Rx := Y * Cos(X);
          Ry := Y * Sin(X);
          if (FailsToCompute = True) then
            NewStart := True
          else
          begin
            if (Interpolate = True) and (NewStart = False) then
              imgGraph.Canvas.LineTo(XToBMP(Rx), YToBMP(Ry))
            else if (Interpolate = True) and (NewStart = True) then
              imgGraph.Canvas.MoveTo(XToBMP(Rx), YToBMP(Ry))
            else if (Interpolate = False) then
              imgGraph.Canvas.Pixels[XToBMP(Rx), YToBMP(Ry)] := GraphsList[GraphNum].GraphColour;
            NewStart := False;
          end;
        until X >= EndX;
      end
      else if (GraphsList[GraphNum].GraphType = 'Parametric') then
      begin //Parametric, re-uses Rx and Ry as X and Y
        if (GraphsList[GraphNum].Eq2 <> '') then
        begin
          i := GraphParser.AddExpression(GraphsList[GraphNum].Eq1);
          j := GraphParser.AddExpression(GraphsList[GraphNum].Eq2);
          StartX := GraphsList[GraphNum].LowBound;
          EndX := GraphsList[GraphNum].HighBound;
          VarStep := (EndX - StartX) / NumSamples;
          X := StartX - VarStep;
          repeat
            X := X + VarStep;
            FailsToCompute := False;
            Rx := GraphParser.AsFloat[i];
            Ry := GraphParser.AsFloat[j];
          until (FailsToCompute <> True) or (X >= EndX);
          if (Interpolate = True) then
            imgGraph.Canvas.MoveTo(XToBMP(Rx), YToBMP(Ry))
          else
            imgGraph.Canvas.Pixels[XToBMP(Rx), YToBMP(Ry)] := GraphsList[GraphNum].GraphColour;
          NewStart := False;
          repeat
            X := X + VarStep;
            FailsToCompute := False;
            Rx := GraphParser.AsFloat[i];
            Ry := GraphParser.AsFloat[j];
            if (FailsToCompute = True) then
              NewStart := True
            else
            begin
              if (Interpolate = True) and (NewStart = False) then
                imgGraph.Canvas.LineTo(XToBMP(Rx), YToBMP(Ry))
              else if (Interpolate = True) and (NewStart = True) then
                imgGraph.Canvas.MoveTo(XToBMP(Rx), YToBMP(Ry))
              else if (Interpolate = False) then
                imgGraph.Canvas.Pixels[XToBMP(Rx), YToBMP(Ry)] := GraphsList[GraphNum].GraphColour;
              NewStart := False;
            end;
          until X >= EndX;
        end;
      end
      else if (GraphsList[GraphNum].GraphType = 'Function') then
      begin //Function
        i := GraphParser.AddExpression(GraphsList[GraphNum].Eq1);
        VarStep := (Xmax - Xmin) / NumSamples;
        X := Xmin - VarStep;
        repeat
          X := X + VarStep;
          FailsToCompute := False;
          Y := GraphParser.AsFloat[i];
        until (FailsToCompute <> True) or (X >= Xmax);
        if (Interpolate = True) then
          imgGraph.Canvas.MoveTo(XToBMP(X), YToBMP(Y))
        else
          imgGraph.Canvas.Pixels[XToBMP(X), YToBMP(Y)] := GraphsList[GraphNum].GraphColour;
        NewStart := False;
        repeat
          X := X + VarStep;
          FailsToCompute := False;
          Y := GraphParser.AsFloat[i];
          if (FailsToCompute = True) then
            NewStart := True
          else
          begin
            if (Interpolate = True) and (NewStart = False) then
              imgGraph.Canvas.LineTo(XToBMP(X), YToBMP(Y))
            else if (Interpolate = True) and (NewStart = True) then
              imgGraph.Canvas.MoveTo(XToBMP(X), YToBMP(Y))
            else if (Interpolate = False) then
              imgGraph.Canvas.Pixels[XToBMP(X), YToBMP(Y)] := GraphsList[GraphNum].GraphColour;
            NewStart := False;
          end;
        until X >= Xmax;
      end;
    end;
  end;
  //Free parser
  GraphParser.Free;
  //List.Free;
end;

procedure TfrmGraph.FormCreate(Sender: TObject);
begin
  imgGraph.Picture.Bitmap.Width := imgGraph.Width;
  imgGraph.Picture.Bitmap.Height := imgGraph.Height;
end;

procedure TfrmGraph.FormResize(Sender: TObject);
begin
  imgGraph.Picture.Bitmap.Width := imgGraph.Width;
  imgGraph.Picture.Bitmap.Height := imgGraph.Height;
  Xscale := imgGraph.Width / (Xmax - Xmin);
  Yscale := imgGraph.Height / (Ymax - Ymin);
  DrawGraph();
end;

procedure TfrmGraph.FormShow(Sender: TObject);
begin
  Xscale := imgGraph.Width / (Xmax - Xmin);
  Yscale := imgGraph.Height / (Ymax - Ymin);
end;

procedure TfrmGraph.mniDrawClick(Sender: TObject);
begin
  DrawGraph();
end;

procedure TfrmGraph.mniGraphOptClick(Sender: TObject);
begin
  if frmGraphOptions.Visible = False then
    frmGraphOptions.Visible := True
  else
    frmGraphOptions.Visible := False;
end;

procedure TfrmGraph.mnuGraphListClick(Sender: TObject);
begin
  if frmGraphList.Visible = False then
    frmGraphList.Visible := True
  else
    frmGraphList.Visible := False;
end;

procedure TfrmGraph.mnuSaveClick(Sender: TObject);
var
  i: Integer;
  FileName: string;
  PNG: TPNGObject;
begin
  i := 0;
  repeat
    Inc(i);
    FileName := 'graph' + inttostr(i) + '.png';
  until not fileexists(FileName);
  PNG := TPNGObject.Create;
  try
    PNG.Assign(imgGraph.Picture.Bitmap);
    PNG.SaveToFile(FileName);
    ShowMessage('Graph saved in file ' + FileName);
  finally
    PNG.Free;
  end
end;

end.

