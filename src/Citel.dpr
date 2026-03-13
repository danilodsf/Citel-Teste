program Citel;

uses
  Vcl.Forms,
  Citel.View.Pedido in 'view\Citel.View.Pedido.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
