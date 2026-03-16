unit classeprodutos;

interface

type TProdutos = class
  private
    FEsto_Codigo: String;
    FEsto_Descricao: String;
    FEsto_Unidade: String;
    FEsto_imagem: WideString;
    FEsqt_qtde: Double;
    FEsqt_vendavis: Double;
    FEsto_desconto: Double;
    procedure SetEsqt_qtde(const Value: Double);
    procedure SetEsqt_vendavis(const Value: Double);
    procedure SetEsto_desconto(const Value: Double);
    procedure SetEsto_Codigo(const Value: string);
    procedure SetEsto_Descricao(const Value: String);
    procedure SetEsto_Unidade(const Value: String);
    procedure SetEsto_Imagem(const Value: WideString);
  public
    [FieldName('Esto_Codigo')]
    property Esto_Codigo:string read FEsto_Codigo write SetEsto_Codigo;
    [FieldName('Esto_Descricao')]
    property Esto_Descricao:String read FEsto_Descricao write SetEsto_Descricao;
    [FieldName('Esto_Unidade')]
    property Esto_Unidade:String read FEsto_Unidade write SetEsto_Unidade;
    [FieldName('Esto_Imagem')]
    property Esto_Imagem:WideString read FEsto_Imagem write SetEsto_Imagem;
    [FieldName('Esqt_Qtde')]
    property Esqt_Qtde:Double read FEsqt_Qtde write SetEsqt_Qtde;
    [FieldName('Esto_Desconto')]
    property Esto_Desconto:Double read FEsto_Desconto write SetEsto_Desconto;
    [FieldName('Esqt_Vendavis')]
    property Esqt_Vendavis:Double read FEsqt_Vendavis write SetEsqt_Vendavis;

end;


implementation

{ TProdutos }

procedure TProdutos.SetEsto_desconto(const Value: Double);
begin
   FEsto_desconto := Value;
end;

procedure TProdutos.SetEsqt_qtde(const Value: Double);
begin
   FEsqt_qtde := Value;
end;

procedure TProdutos.SetEsqt_vendavis(const Value: Double);
begin
   FEsqt_vendavis := Value;
end;

procedure TProdutos.SetEsto_Codigo(const Value: string);
begin
   FEsto_Codigo := Value;
end;

procedure TProdutos.SetEsto_Descricao(const Value: String);
begin
   FEsto_Descricao := Value;
end;

procedure TProdutos.SetEsto_Imagem(const Value: WideString);
begin
   FEsto_Imagem := Value;
end;

procedure TProdutos.SetEsto_Unidade(const Value: String);
begin
   FEsto_UNidade := Value;
end;

end.
