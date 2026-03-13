unit BaseDAO;

interface

uses
  FireDAC.Comp.Client;

type
  TBaseDAO = class
  protected
    function NewQuery: TFDQuery;
  end;

implementation

uses
  ConnectionFactory;

function TBaseDAO.NewQuery: TFDQuery;
begin
  Result := TConnectionFactory.GetQuery;
end;

end.
