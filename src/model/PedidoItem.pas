unit Pedidoitem;

interface

type
  TPedidoItem = class
  private
    FId: Integer;
    FNumeroPedido: Integer;
    FCodigoProduto: Integer;
    FDescricaoProduto: string;
    FQuantidade: Integer;
    FValorUnitario: Currency;
    FValorTotal: Currency;
  public
    property Id: Integer read FId write FId;
    property NumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
    property CodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
    property DescricaoProduto: string read FDescricaoProduto write FDescricaoProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Currency read FValorUnitario write FValorUnitario;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
  end;

implementation

end.
