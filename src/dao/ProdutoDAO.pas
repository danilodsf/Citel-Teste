unit ProdutoDAO;

interface

uses
  Produto,
  BaseDAO,
  System.Generics.Collections;

type
  TProdutoDAO = class(TBaseDAO)
  public
    function BuscarPorCodigo(ACodigo: Integer): TProduto;
    function ListarTodos: TObjectList<TProduto>;
  end;

implementation

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Data.DB,
  SysUtils;

function TProdutoDAO.BuscarPorCodigo(ACodigo: Integer): TProduto;
var
  Q: TFDQuery;
begin
  Result := nil;

  Q := NewQuery;
  try
    Q.SQL.Text :=
      'SELECT codigo, descricao, preco_venda ' +
      'FROM produtos ' +
      'WHERE codigo = :codigo';

    Q.ParamByName('codigo').AsInteger := ACodigo;

    Q.Open;

    if not Q.IsEmpty then
    begin
      Result := TProduto.Create;
      Result.Codigo := Q.FieldByName('codigo').AsInteger;
      Result.Descricao := Q.FieldByName('descricao').AsString;
      Result.PrecoVenda := Q.FieldByName('preco_venda').AsCurrency;
    end;

  finally
    Q.Free;
  end;
end;

function TProdutoDAO.ListarTodos: TObjectList<TProduto>;
var
  Q: TFDQuery;
  Produto: TProduto;
begin
  Result := TObjectList<TProduto>.Create;

  Q := NewQuery;
  try

    Q.SQL.Text :=
      'SELECT codigo, descricao, preco_venda ' +
      'FROM produtos ' +
      'ORDER BY descricao';

    Q.Open;

    while not Q.Eof do
    begin
      Produto := TProduto.Create;

      Produto.Codigo := Q.FieldByName('codigo').AsInteger;
      Produto.Descricao := Q.FieldByName('descricao').AsString;
      Produto.PrecoVenda := Q.FieldByName('preco_venda').AsCurrency;

      Result.Add(Produto);

      Q.Next;
    end;

  finally
    Q.Free;
  end;
end;

end.
