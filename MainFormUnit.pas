unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFormClass = class of TForm;

  TMainForm = class(TForm)
    ButtonOpenGDIP: TButton;
    TrackBarOpacity: TTrackBar;
    LabelOpacity: TLabel;
    ButtonOpenVCL: TButton;
    ButtonOpenLayered: TButton;
    procedure ButtonOpenGDIPClick(Sender: TObject);
    procedure ButtonOpenVCLClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarOpacityChange(Sender: TObject);
    procedure ButtonOpenLayeredClick(Sender: TObject);
  private
    FGDIPChildForm: TForm;
    FVCLChildForm: TForm;
    FLayeredForm: TForm;
    procedure ShowChild( var F: TForm; AClass: TFormClass );
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  GDIPChildFormUnit, VCLChildFormUnit, LayeredFormUnit;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  TrackBarOpacity.Min := 5;
  TrackBarOpacity.Max := 100;
  TrackBarOpacity.Position := 50;
end;

procedure TMainForm.ShowChild(var F: TForm; AClass: TFormClass ); begin
  if not Assigned( F ) then begin
    F := AClass.Create( Self );
    F.Show;
  end
  else
    F.Visible := not F.Visible;
end;

procedure TMainForm.TrackBarOpacityChange(Sender: TObject); begin
  LabelOpacity.Caption := Format( 'Непрозрачность: %d%%', [ TrackBarOpacity.Position ] );
  if Assigned( FGDIPChildForm ) then
  try TGDIPChildForm( FGDIPChildForm ).MaxOpacity := TrackBarOpacity.Position;
  except //
  end;
  if Assigned( FVCLChildForm ) then
  try TVCLChildForm( FVCLChildForm ).MaxOpacity :=  TrackBarOpacity.Position;
  except //
  end;
  if Assigned( FLayeredForm ) then
  try TLayeredForm( FLayeredForm ).SetAlphaLevel( TrackBarOpacity.Position );
  except //
  end;
end;

procedure TMainForm.ButtonOpenLayeredClick(Sender: TObject); begin
  ShowChild( FLayeredForm, TLayeredForm );
end;

procedure TMainForm.ButtonOpenGDIPClick(Sender: TObject); begin
  ShowChild( FGDIPChildForm, TGDIPChildForm );
end;

procedure TMainForm.ButtonOpenVCLClick(Sender: TObject); begin
  ShowChild( FVCLChildForm, TVCLChildForm );
end;

end.
