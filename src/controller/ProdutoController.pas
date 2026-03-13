unit ProdutoController;

interface

uses
  Produto;

type
  TProdutoController = class
  public
    function BuscarPorCodigo(ACodigo: Integer): TProduto;
    function ProdutoExiste(ACodigo: Integer): boolean;
  end;

implementation

uses
  ProdutoDAO;

function TProdutoController.BuscarPorCodigo(ACodigo: Integer): TProduto;
var
  DAO: TProdutoDAO;
begin
  DAO := TProdutoDAO.Create;
  try
    Result := DAO.BuscarPorCodigo(ACodigo);
  finally
    DAO.Free;
  end;
end;

function TProdutoController.ProdutoExiste(ACodigo: Integer): boolean;
var
  Produto: TProduto;
begin
  Produto := BuscarPorCodigo(ACodigo);
  try
    result := (Produto.Codigo > 0);
  finally
    Produto.Free;
  end;

end;

end.
