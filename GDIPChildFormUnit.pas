unit GDIPChildFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GDIPlusImport;

type
  TGDIPChildForm = class(TForm)
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);
  private
    FXOffset, FYOffset: Integer;
    FMaxOpacity: Integer;
    procedure DrawGradient(const ARect: TRect);
  public
    constructor Create( AOwner: TComponent ); override;
    property MaxOpacity: Integer read FMaxOpacity write FMaxOpacity;
  end;

var
  GDIPChildForm: TGDIPChildForm;

implementation

constructor TGDIPChildForm.Create( AOwner: TComponent ); begin
  inherited CreateNew( AOwner, 0 );
  BorderStyle := bsNone;
  Position := poScreenCenter;
  ClientWidth := 300;
  ClientHeight := 200;
  Color := clBlack;
  DoubleBuffered := True;
  OnMouseDown := FormMouseDown;
  OnMouseMove := FormMouseMove;
  OnPaint := FormPaint;
end;

procedure TGDIPChildForm.DrawGradient( const ARect: TRect );
var
  Points: array of TGdiPointF;
  Brush: TGPPathGradientBrush;
  Path: TGPPath;
  SurroundColors: TGPColorArray;
begin
  Canvas.Lock;
  try
    SetLength( Points, 3 ); // массив точек эллипса
    Points[ 0 ].X := ARect.Left + ( ARect.Right - ARect.Left ) / 2;
    Points[ 0 ].Y := ARect.Top + ( ARect.Bottom - ARect.Top ) / 2;
    Points[ 1 ].X := ARect.Left;
    Points[ 1 ].Y := ARect.Top;
    Points[ 2 ].X := ARect.Right;
    Points[ 2 ].Y := ARect.Bottom;
    Brush := TGPPathGradientBrush.Create( @Points[ 0 ], Length( Points ) );
    try
      // ÷ентр черного цвета с заданной непрозрачностью
      Brush.SetCenterColor(  MakeARGB(  Round( ( FMaxOpacity * 255 ) / 100 ), 0, 0, 0 ) );
      // ќбрамл€ющие точки прозрачные
      SetLength( SurroundColors, 3 );
      FillChar( SurroundColors, SizeOf( TGPColor ) * 3, 0 );
      Brush.SetSurroundColors( SurroundColors );
      // –исуем градиент
      Path := TGPPath.Create;
      Path.AddEllipse(  ARect.Left, ARect.Top, ARect.Width, ARect.Height );
      Brush.SetCenterPoint(  MakePointF(  ARect.Left + ARect.Width / 2, ARect.Top + ARect.Height / 2 ) );

      with TGPGraphics.Create( Canvas.Handle ) do
      try     FillRectangle( Brush.GetNativeBrush(  ), ARect.Left, ARect.Top, ARect.Width, ARect.Height );
      finally Free;
      end;
      Brush.Free;
    finally Path.Free;
    end;
  finally  Canvas.Unlock;
  end;
end;

procedure TGDIPChildForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    FXOffset := X;
    FYOffset := Y;
  end;
end;

procedure TGDIPChildForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ssLeft in Shift then begin
    Left := Left + (X - FXOffset);
    Top := Top + (Y - FYOffset);
  end;
end;

procedure TGDIPChildForm.FormPaint(Sender: TObject);
begin
  DrawGradient(ClientRect);
end;

end.
