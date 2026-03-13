unit PedidoController;

interface

uses
  Pedido, PedidoItem, System.Generics.Collections;

type
  TPedidoController = class
  public
    procedure GravarPedido(ACodigoCliente: Integer; AItens: TObjectList<TPedidoItem>;
      ACodPedido: Integer = 0);
    function ProximoNumeroPedido: Integer;
    function BuscarPedido(ANumeroPedido: Integer): TPedido;
    function BuscarPedidos: TObjectList<TPedido>;
    procedure ExcluirPedido(ANumeroPedido: Integer);
  end;

implementation

uses
  PedidoDAO, System.SysUtils;

function TPedidoController.BuscarPedido(ANumeroPedido: Integer): TPedido;
var
  DAO: TPedidoDAO;
begin
  DAO := TPedidoDAO.Create;
  try
    result := DAO.BuscarPedido(ANumeroPedido);
  finally
    DAO.Free;
  end;
end;

function TPedidoController.BuscarPedidos: TObjectList<TPedido>;
var
  DAO: TPedidoDAO;
begin
  DAO := TPedidoDAO.Create;
  try
    result := DAO.BuscarPedidos;
  finally
    DAO.Free;
  end;
end;

procedure TPedidoController.ExcluirPedido(ANumeroPedido: Integer);
var
  DAO: TPedidoDAO;
begin
  DAO := TPedidoDAO.Create;
  try
    DAO.ExcluirPedido(ANumeroPedido);
  finally
    DAO.Free;
  end;
end;

procedure TPedidoController.GravarPedido(ACodigoCliente: Integer; AItens: TObjectList<TPedidoItem>;
  ACodPedido: integer);
var
  Pedido: TPedido;
  Item: TPedidoItem;
  DAO: TPedidoDAO;
begin
  Pedido := TPedido.Create;

  try
    Pedido.Numero := ACodPedido;
    if (Pedido.Numero = 0) then
    begin
      Pedido.Numero := ProximoNumeroPedido;
      Pedido.DataEmissao := Date;
      Pedido.CodigoCliente := ACodigoCliente;
      Pedido.ValorTotal := 0;
    end;

    for Item in AItens do
      Pedido.ValorTotal := Pedido.ValorTotal + Item.ValorTotal;

    Pedido.Itens.AddRange(AItens);

    DAO := TPedidoDAO.Create;

    try
      if (ACodPedido = 0) then
        DAO.Inserir(Pedido)
      else
        DAO.Alterar(Pedido);
    finally
      DAO.Free;
    end;

  finally
    Pedido.Free;
  end;

end;

function TPedidoController.ProximoNumeroPedido: Integer;
var
  DAO: TPedidoDAO;
begin
  DAO := TPedidoDAO.Create;
  try
    result := DAO.ProximoNumero;
  finally
    DAO.Free;
  end;
end;

end.
