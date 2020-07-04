program SliMath;

uses
  Forms,
  Graph in 'Graph.pas' {frmGraph},
  oObjects in 'oObjects.pas',
  ParseClass in 'ParseClass.pas',
  ParseExpr in 'ParseExpr.pas',
  GraphOpt in 'GraphOpt.pas' {frmGraphOptions},
  Calculate in 'Calculate.pas' {frmCalc},
  pngimage in 'png\pngimage.pas',
  zlibpas in 'png\zlibpas.pas',
  pnglang in 'png\pnglang.pas',
  GraphList in 'GraphList.pas' {frmGraphList},
  SharedGlobal in 'SharedGlobal.pas';

{$R *.res}
{$SetPEFlags 1}

begin
  Application.Initialize;
  Application.Title := 'SliMath';
  Application.CreateForm(TfrmCalc, frmCalc);
  Application.CreateForm(TfrmGraph, frmGraph);
  Application.CreateForm(TfrmGraphOptions, frmGraphOptions);
  Application.CreateForm(TfrmGraphList, frmGraphList);
  Application.Run;
end.
