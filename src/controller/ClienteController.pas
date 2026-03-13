unit ClienteController;

interface

uses
  Cliente;

type
  TClienteController = class
  public
    function BuscarPorCodigo(ACodigo: Integer): TCliente;
  end;

implementation

uses
  ClienteDAO;

function TClienteController.BuscarPorCodigo(ACodigo: Integer): TCliente;
var
  DAO: TClienteDAO;
begin
  DAO := TClienteDAO.Create;
  try
    Result := DAO.BuscarPorCodigo(ACodigo);
  finally
    DAO.Free;
  end;
end;

end.
