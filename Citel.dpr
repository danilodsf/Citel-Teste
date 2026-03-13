program Citel;

uses
  Vcl.Forms,
  Citel.View.Pedido in 'src\view\Citel.View.Pedido.pas' {FrmMain},
  ConnectionFactory in 'src\infra\ConnectionFactory.pas',
  DBConfig in 'src\infra\DBConfig.pas',
  BaseDAO in 'src\dao\BaseDAO.pas',
  ProdutoDAO in 'src\dao\ProdutoDAO.pas',
  Produto in 'src\model\Produto.pas',
  Cliente in 'src\model\Cliente.pas',
  PedidoItem in 'src\model\PedidoItem.pas',
  Pedido in 'src\model\Pedido.pas',
  PedidoDAO in 'src\dao\PedidoDAO.pas',
  PedidoItemDAO in 'src\dao\PedidoItemDAO.pas',
  ClienteDAO in 'src\dao\ClienteDAO.pas',
  ClienteController in 'src\controller\ClienteController.pas',
  ProdutoController in 'src\controller\ProdutoController.pas',
  PedidoController in 'src\controller\PedidoController.pas',
  AppController in 'src\controller\AppController.pas',
  PedidoItemController in 'src\controller\PedidoItemController.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
