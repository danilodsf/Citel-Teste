unit PedidoItemDAO;

interface

uses
  BaseDAO,
  PedidoItem,
  System.Generics.Collections;

type
  TPedidoItemDAO = class(TBaseDAO)
  public
    procedure ExcluirItem(ACodItem: integer);
    procedure InserirItens(APedido: integer; AItens: TObjectList<TPedidoItem>);
    procedure AlterarItens(APedido: integer; AItens: TObjectList<TPedidoItem>);
    function ListarItens(ANumeroPedido: integer): TObjectList<TPedidoItem>;
  end;

implementation

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Param;

procedure TPedidoItemDAO.AlterarItens(APedido: integer; AItens: TObjectList<TPedidoItem>);
var
  Q: TFDQuery;
  Item: TPedidoItem;
const
  SQL_INSERT = 'INSERT INTO pedido_produtos ' +
    '(numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' +
    'VALUES (:pedido, :produto, :qtd, :unit, :total)';
  SQL_UPDATE = 'UPDATE pedido_produtos SET quantidade = :qtd, valor_unitario = :unit, ' +
    'valor_total = :total WHERE id = :id';
begin
  Q := NewQuery;
  try
    for Item in AItens do
    begin
      if Item.Id = 0 then
      begin
        Q.SQL.Text := SQL_INSERT;
        Q.ParamByName('pedido').AsInteger := Item.NumeroPedido;
        Q.ParamByName('produto').AsInteger := Item.CodigoProduto;
      end
      else
      begin
        Q.SQL.Text := SQL_UPDATE;
        Q.ParamByName('id').AsInteger := Item.Id;
      end;

      Q.ParamByName('qtd').AsFloat := Item.Quantidade;
      Q.ParamByName('unit').AsCurrency := Item.ValorUnitario;
      Q.ParamByName('total').AsCurrency := Item.ValorTotal;

      Q.ExecSQL;
    end;

  finally
    Q.Free;
  end;
end;

procedure TPedidoItemDAO.ExcluirItem(ACodItem: integer);
var
  Q: TFDQuery;
begin
  Q := NewQuery;
  try
    Q.SQL.Text := 'delete from pedido_produtos where id = :id';
    Q.ParamByName('id').AsInteger := ACodItem;
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TPedidoItemDAO.InserirItens(APedido: integer; AItens: TObjectList<TPedidoItem>);
var
  Q: TFDQuery;
  Item: TPedidoItem;
begin
  Q := NewQuery;
  try

    Q.SQL.Text := 'INSERT INTO pedido_produtos ' +
      '(numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' +
      'VALUES (:pedido, :produto, :quantidade, :unitario, :total)';

    for Item in AItens do
    begin
      Q.ParamByName('pedido').AsInteger := APedido;
      Q.ParamByName('produto').AsInteger := Item.CodigoProduto;
      Q.ParamByName('quantidade').AsFloat := Item.Quantidade;
      Q.ParamByName('unitario').AsCurrency := Item.ValorUnitario;
      Q.ParamByName('total').AsCurrency := Item.ValorTotal;

      Q.ExecSQL;
    end;

  finally
    Q.Free;
  end;
end;

function TPedidoItemDAO.ListarItens(ANumeroPedido: integer): TObjectList<TPedidoItem>;
var
  Q: TFDQuery;
  Item: TPedidoItem;
begin

  Result := TObjectList<TPedidoItem>.Create(True);

  Q := NewQuery;
  try

    Q.SQL.Text := 'SELECT i.id, i.numero_pedido, i.codigo_produto, ' +
      'p.descricao, i.quantidade, i.valor_unitario, i.valor_total ' +
      'FROM pedido_produtos i JOIN produtos p ON p.codigo = i.codigo_produto ' +
      'WHERE i.numero_pedido = :pedido';

    Q.ParamByName('pedido').AsInteger := ANumeroPedido;

    Q.Open;

    while not Q.Eof do
    begin

      Item := TPedidoItem.Create;

      Item.Id := Q.FieldByName('id').AsInteger;
      Item.NumeroPedido := Q.FieldByName('numero_pedido').AsInteger;
      Item.CodigoProduto := Q.FieldByName('codigo_produto').AsInteger;
      Item.DescricaoProduto := Q.FieldByName('descricao').AsString;
      Item.Quantidade := Q.FieldByName('quantidade').AsInteger;
      Item.ValorUnitario := Q.FieldByName('valor_unitario').AsCurrency;
      Item.ValorTotal := Q.FieldByName('valor_total').AsCurrency;

      Result.Add(Item);

      Q.Next;

    end;

  finally
    Q.Free;
  end;
end;

end.
