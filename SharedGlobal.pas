unit SharedGlobal;
interface
uses Graphics;
	
 type
   TGraph = record
     GraphType : string;
     Eq1  : string;
     Eq2: string;
     LowBound: Double;
     HighBound: Double;
     GraphColour: TColor;
   end;

 var
   GraphsList : array[0..9] of TGraph;
   FailsToCompute: Boolean;
   //Graphs settings
   Xmin, Xmax, Ymin, Ymax, XAxisScale, YAxisScale, ScaleMarkSize: Double;
   BackgroundColour, AxesColour, GridColour, TicksColour, LabelsColour: TColor;
   NumSamples, GraphThick, AxesThick, GridThick, TicksThick: Integer;
   DrawAxes, DrawGrid, DrawTicks, DrawLabels, Interpolate: Boolean;

implementation

end.
