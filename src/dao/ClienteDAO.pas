unit ClienteDAO;

interface

uses
  BaseDAO,
  Cliente;

type
  TClienteDAO = class(TBaseDAO)
  public
    function BuscarPorCodigo(ACodigo: Integer): TCliente;
  end;

implementation

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Data.DB;

function TClienteDAO.BuscarPorCodigo(ACodigo: Integer): TCliente;
var
  Q: TFDQuery;
begin
  Result := nil;

  Q := NewQuery;
  try

    Q.SQL.Text :=
      'SELECT codigo, nome, cidade, uf ' +
      'FROM clientes ' +
      'WHERE codigo = :codigo';

    Q.ParamByName('codigo').AsInteger := ACodigo;

    Q.Open;

    if not Q.IsEmpty then
    begin
      Result := TCliente.Create;

      Result.Codigo := Q.FieldByName('codigo').AsInteger;
      Result.Nome := Q.FieldByName('nome').AsString;
      Result.Cidade := Q.FieldByName('cidade').AsString;
      Result.UF := Q.FieldByName('uf').AsString;
    end;

  finally
    Q.Free;
  end;
end;

end.
