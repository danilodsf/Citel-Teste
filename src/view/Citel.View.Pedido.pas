unit Citel.View.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Buttons, Data.DB, Vcl.Grids, Vcl.DBGrids, AppController, System.Actions, Vcl.ActnList,
  Vcl.NumberBox, PedidoItem, System.Generics.Collections, Datasnap.DBClient;

type
  TFrmMain = class(TForm)
    pnlMain: TPanel;
    pnlHeader: TPanel;
    pnlImg: TPanel;
    imgLogo: TImage;
    pnlTitle: TPanel;
    lblTitle: TLabel;
    pnlNroPedido: TPanel;
    pnlNroPedidoSelecionado: TPanel;
    pnlNroPedidoDesc: TPanel;
    lblNroPedidoDesc: TLabel;
    lblNroPedidoSelecionado: TLabel;
    pnlContent: TPanel;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    pnlCliente: TPanel;
    pnlTituloCliente: TPanel;
    lblTituloCliente: TLabel;
    lblCodigoCliente: TLabel;
    edtClienteCodigo: TEdit;
    lblPedidoNome: TLabel;
    edtClienteNome: TEdit;
    lblClienteCidade: TLabel;
    edtClienteCidade: TEdit;
    lblClienteUF: TLabel;
    edtClienteUF: TEdit;
    pnlProdutos: TPanel;
    pnlTituloProdutos: TPanel;
    lblTituloProdutos: TLabel;
    gdProdutos: TDBGrid;
    pnlPedidoResumo: TPanel;
    pnlResumoPedTot: TPanel;
    pnlResumoPedTotLeft: TPanel;
    lblValorTotalDesc: TLabel;
    pnlResumoPedTotRight: TPanel;
    lblValorTotalPedido: TLabel;
    pnlPesquisaPedido: TPanel;
    lblBuscarNumero: TLabel;
    pnlTituloPesquisaPedido: TPanel;
    lblPesquisaPedidoTitulo: TLabel;
    edtBuscarNumero: TEdit;
    pnlHistoricoPedido: TPanel;
    pnlTituloHistorico: TPanel;
    lblHistoricoPedidos: TLabel;
    gdHistoricoPedido: TDBGrid;
    pnlContentPedido: TPanel;
    pnlGravar: TPanel;
    pnlLine: TPanel;
    btnGravarPedido: TBitBtn;
    btnCancelar: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btBuscPedido: TBitBtn;
    pnlProdutoInserir: TPanel;
    lblCodProduto: TLabel;
    edtCodProduto: TEdit;
    btnBuscarProduto: TBitBtn;
    lblValorUnitario: TLabel;
    edtQtdeProduto: TEdit;
    lblQtdeProduto: TLabel;
    ActionList1: TActionList;
    actBuscarCliente: TAction;
    actBuscarProduto: TAction;
    btnInserirProduto: TBitBtn;
    Label1: TLabel;
    edtDescricaoProduto: TEdit;
    actInserirProduto: TAction;
    edtValorUnitario: TNumberBox;
    dsPedidoItem: TDataSource;
    cdsPedidoItem: TClientDataSet;
    cdsPedidoItemCODPRODUTO: TIntegerField;
    cdsPedidoItemQTDE: TIntegerField;
    cdsPedidoItemDESCRICAO: TStringField;
    cdsPedidoItemVALOR_UNIT: TCurrencyField;
    cdsPedidoItemVALOR_TOTAL: TCurrencyField;
    actInserirPedido: TAction;
    actCancelarPedido: TAction;
    dsPedidos: TDataSource;
    cdsPedidos: TClientDataSet;
    cdsPedidosNROPEDIDO: TIntegerField;
    cdsPedidosDTEMISSAO: TDateField;
    cdsPedidosVALOR_TOTAL: TCurrencyField;
    actCarregarPedido: TAction;
    cdsPedidoItemID: TIntegerField;
    btnExcluir: TBitBtn;
    actExcluirPedido: TAction;
    procedure edtClienteCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actBuscarClienteExecute(Sender: TObject);
    procedure edtCodProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actBuscarProdutoExecute(Sender: TObject);
    procedure edtClienteUFExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actInserirProdutoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtClienteCodigoExit(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actInserirPedidoExecute(Sender: TObject);
    procedure actCancelarPedidoExecute(Sender: TObject);
    procedure actCarregarPedidoExecute(Sender: TObject);
    procedure edtBuscarNumeroExit(Sender: TObject);
    procedure edtBuscarNumeroKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gdHistoricoPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsPedidosBeforeDelete(DataSet: TDataSet);
    procedure cdsPedidoItemBeforeDelete(DataSet: TDataSet);
    procedure edtClienteCodigoChange(Sender: TObject);
    procedure actExcluirPedidoExecute(Sender: TObject);
  private
    FAppController: TAppController;
    FItensPedido: TObjectList<TPedidoItem>;
    procedure limparDadosCliente(ASetFocus: Boolean = true);
    procedure limparDadosProduto(ASetFocus: Boolean = true);
    procedure AtualizarTotalPedido;
    procedure limparDadosPedido;
    procedure CarregarHistoricoPedidos;
    procedure AtualizarProduto(AIDProduto: integer);
    function LocalizarItemPorId(AId: integer): TPedidoItem;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  Cliente, Produto, Pedido, System.UITypes;

{$R *.dfm}

procedure TFrmMain.limparDadosCliente(ASetFocus: Boolean);
begin
  edtClienteCodigo.Clear;
  edtClienteNome.Clear;
  edtClienteCidade.Clear;
  edtClienteUF.Clear;

  if ASetFocus then
    edtClienteCodigo.SetFocus;
end;

procedure TFrmMain.limparDadosProduto(ASetFocus: Boolean);
begin
  edtCodProduto.Clear;
  edtQtdeProduto.Clear;
  edtValorUnitario.Clear;
  edtDescricaoProduto.Clear;

  if ASetFocus then
    edtCodProduto.SetFocus;
end;

procedure TFrmMain.limparDadosPedido;
begin
  limparDadosCliente(false);
  limparDadosProduto(false);
  cdsPedidoItem.EmptyDataSet;
  pnlNroPedido.Visible := false;
  edtBuscarNumero.Clear;

  FItensPedido.Clear;

  AtualizarTotalPedido;
end;

procedure TFrmMain.actBuscarClienteExecute(Sender: TObject);
var
  codCliente: integer;
  Cliente: TCliente;
begin
  if edtClienteCodigo.Text = '' then
    exit;

  codCliente := StrToIntDef(edtClienteCodigo.Text, 0);

  if not TryStrToInt(edtClienteCodigo.Text, codCliente) then
  begin
    ShowMessage('Código do cliente inválido.');
    limparDadosCliente;
    exit;
  end;

  Cliente := FAppController.Cliente.BuscarPorCodigo(codCliente);
  try
    if not Assigned(Cliente) then
    begin
      ShowMessage('Cliente não encontrado.');
      limparDadosCliente;
      exit;
    end;

    edtClienteNome.Text := Cliente.Nome;
    edtClienteCidade.Text := Cliente.Cidade;
    edtClienteUF.Text := Cliente.UF;

  finally
    Cliente.Free;
  end;
end;

procedure TFrmMain.actBuscarProdutoExecute(Sender: TObject);
var
  codProduto: integer;
  Produto: TProduto;
begin
  if edtCodProduto.Text = '' then
    exit;

  codProduto := StrToIntDef(edtCodProduto.Text, 0);

  if not TryStrToInt(edtCodProduto.Text, codProduto) then
  begin
    ShowMessage('Código do produto inválido.');
    limparDadosProduto;
    exit;
  end;

  Produto := FAppController.Produto.BuscarPorCodigo(codProduto);
  try
    if not Assigned(Produto) then
    begin
      ShowMessage('Produto não encontrado.');
      limparDadosProduto;
      exit;
    end;

    edtDescricaoProduto.Text := Produto.Descricao;
    edtValorUnitario.Value := Produto.PrecoVenda;
    edtQtdeProduto.Text := '1';
    edtQtdeProduto.SetFocus;

  finally
    Produto.Free;
  end;
end;

procedure TFrmMain.actCancelarPedidoExecute(Sender: TObject);
begin
  limparDadosPedido;
end;

procedure TFrmMain.actCarregarPedidoExecute(Sender: TObject);
var
  CodPedido: integer;
  Pedido: TPedido;
  PedidoItem: TPedidoItem;
begin
  if not TryStrToInt(edtBuscarNumero.Text, CodPedido) then
  begin
    ShowMessage('Número do pedido inválido.');
    edtBuscarNumero.SetFocus;
    exit;
  end;

  Pedido := FAppController.Pedido.BuscarPedido(CodPedido);
  try
    if not Assigned(Pedido) then
    begin
      ShowMessage('Pedido não encontrado.');
      edtBuscarNumero.SetFocus;
      exit;
    end;

    limparDadosPedido;

    pnlNroPedido.Visible := true;

    lblNroPedidoSelecionado.Caption := FormatFloat('000000', Pedido.Numero);
    edtClienteCodigo.Text := Pedido.CodigoCliente.ToString;
    actBuscarCliente.Execute;

    for PedidoItem in Pedido.Itens do
    begin
      cdsPedidoItem.Append;
      cdsPedidoItemID.AsInteger := PedidoItem.Id;
      cdsPedidoItemCODPRODUTO.AsInteger := PedidoItem.CodigoProduto;
      cdsPedidoItemQTDE.AsInteger := PedidoItem.Quantidade;
      cdsPedidoItemDESCRICAO.AsString := PedidoItem.DescricaoProduto;
      cdsPedidoItemVALOR_UNIT.AsCurrency := PedidoItem.ValorUnitario;
      cdsPedidoItemVALOR_TOTAL.AsCurrency := PedidoItem.ValorTotal;
      cdsPedidoItem.Post;
    end;
    FItensPedido.Clear;
    FItensPedido.AddRange(Pedido.Itens);

    Pedido.Itens.OwnsObjects := false;

    AtualizarTotalPedido;

    limparDadosProduto;
  finally
    Pedido.Free;
  end;
end;

procedure TFrmMain.actExcluirPedidoExecute(Sender: TObject);
var
  CodPedido: integer;
begin
  if (not pnlNroPedido.Visible) then
  begin
    ShowMessage('Você deve buscar um pedido para continuar');
    edtBuscarNumero.SetFocus;
    exit;
  end;

  TryStrToInt(lblNroPedidoSelecionado.Caption, CodPedido);

  if MessageDlg('Tem certeza que deseja excluir o pedido ' + CodPedido.ToString + ' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    FAppController.Pedido.ExcluirPedido(CodPedido);
    ShowMessage('Pedido excluído com sucesso!');
    CarregarHistoricoPedidos;
    limparDadosPedido;
    edtClienteCodigo.SetFocus;
  end;
end;

procedure TFrmMain.actInserirPedidoExecute(Sender: TObject);
var
  codCliente: integer;
  CodPedido: integer;
begin
  CodPedido := 0;

  if not TryStrToInt(edtClienteCodigo.Text, codCliente) then
  begin
    ShowMessage('É necessário preencher um cliente para continuar.');
    exit;
  end;

  if FItensPedido.Count = 0 then
  begin
    ShowMessage('Adicione pelo menos um produto ao pedido.');
    exit;
  end;

  try
    if pnlNroPedido.Visible then
      CodPedido := StrToInt(lblNroPedidoSelecionado.Caption);

    FAppController.Pedido.GravarPedido(codCliente, FItensPedido, CodPedido);

    limparDadosPedido;
    CarregarHistoricoPedidos;
    edtClienteCodigo.SetFocus;

    ShowMessage('Pedido gravado com sucesso.');

  except
    on E: Exception do
      ShowMessage('Erro ao gravar pedido: ' + E.Message);
  end;
end;

procedure TFrmMain.actInserirProdutoExecute(Sender: TObject);
var
  Item: TPedidoItem;
  qtd, codProduto: integer;
  valorUnit: Currency;
begin
  if not TryStrToInt(edtCodProduto.Text, codProduto) then
  begin
    ShowMessage('É necessário buscar um produto válido para continuar.');
    exit;
  end;

  if not TryStrToInt(edtQtdeProduto.Text, qtd) then
  begin
    ShowMessage('Quantidade inválida.');
    exit;
  end;

  if not TryStrToCurr(edtValorUnitario.Text, valorUnit) then
  begin
    ShowMessage('Valor unitário inválido.');
    exit;
  end;

  if edtCodProduto.Tag > 0 then
  begin
    if not MessageDlg('Tem certeza que deseja alterar o produto ?', mtConfirmation, [mbYes, mbNo],
      0) = mrYes then
      exit;

    AtualizarProduto(edtCodProduto.Tag);
    edtCodProduto.ReadOnly := false;
    edtDescricaoProduto.ReadOnly := false;
    edtCodProduto.Tag := 0;
    btnInserirProduto.Caption := '&Inserir';
    exit;
  end;

  Item := TPedidoItem.Create;
  Item.Id := FItensPedido.Count;
  Item.CodigoProduto := StrToInt(edtCodProduto.Text);
  Item.DescricaoProduto := edtDescricaoProduto.Text;
  Item.Quantidade := qtd;
  Item.ValorUnitario := valorUnit;
  Item.ValorTotal := qtd * valorUnit;

  if pnlNroPedido.Visible then
    Item.NumeroPedido := StrToInt(lblNroPedidoSelecionado.Caption);

  FItensPedido.Add(Item);

  cdsPedidoItem.Append;
  cdsPedidoItemID.AsInteger := Item.Id;
  cdsPedidoItemCODPRODUTO.AsInteger := Item.CodigoProduto;
  cdsPedidoItemQTDE.AsInteger := Item.Quantidade;
  cdsPedidoItemDESCRICAO.AsString := Item.DescricaoProduto;
  cdsPedidoItemVALOR_UNIT.AsCurrency := Item.ValorUnitario;
  cdsPedidoItemVALOR_TOTAL.AsCurrency := Item.ValorTotal;
  cdsPedidoItem.Post;

  AtualizarTotalPedido;

  limparDadosProduto;
end;

function TFrmMain.LocalizarItemPorId(AId: integer): TPedidoItem;
var
  Item: TPedidoItem;
begin
  Result := nil;

  for Item in FItensPedido do
  begin
    if Item.Id = AId then
      exit(Item);
  end;
end;

procedure TFrmMain.AtualizarProduto(AIDProduto: integer);
var
  Item: TPedidoItem;
begin
  if cdsPedidoItem.Locate('ID', AIDProduto, []) then
  begin
    Item := LocalizarItemPorId(AIDProduto);
    Item.DescricaoProduto := edtDescricaoProduto.Text;
    Item.Quantidade := StrToInt(edtQtdeProduto.Text);
    Item.ValorUnitario := StrToCurr(edtValorUnitario.Text);
    Item.ValorTotal := Item.Quantidade * Item.ValorUnitario;

    cdsPedidoItem.Edit;
    cdsPedidoItemQTDE.AsInteger := Item.Quantidade;
    cdsPedidoItemDESCRICAO.AsString := Item.DescricaoProduto;
    cdsPedidoItemVALOR_UNIT.AsCurrency := Item.ValorUnitario;
    cdsPedidoItemVALOR_TOTAL.AsCurrency := Item.ValorTotal;
    cdsPedidoItem.Post;

    AtualizarTotalPedido;

    limparDadosProduto;
  end;
end;

procedure TFrmMain.AtualizarTotalPedido;
var
  Item: TPedidoItem;
  total: Currency;
begin

  total := 0;

  for Item in FItensPedido do
    total := total + Item.ValorTotal;

  lblValorTotalPedido.Caption := 'R$ ' + FormatFloat('#,##0.00', total);

end;

procedure TFrmMain.edtBuscarNumeroExit(Sender: TObject);
begin
  if edtBuscarNumero.Text <> '' then
    actCarregarPedido.Execute;
end;

procedure TFrmMain.edtBuscarNumeroKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
    actCarregarPedido.Execute;
end;

procedure TFrmMain.edtClienteCodigoChange(Sender: TObject);
begin
  if edtClienteCodigo.Text <> '' then
  begin
    pnlPesquisaPedido.Height := 0;
    pnlPesquisaPedido.Margins.Bottom := 0;

    if (not pnlNroPedido.Visible) then
      btnExcluir.Visible := false;
  end
  else
  begin
    pnlPesquisaPedido.Height := 106;
    pnlPesquisaPedido.Margins.Bottom := 10;
    btnExcluir.Visible := true;

    edtClienteNome.Clear;
    edtClienteCidade.Clear;
    edtClienteUF.Clear;
  end;

end;

procedure TFrmMain.edtClienteCodigoExit(Sender: TObject);
begin
  if edtClienteCodigo.Text <> '' then
    actBuscarCliente.Execute;
end;

procedure TFrmMain.edtClienteCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
    actBuscarCliente.Execute;
end;

procedure TFrmMain.edtClienteUFExit(Sender: TObject);
begin
  edtCodProduto.SetFocus;
end;

procedure TFrmMain.edtCodProdutoExit(Sender: TObject);
begin
  if edtCodProduto.Text <> '' then
    actBuscarProduto.Execute;
end;

procedure TFrmMain.edtCodProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_return then
    actBuscarProduto.Execute;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
  edtClienteCodigo.SetFocus;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FAppController := TAppController.Create;
  FItensPedido := TObjectList<TPedidoItem>.Create(true);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FItensPedido.Free;
  FAppController.Free;
end;

procedure TFrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = vk_return) and not(ActiveControl is TDBGrid)) then
  begin
    Key := 0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  cdsPedidoItem.CreateDataSet;
  cdsPedidos.CreateDataSet;

  CarregarHistoricoPedidos;
  AtualizarTotalPedido;
end;

procedure TFrmMain.gdHistoricoPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Key = vk_return) and (pnlPesquisaPedido.Height > 0)) then
  begin
    edtBuscarNumero.Text := cdsPedidosNROPEDIDO.AsString;
    actCarregarPedido.Execute;
  end;
end;

procedure TFrmMain.gdProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (ssCtrl in Shift) then
  begin
    Key := 0;
  end
  else if Key = vk_return then
  begin
    edtCodProduto.Tag := cdsPedidoItemID.AsInteger;
    edtCodProduto.Text := cdsPedidoItemCODPRODUTO.AsString;
    edtQtdeProduto.Text := cdsPedidoItemQTDE.AsString;
    edtValorUnitario.Value := cdsPedidoItemVALOR_UNIT.AsCurrency;
    edtDescricaoProduto.Text := cdsPedidoItemDESCRICAO.AsString;
    edtQtdeProduto.SetFocus;

    btnInserirProduto.Caption := '&Alterar';
    edtCodProduto.ReadOnly := true;
    edtDescricaoProduto.ReadOnly := true;
  end
  else if (Key = VK_DELETE) and not(ssCtrl in Shift) and (not cdsPedidoItem.IsEmpty) then
    cdsPedidoItem.Delete;

end;

procedure TFrmMain.CarregarHistoricoPedidos;
var
  Pedidos: TObjectList<TPedido>;
  Pedido: TPedido;
begin
  cdsPedidos.EmptyDataSet;
  Pedidos := FAppController.Pedido.BuscarPedidos;

  if not Assigned(Pedidos) then
    exit;

  try
    for Pedido in Pedidos do
    begin
      cdsPedidos.Append;
      cdsPedidosNROPEDIDO.AsInteger := Pedido.Numero;
      cdsPedidosDTEMISSAO.AsDateTime := Pedido.DataEmissao;
      cdsPedidosVALOR_TOTAL.AsCurrency := Pedido.ValorTotal;
      cdsPedidos.Post;
    end;
  finally
    Pedidos.Free;
  end;
end;

procedure TFrmMain.cdsPedidoItemBeforeDelete(DataSet: TDataSet);
var
  Item: TPedidoItem;
  Index: integer;
begin
  if not(MessageDlg('Tem certeza que deseja apagar o produto ?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes) then
    Abort;

  Item := LocalizarItemPorId(cdsPedidoItemID.AsInteger);

  if Assigned(Item) then
  begin
    Index := FItensPedido.IndexOf(Item);
    FAppController.PedidoItem.ExcluirItem(Item.Id);
    FItensPedido.Delete(Index);
    AtualizarTotalPedido;

    edtCodProduto.SetFocus;
  end;
end;

procedure TFrmMain.cdsPedidosBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

end.
