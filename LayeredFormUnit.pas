unit LayeredFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Math;

type
  TLayeredForm = class(TForm)
  private
    FBitmap: TBitmap;
    FAlphaLevel: Byte;
    procedure UpdateLayeredWindow;
    procedure WMEraseBkgnd( var Message: TWMEraseBkgnd ); message WM_ERASEBKGND;
    procedure WMNCHitTest( var Msg: TWMNCHitTest ); message WM_NCHITTEST;
    procedure PaintHandler( Sender: TObject );
  protected
    procedure CreateParams( var Params: TCreateParams ); override;
  public
    constructor Create( AOwner: TComponent ); override;
    destructor Destroy; override;
    procedure SetAlphaLevel( Value: Byte );
  end;

var
  LayeredForm: TLayeredForm;

implementation

constructor TLayeredForm.Create( AOwner: TComponent );
begin
  inherited Create(AOwner);
  BorderStyle := bsNone;
  Position := poScreenCenter;
  ClientWidth := 300;
  ClientHeight := 200;
  Color := clBlack;
  DoubleBuffered := True;
  FBitmap := TBitmap.Create;
  FBitmap.PixelFormat := pf32bit;
  FBitmap.Width := Width;
  FBitmap.Height := Height;
  FAlphaLevel := 128; // Начальная прозрачность (полупрозрачная)
  OnPaint := PaintHandler;
end;

destructor TLayeredForm.Destroy; begin
  FBitmap.Free;
  inherited Destroy;
end;

procedure TLayeredForm.UpdateLayeredWindow;
var
  BlendFunction: TBlendFunction;
  DC: HDC;
begin
  if HandleAllocated then begin
    DC := GetDC( Handle );
    try
      FBitmap.Canvas.Brush.Style := bsSolid;
      FBitmap.Canvas.Brush.Color := clBlack;
      FBitmap.Canvas.FillRect( Rect( 0, 0, FBitmap.Width, FBitmap.Height ) );
      BlendFunction.BlendOp := AC_SRC_OVER;
      BlendFunction.BlendFlags := 0;
      BlendFunction.SourceConstantAlpha := FAlphaLevel;
      BlendFunction.AlphaFormat := AC_SRC_ALPHA;
      Windows.UpdateLayeredWindow( Handle, DC, nil, nil, FBitmap.Canvas.Handle, nil, 0, @BlendFunction, ULW_ALPHA );
    finally ReleaseDC( Handle, DC );
    end;
  end;
end;

procedure TLayeredForm.WMEraseBkgnd(var Message: TWMEraseBkgnd); begin
  // Пропускаем стандартную очистку фона, так как сами обновляем слои
  Message.Result := 1;
end;

procedure TLayeredForm.WMNCHitTest(var Msg: TWMNCHitTest); begin
  inherited;
  Msg.Result := HTCAPTION; // Пользователь сможет двигать окно кликая в любом месте
end;

procedure TLayeredForm.PaintHandler(Sender: TObject); begin
  // Ничего особенного, обновление прозрачного состояния достаточно для отрисовки
  UpdateLayeredWindow;
end;

procedure TLayeredForm.CreateParams(var Params: TCreateParams); begin
  inherited CreateParams( Params );
  Params.ExStyle := Params.ExStyle or WS_EX_LAYERED;
end;

procedure TLayeredForm.SetAlphaLevel( Value: Byte ); begin
  FAlphaLevel := Value;
  UpdateLayeredWindow;
end;

end.
