unit PedidoDAO;

interface

uses
  BaseDAO,
  Pedido,
  System.Generics.Collections;

type
  TPedidoDAO = class(TBaseDAO)
  public
    procedure Inserir(APedido: TPedido);
    procedure Alterar(APedido: TPedido);
    function ProximoNumero: Integer;
    function BuscarPedido(ANumeroPedido: Integer): TPedido;
    function BuscarPedidos: TObjectList<TPedido>;
    procedure ExcluirPedido(ANumeroPedido: Integer);
  end;

implementation

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  PedidoItemDAO,
  Data.DB, PedidoItem;

procedure TPedidoDAO.Alterar(APedido: TPedido);
var
  Q: TFDQuery;
  ItemDAO: TPedidoItemDAO;
begin

  Q := NewQuery;

  try
    Q.Connection.StartTransaction;
    try

      Q.SQL.Text := 'update pedidos set valor_total = :total where numero_pedido = :numero ';

      Q.ParamByName('numero').AsInteger := APedido.Numero;
      Q.ParamByName('total').AsCurrency := APedido.ValorTotal;

      Q.ExecSQL;

      ItemDAO := TPedidoItemDAO.Create;

      try
        ItemDAO.AlterarItens(APedido.Numero, APedido.Itens);
      finally
        ItemDAO.Free;
      end;

      Q.Connection.Commit;

    except
      Q.Connection.Rollback;
      raise;
    end;

  finally
    Q.Free;
  end;
end;

function TPedidoDAO.BuscarPedido(ANumeroPedido: Integer): TPedido;
var
  Q: TFDQuery;
  ItemDAO: TPedidoItemDAO;
  ListaItens: TObjectList<TPedidoItem>;
  PedidoItem: TPedidoItem;
  I: Integer;
begin
  Result := nil;
  Q := NewQuery;

  try

    Q.SQL.Text := 'SELECT numero_pedido, data_emissao, codigo_cliente, valor_total ' +
      'FROM pedidos WHERE numero_pedido = :pnumero_pedido';
    Q.ParamByName('pnumero_pedido').AsInteger := ANumeroPedido;
    Q.Open;

    if Q.IsEmpty then
      exit;

    Result := TPedido.Create;

    Result.Numero := Q.FieldByName('numero_pedido').AsInteger;
    Result.DataEmissao := Q.FieldByName('data_emissao').AsDateTime;
    Result.CodigoCliente := Q.FieldByName('codigo_cliente').AsInteger;
    Result.ValorTotal := Q.FieldByName('valor_total').AsCurrency;

    ItemDAO := TPedidoItemDAO.Create;

    try
      ListaItens := ItemDAO.ListarItens(Result.Numero);
      try
        for I := 0 to Pred(ListaItens.Count) do
        begin
          PedidoItem := TPedidoItem.Create;
          PedidoItem.Id := ListaItens[I].Id;
          PedidoItem.NumeroPedido := ListaItens[I].NumeroPedido;
          PedidoItem.CodigoProduto := ListaItens[I].CodigoProduto;
          PedidoItem.DescricaoProduto := ListaItens[I].DescricaoProduto;
          PedidoItem.Quantidade := ListaItens[I].Quantidade;
          PedidoItem.ValorUnitario := ListaItens[I].ValorUnitario;
          PedidoItem.ValorTotal := ListaItens[I].ValorTotal;
          Result.Itens.Add(PedidoItem);
        end;

      finally
        ListaItens.Free;
      end;
    finally
      ItemDAO.Free;
    end;

  finally
    Q.Free;
  end;
end;

function TPedidoDAO.BuscarPedidos: TObjectList<TPedido>;
var
  Q: TFDQuery;
  ItemDAO: TPedidoItemDAO;
  Pedido: TPedido;
  ListaItens: TObjectList<TPedidoItem>;
begin
  Result := nil;

  Q := NewQuery;

  try

    Q.SQL.Text := 'SELECT numero_pedido, data_emissao, codigo_cliente, valor_total ' +
      'FROM pedidos';

    Q.Open;

    if Q.IsEmpty then
      exit;

    Result := TObjectList<TPedido>.Create(True);

    while not Q.Eof do
    begin

      Pedido := TPedido.Create;

      Pedido.Numero := Q.FieldByName('numero_pedido').AsInteger;
      Pedido.DataEmissao := Q.FieldByName('data_emissao').AsDateTime;
      Pedido.CodigoCliente := Q.FieldByName('codigo_cliente').AsInteger;
      Pedido.ValorTotal := Q.FieldByName('valor_total').AsCurrency;

      ItemDAO := TPedidoItemDAO.Create;

      try

        ListaItens := ItemDAO.ListarItens(Pedido.Numero);

        try
          Pedido.Itens.AddRange(ListaItens);
        finally
          ListaItens.Free;
        end;

      finally
        ItemDAO.Free;
      end;

      Result.Add(Pedido);

      Q.Next;

    end;

  finally
    Q.Free;
  end;

end;

procedure TPedidoDAO.ExcluirPedido(ANumeroPedido: Integer);
var
  Q: TFDQuery;
begin

  Q := NewQuery;

  try
    Q.Connection.StartTransaction;
    try
      Q.SQL.Text := 'DELETE FROM pedido_produtos WHERE numero_pedido = :pedido';
      Q.ParamByName('pedido').AsInteger := ANumeroPedido;
      Q.ExecSQL;

      Q.SQL.Text := 'DELETE FROM pedidos WHERE numero_pedido = :pedido';
      Q.ParamByName('pedido').AsInteger := ANumeroPedido;
      Q.ExecSQL;

      Q.Connection.Commit;
    except
      Q.Connection.Rollback;
      raise;
    end;

  finally
    Q.Free;
  end;
end;

procedure TPedidoDAO.Inserir(APedido: TPedido);
var
  Q: TFDQuery;
  ItemDAO: TPedidoItemDAO;
begin

  Q := NewQuery;

  try
    Q.Connection.StartTransaction;
    try

      Q.SQL.Text := 'INSERT INTO pedidos ' +
        '(numero_pedido, data_emissao, codigo_cliente, valor_total) ' +
        'VALUES (:numero, :data, :cliente, :total)';

      Q.ParamByName('numero').AsInteger := APedido.Numero;
      Q.ParamByName('data').AsDate := APedido.DataEmissao;
      Q.ParamByName('cliente').AsInteger := APedido.CodigoCliente;
      Q.ParamByName('total').AsCurrency := APedido.ValorTotal;

      Q.ExecSQL;

      ItemDAO := TPedidoItemDAO.Create;

      try
        ItemDAO.InserirItens(APedido.Numero, APedido.Itens);
      finally
        ItemDAO.Free;
      end;

      Q.Connection.Commit;

    except
      Q.Connection.Rollback;
      raise;
    end;

  finally
    Q.Free;
  end;
end;

function TPedidoDAO.ProximoNumero: Integer;
var
  Q: TFDQuery;
begin
  Q := NewQuery;

  try

    Q.SQL.Text := 'SELECT IFNULL(MAX(numero_pedido),0) + 1 numero ' + 'FROM pedidos';

    Q.Open;

    Result := Q.FieldByName('numero').AsInteger;

  finally
    Q.Free;
  end;
end;

end.
