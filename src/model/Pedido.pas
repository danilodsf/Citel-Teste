unit Pedido;

interface

uses
  System.Generics.Collections,
  PedidoItem;

type
  TPedido = class
  private
    FNumero: Integer;
    FDataEmissao: TDateTime;
    FCodigoCliente: Integer;
    FValorTotal: Currency;
    FItens: TObjectList<TPedidoItem>;
  public
    constructor Create;
    destructor Destroy; override;

    property Numero: Integer read FNumero write FNumero;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
    property ValorTotal: Currency read FValorTotal write FValorTotal;

    property Itens: TObjectList<TPedidoItem> read FItens;
  end;

implementation

constructor TPedido.Create;
begin
  FItens := TObjectList<TPedidoItem>.Create(False);
end;

destructor TPedido.Destroy;
begin
  FItens.Free;
  inherited;
end;

end.
