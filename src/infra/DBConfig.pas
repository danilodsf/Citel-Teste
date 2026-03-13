unit DBConfig;

interface

type
  TDBConfig = class
  private
    FHost: string;
    FPort: Integer;
    FDatabase: string;
    FUser: string;
    FPassword: string;
  public
    constructor Create;

    property Host: string read FHost;
    property Port: Integer read FPort;
    property Database: string read FDatabase;
    property User: string read FUser;
    property Password: string read FPassword;
  end;

implementation

uses
  System.SysUtils,
  System.IniFiles,
  Vcl.Dialogs,
  System.UITypes,
  Vcl.Forms;

{ TDBConfig }

constructor TDBConfig.Create;
var
  Ini: TIniFile;
  Path: string;
begin
  Path := ExtractFilePath(ParamStr(0)) + 'database.ini';

  if not FileExists(Path) then
  begin
    MessageDlg('Arquivo de configuração "database.ini" não encontrado.' + sLineBreak +
      'Verifique se o arquivo existe na pasta do sistema.', mtError, [mbOK], 0);

    Application.Terminate;
    Halt;
  end;

  Ini := TIniFile.Create(Path);
  try

    FHost := Ini.ReadString('DATABASE', 'HOST', 'localhost');
    FPort := Ini.ReadInteger('DATABASE', 'PORT', 3306);
    FDatabase := Ini.ReadString('DATABASE', 'NAME', 'pedido_vendas');
    FUser := Ini.ReadString('DATABASE', 'USER', 'root');
    FPassword := Ini.ReadString('DATABASE', 'PASSWORD', '');

  finally
    Ini.Free;
  end;
end;

end.
