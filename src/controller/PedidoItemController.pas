unit PedidoItemController;

interface

type
  TPedidoItemController = class
  public
    procedure ExcluirItem(ACodItem: Integer);
  end;

implementation

{ TPedidoItemController }

uses PedidoItemDAO;

procedure TPedidoItemController.ExcluirItem(ACodItem: Integer);
var
  DAO: TPedidoItemDAO;
begin
  DAO := TPedidoItemDAO.Create;
  try
    DAO.ExcluirItem(ACodItem);
  finally
    DAO.Free;
  end;
end;

end.
