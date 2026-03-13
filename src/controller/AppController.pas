unit AppController;

interface

uses
  ClienteController,
  ProdutoController,
  PedidoController,
  PedidoItemController;

type
  TAppController = class
  private
    FCliente: TClienteController;
    FProduto: TProdutoController;
    FPedido: TPedidoController;
    FPedidoItem: TPedidoItemController;
  public
    constructor Create;
    destructor Destroy; override;

    property Cliente: TClienteController read FCliente;
    property Produto: TProdutoController read FProduto;
    property Pedido: TPedidoController read FPedido;
    property PedidoItem: TPedidoItemController read FPedidoItem;
  end;

implementation

{ TAppController }

constructor TAppController.Create;
begin
  FCliente := TClienteController.Create;
  FProduto := TProdutoController.Create;
  FPedido := TPedidoController.Create;
  FPedidoItem := TPedidoItemController.Create;
end;

destructor TAppController.Destroy;
begin
  FCliente.Free;
  FProduto.Free;
  FPedido.Free;
  FPedidoItem.Free;
  inherited;
end;

end.
