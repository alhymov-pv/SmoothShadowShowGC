unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
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

procedure TMainForm.TrackBarOpacityChange(Sender: TObject);
begin
  LabelOpacity.Caption := Format( 'Непрозрачность: %d%%', [ TrackBarOpacity.Position ] );
end;

procedure TMainForm.ButtonOpenLayeredClick(Sender: TObject);
begin
  if not Assigned( FLayeredForm ) then begin
    FLayeredForm := TLayeredForm.Create( Self );
    FLayeredForm.Show;
  end
  else
    FLayeredForm.Hide;
end;

procedure TMainForm.ButtonOpenGDIPClick(Sender: TObject); begin
  if not Assigned( FGDIPChildForm ) then begin
    FGDIPChildForm := TGDIPChildForm.CreateForm( Self );
    FGDIPChildForm.Show;
  end
  else
    FGDIPChildForm.Hide;
end;

procedure TMainForm.ButtonOpenVCLClick(Sender: TObject); begin
  if not Assigned( FVCLChildForm ) then begin
    FVCLChildForm := TVCLChildForm.CreateForm( Self );
    FVCLChildForm.Show;
  end
  else
    FVCLChildForm.Hide;
end;

end.
