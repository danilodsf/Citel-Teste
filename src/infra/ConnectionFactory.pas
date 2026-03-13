unit ConnectionFactory;

interface

uses
  FireDAC.Comp.Client;

type
  TConnectionFactory = class
  private
    class var FConnection: TFDConnection;
    class function CreateConnection: TFDConnection;
  public
    class function GetQuery: TFDQuery;
  end;

implementation

uses
  DBConfig,
  SysUtils,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait;

class function TConnectionFactory.CreateConnection: TFDConnection;
var
  Config: TDBConfig;
begin
  Config := TDBConfig.Create;
  try

    Result := TFDConnection.Create(nil);

    Result.Params.DriverID := 'MySQL';
    Result.Params.Database := Config.Database;
    Result.Params.UserName := Config.User;
    Result.Params.Password := Config.Password;

    Result.Params.Add('Server=' + Config.Host);
    Result.Params.Add('Port=' + Config.Port.ToString);

    Result.LoginPrompt := False;

    Result.Connected := True;

  finally
    Config.Free;
  end;
end;

class function TConnectionFactory.GetQuery: TFDQuery;
begin
  if not Assigned(FConnection) then
    FConnection := CreateConnection;

  Result := TFDQuery.Create(nil);
  Result.Connection := FConnection;
end;

initialization

finalization
  FreeAndNil(TConnectionFactory.FConnection);

end.




