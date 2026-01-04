unit VCLChildFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TVCLChildForm = class(TForm)
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
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
  VCLChildForm: TVCLChildForm;

implementation

uses System.Math;

constructor TVCLChildForm.Create(AOwner: TComponent); begin
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

procedure TVCLChildForm.DrawGradient( const ARect: TRect );
//
  function ARGB(A, R, G, B: Byte): TColor; begin
    Result := (A shl 24) or (R shl 16) or (G shl 8) or B;
  end;
//
var
  Bmp: TBitmap;
  X, Y, CenterX, CenterY, Diameter, AlphaStep: Integer;
  RadiusSquare: Double;
  CurrentAlpha: Byte;
begin   //  TVCLChildForm.DrawGradient(
  Bmp := TBitmap.Create;
  try
    Bmp.PixelFormat := pf32bit;
    Bmp.Width := ARect.Width;
    Bmp.Height := ARect.Height;
    // Вычисляем радиус окружности и квадрат расстояния
    Diameter := Min( ARect.Width, ARect.Height );
    RadiusSquare := Sqr( Diameter div 2 );
    // Рассчитываем шаг альфы для равномерного распределения
    AlphaStep := Trunc( RadiusSquare / ( FMaxOpacity / 100 ) );
    CenterX := Bmp.Width div 2;
    CenterY := Bmp.Height div 2;
    // Заполняем каждый пиксель согласно расстоянию от центра
    for Y := 0 to Bmp.Height - 1 do
    for X := 0 to Bmp.Width - 1 do begin
      // Расстояние от центра эллипса
      CurrentAlpha := EnsureRange( Trunc(
        255 - ( ( Sqrt( Sqr( X - CenterX ) + Sqr( Y - CenterY ) ) / RadiusSquare ) * AlphaStep ) ),
        0, 255 );
      // Прорисовка каждого пикселя с расчетной прозрачностью
      Bmp.Canvas.Pixels[ X, Y ] := ARGB( CurrentAlpha, 0, 0, 0 );
    end;
    // Отображение полученного градиента на канвас
    Canvas.StretchDraw( ARect, Bmp );
  finally Bmp.Free;
  end;
end;

procedure TVCLChildForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); begin
  if Button = mbLeft then begin
    FXOffset := X;
    FYOffset := Y;
  end;
end;

procedure TVCLChildForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then begin
    Left := Left + ( X - FXOffset );
    Top := Top + ( Y - FYOffset );
  end;
end;

procedure TVCLChildForm.FormPaint(Sender: TObject); begin
  DrawGradient(ClientRect);
end;

end.
